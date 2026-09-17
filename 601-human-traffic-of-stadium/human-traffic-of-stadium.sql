# Write your MySQL query statement below
SELECT id, visit_date, people
FROM (
    SELECT *,
        LAG(people, 2) OVER (ORDER BY id) AS p2,
        LAG(people, 1) OVER (ORDER BY id) AS p1,
        LEAD(people, 1) OVER (ORDER BY id) AS n1,
        LEAD(people, 2) OVER (ORDER BY id) AS n2,
        LAG(id, 2) OVER (ORDER BY id) AS id2,
        LAG(id, 1) OVER (ORDER BY id) AS id1,
        LEAD(id, 1) OVER (ORDER BY id) AS nid1,
        LEAD(id, 2) OVER (ORDER BY id) AS nid2
    FROM Stadium
) s
WHERE people >= 100
AND (
    (id1 = id - 1 AND id2 = id - 2 AND p1 >= 100 AND p2 >= 100)
    OR
    (id1 = id - 1 AND nid1 = id + 1 AND p1 >= 100 AND n1 >= 100)
    OR
    (nid1 = id + 1 AND nid2 = id + 2 AND n1 >= 100 AND n2 >= 100)
)
ORDER BY visit_date;