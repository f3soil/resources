UPDATE aos
SET backblast = 1
WHERE (
    ao LIKE 'ao_%'
    OR ao LIKE 'csaup_%'
    OR channel_id IN (
      'C04KMV5DP32', -- black_ops
      'C04KMV5DP32', -- dr
      'C04HUNJC05B', -- q-source
      'C04HR3BH9K8', -- rucking
      'C0518AEDD7B'  -- running
    )
  )
  AND backblast != 1
  AND archived = 0
