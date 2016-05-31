/* 
	SISTEMA DE GERENCIAMENTO DE HORAS
*/
use db_mhs;
/* =========================
PESSOA
========================= */
CREATE TABLE tb_pessoa(
	id 				serial not null COMMENT 'Identificador da pessoa',
	nm_pessoa 		varchar(255) not null COMMENT 'Nome da pessoa',
	nm_sobrenome 	varchar(400) COMMENT 'Sobrenome da pessoa',
	dt_nascimento 	date COMMENT 'Data de nascimento da pessoa',
	
	CONSTRAINT pk_pessoa PRIMARY KEY (id)
);
ALTER TABLE tb_pessoa COMMENT = 'Tabela que armazena as informações das pessoas';

/* === INSERT ====*/
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Rick', 'Fazollo', '1990-04-01');
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Bruno', 'Silva', '1984-01-21');
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Rafael', 'Carvalho', '1980-11-27');
INSERT INTO tb_pessoa (nm_pessoa, nm_sobrenome, dt_nascimento) VALUES ('Steve', 'Jobs', '1991-09-15');

/* =========================
EMPRESA
========================= */
CREATE TABLE tb_empresa (
	id 			serial not null COMMENT 'Identificador da empresa',
	nm_empresa 	varchar(300) not null COMMENT 'Nome registrado da empresa',
	nm_fantasia varchar(500) COMMENT 'Nome fantasia da empresa',
	
	CONSTRAINT pk_empresa PRIMARY KEY (id)
);
ALTER TABLE tb_empresa COMMENT = 'Tabela que armazena as informações das empresas';

/* === INSERT ====*/
INSERT INTO tb_empresa (nm_empresa, nm_fantasia) VALUES ('Technology', 'T - Desenvolvimento e soluções de softwares');
INSERT INTO tb_empresa (nm_empresa, nm_fantasia) VALUES ('Analisy Technology Research', 'ATR');
INSERT INTO tb_empresa (nm_empresa, nm_fantasia) VALUES ('Business Tech Solutions S.A.', 'Soluções em Tecnologias de Negócios');

/* =========================
EMPREGADO FUNCAO
========================= */
CREATE TABLE tb_empregado_funcao (
	id 					serial not null COMMENT 'Identificador da função do empregado',
	nm_empregado_funcao varchar(255) not null COMMENT 'Nome da função do empregado',
	ds_abreviacao 		varchar(100) COMMENT 'Descrição da abreviação',
	
	CONSTRAINT pk_empregado_funcao PRIMARY KEY (id)
);
ALTER TABLE tb_empregado_funcao COMMENT = 'Tabela que armazena as informações das funções que os empregados podem exercer na empresa';

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
	id 						serial not null COMMENT 'Identificador do empregado',
	id_empresa 				BIGINT UNSIGNED not null COMMENT 'Identificador da empresa',
	id_pessoa 				BIGINT UNSIGNED not null COMMENT 'Identificador da pessoa',
	id_empregado_funcao 	BIGINT UNSIGNED not null COMMENT 'Identificador da fução do empregado',
	
	CONSTRAINT pk_empregado 		PRIMARY KEY (id),
	CONSTRAINT fk_empregado_empresa FOREIGN KEY (id_empresa) REFERENCES tb_empresa(id),
	CONSTRAINT fk_empregado_pessoa 	FOREIGN KEY (id_pessoa) REFERENCES tb_pessoa(id),
	CONSTRAINT fk_empregado_funcao 	FOREIGN KEY (id_empregado_funcao) REFERENCES tb_empregado_funcao(id),
	CONSTRAINT uq_empregado_key 	UNIQUE(id_empresa, id_pessoa, id_empregado_funcao)
);

