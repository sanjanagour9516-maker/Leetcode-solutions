# Write your MySQL query statement below
SELECT 
    u.name ,
    SUM(t.amount) As balance
FROM users u
JOIN Transactions t
ON u.account = t.account
GROUP BY u.account,u.name
HAVING SUM(amount)>10000;
