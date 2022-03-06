use pluralsight;

drop table if exists mobilephones;

-- Maps
create table mobilephones (
    id string,
    title string,
    cost float,
    colors array<string>,
    screen_size array<float>,
    features map<string, boolean>
)
row format delimited fields terminated by ','
collection items terminated by '#'
map keys terminated by ':'
;

describe mobilephones;

-- load data file with map collections
load data local inpath 'data/mobilephones.2.csv'
into table mobilephones;

select * from mobilephones;
select id, features['camera'] from mobilephones;
select id, features['autofocus'] from mobilephones;
