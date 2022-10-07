

-- HW
--6.
/*
Write a PL/SQL procedure which prints out the names and sizes (in bytes) of indexes created
on the parameter table. Indexes should be in alphabetical order, and the format of the 
output should be like this: (number of spaces doesn't count between the columns)
CUSTOMERS_YOB_BIX:   196608 */
select BYTES from  DBA_SEGMENTS 
where owner = 'NIKOVITS' and 
segment_type='TABLE' and 
segment_name= 'CUSTOMERS';
select * from nikovits.customers;

select * from DBA_SEGMENTS where segment_type = 'INDEX'and owner = 'NIKOVITS' and segment_name in (
SELECT  index_name
FROM all_indexes
where table_name = 'CUSTOMERS'and table_owner = 'NIKOVITS');


SELECT  *
FROM    all_indexes
where table_name = 'CUSTOMERS'and table_owner = 'NIKOVITS';

CREATE OR REPLACE PROCEDURE list_indexes(p_owner VARCHAR2, p_table VARCHAR2) IS
    Cursor index_cursor is
        select * from DBA_SEGMENTS where segment_type = 'INDEX'and owner = upper(p_owner) and segment_name in (
        SELECT  index_name
        FROM all_indexes
        where table_name = upper(p_table)and table_owner = upper(p_owner));
begin
    for index_info in index_cursor loop
        DBMS_OUTPUT.PUT_LINE(index_info.SEGMENT_NAME ||': '|| index_info.BYTES);
    end loop;
end;
/
set serveroutput on
EXECUTE list_indexes('nikovits', 'customers');

EXECUTE check_plsql('list_indexes(''nikovits'',''customers'')');