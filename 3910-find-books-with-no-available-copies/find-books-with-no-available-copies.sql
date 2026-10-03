# Write your MySQL query statement below
SELECT
    l.book_id,
    l.title,
    l.author,
    l.genre,
    l.publication_year,
    COUNT(br.record_id) AS current_borrowers
FROM library_books l
JOIN borrowing_records br
ON l.book_id = br.book_id
WHERE br.return_date IS NULL
GROUP BY l.book_id,
    l.title,
    l.author,
    l.genre,
    l.publication_year,
    l.total_copies
HAVING COUNT(br.record_id) = l.total_copies
ORDER BY current_borrowers DESC,
    title ASC;
