SELECT 
    h.host,
    COUNT(DISTINCT t.triggerid) AS quantidade_triggers_com_problema
FROM problem p
JOIN events e ON e.eventid = p.eventid
JOIN triggers t ON e.objectid = t.triggerid
JOIN functions f ON f.triggerid = t.triggerid
JOIN items i ON i.itemid = f.itemid
JOIN hosts h ON h.hostid = i.hostid
WHERE p.r_eventid IS NULL  -- apenas problemas ainda ativos
  AND h.status = 0         -- host habilitado
  AND h.flags IN (0, 4)    -- apenas hosts normais e descobertos (sem templates)
  AND t.status = 0         -- trigger habilitada
GROUP BY h.host
ORDER BY quantidade_triggers_com_problema DESC;
