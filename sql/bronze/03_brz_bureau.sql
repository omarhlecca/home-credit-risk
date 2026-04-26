-- Bronze: brz_bureau
-- Fuente: bureau.csv
-- Filas: ~1,716,428 | Columnas: 17
-- Historial crediticio externo del cliente

USE hc_bronze;

DROP TABLE IF EXISTS brz_bureau;

CREATE TABLE brz_bureau (
    SK_ID_BUREAU                INT             NOT NULL    COMMENT 'PK - ID del credito en el buro externo',
    SK_ID_CURR                  INT             NOT NULL    COMMENT 'FK - ID del prestamo en la muestra',
    CREDIT_ACTIVE               VARCHAR(20)     NULL        COMMENT 'Estado del credito: Active, Closed, Sold, Bad debt',
    CREDIT_CURRENCY             VARCHAR(20)     NULL        COMMENT 'Moneda del credito (recodificada)',
    DAYS_CREDIT                 INT             NULL        COMMENT 'Dias antes de la solicitud actual en que se abrio este credito',
    CREDIT_DAY_OVERDUE          INT             NULL        COMMENT 'Dias de atraso al momento de la solicitud',
    DAYS_CREDIT_ENDDATE         FLOAT           NULL        COMMENT 'Duracion restante del credito en dias. Positivo=activo, negativo=cerrado',
    DAYS_ENDDATE_FACT           FLOAT           NULL        COMMENT 'Dias desde que cerro el credito (solo creditos cerrados)',
    AMT_CREDIT_MAX_OVERDUE      FLOAT           NULL        COMMENT 'Monto maximo de atraso en este credito',
    CNT_CREDIT_PROLONG          INT             NULL        COMMENT 'Veces que se prorrogo el credito',
    AMT_CREDIT_SUM              FLOAT           NULL        COMMENT 'Monto actual del credito',
    AMT_CREDIT_SUM_DEBT         FLOAT           NULL        COMMENT 'Deuda actual en este credito',
    AMT_CREDIT_SUM_LIMIT        FLOAT           NULL        COMMENT 'Limite actual de tarjeta de credito',
    AMT_CREDIT_SUM_OVERDUE      FLOAT           NULL        COMMENT 'Monto actual en atraso',
    CREDIT_TYPE                 VARCHAR(50)     NULL        COMMENT 'Tipo de credito: auto, cash, tarjeta, etc.',
    DAYS_CREDIT_UPDATE          INT             NULL        COMMENT 'Dias desde ultima actualizacion de este credito',
    AMT_ANNUITY                 FLOAT           NULL        COMMENT 'Cuota anual del credito del buro',
    _ingested_at                TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                VARCHAR(100)    NOT NULL    DEFAULT 'bureau.csv' COMMENT 'Archivo CSV de origen',
    PRIMARY KEY (SK_ID_BUREAU),
    INDEX idx_brz_bureau_sk_id_curr (SK_ID_CURR)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: copia exacta de bureau.csv';