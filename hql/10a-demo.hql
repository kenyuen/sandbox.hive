use pluralsight;

load data local inpath 'data/products.csv'
overwrite into table products;

select * from products;
select * from freshproducts;

-- union 
select * from products
union
select id, title, cost from freshproducts;

-- duplicate record
insert into freshproducts
values ("iphone7"," iPhone 7k", 950, '2015-02-22');

-- no dups
select * from products
union
select id, title, cost from freshproducts;

-- dups 
select * from products
union all
select id, title, cost from freshproducts;
-- minus, intersect not supported on Hive

--  Subqueries with FROM
select *
from (
    select id as product_id from products
    union
    select id as product_id from freshproducts
) t;

select distinct(t.product_id) from
(
    select product_id from
    customers join orders
    where customers.id = orders.customer_id
) t;

-- Subqueries with WHERE
select name from customers
where 
id in 
(select customer_id from orders);

select id, title from products
where 
id not in 
(select product_id from orders);

select id from customers
where exists
(
    select customer_id from orders
    -- correlated to parent query
    where orders.customer_id = customers.id
);

-- create table with subquery
create table if not exists allproducts 
as 
select id, title as name, cost from products;

select * from allproducts;

-- Views
describe customers;
describe orders;

create view customer_purchases
as
select customer_id, product_id, address
from customers join orders
where customers.id = orders.customer_id;

describe formatted customer_purchases;

-- multiple views from same tables
create view if not exists product_purchases
as
select product_id, quantity
from orders;

show tables;
describe product_purchases;

alter view product_purchases
as
select product_id, quantity, amount
from orders;