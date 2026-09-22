# Write your MySQL query statement below
(SELECT 
u.name AS results
FROM users AS u
JOIN MovieRating AS mr
ON u.user_id = mr.user_id 
GROUP BY u.user_id , u.name
ORDER BY COUNT(*) DESC , u.name
LIMIT 1)

UNION ALL

(SELECT
m.title AS results
FROM Movies AS m
JOIN MovieRating AS mr
ON m.movie_id = mr.movie_id
WHERE created_at BETWEEN '2020-02-01'AND '2020-02-29'
GROUP BY mr.movie_id , m.title
ORDER BY AVG(mr.rating) DESC , m.title ASC 
LIMIT 1);
