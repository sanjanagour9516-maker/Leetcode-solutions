# Write your MySQL query statement below
WITH ranked_events AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id
               ORDER BY event_date DESC, event_id DESC
           ) AS rn
    FROM subscription_events
),
user_data AS (
    SELECT
        user_id,
        MIN(event_date) AS first_date,
        MAX(monthly_amount) AS max_amount
    FROM subscription_events
    GROUP BY user_id
)
SELECT
    r.user_id,
    r.plan_name AS current_plan,
    r.monthly_amount AS current_monthly_amount,
    u.max_amount AS max_historical_amount,
    DATEDIFF(r.event_date, u.first_date) AS days_as_subscriber
FROM ranked_events r
JOIN user_data u
    ON r.user_id = u.user_id
WHERE r.rn = 1
  AND r.event_type != 'cancel'
  AND r.monthly_amount < 0.5 * u.max_amount
  AND DATEDIFF(r.event_date, u.first_date) >= 60
  AND EXISTS (
      SELECT 1
      FROM subscription_events d
      WHERE d.user_id = r.user_id
        AND d.event_type = 'downgrade'
  )
ORDER BY days_as_subscriber DESC, r.user_id ASC;