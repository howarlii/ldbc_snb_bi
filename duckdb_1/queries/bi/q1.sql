/* Q1. Posting summary
\set date '\'2011-07-21T22:00:00\''::timestamp
 */
WITH
  message_count AS (
    SELECT 0.0 + count(*) AS cnt
      FROM message
     WHERE 1=1
       AND creationDate < '2011-07-21T22:00:00'
)
, message_prep AS (
    SELECT extract(year from creationDate) AS messageYear
         , m_c_replyof IS NOT NULL AS isComment
         , CASE
             WHEN length <  40 THEN 0 -- short
             WHEN length <  80 THEN 1 -- one liner
             WHEN length < 160 THEN 2 -- tweet
             ELSE                     3 -- long
           END AS lengthCategory
         , length
      FROM message
     WHERE 1=1
       AND creationDate < '2011-07-21T22:00:00'
       --AND m_content IS NOT NULL
       AND m_ps_imagefile IS NULL -- FIXME CHECKME: posts w/ m_ps_imagefile IS NOT NULL should have m_content IS NULL
)
SELECT messageYear, isComment, lengthCategory
     , count(*) AS messageCount
     , avg(length) AS averageMessageLength
     , sum(length) AS sumMessageLength
     , count(*) / mc.cnt AS percentageOfMessages
  FROM message_prep
     , message_count mc
 GROUP BY messageYear, isComment, lengthCategory, mc.cnt
 ORDER BY messageYear DESC, isComment ASC, lengthCategory ASC
;