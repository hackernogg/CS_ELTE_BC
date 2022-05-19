/* CONNECT BY
Write a procedure which prints out (based on table NIKOVITS.PARENTOF) the names 
of people who has a richer descendant than him/her. 
(That is, at least one descendant has more money than the person.)
*/
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
/
set serveroutput on
execute rich_descendant(); 

--select * from nikovits.parentof;

/*
Write a procedure which prints out (based on table NIKOVITS.PARENTOF) the name,
money and average money of the descendants for whom it is true, that the average money
of the descendants is greater than the person's money.
The program should print out 3 pieces of data for every row: Name, Money, Avg_Money_of_Descendants 
*/
CREATE OR REPLACE PROCEDURE rich_avg_descendant IS
    avg_money number;
BEGIN
    For rec in (select name, money from nikovits.parentof) loop
        select avg(money) into avg_money
        from nikovits.parentof
        where name != rec.name
        start with name = rec.name
        connect by prior name = parent;
        
        if avg_money > rec.money then
            DBMS_OUTPUT.PUT_LINE(rec.name||'-'||rec.money||'-'||avg_money);
        end if;
    end loop;
END;
/
set serveroutput on
execute rich_avg_descendant();


/*
Write a procedure which prints out (based on table NIKOVITS.PARENTOF) the name and city
of people who have at least two ancestors with the same city as the person's city.
*/
select * from nikovits.parentof;
CREATE OR REPLACE PROCEDURE ancestor2 IS
    cnt integer;
BEGIN
    For rec in (select name, city from nikovits.parentof) loop
        select count(*) into cnt
        from nikovits.parentof
        where city = rec.city
        start with name = rec.name
        connect by prior parent = name;
        
        if cnt>2 then
            DBMS_OUTPUT.PUT_LINE(rec.name||'-'||rec.city);
        end if;
            
    end loop;
END;
/
set serveroutput on
execute ancestor2();
/*
CREATE OR REPLACE PROCEDURE ancestor2 IS
BEGIN
    For rec in (select name, city from nikovits.parentof) loop
        for rec_path in (
            select name, sys_connect_by_path(city, '-') as path
            from nikovits.parentof
            start with name = rec.name
            connect by prior parent = name
        ) loop
            if instr(rec_path.path, rec.city, 1, 3) > 0 then
                DBMS_OUTPUT.PUT_LINE(rec.name || ' ' || rec_path.path);
            end if;
            
        end loop;
    end loop;
END;
set serveroutput on
execute ancestor2();
*/

/*
Write a procedure which prints out (based on table NIKOVITS.FLIGHT) the nodes (cities)
of the directed cycles, which start and end with the parameter city.
Example output: Dallas-Chicago-Denver-Dallas
*/
CREATE OR REPLACE PROCEDURE find_cycle(p_node VARCHAR2) IS

BEGIN
    for rec_path in (
    select SYS_CONNECT_BY_PATH(orig, '-') || '-'||dest as path
    from nikovits.flight
    where connect_by_root orig = dest
    start with orig = p_node
    connect by nocycle prior dest = orig
    ) loop
        DBMS_OUTPUT.PUT_LINE(rec_path.path);
    end loop;
END;
/
set serveroutput on
execute find_cycle('Denver');
execute find_cycle('Dallas');
select * from nikovits.flight;


/* DATALOG-like
Take the relation FLIGHT and give a recursive query for the following:
Give all the possible routes from Orig city to Dest city with the total cost of the route.
  FLIGHT(airline VARCHAR2(10), orig VARCHAR2(15), dest VARCHAR2(15), cost NUMBER);
Help:
Use a temporal relation Reaches(x,y,c,r) which gives the pair of cities (x,y) for which
it is possible to get from city x to city y by taking one or more flights, and c is the total
cost of that flight, r is the route (concatenated string).
First specify the Datalog rules for Reaches(orig,dest,cost,route) then rewrite it into an SQL recursive query,
then write a procedure where p_orig and p_dest are parameters.
*/
--- Reaches(x,y,c,r) <-Reaches (x,z,c1,r1) and flight(z,y,c2) and c=c1+c2 and r=r1||y

WITH  reaches(orig, dest, cost, route) AS 
 (
  SELECT orig, dest, cost, orig||dest FROM flight
   UNION ALL
  SELECT reaches.orig, flight.dest, flight.cost+reaches.cost, reaches.route||flight.dest FROM flight, reaches
  WHERE reaches.dest = flight.orig AND reaches.orig <> flight.dest
  )
  CYCLE orig, dest SET cycle_yes TO 'Y' DEFAULT 'N' 
SELECT  distinct orig, dest, cost, route FROM reaches 
WHERE orig='San Francisco' AND dest='New York';
