#!/bin/bash
# Creates the Azure Storage backend for Terraform state (run once).
set -e

RG=rg-tfstate
LOCATION=uksouth
SA=tfstateyaseen6249

az group create --name $RG --location $LOCATION
az storage account create --name $SA --resource-group $RG --location $LOCATION \
  --sku Standard_LRS --min-tls-version TLS1_2 --allow-blob-public-access false
az storage account blob-service-properties update --account-name $SA \
  --resource-group $RG --enable-versioning true
az storage container create --name tfstate --account-name $SA --auth-mode key
