#!/bin/bash

########## ATTENTION : À FAIRE AU PRÉALABLE ##########
# Ce script suppose que vous avez déjà créé un groupe de sécurité sur AWS
# avec toutes les règles de trafic autorisées (IN/OUT), sinon l'accès à l'application échouera.

########## ÉTAPES PRÉLIMINAIRES (manuelles) ##########
# 1. Se connecter en tant que root :
#    sudo -i
#
# 2. Créer le fichier script :
#    nano devops_j2ee.sh
#
# 3. Coller ce code dans le fichier, enregistrer et quitter.
#
# 4. Donner les droits d'exécution :
#    chmod +x devops_j2ee.sh
#
# 5. Lancer le script :
#    ./devops_j2ee.sh

######################################################
########## DÉBUT DE L’INSTALLATION AUTOMATISÉE #######
######################################################

# === ETAPE 01 : Mise à jour et installation des packages de base ===
apt update && sudo apt install -y openjdk-21-jdk
# - apt update : met à jour la liste des paquets
# - apt install : installe le JDK Java par défaut, unzip (pour décompresser les fichiers), et Git
java -version
# === ETAPE 02 : Installation de Maven ===
sudo apt install -y maven
# Configuration de Maven dans le PATH système
rm /etc/profile.d/maven.sh
echo "export M2_HOME=/usr/local/src/apache-maven" > /etc/profile.d/maven.sh
echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
# Ces lignes ajoutent Maven au PATH via un script de profil, pour qu’il soit accessible globalement

# === ETAPE 03 : Configuration des variables d’environnement Java ===
rm /etc/profile.d/java.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64" > /etc/profile.d/java.sh
echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> /etc/profile.d/java.sh
chmod +x /etc/profile.d/java.sh
source /etc/profile.d/java.sh
# Déclare JAVA_HOME et ajoute le binaire Java au PATH

# === Affichage des variables d’environnement pour vérification ===
echo "M2_HOME:$M2_HOME"
echo "JAVA_HOME:$JAVA_HOME"

# === ETAPE 04 : Installation de Tomcat  ===
cd /tmp
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.tar.gz

sha512sum apache-tomcat-9.0.105.tar.gz

# Téléchargement de Tomcat version 9.0.105 et vérification de l'intégrité du fichier téléchargé en utilisant la somme de contrôle SHA512

#unzip apache-tomcat-9.0.105.zip
tar -xvzf apache-tomcat-9.0.105.tar.gz
# Décompression de l’archive

mkdir -p /opt/tomcat
mv apache-tomcat-9.0.105 /opt/tomcat
# Déplacement du dossier Tomcat vers /opt/tomcat

rm -rf /opt/tomcat/latest
ln -s /opt/tomcat/apache-tomcat-9.0.105 /opt/tomcat/latest
# Création d’un lien symbolique "latest" pour toujours pointer vers la version courante

sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
# Rendre exécutables les scripts de démarrage/arrêt de Tomcat

cd
# Retour au répertoire personnel root

# === Création d’un service systemd pour Tomcat ===
rm /etc/systemd/system/tomcat.service
cat << EOF >> /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 8.5 servlet container
After=network.target

[Service]
Type=forking
Environment="JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
# Ce bloc crée un fichier de configuration systemd pour que Tomcat soit géré comme un service Linux

systemctl daemon-reload
# Recharge la configuration des services

systemctl enable tomcat
# Active Tomcat au démarrage

systemctl start tomcat
# Démarre le service Tomcat

# === ETAPE 05 : Build et déploiement de l’application J2EE ===
apt install -y git
git clone https://github.com/abdelbaki-bouzaienne/projet_j2ee.git
cd projet_j2ee
# Clone le dépôt Git contenant le projet Java
rm -rf /root/projet_j2ee/webapp/target/
mvn clean install package
# Compile et empaquette le projet avec Maven
cp /root/projet_j2ee/webapp/target/webapp-1.0-SNAPSHOT.war /opt/tomcat/latest/webapps/webapp.war
# Copie du fichier .war généré dans le dossier des applications Tomcat

# Récupération de l’adresse IP publique de la machine pour l’affichage
var4=`ip a | grep global | cut -d" " -f6 | cut -d"/" -f1 | head -n 1`
echo "Voici l'URL pour acceder a votre java web application en local: http://$var4:8080/webapp"

# Vérification si l'application répond
curl http://$var4:8080/webapp


###########################################################
###################### FIN DU SCRIPT ######################
###########################################################
