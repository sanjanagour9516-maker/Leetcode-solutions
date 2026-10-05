# Write your MySQL query statement below
WITH season_category AS (
    SELECT
        CASE
            WHEN MONTH(s.sale_date) IN (12, 1, 2) THEN 'Winter'
            WHEN MONTH(s.sale_date) IN (3, 4, 5) THEN 'Spring'
            WHEN MONTH(s.sale_date) IN (6, 7, 8) THEN 'Summer'
            WHEN MONTH(s.sale_date) IN (9, 10, 11) THEN 'Fall'
        END AS season,

        p.category,

        SUM(s.quantity) AS total_quantity,
        SUM(s.quantity * s.price) AS total_revenue

    FROM sales s
    JOIN products p
        ON s.product_id = p.product_id

    GROUP BY season, p.category
)

SELECT
    season,
    category,
    total_quantity,
    total_revenue
FROM (
    SELECT
        season,
        category,
        total_quantity,
        total_revenue,
        RANK() OVER (
            PARTITION BY season
            ORDER BY total_quantity DESC, total_revenue DESC
        ) AS rnk
    FROM season_category
) ranked
WHERE rnk = 1
ORDER BY season;



