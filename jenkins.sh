#!/bin/bash
# Installing Jenkins on VM
# Ref : https://www.jenkins.io/doc/book/installing/

#Pre-Requsites - Installing Java
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
openjdk version "17.0.8" 2023-07-18
OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
OpenJDK 64-Bit Server VM (build 17.0.8+7-Debian-1deb12u1, mixed mode, sharing)

# Add package repositories
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
# Install Jenkings
sudo apt-get update
sudo apt-get install jenkins

# Jenkins listens to port 8080 , add exception in firewall
sudo ufw allow 8080
sudo ufw status

# Allow inbound rule in Network Security Group

# Find Admin Password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Jenkins URL : http://172.210.115.13:8080/


#------------------------------- RHEL Installation ----------------------------------
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum update -y
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk -y
sudo yum install jenkins -y
sudo systemctl daemon-reload

echo "----------------------Required Packages have been installed-------------------------------"

# Starting services
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

echo "--------------------- Services have been started -----------------------------------------"

# Allow Firewall
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

sudo yum install firewalld -y
sudo firewall-cmd $PERM --new-service=jenkins
sudo firewall-cmd $SERV --set-short="Jenkins ports"
sudo firewall-cmd $SERV --set-description="Jenkins port exceptions"
sudo firewall-cmd $SERV --add-port=$YOURPORT/tcp
sudo firewall-cmd $PERM --add-service=jenkins
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload

echo "----------------------------- Exception have been added to firewall --------------------"

#-----------------------------Jenkins CLI ---------------------------#
# ref : https://www.jenkins.io/doc/book/managing/cli/
# Myname -> Configure -> SSHKeys configure -> Generate SSH keypair and copy the public SSH key on Jenkins

java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' <command> # You can use without command as well 
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' install-plugin cloudbees-bitbucket-branch-source
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' install-plugin cloud-stats #upgrade
java -jar jenkins-cli.jar -s http://localhost:8085 -auth 'admin:Adm!n321' disable-plugin github -restart -r # disable


#? -------------------------------------------------Jenkins Plugins-----------------------------------------------------#

# Jenkins plugins allow you to connect from one service to another in Jenkins
# Can get information about plugins : https://plugins.jenkins.io/
# locally plugins can be installed from here : http://172.210.115.13:8080/manage/pluginManager/
# If a certain plugin requires reboot
sudo systemctl restart jenkins
