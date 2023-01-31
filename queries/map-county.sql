WITH
    ao_mapping AS (
        SELECT
            county_channel_id,
            soil.channel_id AS soil_channel_id,
            soil.ao
        FROM f3soil.aos AS soil
        LEFT JOIN (
            SELECT
                channel_id AS county_channel_id,
                CASE
                    WHEN ao = 'ao_the_outer_rim' THEN 'ao_outer_rim'
                    WHEN ao = 'ao_the_black_forest_columbia_il' THEN 'ao_black_forest'
                    WHEN ao = 'ao_the_mine_maryville_il' THEN 'ao_mine'
                    WHEN ao = 'ao_stomping_grounds_belleville' THEN 'ao_stomping_grounds'
                    ELSE ao
                END        AS ao
            FROM f3stl.aos
            WHERE
                    ao IN (
                           'ao_the_outer_rim',
                           'ao_the_black_forest_columbia_il',
                           'ao_the_mine_maryville_il',
                           'ao_stomping_grounds_belleville'
                    )
        ) AS county ON county.ao = soil.ao
        WHERE
            soil.ao LIKE 'ao_%'
    ),
    user_mapping AS (
        SELECT
            soil.user_id   AS soil_user_id,
            county.user_id AS county_user_id,
            soil.user_name
        FROM f3stl.users AS county
        JOIN f3soil.users AS soil ON (county.user_name = soil.user_name)
        WHERE
              county.user_name NOT IN ('Slackbot', 'QSignups', 'PAXminer')
          AND soil.user_id NOT IN (
            'U04M00LUV34' -- Stripes' bad account
            )
    )
SELECT
    county.`timestamp`,
    county.ts_edited,
    u.soil_user_id    AS user_id,
    u.user_name       AS user_name,
    a.soil_channel_id AS ao_id,
    a.ao              AS ao_name,
    county.`date`,
    q.soil_user_id    AS q_user_id,
    q.user_name       AS q_user_name
FROM f3stl.bd_attendance AS county
JOIN user_mapping AS u ON county.user_id = u.county_user_id
JOIN user_mapping AS q ON county.q_user_id = q.county_user_id
JOIN ao_mapping AS a ON county.ao_id = a.county_channel_id
WHERE
        ao_id IN (
                  'C022GBLKK35',
                  'C02K0N6DLAE',
                  'C02K16WK20N',
                  'C03B535R709'
        );

WITH
    ao_mapping AS (
        SELECT
            county_channel_id,
            soil.channel_id AS soil_channel_id,
            soil.ao
        FROM f3soil.aos AS soil
        LEFT JOIN (
            SELECT
                channel_id AS county_channel_id,
                CASE
                    WHEN ao = 'ao_the_outer_rim' THEN 'ao_outer_rim'
                    WHEN ao = 'ao_the_black_forest_columbia_il' THEN 'ao_black_forest'
                    WHEN ao = 'ao_the_mine_maryville_il' THEN 'ao_mine'
                    WHEN ao = 'ao_stomping_grounds_belleville' THEN 'ao_stomping_grounds'
                    ELSE ao
                END        AS ao
            FROM f3stl.aos
            WHERE
                    ao IN (
                           'ao_the_outer_rim',
                           'ao_the_black_forest_columbia_il',
                           'ao_the_mine_maryville_il',
                           'ao_stomping_grounds_belleville'
                    )
        ) AS county ON county.ao = soil.ao
        WHERE
            soil.ao LIKE 'ao_%'
    ),
    user_mapping AS (
        SELECT
            soil.user_id   AS soil_user_id,
            county.user_id AS county_user_id,
            soil.user_name
        FROM f3stl.users AS county
        JOIN f3soil.users AS soil ON (county.user_name = soil.user_name)
        WHERE
              county.user_name NOT IN ('Slackbot', 'QSignups', 'PAXminer')
          AND soil.user_id NOT IN (
            'U04M00LUV34' -- Stripes' bad account
            )
    )
SELECT
    county.`timestamp`,
    county.ts_edited,
    a.soil_channel_id AS ao_id,
    a.ao              AS ao_name,
    county.bd_date,
    q.soil_user_id    AS q_user_id,
    q.user_name       AS q_user_name,   -- delete
    coq.soil_user_id  AS coq_user_id,
    coq.user_name     AS coq_user_name, -- delete
    county.pax_count,
    county.backblast,
    county.fngs,
    county.fng_count
FROM f3stl.beatdowns AS county
JOIN user_mapping AS q ON county.q_user_id = q.county_user_id
LEFT JOIN user_mapping AS coq ON county.coq_user_id = coq.county_user_id
JOIN ao_mapping AS a ON county.ao_id = a.county_channel_id
WHERE
        county.ao_id IN (
                         'C022GBLKK35',
                         'C02K0N6DLAE',
                         'C02K16WK20N',
                         'C03B535R709'
        );
