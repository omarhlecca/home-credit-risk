-- ══════════════════════════════════════════════════════
-- Home Credit Risk Project — MySQL Init Script
-- Crea schemas, usuario y permisos
-- Se ejecuta automáticamente al primer arranque de MySQL
-- ══════════════════════════════════════════════════════

-- ── Schemas Medallion ────────────────────────────────
CREATE DATABASE IF NOT EXISTS hc_bronze
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS hc_silver
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS hc_gold
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- ── Schema Airflow metadata ───────────────────────────
CREATE DATABASE IF NOT EXISTS airflow_meta
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- ── Schema MLflow ─────────────────────────────────────
CREATE DATABASE IF NOT EXISTS mlflow
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- ── Permisos al usuario de aplicación ────────────────
GRANT ALL PRIVILEGES ON hc_bronze.*   TO 'hc_user'@'%';
GRANT ALL PRIVILEGES ON hc_silver.*   TO 'hc_user'@'%';
GRANT ALL PRIVILEGES ON hc_gold.*     TO 'hc_user'@'%';
GRANT ALL PRIVILEGES ON airflow_meta.* TO 'hc_user'@'%';
GRANT ALL PRIVILEGES ON mlflow.*      TO 'hc_user'@'%';

FLUSH PRIVILEGES;

-- ── Verificación ──────────────────────────────────────
SELECT schema_name AS 'Schema creado'
FROM information_schema.schemata
WHERE schema_name IN ('hc_bronze','hc_silver','hc_gold','airflow_meta','mlflow');