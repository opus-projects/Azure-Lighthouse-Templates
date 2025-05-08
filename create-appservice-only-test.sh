#!/bin/bash

# === Config ===
RG_NAME="412-test-rg"
PLAN_NAME="412-test-plan"
APP_NAME="412phpapp412"     # MUST be globally unique
LOCATION="israelcentral"

echo "🔁 Registering Microsoft.Web provider if needed..."
az provider register --namespace Microsoft.Web

echo "✅ Creating App Service Plan in $LOCATION..."
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RG_NAME \
  --sku B1 \
  --is-linux \
  --location $LOCATION

echo "✅ Creating Linux Web App (empty, Docker-ready)..."
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --deployment-container-image-name nginx   # temporary placeholder image

echo "🎯 App Service '$APP_NAME' created and ready for Docker config."
