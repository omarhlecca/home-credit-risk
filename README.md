# Home Credit Default Risk - Data Pipeline & ML

End-to-end data engineering and machine learning project based on the
[Home Credit Default Risk](https://www.kaggle.com/c/home-credit-default-risk) Kaggle dataset.

## Stack
- **Orchestration**: Apache Airflow 2.x
- **Storage**: MySQL 8 (Bronze / Silver / Gold schemas)
- **Infrastructure**: Docker + Docker Compose
- **ML**: scikit-learn, XGBoost, LightGBM, PyTorch
- **Experiment tracking**: MLflow

## Architecture
Medallion architecture (Bronze → Silver → Gold) with Kimball Star Schema
in Silver for operational dashboards and a flat feature store in Gold for ML models.

## Status
Work in progress - started April 2026.

## Project Structure
```
home-credit-risk/
├── dags/          # Airflow DAGs
├── sql/           # DDL por capa (bronze / silver / gold)
├── src/           # Módulos Python (ingestion, transforms, models)
├── notebooks/     # EDA y análisis exploratorio
├── models/        # Experimentos ML por modelo
├── docker/        # docker-compose y Dockerfiles
├── docs/          # Arquitectura, ADRs, diccionario de datos
└── tests/         # Tests unitarios e integración
```

## Setup
> Instrucciones completas disponibles al finalizar el proyecto.

## Data Sources

The dataset consists of 9 CSV files from the
[Home Credit Default Risk](https://www.kaggle.com/c/home-credit-default-risk) Kaggle competition.

### Entity Relationship Overview

Three main keys connect all tables:
- `SK_ID_CURR` - Loan ID in current sample (primary key of application tables)
- `SK_ID_PREV` - Previous loan ID in Home Credit (primary key of previous_application)
- `SK_BUREAU_ID` - Credit ID in external Credit Bureau (primary key of bureau)

### Table Summary

| Table | Rows | Key | Relates to |
|-------|------|-----|------------|
| application_train | 307,511 | SK_ID_CURR (PK) | Central table with TARGET |
| application_test  | 48,744  | SK_ID_CURR (PK) | Same structure, no TARGET |
| bureau            | 1,716,428 | SK_BUREAU_ID (PK), SK_ID_CURR (FK) | 1 client → N external credits |
| bureau_balance    | 27,299,925 | SK_BUREAU_ID (FK) | 1 bureau credit → N monthly balances |
| previous_application | 1,670,214 | SK_ID_PREV (PK), SK_ID_CURR (FK) | 1 client → N previous HC apps |
| POS_CASH_balance  | 10,001,358 | SK_ID_PREV (FK), SK_ID_CURR (FK) | 1 prev app → N monthly snapshots |
| credit_card_balance | 3,840,312 | SK_ID_PREV (FK), SK_ID_CURR (FK) | 1 prev app → N monthly card balances |
| installments_payments | 13,605,401 | SK_ID_PREV (FK), SK_ID_CURR (FK) | 1 prev app → N payment records |
| columns_description | 221 | — | Data dictionary, no FK |

### Relationship Notes
- All relationships are **1-to-many (1:N)**
- `bureau` and `previous_application` connect to `application_train` via `SK_ID_CURR`
- `bureau_balance` connects to `bureau` via `SK_BUREAU_ID`
- `POS_CASH_balance`, `credit_card_balance`, `installments_payments` connect to
  `previous_application` via `SK_ID_PREV`, and also carry `SK_ID_CURR` for direct client lookup
- Use **LEFT JOIN** when joining to `bureau` - not all clients have external credit history
- `columns_description` is a reference table only, no foreign key relationships