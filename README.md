# Analytics – dbt Demo Project

This project demonstrates a clean, production-style dbt setup modeling a simple e-commerce system.

It follows best practices for modular, environment-agnostic dbt projects, including raw source management, staging, marts, tests, and documentation.

---

## ✅ Project Checklist

- [x] Logical project structure: `models/staging/`, `models/marts/`
- [x] Raw data sources declared using `source()`
- [x] Staging models (`stg_*`) clean and standardized
- [x] Business models (`dim_*`, `fact_*`) built with `ref()`
- [x] Tests (`unique`, `not_null`) declared in `schema.yml`
- [x] All models and columns documented
- [x] Environment-agnostic: no hardcoded project/schema names
- [x] Clean local runs: `dbt run`, `dbt test`, `dbt docs generate`
- [x] Secure: No credentials or secrets in the repo

---

## Project Structure

```
models/
├── staging/
│   ├── schema.yml
│   ├── stg_customers.sql
│   ├── stg_orders.sql
├── marts/
│   ├── schema.yml
│   ├── dim_customers.sql
│   ├── fact_orders.sql
dbt_project.yml
README.md
```

---

## Key Concepts Demonstrated

- **Raw sources** (`source('raw', 'customers')`) declared for external tables.
- **Staging models** (`stg_*`) that clean and standardize raw data.
- **Mart models** (`dim_*`, `fact_*`) that build business-ready datasets.
- **Automated tests** for critical fields to ensure data integrity.
- **Dynamic environment binding** using dbt targets — no hardcoded environments.
- **Full project documentation** generated with `dbt docs`.

---

## How to Run Locally

1. Install dbt and configure your `profiles.yml` for your dev environment.
2. Run debug to validate connection:
    ```bash
    dbt debug
    ```
3. Run all models:
    ```bash
    dbt run
    ```
4. Run tests:
    ```bash
    dbt test
    ```
5. Generate and view documentation:
    ```bash
    dbt docs generate
    dbt docs serve
    ```
