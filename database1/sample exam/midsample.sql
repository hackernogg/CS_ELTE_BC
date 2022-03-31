--1 s1mple sql
--1a
select * 
from nikovits.emp
where sal between 1000 and 2500;
--1b
select *
from nikovits.emp
where hiredate < '81.06.09';
--1c
select *
from nikovits.emp
where job like '%E%';

--2
select job
from nikovits.emp
where deptno = 20
INTERSECT
select job
from nikovits.emp
where deptno = 30;
--3
--3a
select e1.ename
from nikovits.emp e1, nikovits.emp e2
where e2.mgr = e1.empno and e2.job = 'CLERK';
--3b
select distinct e1.ename
from nikovits.emp e1, nikovits.emp e2, nikovits.dept d1
where e2.mgr = e1.empno and e2.deptno = d1.deptno and d1.deptno = 20;
--4 p3
--4a
select substr(job,1,3) 
from nikovits.emp;
--4b
select *
from nikovits.emp;
select trunc(sal/1000), round(sal/1000,1),mod( sal, 1000 )
from nikovits.emp;
--5
select job,avg(sal)
from nikovits.emp
group by job
having count(*)>1;
--6
--6a
/*
in Relax
select deptno, max(sal) as max_sal, count(*) as numIndeptno
from Emp
group by deptno
having numIndeptno >= 4 
*/
select deptno, max(sal)
from nikovits.emp
group by deptno
having count(*)>=4 ;

--7a
select *
from nikovits.dept;

delete from dept2
where deptno in
(select deptno
from emp2
join nikovits.sal_cat on sal between lowest_sal and highest_sal
where category = 2
group by deptno
having count(*)>=2);

rollback;




