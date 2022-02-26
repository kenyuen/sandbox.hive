use pluralsight;

describe products;

-- correct column order
alter table products
change column title title string
after id;

select * from products;

-- cleanup from previous runs
drop table if exists product_name;
drop table if exists product_cost;

-- new tables
create table product_name (
    id string,
    name string
);

create table product_cost (
    id string,
    cost float
);

-- multi-table insert from one table
from products
insert overwrite table product_name
select id, title
insert into table product_cost
select id, cost;

-- validate
select * from product_name;
select * from product_cost;

-- clean up
select * from freshproducts;
truncate table freshproducts;
select * from freshproducts;