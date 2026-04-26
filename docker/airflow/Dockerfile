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

# Solo dependencias adicionales — sin fijar versiones
# que Airflow ya maneja internamente
RUN pip install --no-cache-dir \
    apache-airflow-providers-mysql \
    mysqlclient \
    pymysql \
    pandas \
    numpy \
    mlflow