
use master
go

DROP DATABASE M2_Biblioteca;
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC1 - DDL - Criação da base
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

CREATE DATABASE M2_Biblioteca;
GO
USE M2_Biblioteca;
GO
--Licença acadêmica para sugerir uma chave composta...
--Poderia ser chave artificial = ID
CREATE TABLE Livro (
Nome VARCHAR(255) NOT NULL
, Copia TINYINT NOT NULL --Não é auto incremental
, Status VARCHAR(30) NULL
, CONSTRAINT PK_Livro PRIMARY KEY ( Nome, Copia )
)
GO
CREATE TABLE Cliente (
ID INT NOT NULL IDENTITY(1,1)
, Nome VARCHAR(50) NOT NULL
, Telefone INT NULL --poderia ou deveria ser VARCHAR
, CONSTRAINT PK_Cliente PRIMARY KEY ( ID )
)
GO

CREATE TABLE Emprestimo (
ID INT NOT NULL IDENTITY(1,1)
, Livro VARCHAR(255) NOT NULL
, Copia TINYINT NOT NULL
, ID_Cliente INT NOT NULL
, DataEmprestimo DATETIME NOT NULL
, DataDevolucaoProposta DATETIME NULL
, DataDevolucaoEfetiva DATETIME NULL
, Multa Decimal(6,2)
, CONSTRAINT PK_Emprestimo PRIMARY KEY ( ID )
, CONSTRAINT FK_EmprestimoLivro FOREIGN KEY ( Livro, Copia ) REFERENCES Livro ( Nome, Copia )
, CONSTRAINT FK_EmprestimoCliente FOREIGN KEY ( ID_cliente ) REFERENCES Cliente ( ID )
)
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC2 - DML - Carga da base
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

INSERT INTO LIVRO ( nome, copia, [status] )
VALUES	('A arte da Guerra', 1, 'Atrasado')	
	,	('A arte da Guerra', 2, 'Livre')	
	,	('O Pequeno Principe', 1, 'Emprestado')	
GO
INSERT INTO CLIENTE (/*ID, */ nome, telefone )
VALUES	(/*1, */'José da Silva', '991235344')
	,	(/*2, */'Igor Pereira', '33120123')
GO
INSERT INTO Emprestimo ( Livro, Copia, ID_Cliente, DataEmprestimo, DataDevolucaoProposta, DataDevolucaoEfetiva, Multa )
VALUES ( 'A arte da Guerra'
		, 1
		, (SELECT id FROM Cliente where nome = 'José da Silva')
		, '20170810' --DataEmprestimo
		, '20170910' --DataDevolucaoProposta
		, NULL		 --DataDevolucaoEfetiva
		, 11.00		 --Ainda não devolveu, por isso a Multa Número sempre com '.' 
		)
	,	( 'O Pequeno Principe'
		, 1
		, (SELECT id FROM Cliente where nome = 'Igor Pereira')
		, '20170915' --DataEmprestimo
		, '20171015' --DataDevolucaoProposta
		, '20171015' --DataDevolucaoEfetiva
		, NULL		 --Já devolveu, por isso sem Multa
		)

--Conferências:
select * from Livro
select * from Cliente
select * from Emprestimo

--Exercicios
/*
- Lista com o nome dos livros disponíveis ( sem duplicidades ).
- Lista com o nome e o número da cópia, de cada livro+copia com status = ‘livre’
- Lista com o nome do cliente, o livro+copia dos livros emprestados cuja data de devolução proposta já expirou. ( ou seja, estou
procurando quais livros estão atrasados, para poder atualizar seus status para atrasado e calcular sua multa ).
- Lista com os nomes dos clientes que pegaram emprestados livros no mês atual de Abril de 2018.
- Lista de Clientes que preencheram o campo Telefone no seguinte formato 912345678
*/
select distinct nome from Livro
--------------------------------
select nome as 'Nome do Livro', copia as 'Exemplar' from Livro where status = 'Livre'
-----------------------------------------------------------------------------------------------
select Cliente.nome as 'Nome do Cliente', Emprestimo.livro as 'Nome do livro', Emprestimo.copia
from Cliente 
inner join Emprestimo on ID_Cliente = Cliente.Id
where DataDevolucaoEfetiva is Null
-------------------------------------------------------------------------------------------------
