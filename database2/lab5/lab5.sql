--HW
/*
9.
Write a PL/SQL procedure which prints out the storage type (heap organized, partitioned, index organized or clustered) 
for the parameter table. Output should look like the following:
   Clustered: NO Partitioned: YES IOT: NO
   */
   
SELECT owner, table_name, cluster_name, partitioned, iot_type 
FROM dba_tables WHERE owner='NIKOVITS' 
AND table_name IN ('EMP', 'ELADASOK5', 'CIKK_IOT', 'EMP_CLT');
SELECT cluster_name, partitioned, iot_type 
FROM dba_tables WHERE owner='NIKOVITS' 
AND table_name = 'EMP';


CREATE OR REPLACE PROCEDURE print_type(p_owner VARCHAR2, p_table VARCHAR2) IS
    temp_cluster VARCHAR2(20);
    temp_partitioned VARCHAR2(20);
    temp_iot VARCHAR2(20);
BEGIN
    SELECT cluster_name, partitioned, iot_type into temp_cluster,temp_partitioned,temp_iot
    FROM dba_tables WHERE owner=upper(p_owner) and table_name = upper(p_table);
    if temp_cluster is null then
        temp_cluster := 'No';
    else
        temp_cluster := 'Yes';
    end if;
    if temp_partitioned is null then
        temp_partitioned := 'No';
    else
        temp_partitioned := 'Yes';
    end if;
    if temp_iot is null then
        temp_iot := 'No';
    else
        temp_iot := 'Yes';
    end if;
    DBMS_OUTPUT.PUT_LINE(temp_cluster);
    DBMS_OUTPUT.PUT_LINE(temp_partitioned);
    DBMS_OUTPUT.PUT_LINE(temp_iot);

            
END;
/
set serveroutput on
execute print_type('nikovits', 'emp');