ALTER TABLE tb_empregado COMMENT = 'Tabela que armazena as informações dos empregados';
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
	id 						serial not null COMMENT 'Identificador do estatus da folha de ponto',
	nm_folha_ponto_status 	varchar(255) not null COMMENT 'Identificador do estatus da folha de ponto',
	
	CONSTRAINT pk_folha_ponto_status PRIMARY KEY (id),
	CONSTRAINT uq_folha_ponto_status UNIQUE(nm_folha_ponto_status)
);
ALTER TABLE tb_folha_ponto_status COMMENT = 'Tabela que armazena as informações dos estatus das folhas de ponto';
/* === INSERT ====*/
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Criada');
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Alimentando');
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Validando');
INSERT INTO tb_folha_ponto_status (nm_folha_ponto_status) values ('Fechada');

/* =========================
FOLHA PONTO
========================= */
CREATE TABLE tb_folha_ponto(
	id 						serial not null COMMENT 'Identificador do estatus da folha de ponto',
	id_empregado 			BIGINT UNSIGNED not null COMMENT 'Identificador do empregado',
	id_folha_ponto_status 	BIGINT UNSIGNED not null COMMENT 'Identificador do estatus da folha de ponto',
	nu_mes 					smallint not null COMMENT 'Número do mês da folha de ponto',
	nu_ano 					smallint not null COMMENT 'Número do ano da folha de ponto',
	hr_carga_horaria 		time null COMMENT 'Horas da carga horária utilizada como base na folha de ponto',
	
	CONSTRAINT pk_folha_ponto 					 PRIMARY KEY (id),
	CONSTRAINT fk_folha_ponto_empregado 		 FOREIGN KEY (id_empregado) REFERENCES tb_empregado(id),
	CONSTRAINT fk_folha_ponto_folha_ponto_status FOREIGN KEY (id_folha_ponto_status) REFERENCES tb_folha_ponto_status(id),
	CONSTRAINT uq_folha_ponto 					 UNIQUE(id_empregado, nu_mes, nu_ano)
);

ALTER TABLE tb_folha_ponto COMMENT = 'Tabela que armazena as informações das folhas de ponto';

/* === INSERT ====*/
INSERT INTO tb_folha_ponto (id_empregado, id_folha_ponto_status, nu_mes, nu_ano) VALUES (1, 1,01, 2015);
INSERT INTO tb_folha_ponto (id_empregado, id_folha_ponto_status, nu_mes, nu_ano, hr_carga_horaria) VALUES (1, 1,02, 2015, '08:00:00');

/* =========================
DIA SEMANA
========================= */
CREATE TABLE tb_dia_semana (
	id 				smallint not null COMMENT 'Identificador do estatus do dia da semana',
	nm_dia_semana 	varchar(100) not null COMMENT 'Nome do dia da semana',
	sg_dia_semana 	varchar(3) not null COMMENT 'Sigla do dia da semana',

	CONSTRAINT pk_dia_semana PRIMARY KEY (id),
	CONSTRAINT uq_dia_semana UNIQUE(nm_dia_semana, sg_dia_semana)
);

ALTER TABLE tb_dia_semana COMMENT = 'Tabela que armazena as informações dos dias da semana';

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
	id 						serial not null COMMENT 'Identificador do estatus do lançamento das horas',
	id_folha_ponto 			BIGINT UNSIGNED not null COMMENT 'Identificador da folha de ponto',
	id_dia_semana 			smallint not null COMMENT 'Identificador do dia da semana',
	nu_dia_mes 				smallint not null COMMENT 'Número do dia do mês',
	hr_entrada 				time not null COMMENT 'Horário de entrada',
	hr_entreda_intervalo 	time null COMMENT 'Horário de entrada no intervalo',
	hr_saida_intervalo 		time null COMMENT 'Horário da saída do intervalo',
	hr_saida 				time not null COMMENT 'Horário da saída',
	fl_dia_descanso 		boolean not null default '0' COMMENT 'Define se é dia de descanço ou não',
	fl_feriado 				boolean not null default '0' COMMENT 'Define se é feriado ou não',
	
	CONSTRAINT pk_lancamento_horas 				PRIMARY KEY (id),
	CONSTRAINT fk_lancamento_horas_folha_ponto 	FOREIGN KEY (id_folha_ponto) REFERENCES tb_folha_ponto(id),
	CONSTRAINT fk_lancamento_horas_dia_semana 	FOREIGN KEY (id_dia_semana) REFERENCES tb_dia_semana(id)
);

