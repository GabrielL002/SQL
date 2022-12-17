
/*Lista com o número da nota fiscal das compras realizadas, 
cujo prazo de entrega ainda não foi atingido (usar função de data).
*/
select NF from compra where NF Not In(
	select NF from compra 
	where dateadd(day, DiasEntrega, Data) between data and getdate()
)

--Lista com um ranking dos TOP 10 produtos mais comprados ( pela quantidade )
select top 10 Produto.Nome, sum(QTDE) Quantidade from produto
inner join ItemCompra on ID_Produto = Produto.ID
Group by Produto.Nome
Order by sum(qtde) Desc

/*Lista com o nome dos produtos não vendidos nem uma única vez no mês atual 
( usar função de data ).*/

select Nome from Produto
where Nome not in(
	select distinct Produto.Nome from Produto
	inner join ItemCompra on ID_Produto = Produto.ID
	inner join Compra on NF = NF_Compra
	where MONTH(Data) = MONTH(GETDATE())
)
