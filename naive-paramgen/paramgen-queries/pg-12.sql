SELECT
    startDate AS 'startDate:DATE',
    150 - salt*5 AS 'lengthThreshold:INT',
    string_agg(lng, ';') AS 'languages:STRING[]'
FROM (SELECT
        salt,
        startDate,
        lang_perm,
        ROW_NUMBER() OVER(PARTITION BY lang_perm, salt ORDER BY md5(concat(lng, lang_perm))) rn,
        lng
    FROM (
        SELECT
            salt,
            startDate,
            lang_perm,
            lng
        FROM (SELECT
                    salt,
                    startDate,
                    lang.language AS lng
                FROM
                    (SELECT
                        (
                            (SELECT creationDay FROM creationDayNumMessages ORDER BY md5(creationDay::VARCHAR) LIMIT 1) + INTERVAL (salt*3) DAY)::DATE AS startDate, salt
                            FROM (SELECT unnest(generate_series(1, 20)) AS salt)
                    ) sd,
                    (SELECT
                        language
                    FROM languageNumPosts
                    ORDER BY md5(language)
                    LIMIT 10
                    ) lang
                ORDER BY salt, md5(concat(lang.language, salt))
            ),
            (SELECT unnest(generate_series(1, 4)) AS lang_perm)
        ORDER BY startDate, salt, md5((3532569367::BIGINT*salt + 342663089::BIGINT*lang_perm)::VARCHAR)
    )
)
WHERE rn <= 3
GROUP BY startDate, salt, lang_perm
ORDER BY md5(startDate::VARCHAR), lang_perm
