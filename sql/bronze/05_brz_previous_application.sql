-- Bronze: brz_previous_application
-- Fuente: previous_application.csv
-- Filas: ~1,670,214 | Columnas: 37
-- Aplicaciones anteriores en Home Credit del cliente

USE hc_bronze;

DROP TABLE IF EXISTS brz_previous_application;

CREATE TABLE brz_previous_application (
    SK_ID_PREV                      INT             NOT NULL    COMMENT 'PK - ID de la aplicacion anterior en Home Credit',
    SK_ID_CURR                      INT             NOT NULL    COMMENT 'FK - ID del prestamo en la muestra',
    NAME_CONTRACT_TYPE              VARCHAR(50)     NULL        COMMENT 'Tipo de contrato: Cash, Consumer, Revolving',
    AMT_ANNUITY                     FLOAT           NULL        COMMENT 'Cuota anual de la aplicacion anterior',
    AMT_APPLICATION                 FLOAT           NULL        COMMENT 'Monto solicitado originalmente',
    AMT_CREDIT                      FLOAT           NULL        COMMENT 'Monto final aprobado (puede diferir del solicitado)',
    AMT_DOWN_PAYMENT                FLOAT           NULL        COMMENT 'Pago inicial. Null si no aplica',
    AMT_GOODS_PRICE                 FLOAT           NULL        COMMENT 'Precio del bien solicitado',
    WEEKDAY_APPR_PROCESS_START      VARCHAR(15)     NULL        COMMENT 'Dia de la semana de la solicitud anterior',
    HOUR_APPR_PROCESS_START         INT             NULL        COMMENT 'Hora de la solicitud anterior',
    FLAG_LAST_APPL_PER_CONTRACT     VARCHAR(2)      NULL        COMMENT 'Es la ultima aplicacion por contrato: Y/N. Filtrar por Y en Silver',
    NFLAG_LAST_APPL_IN_DAY          INT             NULL        COMMENT 'Es la ultima aplicacion del dia: 1/0',
    RATE_DOWN_PAYMENT               FLOAT           NULL        COMMENT 'Tasa de pago inicial normalizada',
    RATE_INTEREST_PRIMARY           FLOAT           NULL        COMMENT 'Tasa de interes primaria normalizada',
    RATE_INTEREST_PRIVILEGED        FLOAT           NULL        COMMENT 'Tasa de interes privilegiada normalizada',
    NAME_CASH_LOAN_PURPOSE          VARCHAR(100)    NULL        COMMENT 'Proposito del prestamo en efectivo',
    NAME_CONTRACT_STATUS            VARCHAR(20)     NULL        COMMENT 'Estado: Approved, Cancelled, Refused, Unused offer',
    DAYS_DECISION                   INT             NULL        COMMENT 'Dias relativos a solicitud actual cuando se tomo la decision',
    NAME_PAYMENT_TYPE               VARCHAR(50)     NULL        COMMENT 'Metodo de pago elegido',
    CODE_REJECT_REASON              VARCHAR(20)     NULL        COMMENT 'Razon de rechazo si aplica',
    NAME_TYPE_SUITE                 VARCHAR(50)     NULL        COMMENT 'Quien acompano al cliente',
    NAME_CLIENT_TYPE                VARCHAR(20)     NULL        COMMENT 'Cliente nuevo o recurrente',
    NAME_GOODS_CATEGORY             VARCHAR(50)     NULL        COMMENT 'Categoria del bien solicitado',
    NAME_PORTFOLIO                  VARCHAR(20)     NULL        COMMENT 'Portafolio: CASH, POS, CAR',
    NAME_PRODUCT_TYPE               VARCHAR(20)     NULL        COMMENT 'Tipo de producto: x-sell o walk-in',
    CHANNEL_TYPE                    VARCHAR(50)     NULL        COMMENT 'Canal de adquisicion del cliente',
    SELLERPLACE_AREA                INT             NULL        COMMENT 'Area del punto de venta',
    NAME_SELLER_INDUSTRY            VARCHAR(50)     NULL        COMMENT 'Industria del vendedor',
    CNT_PAYMENT                     FLOAT           NULL        COMMENT 'Plazo del credito anterior en cuotas',
    NAME_YIELD_GROUP                VARCHAR(20)     NULL        COMMENT 'Grupo de tasa de interes: low, middle, high, XNA',
    PRODUCT_COMBINATION             VARCHAR(100)    NULL        COMMENT 'Combinacion detallada del producto',
    DAYS_FIRST_DRAWING              FLOAT           NULL        COMMENT 'Dias hasta primer desembolso. 365243=no aplica',
    DAYS_FIRST_DUE                  FLOAT           NULL        COMMENT 'Dias hasta primera cuota',
    DAYS_LAST_DUE_1ST_VERSION       FLOAT           NULL        COMMENT 'Dias hasta ultimo vencimiento primera version',
    DAYS_LAST_DUE                   FLOAT           NULL        COMMENT 'Dias hasta ultimo vencimiento actual',
    DAYS_TERMINATION                FLOAT           NULL        COMMENT 'Dias hasta terminacion esperada',
    NFLAG_INSURED_ON_APPROVAL       FLOAT           NULL        COMMENT 'Solicito seguro en la aprobacion: 1/0',
    _ingested_at                    TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                    VARCHAR(100)    NOT NULL    DEFAULT 'previous_application.csv' COMMENT 'Archivo CSV de origen',
    PRIMARY KEY (SK_ID_PREV),
    INDEX idx_brz_prev_app_sk_id_curr (SK_ID_CURR)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: copia exacta de previous_application.csv';