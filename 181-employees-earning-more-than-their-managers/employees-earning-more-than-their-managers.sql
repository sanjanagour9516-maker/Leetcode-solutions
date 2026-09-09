# Write your MySQL query 
SELECT 
    e.name AS Employee
FROM employee AS e
JOIN employee AS m
ON e.managerId = m.id
where  e.salary > m.salary ;