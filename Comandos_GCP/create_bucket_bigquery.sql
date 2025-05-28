-- Google Cloud Storage (GCS)
CREATE OR REPLACE EXTERNAL TABLE `vtal-sandbox-engenharia.inventario_comunicados_interrupcao.temp_comunicados_interrupcao_fe_24052025`
OPTIONS ( 
  allow_jagged_rows = TRUE, 
  encoding = "UTF-8", 
  field_delimiter = ";", 
  skip_leading_rows = 1, 
  ignore_unknown_values = TRUE, 
  max_bad_records = 100, 
  format = "CSV", 
  uris = ["gs://vtal-land-zone-engenharia/Inventario/sci_comunicados/fechados/2025/202505/comunicados_interrupcao_fe_24052025.csv"]
);

CREATE OR REPLACE TABLE `vtal-sandbox-engenharia.inventario_comunicados_interrupcao.raw_comunicados_interrupcao_fe_24052025` AS
SELECT * FROM `vtal-sandbox-engenharia.inventario_comunicados_interrupcao.temp_comunicados_interrupcao_fe_24052025`;

------------------------------------------------------------------------------------------------------------
/*
CRIA TABELA NO BIGQUERY VIA GCS
*/
CREATE OR REPLACE EXTERNAL TABLE `vtal-sandbox-engenharia.inventario_comunicados_interrupcao.temp_comunicados_interrupcao_fe_27052025`
OPTIONS ( 
  allow_jagged_rows = TRUE, 
  encoding = "UTF-8", 
  field_delimiter = ";", 
  skip_leading_rows = 1, 
  ignore_unknown_values = TRUE, 
  max_bad_records = 100, 
  format = "CSV", 
  uris = ["gs://vtal-land-zone-engenharia/Inventario/sci_comunicados/fechados/2025/202505/comunicados_interrupcao_fe_27052025.csv"]
);

CREATE OR REPLACE TABLE `vtal-sandbox-engenharia.inventario_comunicados_interrupcao.raw_comunicados_interrupcao_fe_27052025` AS
SELECT *,
  "comunicados_interrupcao_fe_27052025.csv" AS arquivo_origem,
  TIMESTAMP("2025-05-27 06:09:04.623822 UTC") AS dt_insert
FROM `vtal-sandbox-engenharia.inventario_comunicados_interrupcao.temp_comunicados_interrupcao_fe_27052025`;

