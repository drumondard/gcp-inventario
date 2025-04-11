💻 Pelo Console do GCP
Vá até o BigQuery: https://console.cloud.google.com/bigquery

No menu lateral, clique no projeto onde você quer criar o dataset.

Clique em "Criar conjunto de dados".

Preencha:

ID do conjunto de dados (ex: dataset_privado)

Localização: São Paulo, US, etc.

Controle de acesso:

Marque "Controle de acesso a nível de conjunto de dados".

Remova o acesso público (como AllAuthenticatedUsers, se aparecer).

Adicione apenas os usuários ou grupos que você quer que acessem.

Clique em Criar conjunto de dados.

🧾 Via SQL (CLI ou Editor do Console)
sql
Copiar
Editar
CREATE SCHEMA `seu_projeto.dataset_privado`
OPTIONS (
  location="us" -- ou "southamerica-east1" para São Paulo
);
Depois disso, aplique as permissões:

bash
Copiar
Editar
# Conceder acesso somente a um grupo específico
bq update --dataset --source \
<arquivo_json_com_permissoes>.json \
seu_projeto:dataset_privado
Ou edite as permissões diretamente no Console > BigQuery > seu dataset > Compartilhamento.


🛡️ Dicas para deixar o dataset realmente particular
Não conceda acesso ao grupo allAuthenticatedUsers ou allUsers.

Use grupos do Google Workspace, tipo: equipe-ti@empresa.com

Defina permissões mínimas necessárias: roles/bigquery.dataViewer (somente leitura), dataEditor, etc.


----------------------------------------------------
/*
MODELO DE TESTE
*/
--1*-Passo
CREATE SCHEMA `vtal-sandbox-engenharia.dataset_publico`
OPTIONS (
  location = "southamerica-east1"
);

--2*-Passo
CREATE OR REPLACE VIEW `vtal-sandbox-engenharia.dataset_publico.view_dados_publicos` AS
SELECT * FROM `vtal-sandbox-engenharia.inventario_teste_sql.teste_sql_alexandre`;
--3*-Passo
bq update --dataset \
--source=permissao_autorizada.json \
vtal-sandbox-engenharia:dataset_publico



