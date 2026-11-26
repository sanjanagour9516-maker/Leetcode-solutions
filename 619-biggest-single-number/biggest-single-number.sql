# Write your MySQL query statement below
SELECT
    MAX(num) AS num
FROM(
    SELECT num,
    COUNT(*)
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*)<2
)AS t;