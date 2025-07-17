SELECT 
    e.severity AS severidade_id,
    CASE e.severity
        WHEN 0 THEN 'Not classified'
        WHEN 1 THEN 'Information'
        WHEN 2 THEN 'Warning'
        WHEN 3 THEN 'Average'
        WHEN 4 THEN 'High'
        WHEN 5 THEN 'Disaster'
    END AS severidade_nome,
    COUNT(DISTINCT h.hostid) AS quantidade_hosts
FROM problem p
JOIN events e ON e.eventid = p.eventid
JOIN triggers t ON t.triggerid = e.objectid
JOIN functions f ON f.triggerid = t.triggerid
JOIN items i ON i.itemid = f.itemid
JOIN hosts h ON h.hostid = i.hostid
WHERE p.r_eventid IS NULL
  AND h.status = 0
  AND h.flags IN (0, 4)
  AND t.status = 0
GROUP BY e.severity
ORDER BY e.severity;
