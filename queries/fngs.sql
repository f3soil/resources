SELECT
    bd.Date,
    bd.AO,
    bd.Q,
    bd.CoQ,
    bd.pax_count AS PAXCount,
    bd.fng_count AS FNGCount,
    bd.fngs AS FNGs,
    bb.backblast,
    GROUP_CONCAT(pax.PAX) AS PAX
FROM f3stlcity.beatdown_info AS bd
JOIN f3stlcity.attendance_view AS pax ON (bd.Date = pax.Date AND bd.AO = pax.AO AND bd.Q = pax.Q)
JOIN f3stlcity.backblast bb ON (bd.AO = bb.AO AND bd.Date = bb.Date)
WHERE
    bd.fng_count > 0
  AND bd.AO LIKE '%zoo%'
GROUP BY
    bd.Date,
    bd.AO,
    bd.Q,
    bd.CoQ,
    bd.pax_count,
    bd.fng_count,
    bd.fngs,
    bb.backblast
