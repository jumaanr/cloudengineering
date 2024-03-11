#!/bin/bash
# https://hub.docker.com/r/jenkins/jenkins
sudo docker pull jenkins/jenkins
sudo docker run -d -p 8090:8080 -p 50000:50000 -v /home/azureuser/jenkins_home:/var/jenkins_home jenkins/jenkins
mkdir jenkins_home
chmod 777 jenkins_home #since jenkins user with uid 1000 accessing
sudo docker ps
sudo docker exec -it b51107794522 /bin/bash

# Debian Ubuntu Installation
# allow following firewall ports, ensure following ports are exposed in NSG
sudo ufw status
sudo ufw allow 8080/tcp
sudo ufw allow 50000/tcp
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
sudo ufw status



