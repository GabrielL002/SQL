--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC1 - DDL - Criação da base
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

CREATE DATABASE M4_compras_mercearia;
GO
USE M4_compras_mercearia;
GO

CREATE TABLE Fornecedor (
ID INT NOT NULL IDENTITY(1,1)
, Nome VARCHAR(50) NOT NULL
, CONSTRAINT PK_Fornecedor PRIMARY KEY ( ID )
)
GO
CREATE TABLE Produto (
ID INT NOT NULL IDENTITY(1,1)
, Nome VARCHAR(50) NOT NULL
, ID_FornecedorPadrao INT NOT NULL  --NULL se fornecedor for opcional
									--NOT NULL se fornecedor for obrigatorio
, CONSTRAINT PK_Produto PRIMARY KEY ( ID )
, CONSTRAINT FK_ProdutoFornecedorPadrao FOREIGN KEY ( Id_FornecedorPadrao ) REFERENCES
Fornecedor( ID )
)
GO
CREATE TABLE Compra (
NF VARCHAR(15) NOT NULL
, DiasEntrega TINYINT NOT NULL
, Valor FLOAT NOT NULL
, Data DATE NOT NULL
, CONSTRAINT PK_Compra PRIMARY KEY ( NF )
)
GO

--Neste modelo 1 compra pode ter N itens cada item pode vir de um fornecedor diferente
CREATE TABLE ItemCompra (
ID_Produto INT NOT NULL
, ID_Fornecedor INT NOT NULL
, NF_Compra VARCHAR(15) NOT NULL
, QTDE INT NOT NULL
, CONSTRAINT PK_ItemCompra PRIMARY KEY ( ID_Produto, ID_Fornecedor, NF_Compra )
, CONSTRAINT FK_ItemCompraProduto FOREIGN KEY ( ID_produto ) REFERENCES PRODUTO ( ID )
, CONSTRAINT FK_ItemCompraFornecedor FOREIGN KEY ( ID_fornecedor) REFERENCES Fornecedor ( ID )
, CONSTRAINT FK_ItemCompraCompra FOREIGN KEY ( NF_Compra ) REFERENCES Compra ( NF )
)
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC2 - DML - Carga da base
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

INSERT INTO Fornecedor ( Nome )
VALUES	( 'Ambev' )
	,	( 'P&G' ) 	
	,	( 'Dist. PPG' )

--Não foi definido quem é o fornecedor padrão, então, tive que estabelecer um
INSERT INTO Produto ( nome, ID_FornecedorPadrao )
VALUES ( 'Skol', (SELECT id from Fornecedor WHERE nome = 'Ambev') )
	,  ( 'Fralda Pampers', (SELECT id from Fornecedor WHERE nome = 'P&G') )

INSERT INTO Compra ( NF, DiasEntrega, Valor, [Data] )
VALUES ( '#112434', 3, '8243.00', '20171021' )
	,  ( '#324235', 10, '1123.00', '20171021' )
	,  ( '#455464', 2, '500.00', '20171026' )

--Neste modelo 1 compra pode ter N itens cada item pode vir de um fornecedor diferente
INSERT INTO ItemCompra ( ID_Produto, ID_Fornecedor, NF_Compra, QTDE )
VALUES (	(SELECT id FROM Produto WHERE nome = 'Skol')	
		,	(SELECT id FROM Fornecedor WHERE nome = 'Ambev')	
		,	'#112434'--Se já sei o ID da Compra, basta utilizá-lo, não preciso buscá-lo
		, 300
	),  (	(SELECT id FROM Produto WHERE nome = 'Fralda Pampers')	
		,	(SELECT id FROM Fornecedor WHERE nome = 'P&G')	
		,	'#324235'--Se já sei o ID da Compra, basta utilizá-lo, não preciso buscá-lo
		, 25
	),  (	(SELECT id FROM Produto WHERE nome = 'Fralda Pampers')	
		,	(SELECT id FROM Fornecedor WHERE nome = 'Dist. PPG')	
		,	'#455464'--Se já sei o ID da Compra, basta utilizá-lo, não preciso buscá-lo
		, 10
	)

--Conferências:
select * from Fornecedor
select * from Produto
select * from Compra
select * from ItemCompra

/*
AC03
Execute as seguintes consultas no banco de dados criado:
- Lista com o nome dos produtos disponíveis no cadastro.
- Lista com o número da nota fiscal das compras cuja data seja superior à 01/01/2017 e Dias para entrega superior à 10.
- Lista com o Nome do produto, o nome do fornecedor e a quantidade fornecida.
- Lista com o nome dos produtos e seus respectivos fornecedores padrão.
- Lista com o número na nota fiscal, o nome do produto, a data, quantidade e valor cobrado.
*/
select Nome from Produto
------------------------------------------------------------------------------------------
select NF as [Nota Fiscal] from Compra where data > '20170101' and DiasEntrega > 10
------------------------------------------------------------------------------------------
select produto.nome as [Nome do produto], Fornecedor.nome as [Nome do fornecedor]
, ItemCompra.QTDE as Quantidade
from Produto
inner join  ItemCompra on ID_Produto = Produto.Id
inner join Fornecedor on ItemCompra.ID_Fornecedor = Fornecedor.Id
-------------------------------------------------------------------------------------------------------
select Produto.Nome, Fornecedor.nome as [Fornecedor padrão]
from Produto
inner join Fornecedor on Fornecedor.ID = Produto.ID_FornecedorPadrao
------------------------------------------------------------------------------------------
select Compra.NF as [Nota Fiscal], Produto.Nome as [Nome do Produto]
, Compra.Data, ItemCompra.QTDE as Quantidade, Compra.Valor as [Valor Cobrado]
from Produto
inner join ItemCompra on Produto.Id = ID_Produto
inner join Compra on NF_Compra = Compra.NF
