# Deployment Guide

This document explains how to fully deploy the dbt Analytics project into your BigQuery environment.

---

## Prerequisites

- Google Cloud Project with BigQuery enabled
- dbt CLI installed and configured
- Service account JSON key with BigQuery permissions
- Git and basic shell access

---

## Steps

### 1. Clone the Project

```bash
git clone https://github.com/tstrall/analytics.git
cd analytics
```

### 2. Configure dbt Profiles

Edit `~/.dbt/profiles.yml` to include:

- `dev` target for models (e.g., `dbt_tstrall` dataset)
- `seed_raw` target for seeds (e.g., `dev_raw` dataset)

Test connection:

```bash
dbt debug
```

---

### 3. Deploy Everything Automatically

Run the deployment script:

```bash
./deploy.sh
```

The script will:
- Seed raw data into `dev_raw`
- Test the seeds
- Build models into `dbt_tstrall`
- Test the models
- Generate fresh documentation

---

## Manual Steps (Optional)

If you prefer to run manually:

```bash
# Seed raw data
dbt --target seed_raw seed

# Test seeds
dbt --target seed_raw test --select path:seeds/

# Build models
dbt run

# Test models
dbt test --select path:models/

# Generate docs
dbt docs generate

# Serve docs
dbt docs serve
```

---

## Notes

- Documentation will be viewable locally at [http://localhost:8080](http://localhost:8080)
- Separate targets (`dev` vs `seed_raw`) ensure clean separation between raw ingestion and model builds.
- No secrets or credentials are stored in the GitHub repository.

---

## Author

Built by Ted Strall — [strall.com](https://www.strall.com)
