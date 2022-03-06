use pluralsight;

drop table if exists mobilephones;

-- Maps
create table mobilephones (
    id string,
    title string,
    cost float,
    colors array<string>,
    screen_size array<float>,
    features map<string, boolean>,
    information struct<battery:string,camera:string>
)
row format delimited fields terminated by ','
collection items terminated by '#'
map keys terminated by ':'
;

describe mobilephones;

-- load data file with struct collections
load data local inpath 'data/mobilephones.3.csv'
into table mobilephones;

select * from mobilephones;
select id, features, information from mobilephones;
select id, features['camera'], information.battery from mobilephones;
