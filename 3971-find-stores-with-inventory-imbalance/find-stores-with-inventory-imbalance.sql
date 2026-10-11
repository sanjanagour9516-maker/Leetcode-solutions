# Write your MySQL query statement below


WITH ranked_products AS (
    SELECT
        s.store_id,
        s.store_name,
        s.location,
        i.product_name,
        i.quantity,
        i.price,

        ROW_NUMBER() OVER (
            PARTITION BY s.store_id
            ORDER BY i.price DESC
        ) AS expensive_rank,

        ROW_NUMBER() OVER (
            PARTITION BY s.store_id
            ORDER BY i.price ASC
        ) AS cheap_rank

    FROM stores s
    JOIN inventory i
        ON s.store_id = i.store_id
),
store_products AS (
    SELECT
        store_id,
        store_name,
        location,

        MAX(CASE WHEN expensive_rank = 1
            THEN product_name END) AS most_exp_product,

        MAX(CASE WHEN cheap_rank = 1
            THEN product_name END) AS cheapest_product,

        MAX(CASE WHEN expensive_rank = 1
            THEN quantity END) AS expensive_quantity,

        MAX(CASE WHEN cheap_rank = 1
            THEN quantity END) AS cheap_quantity

    FROM ranked_products
    GROUP BY store_id, store_name, location
)
SELECT
    sp.store_id,
    sp.store_name,
    sp.location,
    sp.most_exp_product,
    sp.cheapest_product,

    ROUND(
        sp.cheap_quantity / NULLIF(sp.expensive_quantity, 0),
        2
    ) AS imbalance_ratio

FROM store_products sp
WHERE sp.expensive_quantity < sp.cheap_quantity
  AND (
      SELECT COUNT(DISTINCT i.product_name)
      FROM inventory i
      WHERE i.store_id = sp.store_id
  ) >= 3

ORDER BY imbalance_ratio DESC, sp.store_name ASC;

