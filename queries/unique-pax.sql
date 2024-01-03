WITH ao_monthly_attendance AS (SELECT MONTH(Date) AS Month, PAX
                               FROM attendance_view
                               WHERE MONTH(Date) >= 2
                                 AND MONTH(Date) < 4
                                 AND YEAR(Date) = 2023
                                 AND AO LIKE 'ao_%'
                               GROUP BY MONTH(Date), PAX
                               ORDER BY MONTH(Date), PAX)
SELECT Month, COUNT(*) AS 'Unique PAX'
FROM ao_monthly_attendance
GROUP BY Month
