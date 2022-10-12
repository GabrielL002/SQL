/*
Inserção, Deletes e Update nas tabelas criadas na AC01

1 - Escreva os comandos para inserir neste banco de dados os dados exatamente como apresentados na
tabela inicial, por exemplo: Já foram compradas 300 unidades de Skoll e 35 unidades de Fraldas Pampers em
2 pedidos de 25 e 10 respectivamente.
A Ambev deve ser o fornecedor padrão do produto SKOL, e a P&G deve ser a distribuidora padrão do
produto Fralda Pampers.
2 - Infelizmente não podemos ter registros associados à aquisição de bebidas alcoólicas no sistema, limpe
todas as entradas associadas à este tipo de produto da base.
3 - Escreva os comandos necessários para a alterar a data da segunda compra das Fraldas Pampers de
26/10/2017 para 28/10/2017.

*/

insert into Fornecedor
values ('Ambev'),
('P&G'),
('Dist. PPG')

------selects para descobrir o ID dos fornecedores-----

select id from Fornecedor where nome = 'Ambev'
select id from Fornecedor where nome = 'P&G'
select id from Fornecedor where nome = 'Dist. PPG'

insert into Produto
values ('Skol', 1 ),
('Fralda Pampers', 2),
('Fralda Pampers', 3)
----------------------------------------------------------

insert into Compra
values ('#112434', 3, 8243.00, '20171010'),
('#324235', 10, 1230.00, '20171021'),
('#455464', 2, 500.00, '20171026')
----select para descobrir o ID dos produto/fornecedor e Para descobrir NF das compra--------
select id, ID_FornecedorPadrao from produto where nome = 'Skol'
select id, ID_FornecedorPadrao from produto where nome = 'Fralda Pampers'
select NF from compra
insert into ItemCompra
values (1, 1, '#112434', 300),
(2, 2, '#324235', 25),
(3, 3, '#455464', 10)
select *from Fornecedor
select *from Produto
select *from Compra
select *from ItemCompra
---Deletes de registros associado a bebidas alcoólicas----------------------------
select id from Produto where nome = 'Skol'

delete from ItemCompra where ID_Produto = 1
delete from Produto where nome = 'Skol'

delete from Fornecedor where nome = 'Ambev'

----------Update data da segunda compra das Fraldas Pampers-----------------------
Update Compra set Data = '20171026' where NF = '#455464'
