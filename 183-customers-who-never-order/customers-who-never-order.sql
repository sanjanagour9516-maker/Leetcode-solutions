# Write your MySQL query statement bel
SELECT
    c.name AS Customers
FROM Customers c
LEFT JOIN orders o
ON c.id = o.customerId
WHERE customerId IS NULL;