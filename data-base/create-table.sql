-- TESTE
CREATE TABLE pessoa(
	id serial not null,
	nome varchar(255) not null,
	sobrenome varchar(400),
	data_nascimento date,
	CONSTRAINT pk_pessoa PRIMARY KEY (id)
);
-- drop table pessoa

/* === INSERT ====*/
insert into pessoa (nome, sobrenome, data_nascimento) values ('Rick', 'Fazollo', '04-01-1990');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Bruno', 'Silva', '1984-01-21');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Rafael', 'Carvalho', '1980-11-27');
insert into pessoa (nome, sobrenome, data_nascimento) values ('Steve', 'Jobs', '1991-09-15');


create table empresa (
	id serial not null,
	nome varchar(300) not null,
	nome_fantasia varchar(500),
	CONSTRAINT pk_empresa PRIMARY KEY (id)
);

insert into empresa (nome, nome_fantasia) 
values ('Thecnolgoy', 'T - Desenvolvimento e soluções de softwares');

create table empregado_funcao (
	id serial not null,
	nome varchar(255) not null,
	abreviacao varchar(100),
	CONSTRAINT pk_empregado_funcao PRIMARY KEY (id)
);

insert into empregado_funcao(nome,abreviacao) values('Desenvolvedor Júnior', 'Dev Jr');
insert into empregado_funcao(nome,abreviacao) values('Desenvolvedor Pleno', 'Dev Pl');
insert into empregado_funcao(nome,abreviacao) values('Desenvolvedor Senior', 'Dev Sr');
insert into empregado_funcao(nome,abreviacao) values('Analista Desenvolvedor Junior', 'Anl Dev Jr');
insert into empregado_funcao(nome,abreviacao) values('Analista Desenvolvedor Pleno', 'Anl Dev Pl');
insert into empregado_funcao(nome,abreviacao) values('Analista Desenvolvedor Senior', 'Anl Dev Sr');

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

insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 1, 2);
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 2, 1);
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 3, 3);
insert into empregado (id_empresa, id_pessoa, id_empregado_funcao) values(1, 4, 5);


/*
pessoa
- nome
- sobrenome
- data_nascimento

empresa
- nome
- apelido


empregado
- id_pessoa
- id_funcao
- id_empresa
*/

select * from pessoa;
select * from empresa;
select * from empregado_funcao;
select * from empregado;

/* === DELETA AS TABELAS ====
drop table empregado;
drop table pessoa;
drop table empresa;
drop table empregado_funcao;
*/


-- == MODULO DOIS 2 ====

create table folha_ponto_status (
	id serial not null,
	nome varchar(255) not null,
	
	CONSTRAINT pk_folha_ponto_status PRIMARY KEY (id),
	CONSTRAINT uq_folha_ponto_status UNIQUE(nome)
);

insert into folha_ponto_status (nome) values ('Criada');
insert into folha_ponto_status (nome) values ('Alimentando');
insert into folha_ponto_status (nome) values ('Validando');
insert into folha_ponto_status (nome) values ('Fechada');

--drop table folha_ponto_status

select * from folha_ponto_status;

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

insert into folha_ponto (id_empregado, id_folha_ponto_status, mes, ano) values (1, 1,01, 2015);
insert into folha_ponto (id_empregado, id_folha_ponto_status, mes, ano, carga_horaria) values (1, 1,02, 2015, '08:00:00');

select * from folha_ponto;

create table dia_semana (
	id serial not null,
	nome varchar(255) not null,
	sigla varchar(10) not null,

	CONSTRAINT pk_dia_semana PRIMARY KEY (id),
	CONSTRAINT uq_dia_semana UNIQUE(nome, sigla)
);

insert into dia_semana(nome, sigla) values ('Domingo', 'Dom');
insert into dia_semana(nome, sigla) values ('Segunda-feira', 'Seg');
insert into dia_semana(nome, sigla) values ('Terça-feira', 'Ter');
insert into dia_semana(nome, sigla) values ('Quarta-feira', 'Qua');
insert into dia_semana(nome, sigla) values ('Quinta-feira', 'Qui');
insert into dia_semana(nome, sigla) values ('Sexta-feira', 'Sex');
insert into dia_semana(nome, sigla) values ('Sábado', 'Sab');

select * from dia_semana

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


select * from lancamento_horas;
/*
folha_ponto
- id_empregado
- mês
- ano
- carga_horaria

lancamento_horas
- dia_mes
- dia_semana
- hora_entrada
- hora_entreda_intervalo
- hora_saida_intervalo
- hora_saida
- flag_dia_descanso
- flag_feriado

lancamento_horas_anexo
- id_lancamento_horas
- id_anexo
- id_anexo_tipo

anexo_tipo
- id
- nome

anexo
- id
- nome
- descricao
- link
*/
