CREATE OR REPLACE VIEW vw_empregados_empresas as
select
	e.id			as idEmpregado,
	p.nome			as nmEmpregado,
	p.sobrenome		as nmSobrenome,
	c.nome			as nmEmpresa,
	c.nome_fantasia		as nmEmpresaFantasia,
	ef.nome			as nmFuncao,
	ef.abreviacao		as dsFuncaoAbreviacao
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