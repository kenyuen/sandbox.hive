use pluralsight;

-- assume exists from previous runs
describe mobilephones;

-- use of table functions

-- on Arrays
select explode(colors) as variants from mobilephones;

-- on Maps
select explode(features) as (feature, present)
from mobilephones where ID ='samsungj7';

select explode(features) as (feature, present)
from mobilephones;

-- use of posexplodes
select posexplode(colors) as (index, variants)
from mobilephones;

-- Use of Lateral Views, exploding the array column
select id, variants
from mobilephones
lateral view explode(colors) colorsTable as variants;

-- Use of Lateral Views, exploding the Map column
select id, feature, present
from mobilephones
lateral view explode(features) featuresTable as feature, present;

-- New Table to be used with Lateral Views
create table if not exists ads(
    page_id string,
    ad_list array<string>
)
row format delimited fields terminated by ','
collection items terminated by '#';

describe ads;

-- load ads file
load data local inpath 'data/ads.1.csv'
into table ads;

select * from ads;

-- use with explode
select explode(ad_list) from ads;

select page_id, ad_id
from ads
lateral view explode(ad_list) adListTable as ad_id;

-- how many times where ads occured
--   Hmmm... this took long, never completed
--   commented out for now.

-- select ad_id, count(*)
-- from ads
-- lateral view explode(ad_list) adListTable as ad_id
-- group by ad_id;

-- multiple lateral views
create table if not exists student_subjects (
    names array<string>,
    subjects array<string>
)
row format delimited fields terminated by ','
collection items terminated by '#';

describe student_subjects;

load data local inpath 'data/student_subjects.csv'
into table student_subjects;

select * from student_subjects;

-- Student and their subjects
select n, subjects
from student_subjects
lateral view explode(names) nameTable as n;

-- further flatten across 2 exploded columns
select n, s
from student_subjects
lateral view explode(names) nameTable as n
lateral view explode(subjects) subjectTAble as s;

--
create table if not exists example (
    double_nested array<array<int>>
);


-- note, this timeoud out, even with CBO set to false
-- insert into table example
-- select array(
--     array(1,2,3),
--     array(4,5,6),
--     array(6,7,8)
-- );

-- select * from example
-- lateral view explode(double_nested) nestedTable as single_nested
-- lateral view explode(single_nested) flatTable as num;

-- select num from example
-- lateral view explode(double_nested) nestedTable as single_nested
-- lateral view explode(single_nested) flatTable as num;