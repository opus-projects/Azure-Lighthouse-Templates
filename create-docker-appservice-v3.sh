#!/bin/bash

# === Config ===
RG_NAME="412-test-rg"
PLAN_NAME="412-test-plan"
APP_NAME="412dockerapp412"  # MUST be globally unique
LOCATION="israelcentral"
IMAGE="nginx"               # Placeholder image for now
STARTUP_CMD="/startup.sh"

echo "🔁 Registering Microsoft.Web provider if needed..."
az provider register --namespace Microsoft.Web

echo "✅ Creating App Service Plan (if needed)..."
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RG_NAME \
  --sku B1 \
  --is-linux \
  --location $LOCATION

echo "🐳 Creating Docker-enabled Web App using current syntax..."
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --container-image-name $IMAGE

echo "🔧 Setting startup file..."
az webapp config set \
  --name $APP_NAME \
  --resource-group $RG_NAME \
  --startup-file $STARTUP_CMD

echo "✅ Docker App Service '$APP_NAME' is ready for GitHub Actions deployment."
