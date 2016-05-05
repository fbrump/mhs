-- SISTEMA DE GERENCIAMENTO DE HORAS

/* =========================
PESSOA
========================= */
CREATE TABLE pessoa(
	id serial not null,
	nome varchar(255) not null,
	sobrenome varchar(400),
	data_nascimento date,
	CONSTRAINT pk_pessoa PRIMARY KEY (id)
);

/* === INSERT ====*/
insert into pessoa (nome, sobrenome, data_nascimento) values ('Rick', 'Ventura Cordeiro', '1990-01-04');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Bruno', 'Silva Pereira', '1984-01-21');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Rafael', 'Carvalho dos Santos', '1980-11-27');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Steve', 'Jobs Kowalski', '1991-09-15');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Steve', 'Jobs Kowalski', '1991-12-01');

/* =========================
EMPRESA
========================= */
create table empresa (
	id serial not null,
	nome varchar(300) not null,
	nome_fantasia varchar(500),
	CONSTRAINT pk_empresa PRIMARY KEY (id)
);

/* === INSERT ====*/
insert into empresa (nome, nome_fantasia) 
values ('Thecnolgoy', 'T - Desenvolvimento e soluções de softwares');

/* =========================
EMPREGADO FUNCAO
========================= */
create table empregado_funcao (
	id serial not null,
	nome varchar(255) not null,
	abreviacao varchar(100),
	CONSTRAINT pk_empregado_funcao PRIMARY KEY (id)
);

/* === INSERT ====*/
insert into empregado_funcao(nome,abreviacao) values('Desenvolvedor Júnior', 'Dev Jr');
insert into empregado_funcao(nome,abreviacao) values('Desenvolvedor Pleno', 'Dev Pl');
insert into empregado_funcao(nome,abreviacao) values('Desenvolvedor Senior', 'Dev Sr');
insert into empregado_funcao(nome,abreviacao) values('Analista Desenvolvedor Junior', 'Anl Dev Jr');
insert into empregado_funcao(nome,abreviacao) values('Analista Desenvolvedor Pleno', 'Anl Dev Pl');
insert into empregado_funcao(nome,abreviacao) values('Analista Desenvolvedor Senior', 'Anl Dev Sr');

/* =========================
EMPREGADO
========================= */
create table empregado (
	id serial not null,
	id_empresa integer not null,
	id_pessoa integer not null,
	id_empregado_funcao integer not null,
	CONSTRAINT pk_empregado PRIMARY KEY (id),
	CONSTRAINT fk_empregado_empresa FOREIGN KEY (id_empresa) REFERENCES empresa(id),
	CONSTRAINT fk_empregado_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa(id),
	CONSTRAINT fk_empregado_funcao FOREIGN KEY (id_empregado_funcao) REFERENCES empregado_funcao(id),
	CONSTRAINT uq_empregado_key UNIQUE(id_empresa, id_pessoa, id_empregado_funcao)
);

/* === INSERT ====*/
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 1, 2);
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 2, 1);
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 3, 3);
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 4, 5);

/* === SELECT MODULO ====*/
select * from pessoa;
select * from empresa;
select * from empregado_funcao;
select * from empregado;

/* =========================
==== MODULO 2 - MAIS FOCADO NAS HORAS E LANCAMENTO
========================= */

/* =========================
FOLHA PONTO STATUS
========================= */
create table folha_ponto_status (
	id serial not null,
	nome varchar(255) not null,
	
	CONSTRAINT pk_folha_ponto_status PRIMARY KEY (id),
	CONSTRAINT uq_folha_ponto_status UNIQUE(nome)
);

/* === INSERT ====*/
insert into folha_ponto_status (nome) values ('Criada');
insert into folha_ponto_status (nome) values ('Alimentando');
insert into folha_ponto_status (nome) values ('Validando');
insert into folha_ponto_status (nome) values ('Fechada');

/* =========================
FOLHA PONTO
========================= */
create table folha_ponto(
	id serial not null,
	id_empregado integer not null,
	id_folha_ponto_status integer not null,
	mes integer not null,
	ano integer not null,
	carga_horaria time null,
	
	CONSTRAINT pk_folha_ponto PRIMARY KEY (id),
	CONSTRAINT fk_folha_ponto_empregado FOREIGN KEY (id_empregado) REFERENCES empregado(id),
	CONSTRAINT fk_folha_ponto_folha_ponto_status FOREIGN KEY (id_folha_ponto_status) REFERENCES folha_ponto_status(id),
	CONSTRAINT uq_folha_ponto UNIQUE(id_empregado,mes, ano)
);

