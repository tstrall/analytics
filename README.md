# Analytics – dbt Demo Project

[![Release](https://img.shields.io/badge/Release-v1.0.0-green)](https://github.com/tstrall/analytics/releases/tag/v1.0.0)

![Building a Modern Data Stack with dbt, BigQuery, and Tableau](/img/dbt-analytics-demo.png)

This project demonstrates a clean, production-style dbt setup modeling a simple e-commerce system.

It follows best practices for modular, environment-agnostic dbt projects, including raw source management, staging, marts, tests, and documentation.

## Building a Modern Data Stack: BigQuery + dbt + Tableau (Starter Project)

This tutorial walks through building a simple, production-quality modern data platform:
- Ingest raw data
- Transform it using dbt
- Analyze with business marts
- Visualize key metrics

---

## Prerequisites

You will need:
- Google Cloud account with BigQuery enabled (free tier is sufficient)
- dbt CLI installed locally (or optionally a dbt Cloud account)
- Tableau Public account (optional for visualization)

Recommended tools:
- Git
- VS Code (or another code editor)

---

## Project Overview

The project is organized into three main layers:
- **Raw sources**: simulated `customers` and `orders` data (in `dev_raw` dataset)
- **Staging models**: light cleaning and standardization
- **Mart models**: business-ready metrics including Customer Lifetime Value and Monthly Revenue Trends

---

## ✅ Project Checklist

- [x] Logical project structure: `models/staging/`, `models/marts/`
- [x] Raw data sources declared using `source()`
- [x] Staging models (`stg_*`) clean and standardized
- [x] Business models (`dim_*`, `fact_*`) built with `ref()`
- [x] Tests (`unique`, `not_null`) declared in `schema.yml`
- [x] All models and columns documented
- [x] Environment-agnostic: no hardcoded project/schema names
- [x] Separate targets for seeds (`seed_raw`) and models (`dev`)
- [x] Clean local runs: `dbt run`, `dbt test`, `dbt docs generate`
- [x] Secure: No credentials or secrets in the repo

---

## Project Structure

```
models/
├── staging/
│   ├── schema.yml
│   ├── stg_customers.sql
│   └── stg_orders.sql
├── marts/
│   ├── schema.yml
│   ├── dim_customers.sql
│   └── fact_orders.sql
seeds/
├── customers.csv
├── orders.csv
├── schema.yml
dbt_project.yml
README.md
deploy.sh
```

---

## How to Run Locally

### Step 1: Clone the Project

```bash
git clone https://github.com/tstrall/analytics.git
cd analytics
```

### Step 2: Set up BigQuery

1. Create a new dataset in BigQuery named `dev_raw`.
2. Create another dataset named `dbt_yourname` (e.g., `dbt_tstrall`) for dbt models.
3. Enable BigQuery Storage API if prompted.

### Step 3: Configure dbt Profiles

Create or edit `~/.dbt/profiles.yml` with the following structure:

```yaml
analytics:
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: your-gcp-project-id
      dataset: dbt_yourname
      keyfile: path/to/your/service_account.json
      threads: 4

    seed_raw:
      type: bigquery
      method: service-account
      project: your-gcp-project-id
      dataset: dev_raw
      keyfile: path/to/your/service_account.json
      threads: 4

  target: dev
```

Replace:
- `your-gcp-project-id` with your GCP project ID
- `dbt_yourname` with your dataset for models
- `path/to/your/service_account.json` with your service account key path

Test your connection:

```bash
dbt debug
```

---

### Step 4: Load Raw Data

This project provides seed files containing dummy raw data.
To load them into BigQuery:

```bash
dbt --target seed_raw seed
```

This loads tables into your `dev_raw` dataset.

### Step 5: Run dbt Transformations

#### 5.1 Test Seeds

```bash
dbt --target seed_raw test --select path:seeds/
```

#### 5.2 Build Models

```bash
dbt run
```

#### 5.3 Test Models

```bash
dbt test --select path:models/
```

---

### Step 6: Generate and View Documentation

```bash
dbt docs generate
dbt docs serve
```

Access documentation locally at `http://localhost:8080`.

---

### Step 7: Full Deployment Automation

You can deploy everything automatically:

```bash
./deploy.sh
```

This will:
- Seed raw data
- Test seeds
- Build models
- Test models
- Generate documentation

---

## Deployment Instructions

For a full step-by-step deployment guide, see [DEPLOYMENT.md](./DEPLOYMENT.md).

---

## Tableau Dashboard

- [View Live Dashboard on Tableau Public](https://public.tableau.com/app/profile/ted.strall/viz/dbtAnalyticsDemo/Revenue)
- [Tableau Files and Documentation](./tableau/README.md)

> **Note:**  
> This Tableau dashboard reflects a snapshot of the dbt-transformed data as of the publish date.  
> Tableau Public dashboards do not maintain live BigQuery connections.

---

## Troubleshooting

| Problem | Solution |
|:--|:--|
| Dataset not found | Confirm your BigQuery dataset names match your `profiles.yml` |
| dbt CLI can't find profile | Ensure your `profiles.yml` is located at `~/.dbt/profiles.yml` |
| Missing raw tables | Ensure you ran `dbt --target seed_raw seed` successfully |
| Partial Parsing Warnings | Expected when switching targets; safe to ignore |

---

## Future Work

This project is built first for BigQuery. Future enhancements include:
- Snowflake version
- Automated ingestion with Fivetran
- Additional visualization dashboards

---

## Built With

- [dbt](https://www.getdbt.com/) — Data transformation and modeling
- [Google BigQuery](https://cloud.google.com/bigquery) — Cloud data warehouse
- [Tableau](https://www.tableau.com/) — Data visualization
- [GitHub](https://github.com/) — Source control and project management

---

## Author

Built by Ted Strall — [strall.com](https://www.strall.com)

---

## Quick Command Summary

```bash
# Seed data into dev_raw
dbt --target seed_raw seed

# Test seeds
dbt --target seed_raw test --select path:seeds/

# Build models into dbt_tstrall
dbt run

# Test models
dbt test --select path:models/

# Generate docs
dbt docs generate

# Serve docs
 dbt docs serve
```

---

## Latest Release

Version [v1.0.0](https://github.com/tstrall/analytics/releases/tag/v1.0.0) — Initial dbt + BigQuery + Tableau stack

- dbt transformations and tests
- Automated deploy script
- Tableau dashboard for Top Customers and Revenue Trends
