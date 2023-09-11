# Write your MySQL query statement below
WITH ConfirmationCounts AS (
    SELECT
        s.user_id,
        COUNT(c.action) AS total_confirmations,
        SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_count
    FROM Signups s
    LEFT JOIN Confirmations c ON s.user_id = c.user_id
    GROUP BY s.user_id
)

SELECT
    s.user_id,
    COALESCE(
        ROUND(CAST(cc.confirmed_count AS DECIMAL) / NULLIF(cc.total_confirmations, 0), 2),
        0.00
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN ConfirmationCounts cc ON s.user_id = cc.user_id;
