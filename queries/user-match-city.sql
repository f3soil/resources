SELECT
    city.user_name,
    COALESCE(soil2.user_id, soil1.user_id) AS user_id,
    soil1.user_id                          AS soil1_user_id,
    soil1.user_name                        AS soil1_user_name,
    soil2.user_id                          AS soil2_user_id,
    soil2.email                            AS soil3_email,
    city.user_id                           AS city_user_id
FROM f3stlcity.users AS city
LEFT JOIN f3soil.users AS soil1 ON (city.user_name = soil1.user_name)
LEFT JOIN f3soil.users AS soil2 ON (city.email = soil2.email)
WHERE
      city.email != 'None'
  AND city.user_id NOT IN (
    'U03RKKP831Q' -- Other Scrappy
    )
  AND (soil1.user_id IS NULL OR soil1.user_id NOT IN (
    'U04M00LUV34' -- Stripes' bad account
    ))
  AND (soil2.user_id IS NULL OR soil2.user_id NOT IN (
    'U04M00LUV34' -- Stripes' bad account
    ))
  AND (soil1.user_id IS NULL OR soil2.user_id IS NULL OR soil1.user_id = soil2.user_id)
  AND NOT (soil1.user_id IS NULL AND soil2.user_id IS NULL)
