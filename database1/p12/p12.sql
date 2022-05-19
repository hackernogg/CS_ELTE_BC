CREATE OR REPLACE PROCEDURE rich_descendant IS
    cnt integer;
BEGIN
    For rec in (select name, money from nikovits.parentof) loop
        select count(*) into cnt
        from nikovits.parentof
        where money>rec.money
        start with name = rec.name
        connect by prior name = parent;
        
        if cnt > 0 then
            DBMS_OUTPUT.PUT_LINE(rec.name || ' has less money than one of his descendants');
        end if;
    end loop;
END;
