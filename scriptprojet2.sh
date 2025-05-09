#!/bin/bash

# Script d'installation de Jenkins sur Ubuntu 24.04
# Nécessite des privilèges root/sudo

# 1. Mise à jour du système
echo "[1/6] Mise à jour des paquets système..."
sudo apt update && sudo apt upgrade -y

# 2. Installation des dépendances
echo "[2/6] Installation des dépendances..."
sudo apt install -y openjdk-21-jdk
# - apt install : installe le JDK Java par défaut, unzip (pour décompresser les fichiers)
java -version
rm /etc/profile.d/java.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64" > /etc/profile.d/java.sh
echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> /etc/profile.d/java.sh
chmod +x /etc/profile.d/java.sh
source /etc/profile.d/java.sh
# Déclare JAVA_HOME et ajoute le binaire Java au PATH

# === Affichage des variables d’environnement pour vérification ===
echo "M2_HOME:$M2_HOME"
echo "JAVA_HOME:$JAVA_HOME"
# === ETAPE 02 : Installation de Maven ===
sudo apt install -y maven
# Configuration de Maven dans le PATH système
rm /etc/profile.d/maven.sh
echo "export M2_HOME=/usr/local/src/apache-maven" > /etc/profile.d/maven.sh
echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/maven.sh
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
# Ces lignes ajoutent Maven au PATH via un script de profil, pour qu’il soit accessible globalement


apt install -y git

# Vérification de Java
java -version
if [ $? -ne 0 ]; then
    echo "Erreur: Java n'est pas installé correctement"
    exit 1
fi

# 3. Ajout du repository Jenkins
echo "[3/6] Configuration du dépôt Jenkins..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

# 4. Installation de Jenkins
echo "[4/6] Installation de Jenkins..."
sudo apt update
sudo apt install -y jenkins

# 5. Démarrage et activation du service
echo "[5/6] Configuration du service Jenkins..."
sudo systemctl enable --now jenkins
sudo systemctl status jenkins --no-pager

# 6. Configuration du pare-feu (si actif)
if command -v ufw &> /dev/null; then
    echo "[6/6] Configuration du pare-feu..."
    sudo ufw allow 8080
    sudo ufw status
fi
apt install -y git
sudo useradd -m -d /var/lib/jenkins -U -s /bin/bash jenkins
sudo mkdir -p /var/lib/jenkins/.ssh
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo chmod 700 /var/lib/jenkins/.ssh


sudo apt install unzip
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin
ngrok http 8080

# Affichage des informations finales
echo "============================================"
echo "Installation terminée !"
echo "Accédez à Jenkins via: http://$(hostname -I | awk '{print $1}'):8080"
echo "Mot de passe initial:"
echo "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo "============================================"
