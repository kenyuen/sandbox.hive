use pluralsight;

-- clear from previous runs
drop table if exists products;

-- load from external HDFS
create external table if not exists products (
    id string,
    title string,
    cost float
)
comment "Table to store product information sold in stores"
row format delimited fields terminated by ','
stored as textfile
location '/data/';

select * from products;

show tables;

-- show details of a managed table
-- look for Location and Table Type
describe formatted customers;

-- compared to that of an external table
describe formatted products;
