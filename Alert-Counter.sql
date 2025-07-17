SELECT 
    h.host AS hostname,
    t.triggerid,
    MAX(t.description) AS description,
    MAX(t.expression) AS expression,
    COUNT(e.eventid) AS alert_count,
    MIN(FROM_UNIXTIME(e.clock)) AS first_alert,
    MAX(FROM_UNIXTIME(e.clock)) AS last_alert,
    MAX(t.priority) AS priority,
    MAX(t.status) AS status
FROM triggers t
JOIN functions f ON f.triggerid = t.triggerid
JOIN items i ON i.itemid = f.itemid
JOIN hosts h ON h.hostid = i.hostid
JOIN events e ON e.objectid = t.triggerid AND e.object = 0
WHERE e.clock > UNIX_TIMESTAMP(NOW() - INTERVAL 7 DAY)
GROUP BY h.host, t.triggerid
ORDER BY alert_count DESC
LIMIT 50;
