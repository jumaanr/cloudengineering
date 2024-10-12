```markdown
# AWS CLI Interface Setup

Reference:
- [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

### Ensure Latest PowerShell Version is Available
```bash
winget install --id Microsoft.Powershell --source winget
Write-Output $PSVersionTable
```

### Install the AWS CLI
```bash
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi # Install using MSI installer
aws --version # Verify the installation
```

### How to Connect to AWS
- Video Reference: [How to Connect](https://www.youtube.com/watch?v=hYtYaFVWcCU)
  
```bash
aws configure # This will prompt for entering access-key ID and secret access key
aws iam list-users # This will list down the IAM users
```

---

## Windows PowerShell

### Connect to EC2 Instance

1. Move to the directory where the `.pem` file is located.
2. Run the following command:

```bash
ssh -i .\privatekey.pem ec2-user@ip_address # Accept the yes prompt
```

### Fixing Permissions Issue on `.pem` File
1. Right-click the `.pem` file and go to Properties.
2. Navigate to the `Security` tab, then click on `Advanced`.
3. Make yourself the Owner of the file with full control.
4. Remove all inherited permissions, including the `SYSTEM` user.

---

```