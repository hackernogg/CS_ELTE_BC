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

--4.
select * from dual;

select * from sz1;

--HW.
select * from dba_tables where owner = 'NIKOVITS';

select max(timestamp) from DBA_OBJECTS where owner ='NIKOVITS' and object_type = 'TABLE';

select object_name, timestamp from DBA_OBJECTS
where owner = 'NIKOVITS' and 
object_type = 'TABLE' and 
timestamp = (select max(timestamp) from DBA_OBJECTS where owner ='NIKOVITS' and object_type = 'TABLE');

select BYTES from  DBA_SEGMENTS 
where owner = 'NIKOVITS' and 
segment_type='TABLE' and 
segment_name=(
select object_name from DBA_OBJECTS
where owner = 'NIKOVITS' and 
object_type = 'TABLE' and 
timestamp = (select max(timestamp) from DBA_OBJECTS where owner ='NIKOVITS' and object_type = 'TABLE'));


CREATE OR REPLACE PROCEDURE newest_table(p_user VARCHAR2) IS
    newest_time VARCHAR2(20);
    num_bytes NUMBER;
    newest_table_name VARCHAR2(20);
    needed_time VARCHAR2(20);
BEGIN
    select object_name,timestamp into newest_table_name , newest_time from DBA_OBJECTS
    where owner = p_user and 
    object_type = 'TABLE' and 
    timestamp = (select max(timestamp) from DBA_OBJECTS where owner =p_user and object_type = 'TABLE');
    
    select BYTES into num_bytes from  DBA_SEGMENTS 
    where owner = p_user and 
    segment_type='TABLE' and 
    segment_name=(
    select object_name from DBA_OBJECTS
    where owner = p_user and 
    object_type = 'TABLE' and 
    timestamp = (select max(timestamp) from DBA_OBJECTS where owner =p_user and object_type = 'TABLE'));
    needed_time := SUBSTR(newest_time,1,4)||'.'||
                   SUBSTR(newest_time,6,2)||'.'||
                   SUBSTR(newest_time,9,2)||'.'||
                   SUBSTR(newest_time,12,2)||':'||
                   SUBSTR(newest_time,15,2);
    DBMS_OUTPUT.PUT_LINE('Table_name: '||newest_table_name||' Size: '||num_bytes|| ' bytes ' ||'Created: '||needed_time);

END;
/
set serveroutput on
EXECUTE newest_table('NIKOVITS');

EXECUTE check_plsql('newest_table(''NIKOVITS'')');


