WITH home_ao AS (
    SELECT PAX, AO, COUNT(*) AS Count
    FROM f3stlcity.attendance_view
    GROUP BY PAX, AO
)
SELECT a.*
FROM home_ao AS a
LEFT JOIN home_ao AS b ON a.PAX = b.PAX AND a.Count < b.Count
WHERE b.Count IS NULL
