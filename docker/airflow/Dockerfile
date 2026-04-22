# ══════════════════════════════════════════════════════
# Home Credit Risk — Airflow Custom Image
# Base: apache/airflow 2.8.1 + dependencias del proyecto
# ══════════════════════════════════════════════════════

FROM apache/airflow:2.8.1-python3.11

USER root

# Dependencias del sistema
RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

# Dependencias Python
RUN pip install --no-cache-dir \
    apache-airflow-providers-mysql==3.4.0 \
    mysqlclient==2.2.0 \
    pymysql==1.1.0 \
    sqlalchemy==2.0.25 \
    pandas==2.2.0 \
    numpy==1.26.0 \
    mlflow==2.10.0