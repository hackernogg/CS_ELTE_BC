--5b
WITH dept_avg_temp AS ( 
Select deptno, avg(sal) as dept_avg from nikovits.Emp group by deptno
),
gen_avg_temp AS ( 
Select avg(sal) as gen_avg from nikovits.Emp
)
Select dname, round(dept_avg, 2), round(gen_avg, 2), abs(round(gen_avg - dept_avg,2)) as sal_diff
from nikovits.Dept dept, dept_avg_temp, gen_avg_temp
where dept.deptno=dept_avg_temp.deptno;

-- copy table from teacher
drop table emp2;
drop table dept2;
CREATE TABLE emp2 AS SELECT * FROM nikovits.emp;
CREATE TABLE dept2 AS SELECT * FROM nikovits.dept;

--db1_exercise6_DML
--1
delete from emp2
where comm is null;
--2
delete from emp2
where hiredate < '1982.01.01';

--3
delete from emp2
where deptno in (
    select deptno from dept2 where loc='DALLAS'
);


--4
delete from emp2
where sal < (select avg(sal) from emp2);

--5
delete from emp2 outer
where sal < (select avg(sal) from emp2 where deptno= outer.deptno);

--6
delete from emp2
where sal = (select max(sal) from emp2);
--7
delete from dept2
where deptno in (
    select deptno from emp2 join nikovits.sal_cat
    on sal between lowest_sal and highest_sal
    where category =2
);
--8
delete from dept2 
where deptno in ( 
    select deptno from emp2 join nikovits.sal_cat
    on sal between lowest_sal and highest_sal
    where category=2 
    group by deptno having count (*)>=2 
) ;
--9a
INSERT INTO emp2 (empno, ename, deptno, hiredate, sal)
VALUES (1, 'Smith', 10, SYSDATE, 
    (select avg(sal) from emp2 where deptno=10)) ;
--9/b
INSERT INTO emp2 (empno, ename, deptno, hiredate, sal)
select 1, 'Smith', 10, SYSDATE,
    (select avg(sal) from emp2 where deptno=10) 
from dual;
--10
UPDATE emp2
SET sal=sal+sal*0.2
WHERE deptno=20;

--11
UPDATE emp2
SET sal=sal+500
WHERE comm is null OR sal < (select avg(sal) from emp2);

--12

UPDATE emp2
SET comm=coalesce (comm, 0)+(select max(comm) from emp2);
--13
UPDATE emp2
SET ename='Poor'
WHERE sal = (select min(sal) from emp2);
--14 
UPDATE emp2 
SET comm=coalesce (comm, 0) + 3000
where empno in ( 
    select e.empno from emp2 e join emp2 sub on e.empno = sub.mgr
    group by e.empno having count (*)>=2 
);
--15
UPDATE emp2
SET sal=sal+(select min(sal) from emp2)
WHERE empno in (
    select e.empno from emp2 e join emp2 sub on e.empno = sub.mgr
);
UPDATE emp2
SET sal=sal+(select min(sal) from emp2)
WHERE empno in (
    select mgr from emp2
);
--16
UPDATE emp2 outer
SET sal=sal+(select avg(Sal) from emp2 where deptno=outer.deptno)
WHERE empno in (
    select empno from emp2
    MINUS
    select mgr from emp2
);
rollback;
