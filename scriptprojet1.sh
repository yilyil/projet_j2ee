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
