#!/bin/bash
set -e

echo "==> Seeding raw data into dev_raw..."
dbt --target seed_raw seed

echo "==> Testing seeds in dev_raw..."
dbt --target seed_raw test --select path:seeds/

echo "==> Building models into dbt_tstrall..."
dbt run

echo "==> Testing models in dbt_tstrall..."
dbt test --select path:models/

echo "==> Generating dbt docs..."
dbt docs generate

echo "==> Done! ✅ You can now view docs with 'dbt docs serve'"
