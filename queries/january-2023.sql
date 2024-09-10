WITH
    user_match AS (
        SELECT
            city.user_id,
            COALESCE(soil2.user_name, soil1.user_name) AS user_name
        FROM f3stlcity.users AS city
        LEFT JOIN f3soil.users AS soil2 ON (city.email = soil2.email)
        LEFT JOIN f3soil.users AS soil1 ON (
            (
                city.user_name = soil1.user_name
                OR
                city.user_name LIKE CONCAT(soil1.user_name, " %(")
            )
            AND soil2.user_id != soil1.user_id
        )
        WHERE
            (
                soil1.user_id IS NOT NULL
                OR soil2.user_name IS NOT NULL
            )
            AND COALESCE(soil2.user_name, soil1.user_name) NOT LIKE "%(%"
            AND COALESCE(soil2.user_name, soil1.user_name) NOT IN (
                "Channel Tools",
                "Google Drive",
                "PAXminer",
                "QSignups",
                "Slackbot"
            )
    ),
    city AS (
        SELECT user_name
        FROM f3stlcity.aos AS aos
        JOIN f3stlcity.bd_attendance AS bd ON bd.ao_id = aos.channel_id
        JOIN user_match ON (bd.user_id = user_match.user_id)
        WHERE ao IN (
                     'ao_outer_rim_moody_park',
                     'ao_black_forest_bolm_schuhkraft_park',
                     'ao_mine_drost_park',
                     'ao_stomping_grounds_bicentennial_park',
                     'ao_the_station_ofallon_community_park',
                     'ao_the_store_joe_glik_park',
                     'ao_the_zoo_tri-township_park_troy',
                     'blackops'
            )
          AND MONTH(bd.Date) = 1 AND YEAR(bd.Date) = 2023
    ),
    soil AS (
        SELECT PAX AS user_name
        FROM attendance_view
        WHERE YEAR(Date) = 2023
    ),
    minimum AS (
        SELECT user_name, COUNT(*) AS posts
        FROM (
                 SELECT * FROM city
                 UNION ALL
                 SELECT * FROM soil
             ) AS combined
        GROUP BY user_name
        HAVING posts >= 52*5
    )
SELECT CONCAT('@', user_name)
FROM minimum
GROUP BY user_name
ORDER BY user_name
