/*
O setor financeiro da nossa empresa, est� querendo saber os menores e maiores valores dos produtos, que vendemos.
Para isso exiba somente o maior e o menor pre�o da tabela produtos.
*/
select MAX(price) price, MIN(price)price from products;