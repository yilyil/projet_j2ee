######################################################
########## DÉBUT DE L’INSTALLATION AUTOMATISÉE #######
######################################################

# === ETAPE 01 : Mise à jour et installation des packages de base ===
apt update 
# === ETAPE 04 : Installation de Tomcat  ===
cd /tmp
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz

sha512sum apache-tomcat-9.0.100.tar.gz

# Téléchargement de Tomcat version 9.0.100 et vérification de l'intégrité du fichier téléchargé en utilisant la somme de contrôle SHA512

#unzip apache-tomcat-9.0.100.zip
tar -xvzf apache-tomcat-9.0.100.tar.gz
# Décompression de l’archive

mkdir -p /opt/tomcat
mv apache-tomcat-9.0.100 /opt/tomcat
# Déplacement du dossier Tomcat vers /opt/tomcat

rm -rf /opt/tomcat/latest
ln -s /opt/tomcat/apache-tomcat-9.0.100 /opt/tomcat/latest
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

# === ETAPE 04 : copiage de l’application J2EE ===
scp 
# Récupération de l’adresse IP publique de la machine pour l’affichage
var4=`ip a | grep global | cut -d" " -f6 | cut -d"/" -f1 | head -n 1`
echo "Voici l'URL pour acceder a votre java web application en local: http://$var4:8080/webapp"

# Vérification si l'application répond
curl http://$var4:8080/webapp


###########################################################
###################### FIN DU SCRIPT ######################
###########################################################
