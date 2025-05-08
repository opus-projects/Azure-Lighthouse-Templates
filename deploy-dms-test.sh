#!/bin/bash

# === CONFIG ===
RG="412-test-rg"
LOCATION="israelcentral"
DMS_NAME="dms-412-test"
VNET_NAME="412-test-vnet"
SUBNET_NAME="subnet-dms"

# === FETCH SUBNET ID ===
echo "Fetching subnet ID..."
SUBNET_ID=$(az network vnet subnet show \
  --resource-group "$RG" \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --query "id" -o tsv)

# === CREATE DMS INSTANCE ===
echo "Creating DMS instance..."
az dms create \
  --resource-group "$RG" \
  --name "$DMS_NAME" \
  --location "$LOCATION" \
  --sku-name "Standard_1vCore" \
  --subnet "$SUBNET_ID"

echo "✅ DMS instance created successfully in subnet: $SUBNET_ID"
