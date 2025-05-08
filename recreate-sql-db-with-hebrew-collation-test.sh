#!/bin/bash

# === CONFIG ===
RG="412-test-rg"
SQL_SERVER="412-test-sqlserver"
SQL_DB="412-test-db"

# === DELETE EXISTING DB ===
echo "Deleting existing database $SQL_DB..."
az sql db delete \
  --name "$SQL_DB" \
  --resource-group "$RG" \
  --server "$SQL_SERVER" \
  --yes

# === RECREATE DB WITH HEBREW COLLATION ===
echo "Creating new database $SQL_DB with Hebrew_CI_AS collation..."
az sql db create \
  --name "$SQL_DB" \
  --resource-group "$RG" \
  --server "$SQL_SERVER" \
  --service-objective "GP_Gen5_2" \
  --edition "GeneralPurpose" \
  --compute-model "Provisioned" \
  --collation "Hebrew_CI_AS"

echo "✅ Database recreated with Hebrew_CI_AS collation."
