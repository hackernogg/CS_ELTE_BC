--HW
--Write a PL/SQL procedure which counts and prints the number of empty blocks of a table.
--Output format -> Empty Blocks: nnn
select blocks from dba_segments where owner = 'NIKOVITS' and segment_name = 'EMPLOYEES';
SELECT COUNT(*) FROM( SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) 
FROM NIKOVITS.employees GROUP BY DBMS_ROWID.ROWID_BLOCK_NUMBER(ROWID));

CREATE OR REPLACE PROCEDURE empty_blocks(p_owner VARCHAR2, p_table VARCHAR2) IS
    total_num_block INTEGER;
    used_num_block INTEGER;
    empty_num_block INTEGER;
    v_str VARCHAR2(2000);
BEGIN
    select blocks into total_num_block  from dba_segments 
    where owner = UPPER(p_owner) and segment_name = UPPER(p_table);
    v_str := 'SELECT COUNT(*) FROM( SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(rowid) 
    FROM '||UPPER(p_owner)||'.'||UPPER(p_table)||' GROUP BY DBMS_ROWID.ROWID_BLOCK_NUMBER(ROWID))';
    EXECUTE IMMEDIATE v_str into used_num_block;
    empty_num_block := total_num_block - used_num_block;
    DBMS_OUTPUT.PUT_LINE( 'Empty Blocks: '||empty_num_block);
END;
/
set serveroutput on
EXECUTE empty_blocks('nikovits', 'employees');

EXECUTE check_plsql('empty_blocks(''nikovits'', ''employees'')');



