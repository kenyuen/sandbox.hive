use pluralsight;

create table if not exists customers ( 
    id bigint,
    name string,
    address string 
    );

-- clear from previous runs
truncate table customers;

-- load
insert into customers values ( 1111, "John", "WA");
insert into customers values ( 
    2222, "Emily", "WA"
    ), (
    3333, "Rick", "WA"
    ), (
	4444, "Jane", "WA"
    ), (
	5555, "Amit", "WA"
    ), (
	6666, "Nina", "WA"
    );

-- Various Selects
select * from customers where address = "WA";
select name,  address from customers where address = "WA" and id > 2222;
select DISTINCT address from customers;
select name, address from customers order by address;
select count(*) from customers;
select address, count(*) from customers group by address;
select * from customers limit 1;

