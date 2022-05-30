/*1. SQL WITH statement (Tables needed: nikovits.emp, nikovits.sal_cat)
Give the following result for which you can use the WITH statement. Give the employees for 
whom it is true that his salary is less than the average salary of the employees falling in the same 
salary category as his salary category. In the result give the employee¡¯s name, his salary, and the 
average salary of his salary category.  (ename, sal, category_avg) 
*/
with avg_cat_table(cat,avg_sal) as
    (select category, round(avg(sal),2) from nikovits.emp 
     join nikovits.sal_cat on sal between lowest_sal and highest_sal
     group by category)
select ename, sal, avg_sal from avg_cat_table,nikovits.emp join nikovits.sal_cat on sal between lowest_sal and highest_sal
where category = avg_cat_table.cat and sal<avg_cat_table.avg_sal;

/* 2. Recursion in Datalog (Tables needed: nikovits.flight)
We have a relation FLIGHT(Airline, Orig, Dest, Cost) which contains the flights and their costs 
from a city (Orig) to another city (Dest). Write a recursive SQL query (a similar Datalog query can 
help you) which gives the destination cities that can be reached from ¡®Denver¡¯ with at most 1200 
cost. The output should contain the destination city and the cost of the whole journey.
(Dest_city, Cost).
*/
-- Reaches(x, y, c, r) <- Flight(x, y, c) AND r=x||y
-- Reaches(x, y, c, r) <- Reaches(x, z, c1, r1) AND Flight(z, y, c2) AND c=c1+c2 AND r=r1||y
WITH  reaches(orig, dest, cost, route) AS 
 (
  SELECT orig, dest, cost, orig||dest FROM nikovits.flight
   UNION ALL
  SELECT reaches.orig, flight.dest, flight.cost+reaches.cost, reaches.route||flight.dest FROM nikovits.flight, reaches
  WHERE reaches.dest = flight.orig AND reaches.orig <> flight.dest
  )
  CYCLE orig, dest SET cycle_yes TO 'Y' DEFAULT 'N' 
SELECT  distinct orig, dest, cost, route FROM reaches
WHERE orig='Denver' and cost <= 1200;

/*
3. DML (Tables needed: nikovits.emp)
Create a table EMP2 which has the same tuples as nikovits.EMP, then write an UPDATE statement
(not a pl/sql program !!!) on this table which increases the salaries of the employees for whom it is 
true that the total summarized salaries of his direct subordinates are larger than 6000 (>6000). The 
increment is the average salary of the employee's direct subordinates. After the update, give the 
result of the following query: 
SELECT avg(sal) FROM emp2; (Avg_Sal)
*/
drop table emp2;
CREATE TABLE emp2 AS SELECT * FROM nikovits.emp;
update emp2
set sal = sal + (select avg(e2.sal) from emp2 e2 where emp2.empno = e2.mgr)
where ename in (
    select e1.ename from emp2 e1, emp2 e2 
    where e1.empno = e2.mgr 
    group by e1.ename 
    having sum(e2.sal) > 6000
);
SELECT avg(sal) FROM emp2;
rollback;
/*
5. Normal Forms
*/
---https://gamgi.github.io/js-bcnf/


/*
6. E-R models and DDL
Convert the following E-R diagram to a relational database schema following the object-oriented 
approach. Give the CREATE TABLE statements with primary key and foreign key definitions.
The statements should be syntactically correct, please run them in Oracle to test it. (You can use any 
Oracle datatype for the columns. You can change the attribute names if needed, for example from 
¡°number¡± to ¡°Cnumber¡±.
*/
create table depts1(dname varchar2(500) not null, chair integer not null, PRIMARY key (dname));
create table course1(cnumber integer not null,dname varchar2(500), room integer not null,PRIMARY key(cnumber));
ALTER TABLE course1 ADD CONSTRAINT course1_dname_fk FOREIGN KEY (dname)
REFERENCES depts1 (dname) ON DELETE CASCADE;
create table lab1(cnumber integer not null,dname varchar2(500),comp_allo integer not null ,room integer not null,PRIMARY key(cnumber));
ALTER TABLE lab1 ADD CONSTRAINT lab1_dname_fk FOREIGN KEY (dname)
REFERENCES depts1 (dname) ON DELETE CASCADE;
select * from lab1;














