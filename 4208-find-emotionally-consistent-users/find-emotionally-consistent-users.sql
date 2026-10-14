# Write your MySQL query statement below

WITH cte AS (
    SELECT
        user_id,
        reaction,
        COUNT(*) AS cnt
    FROM reactions
    GROUP BY user_id, reaction
),
total AS (
    SELECT
        user_id,
        COUNT(*) AS total_reactions,
        COUNT(DISTINCT content_id) AS content_count
    FROM reactions
    GROUP BY user_id
)
SELECT
    c.user_id,
    c.reaction AS dominant_reaction,
    ROUND(c.cnt * 1.0 / t.total_reactions, 2) AS reaction_ratio
FROM cte c
JOIN total t
    ON c.user_id = t.user_id
WHERE t.content_count >= 5
  AND c.cnt * 1.0 / t.total_reactions >= 0.60
  AND c.cnt = (
      SELECT MAX(c2.cnt)
      FROM cte c2
      WHERE c2.user_id = c.user_id
  )
ORDER BY reaction_ratio DESC, c.user_id ASC;
