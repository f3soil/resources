SELECT *
FROM beatdowns
WHERE
  bd_date > CURRENT_DATE()
  OR
  fng_count < 0
  OR
  fng_count > 5
  OR
  pax_count < 0
  OR
  pax_count > 20
