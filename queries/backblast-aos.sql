UPDATE aos
SET backblast = 1
WHERE (
    ao LIKE 'ao_%'
    OR channel_id = 'C04KMV5DP32' -- black_ops
  )
  AND backblast != 1
  AND archived = 0
