#!/bin/bash

# === Config ===
RG_NAME="412-test-rg"
PLAN_NAME="412-test-plan"
APP_NAME="412dockerapp412"  # MUST be globally unique
LOCATION="israelcentral"
STARTUP_CMD="/startup.sh"

echo "🔁 Registering Microsoft.Web provider if needed..."
az provider register --namespace Microsoft.Web

echo "✅ Creating App Service Plan (if not exists)..."
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RG_NAME \
  --sku B1 \
  --is-linux \
  --location $LOCATION

echo "🐳 Creating Docker-based Web App..."
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --deployment-container-image-name nginx \
  --startup-file $STARTUP_CMD

echo "✅ Setting App to use local Dockerfile (GitHub/Azure DevOps CI/CD assumed)..."
az webapp config container set \
  --name $APP_NAME \
  --resource-group $RG_NAME \
  --docker-custom-image-name "" \
  --docker-registry-server-url ""

echo "🧪 App '$APP_NAME' is now ready for Git-based CI/CD with a Dockerfile."
