-- Bronze: brz_installments_payments
-- Fuente: installments_payments.csv
-- Filas: ~13,605,401 | Columnas: 8
-- Historial de pagos de cuotas de creditos anteriores en Home Credit

USE hc_bronze;

DROP TABLE IF EXISTS brz_installments_payments;

CREATE TABLE brz_installments_payments (
    SK_ID_PREV                  INT             NOT NULL    COMMENT 'FK - ID del credito anterior en Home Credit',
    SK_ID_CURR                  INT             NOT NULL    COMMENT 'FK - ID del prestamo en la muestra (acceso directo)',
    NUM_INSTALMENT_VERSION      FLOAT           NULL        COMMENT 'Version del calendario de pagos. Cambio indica renegociacion',
    NUM_INSTALMENT_NUMBER       INT             NULL        COMMENT 'Numero de cuota observada',
    DAYS_INSTALMENT             FLOAT           NULL        COMMENT 'Cuando debia pagarse la cuota (relativo a solicitud actual)',
    DAYS_ENTRY_PAYMENT          FLOAT           NULL        COMMENT 'Cuando se pago realmente. Null=cuota no pagada',
    AMT_INSTALMENT              FLOAT           NULL        COMMENT 'Monto que debia pagarse',
    AMT_PAYMENT                 FLOAT           NULL        COMMENT 'Monto que realmente se pago',
    _ingested_at                TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                VARCHAR(100)    NOT NULL    DEFAULT 'installments_payments.csv' COMMENT 'Archivo CSV de origen',
    INDEX idx_brz_install_sk_id_prev (SK_ID_PREV),
    INDEX idx_brz_install_sk_id_curr (SK_ID_CURR)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: copia exacta de installments_payments.csv. Segunda tabla mas grande ~13.6M filas';