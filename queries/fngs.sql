SELECT
    DATE_FORMAT(bd.Date, "%m/%d") AS Anniversary,
    bd.Date AS StartDate,
    bd.AO,
    bd.Q,
    bd.CoQ,
    bd.pax_count AS PAXCount,
    bd.fng_count AS FNGCount,
    bd.fngs AS FNGs,
    bb.backblast,
    GROUP_CONCAT(pax.PAX) AS PAX
FROM beatdown_info AS bd
JOIN attendance_view AS pax ON (bd.Date = pax.Date AND bd.AO = pax.AO AND bd.Q = pax.Q)
JOIN backblast bb ON (bd.AO = bb.AO AND bd.Date = bb.Date)
WHERE
    bd.fng_count > 0
    AND bd.fngs != "0"
    AND bd.fngs NOT LIKE "None%"
    AND bd.fngs NOT LIKE "none%"
    AND bd.fngs NOT LIKE "Nope%"
GROUP BY
    bd.Date,
    bd.AO,
    bd.Q,
    bd.CoQ,
    bd.pax_count,
    bd.fng_count,
    bd.fngs,
    bb.backblast
ORDER BY MONTH(bd.Date), DAY(bd.Date)
