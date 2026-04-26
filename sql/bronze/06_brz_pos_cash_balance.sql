-- Bronze: brz_pos_cash_balance
-- Fuente: POS_CASH_balance.csv
-- Filas: ~10,001,358 | Columnas: 8
-- Balance mensual de creditos POS y cash anteriores en Home Credit

USE hc_bronze;

DROP TABLE IF EXISTS brz_pos_cash_balance;

CREATE TABLE brz_pos_cash_balance (
    SK_ID_PREV                  INT             NOT NULL    COMMENT 'FK - ID del credito anterior en Home Credit',
    SK_ID_CURR                  INT             NOT NULL    COMMENT 'FK - ID del prestamo en la muestra (acceso directo)',
    MONTHS_BALANCE              INT             NOT NULL    COMMENT 'Mes del balance relativo a solicitud. -1=mas reciente',
    CNT_INSTALMENT              FLOAT           NULL        COMMENT 'Plazo del credito anterior (puede cambiar)',
    CNT_INSTALMENT_FUTURE       FLOAT           NULL        COMMENT 'Cuotas restantes por pagar',
    NAME_CONTRACT_STATUS        VARCHAR(20)     NULL        COMMENT 'Estado del contrato durante el mes',
    SK_DPD                      INT             NULL        COMMENT 'Dias de atraso real durante el mes',
    SK_DPD_DEF                  INT             NULL        COMMENT 'Dias de atraso con tolerancia (ignora deudas pequenas)',
    _ingested_at                TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                VARCHAR(100)    NOT NULL    DEFAULT 'POS_CASH_balance.csv' COMMENT 'Archivo CSV de origen',
    INDEX idx_brz_pos_cash_sk_id_prev (SK_ID_PREV),
    INDEX idx_brz_pos_cash_sk_id_curr (SK_ID_CURR),
    INDEX idx_brz_pos_cash_months (MONTHS_BALANCE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: copia exacta de POS_CASH_balance.csv';