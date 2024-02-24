UPDATE aos
SET backblast = IF(ao LIKE 'mumblechat%' OR archived = 1, 0, 1)
WHERE
    backblast = IF(ao LIKE 'mumblechat%' OR archived = 1, 1, 0);

SELECT ao, backblast, archived
FROM aos
ORDER BY backblast DESC, archived, ao;