/* === INSERT ====*/
insert into folha_ponto (id_empregado, id_folha_ponto_status, mes, ano) values (1, 1,01, 2015);
insert into folha_ponto (id_empregado, id_folha_ponto_status, mes, ano, carga_horaria) values (1, 1,02, 2015, '08:00:00');

/* =========================
DIA SEMANA
========================= */
create table dia_semana (
	id serial not null,
	nome varchar(255) not null,
	sigla varchar(10) not null,

	CONSTRAINT pk_dia_semana PRIMARY KEY (id),
	CONSTRAINT uq_dia_semana UNIQUE(nome, sigla)
);

/* === INSERT ====*/
insert into dia_semana(nome, sigla) values ('Domingo', 'Dom');
insert into dia_semana(nome, sigla) values ('Segunda-feira', 'Seg');
insert into dia_semana(nome, sigla) values ('Terça-feira', 'Ter');
insert into dia_semana(nome, sigla) values ('Quarta-feira', 'Qua');
insert into dia_semana(nome, sigla) values ('Quinta-feira', 'Qui');
insert into dia_semana(nome, sigla) values ('Sexta-feira', 'Sex');
insert into dia_semana(nome, sigla) values ('Sábado', 'Sab');
/* =========================
LANCAMENTO HORAS
========================= */
create table lancamento_horas (
	id serial not null,
	id_folha_ponto integer not null,
	id_dia_semana integer not null,
	dia_mes integer not null,
	hora_entrada time not null,
	hora_entreda_intervalo time null,
	hora_saida_intervalo time null,
	hora_saida time not null,
	flag_dia_descanso boolean default(false),
	flag_feriado boolean default(false),
	
	CONSTRAINT pk_lancamento_horas PRIMARY KEY (id),
	CONSTRAINT fk_lancamento_horas_folha_ponto FOREIGN KEY (id_folha_ponto) REFERENCES folha_ponto(id),
	CONSTRAINT fk_lancamento_horas_dia_semana FOREIGN KEY (id_dia_semana) REFERENCES dia_semana(id)
);

/* =========================
ANEXO TIPO
========================= */
create table anexo_tipo (
	id serial not null,
	nome varchar(255) not null,

	CONSTRAINT pk_anexo_tipo PRIMARY KEY (id),
	CONSTRAINT uq_anexo_tipo UNIQUE(nome)
);

/* === INSERT ====*/
insert into anexo_tipo (nome) values ('Atestado Médico');
insert into anexo_tipo (nome) values ('Atestado Dentista');

/* =========================
ANEXO
========================= */
create table anexo (
	id serial not null,
	id_anexo_tipo integer not null,
	nome varchar(255) not null,
	descricao varchar(500) null,
	link varchar(1000) null,

	CONSTRAINT pk_anexo PRIMARY KEY (id),
	CONSTRAINT fk_anexo_anexo_tipo FOREIGN KEY (id_anexo_tipo) REFERENCES anexo_tipo(id)
);

/* =========================
LANCAMENTO HORA ANEXO
========================= */
create table lancamento_horas_anexo (
	id_lancamento_horas integer not null,
	id_anexo integer not null,

	CONSTRAINT pk_lancamento_horas_anexo PRIMARY KEY (id_lancamento_horas, id_anexo),
	CONSTRAINT fk_lancamento_horas_anexo_to_anexo FOREIGN KEY (id_anexo) REFERENCES anexo(id),
	CONSTRAINT fk_lancamento_horas_anexo_to_lancamento_horas FOREIGN KEY (id_lancamento_horas) REFERENCES lancamento_horas(id),
	CONSTRAINT uq_lancamento_horas_anexo UNIQUE(id_lancamento_horas, id_anexo)
);

/* === SELECT MODULO ====*/
select * from lancamento_horas_anexo;
select * from anexo_tipo;
select * from anexo;  
select * from dia_semana;
select * from folha_ponto_status;
select * from folha_ponto;
select * from lancamento_horas;

/* =========================
==== LIMPAR A BASE
========================= */
/*
-- === DELETA AS TABELAS ====

drop view vw_empregados_empresas;
drop view vw_folhas_ponto;

-- === DELETA AS TABELAS ====

drop table lancamento_horas_anexo;
drop table anexo;
drop table anexo_tipo;
drop table lancamento_horas;
drop table folha_ponto;
drop table folha_ponto_status;
drop table dia_semana;
drop table empregado;
drop table pessoa;
drop table empresa;
drop table empregado_funcao;

*/
