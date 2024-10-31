UPDATE aos
SET   backblast  = IF(ao LIKE '%mumblechat%' OR ao LIKE '%slt' OR ao IN ('achievements', 'paxminer_logs', 'sector_discussion', 'slackblast_practice', 'slt-messages') OR archived, 0, 1)
WHERE backblast != IF(ao LIKE '%mumblechat%' OR ao LIKE '%slt' OR ao IN ('achievements', 'paxminer_logs', 'sector_discussion', 'slackblast_practice', 'slt-messages') OR archived, 0, 1)
;

UPDATE aos
SET archived = 1
WHERE channel_id IN (
    'C04HH51JF4P',
    'C05K2TKMY2H',
    'C06NFKQL7MW',
    'C06UDUBH160'
);

SELECT ao, channel_id, archived, backblast
FROM aos
WHERE NOT archived OR (archived AND backblast)
ORDER BY ao;
