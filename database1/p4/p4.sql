--18 from p3
select sal, rpad('#', round(sal/1000), '#') from nikovits.emp;

select avg(salary), max(salary), min(salary), sum(salary)
from nikovits.employees
where job_id like '%REP%';

select count(*)
from nikovits.employees
where department_id = 50;

select count(distinct department_id)
from nikovits.employees;

select department_id, avg(salary)
from nikovits.employees
group by department_id;

select department_id dept_id,job_id, sum(salary)
from nikovits.employees
group by department_id,job_id;

select department_id, max(salary)
from nikovits.employees
group by department_id
having max(salary)>10000;

select job_id, sum(salary) PAYROLL
from nikovits.employees
where job_id not like '%REP%'
group by job_id
having sum(salary)>13000
order by sum(salary);

select max(avg(salary))
from nikovits.employees
group by department_id;

--1
select max(sal) as max_sal
from nikovits.emp;
--2
select sum(sal) as sum_sal
from nikovits.emp;
--3
select sum(sal), avg(sal)
from nikovits.emp
where deptno=20;
--4
select count(distinct job)
from nikovits.emp;
--5
select count(*)
from nikovits.emp
where sal>2000;
--6
select deptno,round(avg(sal),2) as avg_sal
from nikovits.emp
group by deptno
order by deptno;
--7
select deptno, loc, round(avg(sal),2) as avg_sal
from nikovits.emp natural join nikovits.dept
group by deptno, loc;
--8
select deptno,count(*) as num_emp
from nikovits.emp
group by deptno;
--9
select deptno, round(avg(sal),2) as avg_sal
from nikovits.emp
group by deptno
having avg(sal)>2000;
--10
select deptno, avg(sal)
from nikovits.emp
group by deptno
having count(*) > 4;
--11
select deptno,loc, avg(sal)
from nikovits.emp natural join nikovits.dept
group by deptno,loc
having count(*) > 4;
--12
select dname,loc,avg(sal)
from nikovits.emp natural join nikovits.dept
group by dname,loc
having avg(sal)>2000;
--13
select category 
from nikovits.sal_cat join nikovits.emp
on sal between lowest_sal and highest_sal
group by category
having count(*)=3;
--14
select category 
from nikovits.sal_cat join nikovits.emp
on sal between lowest_sal and highest_sal
group by category
having count(distinct deptno) = 1;
--15

select 
    case
        when mod(empno, 2)=0 then 'even'
        else 'odd'
        end as parity, 
        count(*) as num_of_emps
from nikovits.emp
group by mod(empno, 2)
--16
--hw

