--16 last hw
select job, count(*) as num_emps, avg(sal) as avg_sal, rpad('#', avg(sal)/200, '#')
from nikovits.emp 
group by job;
----
select last_name
from nikovits.employees
where salary > 
                (select salary
                from nikovits.employees
                where last_name = 'Abel');
--1
select deptno, dname, loc
from nikovits.dept
where deptno in 
                (select distinct deptno 
                from nikovits.emp join nikovits.sal_cat
                on lowest_sal <= sal and sal<= highest_sal
                where category = 1);

--2nd way for q1
select deptno, dname, loc
from nikovits.dept
natural join
(select distinct deptno 
 from nikovits.emp join nikovits.sal_cat
 on lowest_sal <= sal and sal<= highest_sal
 where category = 1);
 --2
 select deptno, dname, loc from nikovits.Dept
 minus
 select deptno, dname, loc from nikovits.Dept
 natural join
 (select distinct deptno from nikovits.emp join
 nikovits.sal_cat on lowest_sal <= sal and sal <= highest_sal
 where category = 1);
 --3
 select deptno, dname, loc
from nikovits.dept
natural join
(select distinct deptno 
 from nikovits.emp join nikovits.sal_cat
 on lowest_sal <= sal and sal<= highest_sal
 where category = 1
 group by deptno
 having count(*)>=2);
 
 --4
 select emp.deptno, sal, ename
 from nikovits.emp
    join
    ( select deptno, max(sal) as max_sal
 from nikovits.emp
 group by deptno)  tmp
    on emp.deptno=emp.deptno and emp.sal = tmp.max_sal
order by emp.deptno;
--5
select job, dname
from nikovits.emp
natural join
nikovits.dept
where job in (select job 
from nikovits.emp
group by job
having count(distinct deptno)=1);

select job, dname
from nikovits.emp
natural join
nikovits.dept
natural join
(select job 
from nikovits.emp
group by job
having count(distinct deptno)=1);
--6
select name from nikovits.likes
group by name
having count(*) = (select count(distinct fruits) from nikovits.likes);

select name from
(select name , count(*) from nikovits.likes
group by name)
natural join
(select count(distinct fruits) as nr_fruits from nikovits.likes);

--7
select sal, category from nikovits.sal_cat
    join
    (select min(e2.sal)as min_sal from nikovits.emp e1 join nikovits.emp e2 on e1.mgr=e2.empno)
    on lowest_sal <= min_sal and min_sal <= highest_sal;
    




 
                