use pluralsight;

-- load data from HDFS (local is NOT used)
load data inpath '/data/freshproducts.csv'
into table freshproducts;

-- appended 
select * from freshproducts;

-- loading from local with an overwrite
load data local inpath 'data/freshproducts.csv'
overwrite into table freshproducts;

-- overwritten
select * from freshproducts;