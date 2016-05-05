/* =============
author -------- : Felipe Brum
date ---------- : 2016-05-05
description --- : Visualizacao das folhas de pontos do sistema com a quantidade de anexos.
============= */
-- drop view vw_folhas_ponto
CREATE OR REPLACE  VIEW vw_folhas_ponto as
-- Horarios
select
	-- FOLHA PONTO
	fp.id_empregado,
	fp.id AS id_folha_ponto,
	fp.ano,
	fp.mes,
	fp.carga_horaria,
	-- FOLHA PONTO STATUS
	fps.id as id_folha_ponto_status,
	fps.nome,
	-- LANCAMENTO HORAS
	lh.id as id_lancamento_horas,
	lh.dia_mes,
	-- DIA SEMANA
	ds.id as id_dia_semana,
	ds.sigla,
	-- ANEXO
	count(lha.*) as count_anexos
from
	folha_ponto as fp
	inner join folha_ponto_status as fps
		on fps.id = fp.id_folha_ponto_status
	left join lancamento_horas as lh
		on lh.id_folha_ponto = fp.id
	left join dia_semana as ds
		on ds.id = lh.id_dia_semana
	left join lancamento_horas_anexo as lha
		on lha.id_lancamento_horas = lh.id
group by
	-- FOLHA PONTO
	fp.id_empregado,
	fp.id,
	fp.ano,
	fp.mes,
	fp.carga_horaria,
	-- FOLHA PONTO STATUS
	fps.id,
	fps.nome,
	-- LANCAMENTO HORAS
	lh.id,
	lh.dia_mes,
	-- DIA SEMANA
	ds.id,
	ds.sigla
order by
	fp.ano,
	fp.mes
