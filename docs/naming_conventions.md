# Naming Conventions - Home Credit Risk Project

Estándares y convenciones aplicadas en todo el proyecto.
Cualquier decisión que se desvíe de estas reglas debe documentarse en un ADR.

---

## 1. Base de datos y Schemas

Un solo servidor MySQL con 3 schemas separados por capa Medallion.

| Schema | Propósito |
|--------|-----------|
| `hc_bronze` | Copia exacta de los CSVs fuente, sin transformaciones |
| `hc_silver` | Datos limpios con modelo Kimball (dim_* + fact_*) |
| `hc_gold`   | Feature store y tablas listas para consumo (ML + dashboards) |

---

## 2. Tablas por capa

### Bronze - `hc_bronze`
Prefijo `brz_` + nombre exacto del CSV fuente (sin extensión, snake_case).

| Tabla | CSV fuente |
|-------|------------|
| `brz_application_train` | application_train.csv |
| `brz_application_test` | application_test.csv |
| `brz_bureau` | bureau.csv |
| `brz_bureau_balance` | bureau_balance.csv |
| `brz_previous_application` | previous_application.csv |
| `brz_pos_cash_balance` | POS_CASH_balance.csv |
| `brz_credit_card_balance` | credit_card_balance.csv |
| `brz_installments_payments` | installments_payments.csv |
| `brz_columns_description` | HomeCredit_columns_description.csv |

### Silver - `hc_silver`
Modelo Kimball: tablas de dimensión (`dim_`) y tablas de hechos (`fact_`).

| Tabla | Descripción |
|-------|-------------|
| `fact_application` | Tabla de hechos central - 1 fila por solicitud de crédito |
| `dim_client` | Dimensión cliente - datos personales y demográficos |
| `dim_loan` | Dimensión préstamo - tipo de contrato y montos |
| `dim_bureau_summary` | Dimensión historial externo - agregado por cliente |
| `dim_prev_app_summary` | Dimensión aplicaciones anteriores HC - agregado por cliente |

### Gold - `hc_gold`
Tablas de consumo final. Prefijo `feat_` para feature stores.

| Tabla | Descripción |
|-------|-------------|
| `feat_ml_main` | Feature store principal - 1 fila por cliente, ~200 features |
| `model_target` | Variable TARGET + split train/val/test |
| `kimball_views` | Vistas pre-agregadas para dashboards Power BI |

---

## 3. Columnas SQL

- **Formato**: `snake_case` en minúsculas para todas las columnas
- **Claves primarias**: `{entidad}_id` - ej: `client_id`, `loan_id`
- **Claves foráneas**: mismo nombre que la PK referenciada - ej: `client_id`
- **Timestamps de auditoría**: siempre presentes en Bronze y Silver

```sql
_ingested_at   TIMESTAMP   -- cuándo se cargó el registro
_source_file   VARCHAR     -- archivo CSV de origen (solo Bronze)
_updated_at    TIMESTAMP   -- última actualización (Silver en adelante)
```

- **Flags booleanos**: prefijo `is_` o `has_` - ej: `is_active`, `has_car`
- **Montos**: prefijo `amt_` - ej: `amt_credit`, `amt_income`
- **Conteos**: prefijo `cnt_` - ej: `cnt_children`, `cnt_credits`
- **Días**: prefijo `days_` - ej: `days_birth`, `days_employed`
- **Comentarios**: toda columna en Silver y Gold debe tener `COMMENT` en el DDL

---

## 4. DAGs de Airflow

Formato: `{capa}_{accion}_dag`

| DAG | Descripción |
|-----|-------------|
| `raw_ingestion_dag` | Carga CSVs a hc_bronze |
| `bronze_standardize_dag` | Estandariza tipos y agrega timestamps |
| `silver_clean_dag` | Limpieza y carga al modelo Kimball |
| `silver_bureau_agg_dag` | Agrega bureau + bureau_balance a nivel cliente |
| `gold_features_dag` | Construye feat_ml_main en hc_gold |

