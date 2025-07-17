SELECT 
    h.host AS hostname,
    t.description,
    t.status
FROM triggers t
JOIN functions f ON f.triggerid = t.triggerid
JOIN items i ON i.itemid = f.itemid
JOIN hosts h ON h.hostid = i.hostid
WHERE t.status = 1  -- 1 = disabled
ORDER BY h.host;
