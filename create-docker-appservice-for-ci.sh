#!/bin/bash

# === Config ===
RG_NAME="412-test-rg"
PLAN_NAME="412-test-plan"
APP_NAME="412dockerapp412"  # MUST be globally unique
LOCATION="israelcentral"

echo "🔁 Registering Microsoft.Web provider if needed..."
az provider register --namespace Microsoft.Web

echo "✅ Creating App Service Plan (if needed)..."
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RG_NAME \
  --sku B1 \
  --is-linux \
  --location $LOCATION

echo "🐳 Creating Docker-enabled Web App with no predefined image..."
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --multicontainer-config-type dockerfile

echo "✅ App '$APP_NAME' is ready for GitHub Actions Dockerfile-based deployment."
