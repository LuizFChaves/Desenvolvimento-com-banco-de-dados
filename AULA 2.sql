/*1 - Crie um BD com nome Clinica*/
create database Clinica;
create schema Clinica;
set sql_safe_updates=0;
/*use Clinica*/
/*2 - Crie as seguintes tabelas neste BD, considerando que os atributos sublinhados 
são chaves primárias e os em itálico são chaves estrangeiras: */
create table Ambulatorios(
	nroa int not null primary key,
    andar numeric(3) not null,
    capacidade smallint
    );

create table Medicos(
	codm int primary key,
    nome varchar(40) not null,
    especialidade char(20),
    idade smallint not null,
    cpf numeric(11) unique,
    cidade varchar(30),
    nroa int,
    foreign key (nroa) references Ambulatorios(nroa)
    );
    
create table Funcionarios(
    codf int primary key,
    nome varchar(40) not null,
    idade smallint,
    cidade varchar(30),
    cargo varchar(20),
    salario numeric(10),
    cpf numeric(11) unique
    );

create table Pacientes(
	codp int primary key,
	nome varchar(40) not null,
    idade smallint not null,
    cidade char(30),
    cpf numeric(11) unique,
    doenca varchar(40) not null
    );

create table Consultas(
	codm int,
    codp int,
    dia date,
    hora time,
    primary key (codm, codp, dia, hora),
    foreign key (codp) references Pacientes(codp),
    foreign key (codm) references Medicos(codm)
    );
    
#3
ALTER TABLE Funcionarios ADD nroa integer;
ALTER TABLE Funcionarios ADD constraint fk_nroa
FOREIGN KEY(nroa) REFERENCES Ambulatorios (nroa);


#4
CREATE UNIQUE INDEX indMedico_CPF ON medicos (CPF);
CREATE INDEX indPaciente_DOENCA ON Pacientes (doenca);

#5
DROP INDEX indPaciente_DOENCA ON Pacientes;

#6
ALTER TABLE Funcionarios DROP FOREIGN KEY fk_nroa;
ALTER TABLE Funcionarios DROP COLUMN cargo;
ALTER TABLE Funcionarios DROP COLUMN nroa;

#voltando com nroa em funcionarios
ALTER TABLE Funcionarios ADD nroa integer;
ALTER TABLE Funcionarios ADD cargo varchar(20);

#DUMP
INSERT INTO Ambulatorios VALUES (1, 1, 30);
INSERT INTO Ambulatorios VALUES (2, 1, 50);
INSERT INTO Ambulatorios VALUES (3, 2, 40);
INSERT INTO Ambulatorios VALUES (4, 2, 25);
INSERT INTO Ambulatorios VALUES (5, 2, 50);

INSERT INTO medicos (codm,nome,idade,especialidade,CPF,cidade,nroa) VALUES (1,'Joao',40,'ortopedia',10000100000,'Florianopolis',1);
INSERT INTO medicos (codm,nome,idade,especialidade,CPF,cidade,nroa) VALUES (2,'Maria',42,'traumatologia',10000110000,'Blumenau',2);
INSERT INTO medicos (codm,nome,idade,especialidade,CPF,cidade,nroa) VALUES (3,'Pedro',51,'pediatria',11000100000,'Sao Jose',2);
INSERT INTO medicos (codm,nome,idade,especialidade,CPF,cidade,nroa) VALUES (4,'Carlos',28,'Ortopedia',11000110000,'Joinville',null);
INSERT INTO medicos (codm,nome,idade,especialidade,CPF,cidade,nroa) VALUES (5,'Marcia',33,'neurologia',11000111000,'Biguacu',3);

INSERT INTO Funcionarios (codf,nome,idade,CPF,cidade,salario,nroa,cargo) VALUES (1,'Rita',32,20000100000,'Sao Jose',1200, 2,'Secretaria');
INSERT INTO Funcionarios (codf,nome,idade,CPF,cidade,salario,nroa,cargo) VALUES (2,'Maria',55,30000110000,'Palhoca',1220, 4, 'Contadora');
INSERT INTO Funcionarios (codf,nome,idade,CPF,cidade,salario,nroa,cargo) VALUES (3,'Caio',45,41000100000,'Florianopolis',1100, 5,'Analista de Sistemas');
INSERT INTO Funcionarios (codf,nome,idade,CPF,cidade,salario,nroa,cargo) VALUES (4,'Carlos',44,51000110000,'Florianopolis',1200, 3,'Secretario');
INSERT INTO Funcionarios (codf,nome,idade,CPF,cidade,salario,nroa,cargo) VALUES (5,'Paula',33,61000111000,'Florianopolis',2500, 1,'Telefonista');

INSERT into pacientes (codp,nome,idade,cidade,CPF,doenca) VALUES (1, 'Ana', 20, 'Florianopolis', 20000200000, 'gripe');
INSERT into pacientes (codp,nome,idade,cidade,CPF,doenca) VALUES (2, 'Paulo', 24, 'Palhoca', 20000220000, 'fratura');
INSERT into pacientes (codp,nome,idade,cidade,CPF,doenca) VALUES (3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite');
INSERT into pacientes (codp,nome,idade,cidade,CPF,doenca) VALUES (4, 'Carlos', 28, 'Joinville', 11000110000, 'sarampo');

INSERT into consultas (codm,codp,dia,hora) VALUES (1,1,STR_TO_DATE('12/06/2006','%d/%m/%Y'),STR_TO_DATE('14:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (1,4,STR_TO_DATE('13/06/2006','%d/%m/%Y'),STR_TO_DATE('10:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (2,1,STR_TO_DATE('13/06/2006','%d/%m/%Y'),STR_TO_DATE('09:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (2,2,STR_TO_DATE('13/06/2006','%d/%m/%Y'),STR_TO_DATE('11:00','%H:%i'));
INSERT into consultas (codm,codp,dia,hora) VALUES (2,3,STR_TO_DATE('14/06/2006','%d/%m/%Y'),STR_TO_DATE('14:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (2,4,STR_TO_DATE('14/06/2006','%d/%m/%Y'),STR_TO_DATE('17:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (3,1,STR_TO_DATE('19/06/2006','%d/%m/%Y'),STR_TO_DATE('18:00','%H:%i'));
INSERT into consultas (codm,codp,dia,hora) VALUES (3,3,STR_TO_DATE('12/06/2006','%d/%m/%Y'),STR_TO_DATE('10:00','%H:%i'));
INSERT into consultas (codm,codp,dia,hora) VALUES (3,4,STR_TO_DATE('19/06/2006','%d/%m/%Y'),STR_TO_DATE('13:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (4,4,STR_TO_DATE('20/06/2006','%d/%m/%Y'),STR_TO_DATE('13:00','%H:%i')); 
INSERT into consultas (codm,codp,dia,hora) VALUES (4,4,STR_TO_DATE('22/06/2006','%d/%m/%Y'),STR_TO_DATE('19:30','%H:%i'));

#EXERCICIOS MYSQL
#1
UPDATE  pacientes SET cidade='Ilhota' WHERE nome='Paulo'
#2





