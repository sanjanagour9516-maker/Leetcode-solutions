# Write your MySQL query statement below
WITH categories AS (
    SELECT 'Low Salary' AS category
    UNION
    SELECT 'Average Salary'
    UNION
    SELECT 'High Salary'
)
SELECT
    c.category,
    COUNT(a.account_id) AS accounts_count
FROM categories c
LEFT JOIN Accounts a
ON c.category = 
    CASE 
     WHEN a.income < 20000 THEN 'Low Salary'
     WHEN a.income BETWEEN 20000 AND 50000 THEN 'Average Salary'
     ELSE 'High Salary'
     END 
GROUP BY c.category;