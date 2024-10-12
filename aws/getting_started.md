# AWS CLI Configuration on Windows 10

## Description
This script demonstrates how to install and configure AWS CLI using PowerShell.

### Reference:
- [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  
## Steps

### 1. Ensure Latest PowerShell Version is Installed
```powershell
winget install --id Microsoft.Powershell --source winget
Write-Output $PSVersionTable
```

### 2. Install AWS CLI
```powershell
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
aws --version  # Verify the installation
```

### 3. AWS CLI Configuration
You can configure the AWS CLI by entering your credentials and default region:
```powershell
aws configure  # Prompts for access-key ID and secret access key
```

### 4. List IAM Users
```powershell
aws iam list-users  # Lists all IAM users
```

### Additional Reference:
- [How to connect to AWS CLI](https://www.youtube.com/watch?v=hYtYaFVWcCU)

---

## Connecting to an EC2 Instance

### 1. Move to the Directory Where `.pem` File is Located
```powershell
ssh -i .\privatekey.pem ec2-user@ip_address  # Accept the prompt by typing 'yes'
```

### 2. Fixing File Permissions Issue in Windows
- Right-click the `.pem` file → Properties → Security → Advanced.
- Change the Owner to yourself and give full control.
- Remove all inherited permissions, including SYSTEM.

---

## SSH Troubleshooting Guide

### 1. There is a connection timeout
This is a security group issue. Look at the services that has been allowed.

### 2. There is still a connection timeout issue.
The intermediate, corporate or personal firewall is blocking

### 3. SSH Does not work on Windows
- if it says : ssh command not found , you have to use 3rd party tool like putty

### 4. Connection refused
Try to restart the service, or instance. 

### 5. Permission denied
This means either two things:
- You are using the wrong key or not using a security key. Look at the instance configuration and make sure you have assigned the correct key
- You are using wrong user. Makesure you are using ec2-user. Check the ssh command

### 6. Nothing working
Spin-up a new instance

### 7. Could connect yesterday , but not today
Public IP address is changed