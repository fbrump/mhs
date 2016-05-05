/* =============
author -------- : Felipe Brum
date ---------- : 2016-05-05
description --- : Visualizacao dos empregados das empresas.
============= */
-- drop view vw_empregados_empresas
CREATE OR REPLACE VIEW vw_empregados_empresas as
select
	e.id			as id_empregado,
	p.nome			as nm_empregado,
	p.sobrenome		as nm_sobrenome,
	c.id			as id_empresa,
	c.nome			as nm_empresa,
	c.nome_fantasia		as nm_empresa_fantasia,
	ef.id			as id_empregado_funcao,
	ef.nome			as nm_funcao,
	ef.abreviacao		as ds_funcao_abreviacao
from
	empregado 			as e
	inner join pessoa 		as p
		on p.id = e.id_pessoa
	inner join empresa 		as c
		on c.id = e.id_empresa
	inner join empregado_funcao 	as ef
		on ef.id = e.id_empregado_funcao
order by
	p.nome