-- Bronze: brz_columns_description
-- Fuente: HomeCredit_columns_description.csv
-- Filas: 221 | Columnas: 5
-- Diccionario de datos del dataset completo

USE hc_bronze;

DROP TABLE IF EXISTS brz_columns_description;

CREATE TABLE brz_columns_description (
    ROW_ID                      INT             NOT NULL    COMMENT 'PK - Numero de fila original del CSV',
    TABLE_NAME                  VARCHAR(100)    NULL        COMMENT 'Nombre de la tabla a la que pertenece la columna',
    ROW_NAME                    VARCHAR(100)    NULL        COMMENT 'Nombre de la columna',
    DESCRIPTION                 TEXT            NULL        COMMENT 'Descripcion de la columna',
    SPECIAL                     VARCHAR(100)    NULL        COMMENT 'Notas especiales: normalized, hashed, recoded, etc.',
    _ingested_at                TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP COMMENT 'Timestamp de carga a Bronze',
    _source_file                VARCHAR(100)    NOT NULL    DEFAULT 'HomeCredit_columns_description.csv' COMMENT 'Archivo CSV de origen',
    PRIMARY KEY (ROW_ID),
    INDEX idx_brz_col_desc_table (TABLE_NAME),
    INDEX idx_brz_col_desc_row (ROW_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Bronze: diccionario de datos del dataset completo. 221 columnas documentadas';