WITH
    attendance_counts AS (
        SELECT PAX, AO, COUNT(*) AS Count
        FROM f3stlcity.attendance_view
        GROUP BY PAX, AO
    ),
    home_ao AS (
        SELECT a.PAX, a.AO AS HomeAO
        FROM attendance_counts AS a
        LEFT JOIN attendance_counts AS b ON a.PAX = b.PAX AND a.Count < b.Count
        WHERE b.Count IS NULL
    ),
    soil_bd_attendance AS (
        SELECT user_id,
               COUNT(*) AS beatdowns
        FROM f3stlcity.aos AS aos
        JOIN f3stlcity.bd_attendance AS bd ON bd.ao_id = aos.channel_id
        WHERE
                ao IN (
                       'ao_outer_rim_moody_park',
                       'ao_black_forest_bolm_schuhkraft_park',
                       'ao_mine_drost_park',
                       'ao_stomping_grounds_bicentennial_park',
                       'ao_the_station_ofallon_community_park',
                       'ao_the_store_joe_glik_park',
                       'ao_the_zoo_tri-township_park_troy'
                )
        GROUP BY user_id
    )
SELECT
    h.HomeAO, u.user_name, u.real_name, u.email
FROM soil_bd_attendance AS bd
JOIN f3stlcity.users AS u ON u.user_id = bd.user_id
JOIN home_ao AS h ON u.user_name = h.PAX
LEFT JOIN f3soil.users AS soil1 ON (u.user_name = soil1.user_name)
LEFT JOIN f3soil.users AS soil2 ON (u.email = soil2.email)
WHERE
        beatdowns > 1
  AND COALESCE(soil1.user_name, soil2.email) IS NULL
ORDER BY
    HomeAO, user_name
