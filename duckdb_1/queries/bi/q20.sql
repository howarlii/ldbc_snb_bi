DROP TABLE IF EXISTS Person_UniversityKnows_Person;
DROP TABLE IF EXISTS PersonUniversity;
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS all_options;

-- PRECOMPUTE
CREATE TEMP TABLE Person_UniversityKnows_Person AS (SELECT p.id                                     as Person1id,
                                                      p2.id                                    as Person2id,
                                                      min(abs(u.classYear - u2.classYear) + 1) as weight --
                                               FROM Person p
                                                        JOIN Person_knows_Person k on p.id = k.Person1id
                                                        JOIN Person p2 on p2.id = k.Person2id
                                                        JOIN Person_studyAt_University u on p.id = u.PersonId
                                                        JOIN Person_studyAt_University u2 on p2.id = u2.PersonId
                                               WHERE u.UniversityId = u2.UniversityId
                                               GROUP BY p.id, p2.id
                                               ORDER BY p.id, p2.id);


-- PRECOMPUTE
CREATE TEMP TABLE PersonUniversity AS (SELECT DISTINCT Person1id as id
                                  FROM ((SELECT Person1id
                                         FROM Person_UniversityKnows_Person)
                                        UNION ALL
                                        (SELECT Person2id AS Person1id
                                         FROM Person_UniversityKnows_Person))
                                  ORDER BY id);

-- CSR CREATION
SELECT CREATE_CSR_VERTEX(
0,
v.vcount,
sub.dense_id,
sub.cnt
) AS numEdges
FROM (
    SELECT c.rowid as dense_id, count(t.person1id) as cnt
    FROM PersonUniversity c
    LEFT JOIN  Person_UniversityKnows_Person t ON t.person1id = c.id
    GROUP BY c.rowid
) sub, (SELECT count(c.id) as vcount FROM PersonUniversity c) v;

-- CSR CREATION
SELECT min(CREATE_CSR_EDGE(0, (SELECT count(c.id) as vcount FROM PersonUniversity c),
CAST ((SELECT sum(CREATE_CSR_VERTEX(0, (SELECT count(c.id) as vcount FROM PersonUniversity c),
sub.dense_id, sub.cnt)) AS numEdges
FROM (
    SELECT c.rowid as dense_id, count(t.person1id) as cnt
    FROM PersonUniversity c
    LEFT JOIN  Person_UniversityKnows_Person t ON t.person1id = c.id
    GROUP BY c.rowid
) sub) AS BIGINT),
src.rowid, dst.rowid, t.weight))
FROM
  Person_UniversityKnows_Person t
  JOIN PersonUniversity src ON t.person1id = src.id
  JOIN PersonUniversity dst ON t.person2id = dst.id;


create temp table results
(
    Person1id bigint,
    Person2id bigint,
    company   varchar,
    weight    bigint
);

-- PRAGMA
pragma set_lane_limit=:param;

-- PRAGMA
pragma threads=:param;

PRAGMA verify_parallelism;

create table all_options(
    person1id bigint,
    person1rowid bigint,
    person2id bigint,
    person2rowid bigint,
    company varchar
);

-- PARAMS
INSERT INTO all_options(SELECT  p.id                                                                            as Person1id,
                                p.rowid                                                                         as person1rowid,
                                p2.id                                                                           as Person2id,
                                p2.rowid                                                                        as person2rowid,
                                c.name                                                                          as Company
                     FROM PersonUniversity p
                              JOIN Person_workAt_Company pwc on p.id = pwc.PersonId
                              JOIN Company c on (pwc.CompanyId = c.id AND c.name = ':company')
                              JOIN PersonUniversity p2 on p2.id = :person2id
                        );

-- NUMPATHS
select count(*) from all_options;

-- NUMVERTICESEDGES
select num_vertices, num_edges from (select count(*) as num_vertices from PersonUniversity),
                                    (select count(*) as num_edges from Person_UniversityKnows_Person);

-- PATH
INSERT INTO results (SELECT p.person1id, p.person2id, p.company, cheapest_path(0, (select count(*) from personuniversity), p.person1rowid, p.person2rowid) as weight from all_options p);

pragma delete_csr=0;

-- RESULTS
SELECT (SELECT person1id FROM results WHERE person2id = agg.person2id and company = agg.company and weight = agg.min_weight LIMIT 20)
           as person1id,
        min_weight as weight,
        company,
        person2id
FROM (SELECT min(weight) AS min_weight, person2id, company
      FROM results
      GROUP BY person2id, company) agg
;

