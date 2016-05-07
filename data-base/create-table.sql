-- SISTEMA DE GERENCIAMENTO DE HORAS

/* =========================
PESSOA
========================= */
CREATE TABLE tb_pessoa(
	id 		serial not null,
	nm_pessoa 	varchar(255) not null,
	nm_sobrenome 	varchar(400),
	dt_nascimento 	date,
	
	CONSTRAINT pk_pessoa PRIMARY KEY (id)
);

COMMENT ON TABLE tb_pessoa IS 'Tabela que armazena as informações das pessoas';

COMMENT ON COLUMN tb_pessoa.id IS 'Identificador da pessoa';
COMMENT ON COLUMN tb_pessoa.nm_pessoa IS 'Nome da pessoa';
COMMENT ON COLUMN tb_pessoa.nm_sobrenome IS 'Sobrenome da pessoa';
COMMENT ON COLUMN tb_pessoa.dt_nascimento IS 'Data de nascimento da pessoa';

/* === INSERT ====*/
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Rick', 'Fazollo', '04-01-1990');
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Bruno', 'Silva', '1984-01-21');
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Rafael', 'Carvalho', '1980-11-27');
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Steve', 'Jobs', '1991-09-15');

/* =========================
EMPRESA
========================= */
CREATE TABLE tb_empresa (
	id 		serial not null,
	nm_empresa 	varchar(300) not null,
	nm_fantasia 	varchar(500),
	
	CONSTRAINT pk_empresa PRIMARY KEY (id)
);

COMMENT ON TABLE tb_empresa IS 'Tabela que armazena as informações das empresas';

COMMENT ON COLUMN tb_empresa.id IS 'Identificador da empresa';
COMMENT ON COLUMN tb_empresa.nm_empresa IS 'Nome registrado da empresa';
COMMENT ON COLUMN tb_empresa.nm_fantasia IS 'Nome fantasia da empresa';

/* === INSERT ====*/
INSERT INTO tb_empresa (nm_empresa, nm_fantasia) VALUES ('Technology', 'T - Desenvolvimento e soluções de softwares');
INSERT INTO tb_empresa (nm_empresa, nm_fantasia) VALUES ('Analisy Technology Research', 'ATR');
INSERT INTO tb_empresa (nm_empresa, nm_fantasia) VALUES ('Business Tech Solutions S.A.', 'Soluções em Tecnologias de Negócios');

/* =========================
EMPREGADO FUNCAO
========================= */
CREATE TABLE tb_empregado_funcao (
	id 			serial not null,
	nm_empregado_funcao 	varchar(255) not null,
	ds_abreviacao 		varchar(100),
	
	CONSTRAINT pk_empregado_funcao PRIMARY KEY (id)
);


COMMENT ON TABLE tb_empregado_funcao IS 'Tabela que armazena as informações das funções que os empregados podem exercer na empresa';

COMMENT ON COLUMN tb_empregado_funcao.id IS 'Identificador da função do empregado';
COMMENT ON COLUMN tb_empregado_funcao.nm_empregado_funcao IS 'Nome da função do empregado';
COMMENT ON COLUMN tb_empregado_funcao.ds_abreviacao IS 'Descrição da abreviação';

/* === INSERT ====*/
INSERT INTO tb_empregado_funcao(nm_empregado_funcao,ds_abreviacao) VALUES ('Desenvolvedor Júnior', 'Dev Jr');
INSERT INTO tb_empregado_funcao(nm_empregado_funcao,ds_abreviacao) VALUES ('Desenvolvedor Pleno', 'Dev Pl');
INSERT INTO tb_empregado_funcao(nm_empregado_funcao,ds_abreviacao) VALUES ('Desenvolvedor Senior', 'Dev Sr');
INSERT INTO tb_empregado_funcao(nm_empregado_funcao,ds_abreviacao) VALUES ('Analista Desenvolvedor Junior', 'Anl Dev Jr');
INSERT INTO tb_empregado_funcao(nm_empregado_funcao,ds_abreviacao) VALUES ('Analista Desenvolvedor Pleno', 'Anl Dev Pl');
INSERT INTO tb_empregado_funcao(nm_empregado_funcao,ds_abreviacao) VALUES ('Analista Desenvolvedor Senior', 'Anl Dev Sr');

