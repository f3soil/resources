WITH
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
    CONCAT('@', u.user_name) AS user_name
FROM soil_bd_attendance AS bd
JOIN f3stlcity.users AS u ON u.user_id = bd.user_id
LEFT JOIN f3soil.users AS soil1 ON (u.user_name = soil1.user_name)
LEFT JOIN f3soil.users AS soil2 ON (u.email = soil2.email)
WHERE
        beatdowns >= 5
  AND COALESCE(soil1.user_name, soil2.email) IS NULL
ORDER BY
    user_name
