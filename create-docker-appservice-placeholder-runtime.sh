#!/bin/bash

# === Config ===
RG_NAME="412-test-rg"
PLAN_NAME="412-test-plan"
APP_NAME="412dockerapp412"
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

echo "📦 Creating Web App with safe placeholder runtime: NODE|18-lts"
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --runtime "NODE|18-lts"

echo "🟢 App '$APP_NAME' is now ready for GitHub Actions to deploy your Dockerfile-based container."
