#!/bin/bash

# === Configuration ===
RG_NAME="412-test-rg"
PLAN_NAME="412-test-plan"
APP_NAME="412phpapp412test"     # MUST be globally unique, change if needed
LOCATION="israelcentral"
GITHUB_USER="eztime412"
REPO_NAME="412-php-app"
BRANCH_NAME="main"

echo "✅ Creating App Service Plan in $LOCATION..."
az appservice plan create \
  --name $PLAN_NAME \
  --resource-group $RG_NAME \
  --sku B1 \
  --is-linux \
  --location $LOCATION

echo "✅ Creating Web App for Docker in App Service..."
az webapp create \
  --resource-group $RG_NAME \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --multicontainer-config-type dockerfile \
  --deployment-source-url https://github.com/$GITHUB_USER/$REPO_NAME \
  --deployment-source-branch $BRANCH_NAME

echo "🎉 Done! App Service '$APP_NAME' created in '$LOCATION' and connected to GitHub repo."