/* =========================
EMPREGADO
========================= */
CREATE TABLE tb_empregado (
	id 			serial not null,
	id_empresa 		integer not null,
	id_pessoa 		integer not null,
	id_empregado_funcao 	integer not null,
	
	CONSTRAINT pk_empregado 	PRIMARY KEY (id),
	CONSTRAINT fk_empregado_empresa FOREIGN KEY (id_empresa) REFERENCES tb_empresa(id),
	CONSTRAINT fk_empregado_pessoa 	FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa(id),
	CONSTRAINT fk_empregado_funcao 	FOREIGN KEY (id_empregado_funcao) REFERENCES tb_empregado_funcao(id),
	CONSTRAINT uq_empregado_key 	UNIQUE(id_empresa, id_pessoa, id_empregado_funcao)
);

COMMENT ON TABLE tb_empregado IS 'Tabela que armazena as informações dos empregados';

COMMENT ON COLUMN tb_empregado.id IS 'Identificador do empregado';
COMMENT ON COLUMN tb_empregado.id_empresa IS 'Identificador da empresa';
COMMENT ON COLUMN tb_empregado.id_pessoa IS 'Identificador da pessoa';
COMMENT ON COLUMN tb_empregado.id_empregado_funcao IS 'Identificador da fução do empregado';

/* === INSERT ====*/
INSERT INTO tb_empregado (id_empresa, id_pessoa, id_empregado_funcao) VALUES (1, 1, 2);
INSERT INTO tb_empregado (id_empresa, id_pessoa, id_empregado_funcao) VALUES (1, 2, 1);
INSERT INTO tb_empregado (id_empresa, id_pessoa, id_empregado_funcao) VALUES (1, 3, 3);
INSERT INTO tb_empregado (id_empresa, id_pessoa, id_empregado_funcao) VALUES (1, 4, 5);

select * from tb_pessoa;
select * from tb_empresa;
select * from tb_empregado_funcao;
select * from tb_empregado;

/* =========================
==== MODULO 2 - MAIS FOCADO NAS HORAS E LANCAMENTO
========================= */

/* =========================
FOLHA PONTO STATUS
========================= */
CREATE TABLE tb_folha_ponto_status (
	id 			serial not null,
	nm_folha_ponto_status 	varchar(255) not null,
	
	CONSTRAINT pk_folha_ponto_status PRIMARY KEY (id),
	CONSTRAINT uq_folha_ponto_status UNIQUE(nm_folha_ponto_status)
);

COMMENT ON TABLE tb_folha_ponto_status IS 'Tabela que armazena as informações dos estatus das folhas de ponto';

COMMENT ON COLUMN tb_folha_ponto_status.id IS 'Identificador do estatus da folha de ponto';
COMMENT ON COLUMN tb_folha_ponto_status.nm_folha_ponto_status IS 'Identificador do estatus da folha de ponto';

/* === INSERT ====*/
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Criada');
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Alimentando');
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Validando');
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Fechada');

/* =========================
FOLHA PONTO
========================= */
CREATE TABLE tb_folha_ponto(
	id 			serial not null,
	id_empregado 		integer not null,
	id_folha_ponto_status 	integer not null,
	nu_mes 			smallint not null,
	nu_ano 			smallint not null,
	hr_carga_horaria 	time null,
	
	CONSTRAINT pk_folha_ponto 			PRIMARY KEY (id),
	CONSTRAINT fk_folha_ponto_empregado 		FOREIGN KEY (id_empregado) REFERENCES tb_empregado(id),
	CONSTRAINT fk_folha_ponto_folha_ponto_status 	FOREIGN KEY (id_folha_ponto_status) REFERENCES tb_folha_ponto_status(id),
	CONSTRAINT uq_folha_ponto 			UNIQUE(id_empregado, nu_mes, nu_ano)
);

