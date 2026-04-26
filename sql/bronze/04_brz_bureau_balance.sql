-- Bronze: brz_bureau_balance
-- Fuente: bureau_balance.csv
-- Filas: ~27,299,925 | Columnas: 3
-- Balance mensual de creditos externos del cliente

USE hc_bronze;

DROP TABLE IF EXISTS brz_bureau_balance;

CREATE TABLE brz_bureau_balance (
    SK_ID_BUREAU                INT             NOT NULL    COMMENT 'FK - ID del credito en el buro externo',
    MONTHS_BALANCE              INT             NOT NULL    COMMENT 'Mes del balance relativo a la solicitud. -1=mas reciente',
    STATUS                      VARCHAR(5)      NULL        COMMENT 'Estado: C=cerrado, X=desconocido, 0=sin DPD, 1=DPD 1-30, 2=DPD 31-60, 3=DPD 61-90, 4=DPD 91-120, 5=DPD 120+',
    _ingested_at                TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                VARCHAR(100)    NOT NULL    DEFAULT 'bureau_balance.csv' COMMENT 'Archivo CSV de origen',
    INDEX idx_brz_bureau_balance_sk_id_bureau (SK_ID_BUREAU),
    INDEX idx_brz_bureau_balance_months (MONTHS_BALANCE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: copia exacta de bureau_balance.csv. Tabla mas grande del dataset ~27M filas';