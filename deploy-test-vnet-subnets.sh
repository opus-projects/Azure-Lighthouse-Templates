#!/bin/bash

# === CONFIG ===
RG="412-test-rg"
LOCATION="israelcentral"
VNET_NAME="412-test-vnet"

# === CREATE VNET + First Subnet (App Service PE subnet, unused for now) ===
echo "Creating VNet..."
az network vnet create \
  --name "$VNET_NAME" \
  --resource-group "$RG" \
  --location "$LOCATION" \
  --address-prefixes "10.10.0.0/16" \
  --subnet-name "subnet-appsvc" \
  --subnet-prefix "10.10.1.0/28"

# === ADD ADDITIONAL SUBNETS ===
declare -A subnets=(
  ["subnet-sql"]="10.10.1.16/28"
  ["subnet-linux"]="10.10.1.32/27"
  ["subnet-windows"]="10.10.1.64/27"
  ["subnet-dms"]="10.10.1.96/28"
  ["subnet-utility"]="10.10.1.112/28"
)

for name in "${!subnets[@]}"; do
  echo "Creating subnet $name..."
  az network vnet subnet create \
    --resource-group "$RG" \
    --vnet-name "$VNET_NAME" \
    --name "$name" \
    --address-prefix "${subnets[$name]}"
done

echo "✅ VNet and all subnets created successfully."
