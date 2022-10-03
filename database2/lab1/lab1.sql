SELECT * from nikovits.emp;

select * from DBA_TABLES;

select owner,table_name  from DBA_TABLES where owner = 'NIKOVITS';

--1.
select owner from DBA_VIEWS where view_name = 'DBA_TABLES';
select owner from DBA_TABLES where table_name = 'DUAL';
--2.

select owner from DBA_synonyms where synonym_name = 'DBA_TABLES';
--3.
select * from DBA_VIEWS;
select * from DBA_OBJECTS;


select table_name  from DBA_TABLES where owner = 'NIKOVITS' and table_name like '%B%';
--
CREATE TABLE PR01
as (select table_name  from DBA_TABLES where owner = 'NIKOVITS' and table_name like '%B%');

select * from PR01;


select owner,table_name  from DBA_TABLES where owner = 'BCFOGS';

