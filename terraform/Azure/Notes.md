
---

# Deploying Resources in Azure using Terraform

This guide will walk you through installing the necessary tools and deploying resources in Azure using Terraform.

## Prerequisites

Before starting, ensure you have the following installed:

1. **Visual Studio Code (VS Code)**
2. **Terraform**

### Step 1: Install Visual Studio Code

```bash
#!/bin/bash

# Install Visual Studio Code
wget -O https://go.microsoft.com/fwlink/?LinkID=760868
sudo apt install ./<file>.deb
```

### Step 2: Install Terraform

You can follow the official Terraform installation guide [here](https://developer.hashicorp.com/terraform/install).

```bash
# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### Step 3: Install Azure Terraform and Terraform Extension for VS Code

Ensure you have the Terraform and Azure Terraform extensions installed in VS Code.

## Step 4: Create `main.tf` File

You can refer to the following Terraform resources when creating the `main.tf` file:

- **Web App:** [Azure Windows Web App](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app)
- **App Service Plan:** [Azure App Service Plan](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan)
- **SQL Server:** [Azure SQL Server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server)
- **SQL Database:** [Azure SQL Database](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database)

## Step 5: Create an Authorized Connection with Azure

To allow Terraform to interact with Azure, configure the Azure provider with your credentials.

```hcl
provider "azurerm" {
  subscription_id = "6912d7a0-bc28-459a-9407-33bbba641c07"
  tenant_id       = "70c0f6d9-7f3b-4425-a6b6-09b47643ec58"
  client_id       = "3feda701-6a3d-4915-8d26-343827060a8e"
  client_secret   = "kKH8Q~54-LwKs2lYfNj6ECD_VmAt-cKSllRG4bfE"
  features {}
}
```

### Steps to Obtain Azure Credentials:

1. **Generate an App Registration in Azure:**
   - Go to **Microsoft Entra ID** → **App Registration** → **New Registration**.
   - Name it `terraform` and note down the **Tenant ID**, **Client ID** (Application ID), and **Client Secret**.

2. **Assign Permissions:**
   - Go to **Azure Portal** → **Subscription** → **Access Control (IAM)** → **Add Role Assignment**.
   - Assign the **Contributor** role to the `terraform` app. 
   - This will allow Terraform to create resources in Azure. 

*Note: This approach may not align with the Zero Trust Security Model, as permissions are not fine-grained.*

## Step 6: Deploy Resources

Once everything is set up, use the following Terraform commands to deploy resources.

```bash
# Initialize Terraform
terraform init
```

**Explanation:**  
`terraform init` downloads the required providers and modules defined in your configuration. It prepares your working directory for other Terraform commands.

```bash
# Create Terraform Plan
terraform plan -out main.tfplan
```

**Explanation:**  
`terraform plan` compares your existing resources with the configuration defined in your `.tf` files. It generates an execution plan showing what changes will be made, which is saved as `main.tfplan`.

```bash
# Apply Terraform Plan
terraform apply "main.tfplan"
```

**Explanation:**  
`terraform apply` executes the changes outlined in the plan file. This command creates, modifies, or deletes resources in Azure according to the plan.

```bash
# Destroy Resources
terraform destroy
```

**Explanation:**  
`terraform destroy` removes all resources that Terraform has created. It’s useful for cleaning up your environment.

---