COMMENT ON TABLE tb_folha_ponto IS 'Tabela que armazena as informações das folhas de ponto';

COMMENT ON COLUMN tb_folha_ponto.id IS 'Identificador do estatus da folha de ponto';
COMMENT ON COLUMN tb_folha_ponto.id_empregado IS 'Identificador do empregado';
COMMENT ON COLUMN tb_folha_ponto.id_folha_ponto_status IS 'Identificador do estatus da folha de ponto';
COMMENT ON COLUMN tb_folha_ponto.nu_mes IS 'Número do mês da folha de ponto';
COMMENT ON COLUMN tb_folha_ponto.nu_ano IS 'Número do ano da folha de ponto';
COMMENT ON COLUMN tb_folha_ponto.hr_carga_horaria IS 'Horas da carga horária utilizada como base na folha de ponto';

/* === INSERT ====*/
INSERT INTO tb_folha_ponto (id_empregado, id_folha_ponto_status, nu_mes, nu_ano) VALUES (1, 1,01, 2015);
INSERT INTO tb_folha_ponto (id_empregado, id_folha_ponto_status, nu_mes, nu_ano, hr_carga_horaria) VALUES (1, 1,02, 2015, '08:00:00');

/* =========================
DIA SEMANA
========================= */
CREATE TABLE tb_dia_semana (
	id 		smallint not null,
	nm_dia_semana 	varchar(100) not null,
	sg_dia_semana 	varchar(3) not null,

	CONSTRAINT pk_dia_semana PRIMARY KEY (id),
	CONSTRAINT uq_dia_semana UNIQUE(nm_dia_semana, sg_dia_semana)
);

COMMENT ON TABLE tb_dia_semana IS 'Tabela que armazena as informações dos dias da semana';

COMMENT ON COLUMN tb_dia_semana.id IS 'Identificador do estatus do dia da semana';
COMMENT ON COLUMN tb_dia_semana.nm_dia_semana IS 'Nome do dia da semana';
COMMENT ON COLUMN tb_dia_semana.sg_dia_semana IS 'Sigla do dia da semana';

/* === INSERT ====*/
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (1, 'Domingo', 'Dom');
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (2, 'Segunda-feira', 'Seg');
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (3, 'Terça-feira', 'Ter');
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (4, 'Quarta-feira', 'Qua');
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (5, 'Quinta-feira', 'Qui');
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (6, 'Sexta-feira', 'Sex');
INSERT INTO tb_dia_semana(id, nm_dia_semana, sg_dia_semana) VALUES (7, 'Sábado', 'Sab');

/* =========================
LANCAMENTO HORAS
========================= */
CREATE TABLE tb_lancamento_horas (
	id 			serial not null,
	id_folha_ponto 		integer not null,
	id_dia_semana 		smallint not null,
	nu_dia_mes 		smallint not null,
	hr_entrada 		time not null,
	hr_entreda_intervalo 	time null,
	hr_saida_intervalo 	time null,
	hr_saida 		time not null,
	fl_dia_descanso 	boolean not null default('0'),
	fl_feriado 		boolean not null default('0'),
	
	CONSTRAINT pk_lancamento_horas PRIMARY KEY (id),
	CONSTRAINT fk_lancamento_horas_folha_ponto FOREIGN KEY (id_folha_ponto) REFERENCES tb_folha_ponto(id),
	CONSTRAINT fk_lancamento_horas_dia_semana FOREIGN KEY (id_dia_semana) REFERENCES tb_dia_semana(id)
);

