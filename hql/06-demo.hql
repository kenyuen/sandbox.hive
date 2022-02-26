use pluralsight;

-- creating temporary tables
create temporary table test_customers
like customers;

show tables;

describe test_customers;

insert into test_customers values (
    9999, "Jill", "MN"
);

select * from test_customers;

-- Once the connection is closed, this temporary table cease to exist

-- creating a temporary table with same name of existing table
create temporary table customers
like orders;

describe customers;