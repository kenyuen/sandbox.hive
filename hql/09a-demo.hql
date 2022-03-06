use pluralsight;

-- clean up from prior runs
drop table if exists mobilephones;

-- demo use of Arrays of primitive data types
create table if not exists mobilephones (
    id string,
    title string,
    cost float,
    colors array<string>,
    screen_size array<float>
);

show tables;

-- populate table with array values
insert into table mobilephones
select "redminote7", "Redmi Note 7", 300,
array("white","silver","black"), array(float(4.5))
UNION ALL
select "motoGplus", "Moto G Plus", 200, 
array("black","gold"), array(float(4.5),float(5.5));

select * from mobilephones;

select id, colors from mobilephones;
select id, colors[0] from mobilephones;

drop table mobilephones;

-- populate from loading from file; note use of '#' for collections
create table if not exists mobilephones (
    id string,
    title string,
    cost float,
    colors array<string>,
    screen_size array<float>
)
row format delimited fields terminated by ','
collection items terminated by '#'
;

load data local inpath 'data/mobilephones.1.csv'
into table mobilephones;

select * from mobilephones;
select id, colors[0], screen_size[0] from mobilephones;

