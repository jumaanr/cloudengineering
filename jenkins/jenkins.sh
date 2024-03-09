#!/bin/bash

# ---- Go Application ---- #
sudo docker run -it -p 8080:8000 --name go-webapp-sample -v /home/azureuser/go-webapp-sample:/go/go-webapp-sample golang
go run main.go
http://40.121.246.11:8080/#/home
http://40.121.246.11:8080/swagger/index.html
# tests are available in controller directory
cd ./controller/
go test -v . #run every single test inside of the controller directory


#?--- Starting with Jenkins --- #

#ref : https://www.jenkins.io/
# installation : https://www.jenkins.io/doc/book/installing/linux/
# As docker container : https://hub.docker.com/r/jenkins/jenkins/ , https://github.com/jenkinsci/docker/blob/master/README.md

#--- Normal installation : CentOS ---#
# Jenkins Installation - Official Documentation --

sudo yum install epel-release -y
sudo yum install java-11-openjdk -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y


# Edit /lib/systemd/system/jenkins.service file and change Jenkins port to 8090 by updating Environment="JENKINS_PORT=" variable value.
sudo vi /lib/systemd/system/jenkins.service
Environment="JENKINS_PORT=8090"
sudo systemctl start jenkins

/var/lib/jenkins/secrets/initialAdminPassword #password located at


systemctl daemon-reload # apply changes in systemd unti files 
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


# Add exceptions in Firewall
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

firewall-cmd $PERM --new-service=jenkins
firewall-cmd $SERV --set-short="Jenkins ports"
firewall-cmd $SERV --set-description="Jenkins port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=jenkins
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload

#admin,Adm!n321 : https://8090-port-4e653ce0415e49fa.labs.kodekloud.com/  mike , M!k3@123

#? --- Jenkings CLI --- #
# ref : https://www.jenkins.io/doc/book/managing/cli/#ssh
# jenkins -> me -> configre --> SSH PublicKeys (put your generated public key) --> Save

curl -Lv http://localhost:8085/login 2>&1 | grep -i 'x-ssh-endpoint' #shows the port jenkins used
ssh -i /home/mike/.ssh/jenkins_key -l mike -p 8022 jenkins-server help

# api token also can be created and provided to access cli

#? ---- Jenkins Plugins --- #
# Jenkins plugins allow you to connect from one service to another in Jenkins
# Can get information about plugins : https://plugins.jenkins.io/
# locally plugins can be installed from here : http://172.210.115.13:8080/manage/pluginManager/
# If a certain plugin requires reboot
sudo systemctl restart jenkins
