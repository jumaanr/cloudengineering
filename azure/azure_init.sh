#!/bin/bash
#connect with Azure Account
az --version
# login to a specific tenant
tenant_id="db3d8c78-490e-4a2a-bda4-069bab4ae0b6"
subscription_id="09688c0b-8d07-41e6-ad43-b4a1b7329fbc"

az login --tenant db3d8c78-490e-4a2a-bda4-069bab4ae0b6 --use-device-code
az account show
az account subscription list
az account set --subscription $subscription_id
az group list

#creating the lab environment
az account list-locations -o table
az group create --name cloudengineeringlab --location eastus


az network vnet create --name vnetcloudengineering --resource-group cloudengineeringlab --address-prefix 192.168.0.0/16
az network vnet subnet create --name default --resource-group cloudengineeringlab --vnet-name vnetcloudengineering --address-prefix 192.168.100.0/24

az network nsg create --name nsg-cloudengineering --resource-group cloudengineeringlab --location eastus
#allow inbound rules
az network nsg rule create --resource-group cloudengineeringlab --nsg-name nsg-cloudengineering --name AllowHTTP --priority 1000 --source-address-prefixes Internet --destination-port-ranges 80 8080 --access Allow --protocol Tcp --description "Allow Internet to Web on ports 80,8080."
az network nsg rule create --resource-group cloudengineeringlab --nsg-name nsg-cloudengineering --name AllowHTTPS --priority 1001 --source-address-prefixes Internet --destination-port-ranges 443 --access Allow --protocol Tcp --description "Allow Internet to access HTTPS"
az network nsg rule create --resource-group cloudengineeringlab --nsg-name nsg-cloudengineering --name AllowSSH --priority 1002 --source-address-prefixes Internet --destination-port-ranges 22 --access Allow --protocol Tcp --description "Allow SSH Inbound connections"
az network nsg rule create --resource-group cloudengineeringlab --nsg-name nsg-cloudengineering --name AllowRDP --priority 1003 --source-address-prefixes Internet --destination-port-ranges 3389 --access Allow --protocol Tcp --description "Allow RDP Inbound connections"
#attach to subnet
az network vnet subnet update --resource-group cloudengineeringlab --vnet-name vnetcloudengineering --name default --network-security-group nsg-cloudengineering