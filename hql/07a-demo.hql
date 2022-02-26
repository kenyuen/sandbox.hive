use pluralsight;

-- swap columns back
alter table freshproducts
change column title title string
after id;

describe freshproducts;

-- load external data from local inpath
load data local inpath 'data/freshproducts.csv'
into table freshproducts;

-- confirm
select * from freshproducts;