ALTER TABLE tb_lancamento_horas COMMENT = 'Tabela que armazena as informações dos lançamentos das horas do dia.';

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
	id 				serial not null COMMENT 'Identificador do estatus do tipo de anexo',
	nm_anexo_tipo 	varchar(255) not null COMMENT 'Nome do tipo de anexo',

	CONSTRAINT pk_anexo_tipo PRIMARY KEY (id),
	CONSTRAINT uq_anexo_tipo UNIQUE(nm_anexo_tipo)
);

ALTER TABLE tb_anexo_tipo COMMENT 'Tabela que armazena as informações dos tipos de anexos';

/* === INSERT ====*/
INSERT INTO tb_anexo_tipo (nm_anexo_tipo) VALUES ('Atestado Médico');
INSERT INTO tb_anexo_tipo (nm_anexo_tipo) VALUES ('Atestado Dentista');

/* =========================
ANEXO
========================= */
CREATE TABLE tb_anexo (
	id 				serial not null COMMENT 'Identificador do anexo',
	id_anexo_tipo 	BIGINT UNSIGNED not null COMMENT 'Identificador do anexo',
	nm_anexo 		varchar(255) not null COMMENT 'Nome do anexo',
	ds_anexo 		varchar(500) null COMMENT 'Descrição do anexo, comentando e especificando',
	ds_link 		varchar(1000) null COMMENT 'Link, URL, do arquivo anexado Evernote, Dropbox, etc',

	CONSTRAINT pk_anexo 			PRIMARY KEY (id),
	CONSTRAINT fk_anexo_anexo_tipo 	FOREIGN KEY (id_anexo_tipo) REFERENCES tb_anexo_tipo(id)
);

ALTER TABLE tb_anexo COMMENT 'Tabela que armazena as informações dos anexos';

/* === INSERT ====*/
INSERT INTO tb_anexo (id_anexo_tipo, nm_anexo, ds_anexo, ds_link) VALUES (1, 'ida-ao-medico', null, 'http://jasonfrasca.com/wp-content/uploads/2013/10/screenshot3.png');
INSERT INTO tb_anexo (id_anexo_tipo, nm_anexo, ds_anexo, ds_link) VALUES (2, 'Declaração do dentista', 'Necessitei ir ao dentista devida a uma dor de dente que senti recentimente', 'http://jasonfrasca.com/wp-content/uploads/2013/10/screenshot3.png');
INSERT INTO tb_anexo (id_anexo_tipo, nm_anexo, ds_anexo, ds_link) VALUES (1, 'ida-ao-medico', null, 'http://www.evernote.com/l/Aag8N6VotYRKpYZqTHDKKqCOgOvfNaROjV0');

/* =========================
LANCAMENTO HORA ANEXO
========================= */
CREATE TABLE tb_lancamento_horas_anexo (
	id_lancamento_horas 	BIGINT UNSIGNED not null COMMENT 'Identificador do lançamento das horas',
	id_anexo 				BIGINT UNSIGNED not null COMMENT 'Identificador do anexo',

	CONSTRAINT pk_lancamento_horas_anexo 					 PRIMARY KEY (id_lancamento_horas, id_anexo),
	CONSTRAINT fk_lancamento_horas_anexo_to_anexo 			 FOREIGN KEY (id_anexo) REFERENCES tb_anexo(id),
	CONSTRAINT fk_lancamento_horas_anexo_to_lancamento_horas FOREIGN KEY (id_lancamento_horas) REFERENCES tb_lancamento_horas(id),
	CONSTRAINT uq_lancamento_horas_anexo 					 UNIQUE(id_lancamento_horas, id_anexo)
);

ALTER TABLE tb_lancamento_horas_anexo COMMENT 'Tabela que armazena as informações dos anexos por lançamentos';

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
