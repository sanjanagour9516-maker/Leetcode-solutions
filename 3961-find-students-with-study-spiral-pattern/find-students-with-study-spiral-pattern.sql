# Write your MySQL query statement below
# Write your MySQL query statement below

with base as (
select *, max(pattern_start)
over (partition by student_id order by session_date rows between unbounded preceding and current row) as pattern_date
from
(
select *, case when datediff(session_date,lag(session_date) over (partition by student_id order by session_date )) <=2 then null else session_date end as pattern_start
from study_sessions
) t
),
consecutive_day as (
select *, row_number() over(partition by student_id,pattern_date,subject order by session_date) as inside_rank
from base
),
subject_pattern as (
select student_id,pattern_date,
inside_rank,
group_concat(subject order by session_date) as sub_pattern,
count(subject) as total_subjects,
sum(hours_studied) as total_hours
from consecutive_day
group by student_id,pattern_date,inside_rank
),

sequential_pat as (
select *,
max(cycle_repeat)
OVER (PARTITION BY student_id,
pattern_date ORDER BY inside_rank ROWS BETWEEN unbounded preceding AND current row) AS cycle_seq_count
FROM(
SELECT *, 
CASE WHEN sub_pattern= LAG(sub_pattern) OVER (PARTITION BY student_id,pattern_date ORDER BY  inside_rank) THEN NULL ELSE inside_rank end AS cycle_repeat
FROM subject_pattern
) c
)


SELECT 
p.student_id,
s.student_name,
s.major,cycle_length,
total_study_hours
FROM (
SELECT student_id,
MAX(total_subjects) as cycle_length ,
SUM(total_hours) as total_study_hours
FROM sequential_pat 
WHERE total_subjects>2
GROUP BY student_id,pattern_date,cycle_seq_count
HAVING COUNT(sub_pattern)>1) p join students s on p.student_id=s.student_id
WHERE (SELECT COUNT(*) from students) >1
ORDER BY cycle_length DESC,total_study_hours DESC;


