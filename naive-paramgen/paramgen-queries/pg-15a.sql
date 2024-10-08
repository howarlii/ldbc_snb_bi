SELECT
    p1.id AS 'person1Id:ID',
    p2.id AS 'person2Id:ID',
    ( (SELECT creationDay FROM creationDayNumMessages ORDER BY md5(creationDay::VARCHAR) ASC  LIMIT 1) - INTERVAL (p1.id % 7) DAY )::DATE AS 'startDate:DATE',
    ( (SELECT creationDay FROM creationDayNumMessages ORDER BY md5(creationDay::VARCHAR) DESC LIMIT 1) + INTERVAL (p2.id % 7) DAY )::DATE AS 'endDate:DATE'
FROM
    (SELECT id FROM personNumFriends ORDER BY md5(id::VARCHAR) ASC  LIMIT 20) p1,
    (SELECT id FROM personNumFriends ORDER BY md5(id::VARCHAR) DESC LIMIT 20) p2
ORDER BY md5((131::BIGINT*p1.id + 241::BIGINT*p2.id)::VARCHAR), md5(p1.id::VARCHAR)
LIMIT 400
