WITH
    attendance AS (
        SELECT
            user_id,
            COUNT(*) AS posts
        FROM f3stlcity.aos AS aos
        JOIN f3stlcity.bd_attendance AS bd ON bd.ao_id = aos.channel_id
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
        GROUP BY user_id
    ),
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
    )
SELECT user_match.user_name, attendance.posts
FROM attendance
         JOIN user_match ON (attendance.user_id = user_match.user_id)
GROUP BY user_match.user_name
ORDER BY posts DESC

SELECT *
FROM f3stlcity.attendance_view
WHERE PAX = "Cousin Eddie"
  AND MONTH(Date) = 1 AND YEAR(Date) = 2023
ORDER BY Date
