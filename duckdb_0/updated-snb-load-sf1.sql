-- Populate forum table
COPY forum FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Forum/part-00000-5e71841b-ca10-42d6-b79d-c4aeaa569c05-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate forum_person table
COPY forum_person FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Forum_hasMember_Person/part-00000-bd8deb83-af02-4310-8cf5-434affa87bcf-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate forum_tag table
COPY forum_tag FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Forum_hasTag_Tag/part-00000-7161875f-b615-49bd-b6df-19a3d6a6e385-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate organisation table
COPY organisation FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//static/Organisation/part-00000-1248fcd1-a74f-41f4-9b47-501b9990afe2-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate person table
COPY person FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Person/part-00000-0bb8ee98-9bc3-4b19-927d-6a651790788c-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate person_email table

-- Populate person_tag table
COPY person_tag FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Person_hasInterest_Tag/part-00000-a6fbd692-4f68-49e5-915a-c835c6497175-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate knows table
COPY knows ( k_creationdate, k_person1id, k_person2id) FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Person_knows_Person/part-00000-d6e53f20-352b-4d73-9a87-74c185214fc9-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');
COPY knows ( k_creationdate, k_person2id, k_person1id) FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Person_knows_Person/part-00000-d6e53f20-352b-4d73-9a87-74c185214fc9-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate likes table
COPY likes FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Person_likes_Post/part-00000-f1de6a21-608e-42d1-9d0e-68951f8a3dcd-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');
COPY likes FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Person_likes_Comment/part-00000-6a8ae307-0d47-43e1-8461-34d02ecf16b7-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate person_language table

-- Populate person_university table

-- Populate person_company table

-- Populate place table
COPY place FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//static/Place/part-00000-64bc10a1-d3a3-4dea-83b1-0260c46ecb4d-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate message_tag table
COPY message_tag FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Post_hasTag_Tag/part-00000-544dfa30-a53e-4a4d-94ca-fe79fc04fd4f-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');
COPY message_tag FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Comment_hasTag_Tag/part-00000-aff948cb-0aa2-49aa-84ba-e8a1a229715b-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate tagclass table
COPY tagclass FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//static/TagClass/part-00000-d7a4196c-777a-49bc-880b-9722f1a9abfe-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

-- Populate tag table
COPY tag FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//static/Tag/part-00000-855ad4ad-661a-422e-93e5-77ce40de5e2b-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');


-- PROBLEMATIC

-- Populate message table
COPY post FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Post/part-00000-300d292b-0637-4502-b9c9-14b2cfc05c4f-c000.csv.gz'  (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');
COPY comment FROM '/data/project/ldbc-bi/out_sf1_bi_gzip/graphs/csv/bi/composite-merged-fk/initial_snapshot//dynamic/Comment/part-00000-86fff6af-140e-42fb-8c0e-20c8c9c54d0a-c000.csv.gz' (DELIMITER '|', HEADER, TIMESTAMPFORMAT '%Y-%m-%dT%H:%M:%S.%g+00:00');

create view country as select city.pl_placeid as ctry_city, ctry.pl_name as ctry_name from place city, place ctry where city.pl_containerplaceid = ctry.pl_placeid and ctry.pl_type = 'country';
