# Write your MySQL query statement below
WITH ranked AS (
    SELECT
        employee_id,
        review_date,
        rating,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY review_date DESC
        ) AS rn
    FROM performance_reviews
),
last3 AS (
    SELECT
        employee_id,
        review_date,
        rating,
        LAG(rating) OVER (
            PARTITION BY employee_id
            ORDER BY review_date
        ) AS prev_rating
    FROM ranked
    WHERE rn <= 3
)
SELECT
    e.employee_id,
    e.name,
    MAX(l.rating) - MIN(l.rating) AS improvement_score
FROM last3 l
JOIN employees e
    ON l.employee_id = e.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(*) = 3
   AND SUM(
       CASE
           WHEN prev_rating IS NOT NULL
                AND rating > prev_rating
           THEN 1
           ELSE 0
       END
   ) = 2
ORDER BY improvement_score DESC, e.name ASC;