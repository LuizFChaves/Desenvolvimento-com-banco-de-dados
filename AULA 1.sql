#1 Crie um BD com nome Clinica
create database clinica;

#2 Crie as seguintes tabelas neste BD
use clinica;
create table ambulatorios(
	nroa 		int,		
	andar 		numeric(3) 	NOT NULL,
	capacidade 	smallint,
	PRIMARY KEY(nroa)
);

create table medicos(
	codm 		int,
	nome 		varchar(40) NOT NULL,
	idade 		smallint NOT NULL,
	especialidade char(20),
	CPF 		numeric(11) UNIQUE,
	cidade 		varchar(30),
	nroa 		int,
	PRIMARY KEY (codm),
	FOREIGN KEY(nroa) REFERENCES ambulatorios(nroa)
);

create table pacientes(
	 codp int,
	 nome varchar(40) NOT NULL,
	 idade smallint NOT NULL,
	 cidade char(30),
	 CPF numeric(11) UNIQUE,
	 doenca varchar(40) NOT NULL,
	 PRIMARY KEY(codp)
);

create table funcionarios(
	codf int,
	nome varchar(40) NOT NULL,
	idade smallint,
	CPF numeric(11) UNIQUE,
	cidade varchar(30),
	salario numeric(10),
	cargo varchar(20),
	PRIMARY KEY (codf)
);

create table consultas(
	codm int,
	codp int,
	data date,
	hora time,
	FOREIGN KEY(codm) REFERENCES medicos(codm),
	FOREIGN KEY(codp) REFERENCES pacientes(codp),
	PRIMARY KEY (codm,codp,data,hora)
);

#3
alter table funcionarios
add constraint nroa 
FOREIGN KEY(nroa) REFERENCES ambulatorios(nroa)