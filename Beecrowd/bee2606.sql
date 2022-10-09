/*Problema 2606 beecrowd 
Seu chefe precisa que você exiba o código e o nome dos produtos, cuja categoria inicie com 'super'.
Tabelas: 
products (id(PK), name, amount, price, id_categories(FK))
categoiries (id(PK), name)
*/
select products.id, products.name from products
join categories on products.id_categories = products.id
where categories.name like 'super%';