#!/bin/bash

# This project created to install a successfull installation of Jenkins in Ubuntu 22.04 LTS 
# vm-01-cicdstation01-devops-cicd-eastus hosted in Azure

sudo apt update -y && sudo apt-get update -y #update package manager

# Referring documentation https://www.jenkins.io/doc/book/installing/linux/#debianubuntu 
# Installing of Java
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
""" See the result 
openjdk version "17.0.12" 2024-07-16
OpenJDK Runtime Environment (build 17.0.12+7-Ubuntu-1ubuntu222.04)
OpenJDK 64-Bit Server VM (build 17.0.12+7-Ubuntu-1ubuntu222.04, mixed mode, sharing)

"""
##---------[ Install Jenkins ] --------------------# 
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

# Jenkins inital password store location
cat /var/lib/jenkins/secrets/initialAdminPassword
# example : 2eece0c08e77490abcf4a9aa1bebe2b0
2eece0c08e77490abcf4a9aa1bebe2b0
#Allow ports in firewall 
sudo ufw allow 8080
sudo ufw status
# You dont need to do this firewall step, if its a cloud hosted vm because controller by Security Groups

# Enable and Restart the Jenkins Service
sudo systemctl start jenkins
sudo systemctl enable jenkins

#user details : devopsadmin, cicdatjenkins24, URL : http://cicd-station01.eastus.cloudapp.azure.com:8080/

## ------- [ Changing the Jenkins Port ] -----------#
# Edit /lib/systemd/system/jenkins.service file and change Jenkins port to 8090 by updating Environment="JENKINS_PORT=" variable value.
sudo vi /lib/systemd/system/jenkins.service
Environment="JENKINS_PORT=8090"
sudo systemctl start jenkins
/var/lib/jenkins/secrets/initialAdminPassword #password located at

sudo systemctl daemon-reload # apply changes in systemd unit files 
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins