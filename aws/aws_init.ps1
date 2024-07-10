#This is an interface that would connect to AWS CLI
# Reference : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

#Ensure latest PS version is available
winget install --id Microsoft.Powershell --source winget
Write-Output $PSVersionTable

#Install the CLI
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi #Install using MSI installer
aws --version #verify the installation

#How to connect : https://www.youtube.com/watch?v=hYtYaFVWcCU
aws configure # This would prompt for entering access-key ID and 
aws iam list-users # This would list down the IAM users


#~ Windows Powershell
# move the directory where .pem file
ssh -i .\privatekey.pem ec2-user@ip_address #accept the yes prompt
# fixing permissions issue
# properties->Security->Advanced->Make the Owner of the file yourself with full control : remove all inherited permissions , including SYSTEM







