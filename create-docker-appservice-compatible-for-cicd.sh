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

echo "📦 Creating App Service with placeholder runtime (to enable creation)..."
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --runtime "DOTNETCORE|6.0"

echo "🟢 App '$APP_NAME' is ready for GitHub Actions to deploy a Dockerfile-based container."
echo "❗ Azure will override the runtime with the Dockerfile from your CI/CD pipeline on first successful deploy."
