# Jenkins Installation on Ubuntu 22.04 LTS

This guide outlines the steps to install Jenkins on an Ubuntu 22.04 LTS VM successfully  hosted in Azure.

## Update Package Manager

```bash
sudo apt update -y && sudo apt-get update -y
```

## Install Java

Refer to the [Jenkins Documentation](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu) for additional details.

Install Java:

```bash
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
```

You should see an output similar to:

```
openjdk version "17.0.12" 2024-07-16
OpenJDK Runtime Environment (build 17.0.12+7-Ubuntu-1ubuntu222.04)
OpenJDK 64-Bit Server VM (build 17.0.12+7-Ubuntu-1ubuntu222.04, mixed mode, sharing)
```

## Install Jenkins

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins
```

To retrieve the Jenkins initial password:

```bash
cat /var/lib/jenkins/secrets/initialAdminPassword
```

Example output:

```
2eece0c08e77490abcf4a9aa1bebe2b0
```

## Configure Firewall

Allow port 8080 in the firewall:

```bash
sudo ufw allow 8080
sudo ufw status
```

Note: You may not need to adjust the firewall settings if the VM is controlled by Security Groups.

## Enable and Start Jenkins Service

```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### Changing the Jenkins Port

To change the Jenkins port to 8090, edit the `/lib/systemd/system/jenkins.service` file and update the `Environment="JENKINS_PORT="` variable:

```bash
sudo vi /lib/systemd/system/jenkins.service
```

Change to:

```
Environment="JENKINS_PORT=8090"
```

Apply the changes:

```bash
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

For user details, example credentials are:
- **Username:** devopsadmin
- **Password:** cicdatjenkins24
- **URL:** [http://cicd-station01.eastus.cloudapp.azure.com:8080/](http://cicd-station01.eastus.cloudapp.azure.com:8080/)
```
