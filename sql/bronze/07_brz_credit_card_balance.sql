-- Bronze: brz_credit_card_balance
-- Fuente: credit_card_balance.csv
-- Filas: ~3,840,312 | Columnas: 23
-- Balance mensual de tarjetas de credito anteriores en Home Credit

USE hc_bronze;

DROP TABLE IF EXISTS brz_credit_card_balance;

CREATE TABLE brz_credit_card_balance (
    SK_ID_PREV                      INT             NOT NULL    COMMENT 'FK - ID del credito anterior en Home Credit',
    SK_ID_CURR                      INT             NOT NULL    COMMENT 'FK - ID del prestamo en la muestra (acceso directo)',
    MONTHS_BALANCE                  INT             NOT NULL    COMMENT 'Mes del balance relativo a solicitud. -1=mas reciente',
    AMT_BALANCE                     FLOAT           NULL        COMMENT 'Balance durante el mes',
    AMT_CREDIT_LIMIT_ACTUAL         INT             NULL        COMMENT 'Limite de credito durante el mes',
    AMT_DRAWINGS_ATM_CURRENT        FLOAT           NULL        COMMENT 'Monto retiros ATM durante el mes',
    AMT_DRAWINGS_CURRENT            FLOAT           NULL        COMMENT 'Monto total de disposiciones durante el mes',
    AMT_DRAWINGS_OTHER_CURRENT      FLOAT           NULL        COMMENT 'Monto otras disposiciones durante el mes',
    AMT_DRAWINGS_POS_CURRENT        FLOAT           NULL        COMMENT 'Monto compras en comercios durante el mes',
    AMT_INST_MIN_REGULARITY         FLOAT           NULL        COMMENT 'Pago minimo requerido durante el mes',
    AMT_PAYMENT_CURRENT             FLOAT           NULL        COMMENT 'Monto pagado durante el mes',
    AMT_PAYMENT_TOTAL_CURRENT       FLOAT           NULL        COMMENT 'Monto total pagado durante el mes',
    AMT_RECEIVABLE_PRINCIPAL        FLOAT           NULL        COMMENT 'Monto principal por cobrar',
    AMT_RECIVABLE                   FLOAT           NULL        COMMENT 'Monto por cobrar',
    AMT_TOTAL_RECEIVABLE            FLOAT           NULL        COMMENT 'Monto total por cobrar',
    CNT_DRAWINGS_ATM_CURRENT        FLOAT           NULL        COMMENT 'Numero de retiros ATM durante el mes',
    CNT_DRAWINGS_CURRENT            INT             NULL        COMMENT 'Numero total de disposiciones durante el mes',
    CNT_DRAWINGS_OTHER_CURRENT      FLOAT           NULL        COMMENT 'Numero otras disposiciones durante el mes',
    CNT_DRAWINGS_POS_CURRENT        FLOAT           NULL        COMMENT 'Numero compras en comercios durante el mes',
    CNT_INSTALMENT_MATURE_CUM       FLOAT           NULL        COMMENT 'Numero de cuotas pagadas acumuladas',
    NAME_CONTRACT_STATUS            VARCHAR(20)     NULL        COMMENT 'Estado del contrato durante el mes',
    SK_DPD                          INT             NULL        COMMENT 'Dias de atraso real durante el mes',
    SK_DPD_DEF                      INT             NULL        COMMENT 'Dias de atraso con tolerancia',
    _ingested_at                    TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                    VARCHAR(100)    NOT NULL    DEFAULT 'credit_card_balance.csv' COMMENT 'Archivo CSV de origen',
    INDEX idx_brz_cc_balance_sk_id_prev (SK_ID_PREV),
    INDEX idx_brz_cc_balance_sk_id_curr (SK_ID_CURR),
    INDEX idx_brz_cc_balance_months (MONTHS_BALANCE)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: copia exacta de credit_card_balance.csv';