#!/bin/bash

# === CONFIG ===
LOCATION="israelcentral"
RG="412-test-rg"
SQL_SERVER="412-test-sqlserver"
SQL_ADMIN="c412il_clockdb_admin"
SQL_PASSWORD="^Xa8f$1qW4gSd!92zUvF"
SQL_DB="412-test-db"

# === CREATE RESOURCE GROUP ===
echo "Creating resource group..."
az group create --name "$RG" --location "$LOCATION"

# === CREATE SQL SERVER ===
echo "Creating SQL Server..."
az sql server create \
  --name "$SQL_SERVER" \
  --resource-group "$RG" \
  --location "$LOCATION" \
  --admin-user "$SQL_ADMIN" \
  --admin-password "$SQL_PASSWORD"

# === CREATE SQL DATABASE ===
echo "Creating SQL Database..."
az sql db create \
  --name "$SQL_DB" \
  --resource-group "$RG" \
  --server "$SQL_SERVER" \
  --service-objective "GP_Gen5_2" \
  --edition "GeneralPurpose" \
  --compute-model "Provisioned"

# === ADD FIREWALL RULE FOR CURRENT IP ===
MY_IP=$(curl -s ifconfig.me)
echo "Adding firewall rule for IP: $MY_IP"
az sql server firewall-rule create \
  --resource-group "$RG" \
  --server "$SQL_SERVER" \
  --name "AllowMyIP" \
  --start-ip-address "$MY_IP" \
  --end-ip-address "$MY_IP"

echo "✅ SQL Server and Database deployed successfully."
