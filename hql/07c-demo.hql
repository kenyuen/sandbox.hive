use pluralsight;

insert into table products
select id, title, cost from freshproducts;

-- shows appended records
select * from products;

-- overwrite
insert overwrite table products
select id, title, cost from freshproducts; 

select * from products;
