# =============
# author -------- : Felipe Brum
# date ---------- : 2016-05-29
# description --- : Visualizacao dos empregados das empresas.
# =============
-- drop view vw_empregados_empresas
CREATE OR REPLACE VIEW vw_empregados_empresas as
select
	e.id			as id_empregado,
	p.nm_pessoa		as nm_empregado,
	p.nm_sobrenome		as nm_sobrenome,
	c.id			as id_empresa,
	c.nm_empresa		as nm_empresa,
	c.nm_fantasia		as nm_empresa_fantasia,
	ef.id			as id_empregado_funcao,
	ef.nm_empregado_funcao	as nm_funcao,
	ef.ds_abreviacao	as ds_funcao_abreviacao
from
	tb_empregado 			as e
	inner join tb_pessoa 		as p
		on p.id = e.id_pessoa
	inner join tb_empresa 		as c
		on c.id = e.id_empresa
	inner join tb_empregado_funcao 	as ef
		on ef.id = e.id_empregado_funcao
order by
	p.nm_pessoa