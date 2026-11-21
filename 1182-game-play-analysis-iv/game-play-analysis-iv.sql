# Write your MySQL query statement below
WITH first_login AS (
    SELECT player_id,
    MIN(event_date) AS first_date
    FROM Activity 
    GROUP BY player_id

)
SELECT 
    ROUND(
        COUNT(DISTINCT a.player_id) /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity a 
JOIN first_login AS fg
ON fg.player_id = a.player_id
WHERE DATEDIFF(a.event_date , fg.first_date) = 1;

