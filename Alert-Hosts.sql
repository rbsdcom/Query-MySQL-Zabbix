SELECT DISTINCT h.host
FROM hosts h
JOIN items i ON h.hostid = i.hostid
JOIN functions f ON i.itemid = f.itemid
JOIN triggers t ON f.triggerid = t.triggerid
WHERE h.status = 0
  AND h.flags IN (0, 4)
  AND t.value = 1
  AND t.status = 0;
