use pluralsight;

create table if not exists orders ( 
	id bigint, 
	product_id string, 
	customer_id bigint,
	quantity int, 
	amount double
	);

-- clear from previous runs
truncate table orders;

-- load
insert into orders values (
 	1111111, " phone", 1111, 3, 1200
	), (
	1111112, " camera", 1111, 1, 5200
	), (
	1111113, " broom", 1111, 1, 10
	), (
	1111114, " broom", 2222, 2, 20
	), (
	1111115, " t-shirt", 4444,2,66
	);

-- join between tables
select customers.id, name, product_id 
from customers join orders 
where customers.id = orders.customer_id;
