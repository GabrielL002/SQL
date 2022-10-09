/*
O seu trabalho é nos passar os nomes e os endereços dos clientes que moram em 'Porto Alegre',
para entregar os convites pessoalmente.
tabelas: customers
*/
select name, street from customers where city = 'Porto Alegre'
