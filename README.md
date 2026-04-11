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