COMMENT ON TABLE tb_lancamento_horas IS 'Tabela que armazena as informações dos lançamentos das horas do dia.';

COMMENT ON COLUMN tb_lancamento_horas.id IS 'Identificador do estatus do lançamento das horas';
COMMENT ON COLUMN tb_lancamento_horas.id_folha_ponto IS 'Identificador da folha de ponto';
COMMENT ON COLUMN tb_lancamento_horas.id_dia_semana IS 'Identificador do dia da semana';
COMMENT ON COLUMN tb_lancamento_horas.nu_dia_mes IS 'Número do dia do mês';
COMMENT ON COLUMN tb_lancamento_horas.hr_entrada IS 'Horário de entrada';
COMMENT ON COLUMN tb_lancamento_horas.hr_entreda_intervalo IS 'Horário de entrada no intervalo';
COMMENT ON COLUMN tb_lancamento_horas.hr_saida_intervalo IS 'Horário da saída do intervalo';
COMMENT ON COLUMN tb_lancamento_horas.hr_saida IS 'Horário da saída';
COMMENT ON COLUMN tb_lancamento_horas.fl_dia_descanso IS 'Define se é dia de descanço ou não';
COMMENT ON COLUMN tb_lancamento_horas.fl_feriado IS 'Define se é feriado ou não';

