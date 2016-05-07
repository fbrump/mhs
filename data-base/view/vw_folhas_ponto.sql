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
	fp.nu_ano,
	fp.nu_mes,
	fp.hr_carga_horaria,
	-- FOLHA PONTO STATUS
	fps.id as id_folha_ponto_status,
	fps.nm_folha_ponto_status,
	-- LANCAMENTO HORAS
	lh.id as id_lancamento_horas,
	lh.nu_dia_mes,
	-- DIA SEMANA
	ds.id as id_dia_semana,
	ds.sg_dia_semana,
	-- ANEXO
	count(lha.*) as count_anexos
from
	tb_folha_ponto as fp
	inner join tb_folha_ponto_status as fps
		on fps.id = fp.id_folha_ponto_status
	left join tb_lancamento_horas as lh
		on lh.id_folha_ponto = fp.id
	left join tb_dia_semana as ds
		on ds.id = lh.id_dia_semana
	left join tb_lancamento_horas_anexo as lha
		on lha.id_lancamento_horas = lh.id
group by
	-- FOLHA PONTO
	fp.id_empregado,
	fp.id,
	fp.nu_ano,
	fp.nu_mes,
	fp.hr_carga_horaria,
	-- FOLHA PONTO STATUS
	fps.id,
	fps.nm_folha_ponto_status,
	-- LANCAMENTO HORAS
	lh.id,
	lh.nu_dia_mes,
	-- DIA SEMANA
	ds.id,
	ds.sg_dia_semana
order by
	fp.nu_ano,
	fp.nu_mes