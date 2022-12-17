--- URI Online Judge SQL
--- Copyright URI Online Judge
--- www.urionlinejudge.com.br
--- Problem 2737
create database bee2737
go
use bee2737
go

CREATE TABLE lawyers(
  register INTEGER PRIMARY KEY,
  name VARCHAR(255),
  customers_number INTEGER
 );
 go
  
 INSERT INTO lawyers(register, name, customers_number)
 VALUES (1648, 'Marty M. Harrison', 5),
	(2427, 'Jonathan J. Blevins', 15),
	(3365, 'Chelsey D. Sanders', 20),
	(4153, 'Dorothy W. Ford', 16),
	(5525, 'Penny J. Cormier', 6);

  
  /*  Execute this query to drop the tables */
  -- DROP TABLE lawyers; --

select name, customers_number 
from(
select name, customers_number,1 as filter from lawyers 
where customers_number = (select max(customers_number) from lawyers)
or  customers_number = (select Min(customers_number) from lawyers)
union all
select 'Average', round(AVG(customers_number), 0), 2 as filter  from lawyers) as table1
order by filter , customers_number desc

