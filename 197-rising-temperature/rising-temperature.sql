# Write your MySQL query statement below
SELECT id
FROM (
    SELECT
        id,
        recordDate,
        temperature,
        LAG(temperature) OVER(ORDER BY recordDate) AS pre_temp,
        LAG(recordDate) OVER(ORDER BY recordDate) AS pre_date
    FROM Weather
) AS temp
WHERE temperature > pre_temp
AND DATEDIFF(recordDate, pre_date) = 1;