-- Insere registros novos que não contem na tabela tbl_duto_historico pelo FID
INSERT INTO `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.tbl_duto_historico` 
(FID, FID_FORMACAO, SISTEMA, DESCRICAO, DH_EXECUCAO)
SELECT 
  CAST(t1.FID AS INT64) AS FID,
  CAST(t1.FID_FORMACAO AS INT64) AS FID_FORMACAO, 
  t1.SISTEMA,
  'Registro novo' AS DESCRICAO,
  CURRENT_TIMESTAMP() AS DH_EXECUCAO
FROM
  `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.vw_dutos_unificados` t1
LEFT JOIN
  `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.tbl_dutos_unificados` t2
ON
  t1.FID = t2.FID AND t1.fid_formacao = t2.fid_formacao
WHERE
  t2.FID IS NULL 
;
--698.498

-- Insere as novas linhas que estão listadas na tabela tbl_duto_historico
INSERT INTO `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.tbl_dutos_unificados` 
SELECT 
  t1.*
FROM
  `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.vw_dutos_unificados` t1
INNER JOIN
  `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.tbl_duto_historico` t2
ON
  CAST(t1.FID AS INT64) = t2.FID and (CAST(t1.FID_FORMACAO AS INT64) = t2.FID_FORMACAO or t2.FID_FORMACAO IS NULL)
WHERE
  t2.Atualizacao IS NULL and descricao = 'Registro novo'
;
--698.551

-- Atualiza o campo Atualizacao com True dos registros que foram inseridos na tabela unificada
UPDATE `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.tbl_duto_historico` AS t1
SET Atualizacao = TRUE
FROM `vtal-sandbox-engenharia.inventario_auditoria_rede_externa.tbl_dutos_unificados` AS t2
WHERE
  t1.FID = CAST(t2.FID AS INT64)
  AND (CAST(t2.FID_FORMACAO AS INT64) = t1.FID_FORMACAO or t1.FID_FORMACAO IS NULL)
  AND t1.descricao = 'Registro novo'
  AND t1.Atualizacao IS NULL;
--368.020