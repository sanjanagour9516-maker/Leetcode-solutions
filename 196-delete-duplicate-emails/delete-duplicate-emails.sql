# Write your MySQL query statement below
DELETE p1
FROM person as p1
JOIN person as p2
ON p1.email = p2.email
WHERE p1.id > p2.id; 