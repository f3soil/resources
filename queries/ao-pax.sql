SELECT
    AO,
    CONCAT("@", GROUP_CONCAT(PAX ORDER BY PAX SEPARATOR " @"))
FROM (
    SELECT
        AO,
        PAX,
        COUNT(*) AS count
    FROM f3stlcity.attendance_view
    WHERE
            AO IN (
                   'ao_outer_rim_moody_park',
                   'ao_black_forest_bolm_schuhkraft_park',
                   'ao_mine_drost_park',
                   'ao_stomping_grounds_bicentennial_park',
                   'ao_the_station_ofallon_community_park',
                   'ao_the_store_joe_glik_park',
                   'ao_the_zoo_tri-township_park_troy'
            )
    GROUP BY
        AO,
        PAX
    HAVING
            count > 2
) AS attendance
GROUP BY attendance.AO
