# Write your MySQL query statement below
SELECT p.product_id,
       COALESCE(t.new_price, 10) AS price
FROM
(
    SELECT DISTINCT product_id
    FROM Products
) p
LEFT JOIN Products t
ON p.product_id = t.product_id
AND t.change_date = (
    SELECT MAX(change_date)
    FROM Products
    WHERE product_id = p.product_id
      AND change_date <= '2019-08-16'
);