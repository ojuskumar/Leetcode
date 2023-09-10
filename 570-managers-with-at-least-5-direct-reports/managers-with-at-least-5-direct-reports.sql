# Write your MySQL query statement below
SELECT E1.name
FROM Employee E1
JOIN (
    SELECT managerId, COUNT(id) AS directReportsCount
    FROM Employee
    GROUP BY managerId
) E2 ON E1.id = E2.managerId
WHERE E2.directReportsCount >= 5;
