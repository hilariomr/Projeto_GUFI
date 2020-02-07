-- CRIA O BANCO DE DADOS
CREATE DATABASE Gufi_Tarde;

-- DEFINE QUAL BANCO DE DADOS ESTÁ SENDO UTILIZADO
USE Gufi_Tarde;

-- CRIA AS TABELAS DO BANCO DE DADOS
CREATE TABLE TipoUsuario (
	IdTipoUsuario INT PRIMARY KEY IDENTITY
	,TituloTipoUsuario VARCHAR (255) NOT NULL UNIQUE
);

CREATE TABLE TipoEvento (
	IdTipoEvento INT PRIMARY KEY IDENTITY
	,TituloTipoEvento VARCHAR (255) NOT NULL UNIQUE
);

CREATE TABLE Instituicao (
	IdInstituicao INT PRIMARY KEY IDENTITY
	,CNPJ CHAR (14) NOT NULL UNIQUE
	,NomeFantasia VARCHAR (255) NOT NULL UNIQUE
	,Endereco VARCHAR (255) NOT NULL UNIQUE
);

CREATE TABLE Usuario (
	IdUsuario INT PRIMARY KEY IDENTITY
	,NomeUsuario VARCHAR (255) NOT NULL
	,Email VARCHAR (255) NOT NULL UNIQUE
	,Senha VARCHAR (255) NOT NULL
	,Genero VARCHAR (255) NOT NULL 
	,DataNascimento DATETIME2 NOT NULL
	,IdTipoUsuario INT FOREIGN KEY REFERENCES TipoUsuario (IdTipoUsuario)
);

CREATE TABLE Evento (
	IdEvento INT PRIMARY KEY IDENTITY
	,NomeEvento VARCHAR (255) NOT NULL
	,DataEvento DATETIME2 NOT NULL
	,Descricao VARCHAR (255) NOT NULL
	,AcessoLivre BIT DEFAULT (1) NOT NULL
	,IdInstituicao INT FOREIGN KEY REFERENCES Instituicao (IdInstituicao)
	,IdTipoEvento INT FOREIGN KEY REFERENCES TipoEvento (IdTipoEvento)
);

CREATE TABLE Presenca (
	IdPresenca INT PRIMARY KEY IDENTITY
	,IdUsuario INT FOREIGN KEY REFERENCES Usuario (IdUsuario)
	,IdEvento INT FOREIGN KEY REFERENCES Evento (IdEvento)
	,Situacao VARCHAR (255) NOT NULL
);

INSERT INTO TipoUsuario (TituloTipoUsuario)
VALUES ('Administrador'), ('Comum');

INSERT INTO TipoEvento (TituloTipoEvento)
VALUES ('C#'), ('React'), ('SQL');

INSERT INTO Instituicao (CNPJ, NomeFantasia, Endereco)
VALUES ('11111111111111', 'Escola SENAI de Informática', 'Alameda Barão de Limeira, 538');

INSERT INTO Usuario (NomeUsuario, Email, Senha, Genero, DataNascimento, IdTipoUsuario)
VALUES	('Administrador', 'adm@adm.com', 'adm123', 'Não Informado', '06/02/2020', 1),
		('Carol', 'carol@email.com', 'carol123', 'Feminino', '06/02/2020', 2),
		('Saulo', 'saulo@email.com', 'saulo123', 'Masculino', '06/02/2020', 2);

INSERT INTO Evento (NomeEvento, DataEvento, Descricao, AcessoLivre, IdInstituicao, IdTipoEvento)
VALUES	('Introdução ao C#', '07/02/2020', 'Conceitos sobre os pilares da programação orientada a objetos', 1, 1, 1),
		('Ciclo de vida', '07/02/2020', 'Como utilizar o ciclo de vida com ReactJs', 0, 1, 2),
		('Optimização de banco de dados', '07/02/2020', 'Aplicação de índices clusterizados e não clusterizados', 1, 1, 3);

INSERT INTO Presenca (Situacao, IdUsuario, IdEvento)
VALUES	('Agendada', 2, 2),
		('Confirmada', 2, 3),
		('Não compareceu', 3, 1);

SELECT * FROM TipoUsuario;
SELECT * FROM TipoEvento;
SELECT * FROM Instituicao;
SELECT * FROM Usuario;
SELECT * FROM Evento;
SELECT * FROM Presenca;

SELECT Usuario.NomeUsuario, Usuario.Email, Usuario.Senha, Usuario.Genero, Usuario.DataNascimento, TipoUsuario.TituloTipoUsuario
FROM Usuario
INNER JOIN TipoUsuario 
ON TipoUsuario.IdTipoUsuario = Usuario.IdTipoUsuario;

SELECT Instituicao.CNPJ, Instituicao.NomeFantasia, Instituicao.Endereco
FROM Instituicao;

SELECT Evento.NomeEvento
FROM Evento;


SELECT Evento.NomeEvento, TipoEvento.TituloTipoEvento, Evento.DataEvento, Evento.AcessoLivre, Evento.Descricao, Instituicao.CNPJ, Instituicao.NomeFantasia, Instituicao.Endereco
FROM Evento
INNER JOIN TipoEvento
ON TipoEvento.IdTipoEvento = Evento.IdTipoEvento
INNER JOIN Instituicao
ON Evento.IdInstituicao = Instituicao.IdInstituicao;

--LISTAR APENAS OS EVENTOS QUE SÃO PÚBLICOS (NOME EVENTO, TIPO, DATA, PUBLICO OU PRIVADO, DESCRICAO, DADOS DA INSTITUICAO)














