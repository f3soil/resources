UPDATE aos
SET backblast = IF(ao LIKE '%mumblechat%' OR ao IN ('announcements', 'sector_discussion') OR archived, 0, 1)
WHERE
    backblast != IF(ao LIKE '%mumblechat%' OR ao IN ('announcements', 'sector_discussion') OR archived, 0, 1);

SELECT ao, channel_id, archived, backblast
FROM aos
ORDER BY ao;

UPDATE aos
SET archived = 1
WHERE
    channel_id IN (
        'C05K2TKMY2H',
        'C06NFKQL7MW'
    );
