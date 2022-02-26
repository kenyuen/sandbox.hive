use pluralsight;

-- clean up from previous runs
drop table if exists fresh_products;
drop table if exists freshproducts;

-- create table with 'like' to have same table schema
create table if not exists fresh_products like products;

-- shows created fresh_product table
show tables;

-- shows that copied table is managed
describe formatted fresh_products;

-- renaming of table
alter table fresh_products
rename to freshproducts;

show tables;
describe freshproducts;

-- adding column to table
alter table freshproducts add columns (
    expire_date date
    comment "Expiry date of fresh produce"
);

describe freshproducts;

-- swapping columns 
alter table freshproducts 
change column id id string -- orgininal name, new name, column type
after title;

describe freshproducts;

-- swapping columns for a table which holds some data
alter table products
change column id id string
after title;

select * from products;