/* === INSERT ====*/
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (1, 5, 1, '08:00', null, null, '17:00', false, true);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (1, 6, 2, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (1, 7, 3, '00:00', null, null, '00:00', true, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (1, 1, 4, '00:00', null, null, '00:00', true, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (1, 2, 5, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 1, 1, '00:00', null, null, '00:00', true, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 2, 2, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 3, 3, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 4, 4, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 5, 5, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 6, 6, '08:00', '12:00', '13:00', '17:00', false, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 7, 7, '00:00', null, null, '00:00', true, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 1, 8, '00:00', null, null, '00:00', true, false);
INSERT INTO tb_lancamento_horas (id_folha_ponto, id_dia_semana, nu_dia_mes,hr_entrada, hr_entreda_intervalo, hr_saida_intervalo, hr_saida, fl_dia_descanso, fl_feriado)
VALUES (2, 2, 9, '08:00', '12:00', '13:00', '17:00', '0', '1');


/* =========================
ANEXO TIPO
========================= */
CREATE TABLE tb_anexo_tipo (
	id 		serial not null,
	nm_anexo_tipo 	varchar(255) not null,

	CONSTRAINT pk_anexo_tipo PRIMARY KEY (id),
	CONSTRAINT uq_anexo_tipo UNIQUE(nm_anexo_tipo)
);

COMMENT ON TABLE tb_anexo_tipo IS 'Tabela que armazena as informações dos tipos de anexos';

COMMENT ON COLUMN tb_anexo_tipo.id IS 'Identificador do estatus do tipo de anexo';
COMMENT ON COLUMN tb_anexo_tipo.nm_anexo_tipo IS 'Nome do tipo de anexo';

/* === INSERT ====*/
INSERT INTO tb_anexo_tipo (nm_anexo_tipo) VALUES ('Atestado Médico');
INSERT INTO tb_anexo_tipo (nm_anexo_tipo) VALUES ('Atestado Dentista');

/* =========================
ANEXO
========================= */
CREATE TABLE tb_anexo (
	id 		serial not null,
	id_anexo_tipo 	integer not null,
	nm_anexo 	varchar(255) not null,
	ds_anexo 	varchar(500) null,
	ds_link 	varchar(1000) null,

	CONSTRAINT pk_anexo PRIMARY KEY (id),
	CONSTRAINT fk_anexo_anexo_tipo FOREIGN KEY (id_anexo_tipo) REFERENCES tb_anexo_tipo(id)
);

COMMENT ON TABLE tb_anexo IS 'Tabela que armazena as informações dos anexos';

COMMENT ON COLUMN tb_anexo.id IS 'Identificador do anexo';
COMMENT ON COLUMN tb_anexo.id_anexo_tipo IS 'Identificador do anexo';
COMMENT ON COLUMN tb_anexo.nm_anexo IS 'Nome do anexo';
COMMENT ON COLUMN tb_anexo.ds_anexo IS 'Descrição do anexo, comentando e especificando';
COMMENT ON COLUMN tb_anexo.ds_link IS 'Link, URL, do arquivo anexado Evernote, Dropbox, etc';

/* === INSERT ====*/
INSERT INTO tb_anexo (id_anexo_tipo, nm_anexo, ds_anexo, ds_link) VALUES (1, 'ida-ao-medico', null, 'http://jasonfrasca.com/wp-content/uploads/2013/10/screenshot3.png');
INSERT INTO tb_anexo (id_anexo_tipo, nm_anexo, ds_anexo, ds_link) VALUES (2, 'Declaração do dentista', 'Necessitei ir ao dentista devida a uma dor de dente que senti recentimente', 'http://jasonfrasca.com/wp-content/uploads/2013/10/screenshot3.png');
INSERT INTO tb_anexo (id_anexo_tipo, nm_anexo, ds_anexo, ds_link) VALUES (1, 'ida-ao-medico', null, 'http://www.evernote.com/l/Aag8N6VotYRKpYZqTHDKKqCOgOvfNaROjV0');

/* =========================
LANCAMENTO HORA ANEXO
========================= */
CREATE TABLE tb_lancamento_horas_anexo (
	id_lancamento_horas 	integer not null,
	id_anexo 		integer not null,

	CONSTRAINT pk_lancamento_horas_anexo 				PRIMARY KEY (id_lancamento_horas, id_anexo),
	CONSTRAINT fk_lancamento_horas_anexo_to_anexo 			FOREIGN KEY (id_anexo) REFERENCES tb_anexo(id),
	CONSTRAINT fk_lancamento_horas_anexo_to_lancamento_horas 	FOREIGN KEY (id_lancamento_horas) REFERENCES tb_lancamento_horas(id),
	CONSTRAINT uq_lancamento_horas_anexo 				UNIQUE(id_lancamento_horas, id_anexo)
);

COMMENT ON TABLE tb_lancamento_horas_anexo IS 'Tabela que armazena as informações dos anexos por lançamentos';

COMMENT ON COLUMN tb_lancamento_horas_anexo.id_lancamento_horas IS 'Identificador do lançamento das horas';
COMMENT ON COLUMN tb_lancamento_horas_anexo.id_anexo IS 'Identificador do anexo';

/* === INSERT ====*/
INSERT INTO tb_lancamento_horas_anexo (id_lancamento_horas, id_anexo) VALUES (1, 1);
INSERT INTO tb_lancamento_horas_anexo (id_lancamento_horas, id_anexo) VALUES (2, 1);
INSERT INTO tb_lancamento_horas_anexo (id_lancamento_horas, id_anexo) VALUES (3, 2);

select * from tb_lancamento_horas_anexo;
select * from tb_anexo_tipo;
select * from tb_anexo;  
select * from tb_dia_semana;
select * from tb_folha_ponto_status;
select * from tb_folha_ponto;
select * from tb_lancamento_horas;

/* =========================
==== LIMPAR A BASE
========================= */
/*
-- === DELETA AS TABELAS ====

drop view vw_empregados_empresas;
drop view vw_folhas_ponto;

-- === DELETA AS TABELAS ====

drop table tb_lancamento_horas_anexo;
drop table tb_anexo;
drop table tb_anexo_tipo;
drop table tb_lancamento_horas;
drop table tb_folha_ponto;
drop table tb_folha_ponto_status;
drop table tb_dia_semana;
drop table tb_empregado;
drop table tb_pessoa;
drop table tb_empresa;
drop table tb_empregado_funcao;

*/
