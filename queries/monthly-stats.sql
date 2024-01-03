WITH ao_monthly_attendance AS (SELECT AO, MONTH(Date) AS Month, COUNT(*) AS Posts
                               FROM attendance_view
                               WHERE MONTH(Date) >= 2
                                 AND MONTH(Date) < 4
                                 AND YEAR(Date) = 2023
                                 AND AO LIKE 'ao_%'
                               GROUP BY MONTH(Date), AO
                               ORDER BY AO, MONTH(Date))
SELECT *
FROM ao_monthly_attendance
UNION ALL
SELECT 'total' AS AO, Month, SUM(Posts) AS Posts
FROM ao_monthly_attendance
GROUP BY 'total', Month
