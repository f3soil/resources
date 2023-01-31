WITH
    ao_mapping AS (
        SELECT
            soil.ao,
            city_channel_id AS city_channel_id,
            soil.channel_id AS soil_channel_id
        FROM f3soil.aos AS soil
        LEFT JOIN (
            SELECT
                channel_id AS city_channel_id,
                CASE
                    WHEN ao = 'ao_outer_rim_moody_park' THEN 'ao_outer_rim'
                    WHEN ao = 'ao_black_forest_bolm_schuhkraft_park' THEN 'ao_black_forest'
                    WHEN ao = 'ao_mine_drost_park' THEN 'ao_mine'
                    WHEN ao = 'ao_stomping_grounds_bicentennial_park' THEN 'ao_stomping_grounds'
                    WHEN ao = 'ao_the_station_ofallon_community_park' THEN 'ao_station'
                    WHEN ao = 'ao_the_store_joe_glik_park' THEN 'ao_store'
                    WHEN ao = 'ao_the_zoo_tri-township_park_troy' THEN 'ao_zoo'
                    ELSE ao
                END        AS ao
            FROM f3stlcity.aos
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
        ) AS city ON city.ao = soil.ao
        WHERE
            soil.ao LIKE 'ao_%'
    ),
    user_mapping AS (
        SELECT
            city.user_name,
            soil.user_id AS soil_user_id,
            city.user_id AS city_user_id
        FROM f3stlcity.users AS city
        JOIN f3soil.users AS soil ON (city.user_name = soil.user_name)
        WHERE
              city.user_name NOT IN ('slackbot', 'qsignups', 'paxminer')
          AND soil.user_id NOT IN (
            'U04M00LUV34' -- Stripes' bad account
            )
    )
SELECT
    city.`timestamp`,
    city.ts_edited,
    u.soil_user_id    AS user_id,
    u.user_name       AS user_name,
    a.soil_channel_id AS ao_id,
    a.ao              AS ao_name,
    city.`date`,
    q.soil_user_id    AS q_user_id,
    q.user_name       AS q_user_name
FROM f3stlcity.bd_attendance AS city
JOIN user_mapping AS u ON city.user_id = u.city_user_id
JOIN user_mapping AS q ON city.q_user_id = q.city_user_id
JOIN ao_mapping AS a ON city.ao_id = a.city_channel_id
WHERE
        a.ao IN (
                 'ao_black_forest',
                 'ao_mine',
                 'ao_outer_rim',
                 'ao_station',
                 'ao_stomping_grounds',
                 'ao_store',
                 'ao_zoo'
        );

WITH
    ao_mapping AS (
        SELECT
            soil.ao,
            city_channel_id AS city_channel_id,
            soil.channel_id AS soil_channel_id
        FROM f3soil.aos AS soil
        LEFT JOIN (
            SELECT
                channel_id AS city_channel_id,
                CASE
                    WHEN ao = 'ao_outer_rim_moody_park' THEN 'ao_outer_rim'
                    WHEN ao = 'ao_black_forest_bolm_schuhkraft_park' THEN 'ao_black_forest'
                    WHEN ao = 'ao_mine_drost_park' THEN 'ao_mine'
                    WHEN ao = 'ao_stomping_grounds_bicentennial_park' THEN 'ao_stomping_grounds'
                    WHEN ao = 'ao_the_station_ofallon_community_park' THEN 'ao_station'
                    WHEN ao = 'ao_the_store_joe_glik_park' THEN 'ao_store'
                    WHEN ao = 'ao_the_zoo_tri-township_park_troy' THEN 'ao_zoo'
                    ELSE ao
                END        AS ao
            FROM f3stlcity.aos
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
        ) AS city ON city.ao = soil.ao
        WHERE
            soil.ao LIKE 'ao_%'
    ),
    user_mapping AS (
        SELECT
            city.user_name,
            soil.user_id AS soil_user_id,
            city.user_id AS city_user_id
        FROM f3stlcity.users AS city
        JOIN f3soil.users AS soil ON (city.user_name = soil.user_name)
        WHERE
              city.user_name NOT IN ('slackbot', 'qsignups', 'paxminer')
          AND soil.user_id NOT IN (
            'U04M00LUV34' -- Stripes' bad account
            )
    )
SELECT
    city.`timestamp`,
    city.ts_edited,
    a.soil_channel_id AS ao_id,
    a.ao              AS ao_name,
    city.bd_date,
    q.soil_user_id    AS q_user_id,
    q.user_name       AS q_user_name,   -- delete
    coq.soil_user_id  AS coq_user_id,
    coq.user_name     AS coq_user_name, -- delete
    city.pax_count,
    city.backblast,
    city.fngs,
    city.fng_count
FROM f3stlcity.beatdowns AS city
JOIN user_mapping AS q ON city.q_user_id = q.city_user_id
LEFT JOIN user_mapping AS coq ON city.coq_user_id = coq.city_user_id
JOIN ao_mapping AS a ON city.ao_id = a.city_channel_id
WHERE
        a.ao IN (
                 'ao_black_forest',
                 'ao_mine',
                 'ao_outer_rim',
                 'ao_station',
                 'ao_stomping_grounds',
                 'ao_store',
                 'ao_zoo'
        );
