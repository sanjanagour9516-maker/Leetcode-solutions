# Write your MySQL query statement below
SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(
        MIN(CASE
            WHEN c.result = 'Negative'
             AND c.test_date > pos.first_positive
            THEN c.test_date
        END),
        pos.first_positive
    ) AS recovery_time
FROM patients p
JOIN covid_tests c
    ON p.patient_id = c.patient_id
JOIN (
    SELECT patient_id, MIN(test_date) AS first_positive
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
) pos
    ON p.patient_id = pos.patient_id
GROUP BY p.patient_id, p.patient_name, p.age, pos.first_positive
HAVING recovery_time IS NOT NULL
ORDER BY recovery_time ASC, p.patient_name ASC;