Reglas adicionales:
- Nombre del archivo Python = nombre del DAG + `.py`
- `dag_id` en el código = nombre del archivo sin `.py`
- Schedule en cron o `@once` para cargas históricas

---

## 5. Archivos Python

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| Módulos | `snake_case.py` | `silver_clean_utils.py` |
| Clases | `PascalCase` | `BronzeLoader` |
| Funciones | `snake_case` | `load_csv_to_bronze()` |
| Variables | `snake_case` | `connection_string` |
| Constantes | `UPPER_SNAKE_CASE` | `RAW_DATA_PATH` |
| Privados | prefijo `_` | `_validate_schema()` |

---

## 6. Notebooks

Formato: `NN_descripcion_snake_case.ipynb`
El número `NN` define el orden de ejecución.

| Notebook | Descripción |
|----------|-------------|
| `00_bronze_inspection.ipynb` | Verificación post-carga Bronze |
| `01_eda_application.ipynb` | EDA tabla application_train |
| `02_eda_bureau.ipynb` | EDA bureau + bureau_balance |
| `03_eda_balances.ipynb` | EDA POS_CASH, credit_card, installments |
| `04_gold_validation.ipynb` | Validación del feature store Gold |
| `05_model_comparison.ipynb` | Comparativa final de modelos ML |

---

## 7. Ramas Git

| Tipo | Patrón | Ejemplo |
|------|--------|---------|
| Trabajo diario | `develop` | `develop` |
| Nueva funcionalidad | `feat/{descripcion}` | `feat/silver-dim-client` |
| Corrección de bug | `fix/{descripcion}` | `fix/bronze-null-handling` |
| Documentación | `docs/{descripcion}` | `docs/erd-source` |
| Experimento ML | `exp/{modelo}` | `exp/xgboost-tuning` |

Reglas:
- Todo el trabajo diario ocurre en `develop` o en ramas `feat/`
- `main` solo recibe merges cuando una fase está completa y funcionando
- Merge de `develop` → `main` siempre via Pull Request
- Nunca hacer `git push --force` a `main`

---

## 8. Commits - Conventional Commits

Formato: `{tipo}({scope}): {descripcion corta en minúsculas}`

| Tipo | Uso |
|------|-----|
| `feat` | Nueva funcionalidad |
| `fix` | Corrección de bug |
| `docs` | Solo documentación |
| `chore` | Setup, configuración, dependencias |
| `refactor` | Refactoring sin cambio de funcionalidad |
| `test` | Agregar o corregir tests |
| `style` | Formato, espacios (sin cambio de lógica) |
| `exp` | Experimento ML (notebooks, modelos) |

Ejemplos reales del proyecto:
```
chore: initial project structure and configuration
docs: add architecture diagram v1 and update gitignore
docs: add source ERD and data sources section in README
feat(dag): add raw_ingestion_dag for bronze loading
feat(silver): add dim_client DDL and transform logic
fix(bronze): handle encoding issue in bureau_balance csv
exp(xgboost): add hyperparameter tuning with optuna
test(transforms): add unit tests for silver imputation
```

Reglas:
- Descripción en minúsculas, sin punto final
- Máximo 72 caracteres en la primera línea
- Si el cambio es complejo, agregar cuerpo después de una línea en blanco

---

## 9. Archivos de configuración y documentación

| Archivo | Ubicación | Descripción |
|---------|-----------|-------------|
| `.env.example` | raíz | Template de variables de entorno |
| `docker-compose.yml` | `docker/` | Definición de servicios |
| `init.sql` | `docker/mysql/` | Creación de schemas y usuario |
| `naming_conventions.md` | `docs/` | Este archivo |
| `architecture.drawio` | `docs/` | Diagrama de arquitectura general |
| `erd_source.drawio` | `docs/` | ERD de las fuentes CSV |
| `ADR-00N-titulo.md` | `docs/decisions/` | Architecture Decision Records |

---

*Última actualización: Abril 2026*
*Versión: 1.0*
