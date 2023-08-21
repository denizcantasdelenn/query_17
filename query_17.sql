--find the second most recent activity for each user.
--if their is only one activity, return that one.

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


--select * from UserActivity


with cte as (
select *, 
rank() over(partition by username order by startDate) as rank_flag, 
count(*) over(partition by username) as num_of_activity
from UserActivity)

select username, activity, startDate, endDate
from cte
where (num_of_activity > 1 and rank_flag = 2) or (num_of_activity = 1)