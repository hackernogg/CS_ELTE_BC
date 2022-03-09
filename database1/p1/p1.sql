SELECT * FROM nikovits.emp;
SELECT distinct job FROM nikovits.emp;
select * from nikovits.dept;
select * from NIKOVITS.sal_cat;
select category, lowest_sal from NIKOVITS.sal_cat;

select last_name, salary , salary + 300 
from nikovits.employees;

select last_name, salary , 12*salary + 300 
from nikovits.employees;

select last_name "NAME", salary*12 "Annual Salary"
from nikovits.employees;

select last_name,job_id from nikovits.employees;
select last_name||job_id AS "employees" from nikovits.employees;
select last_name|| ' is a ' ||job_id AS "employees" from nikovits.employees;

select employee_id, last_name, job_id, department_id 
from nikovits.employees
where department_id = 90;

select employee_id, last_name, job_id, department_id 
from nikovits.employees
where last_name = 'King';

select employee_id, last_name, job_id, department_id 
from nikovits.employees
where last_name <> 'King';

select employee_id, last_name, job_id, department_id 
from nikovits.employees
where department_id between 50 and 90;

select employee_id, last_name, job_id, department_id 
from nikovits.employees
where department_id IN (90,30,40);

select first_name
from nikovits.employees
where first_name like 'S%';

select first_name
from nikovits.employees
where first_name like '_o%';

select employee_id, last_name, job_id, salary
from nikovits.employees
where salary>=10000
and job_id like '%MAN%';

select employee_id, last_name, job_id, salary
from nikovits.employees
where salary>=10000
or job_id like '%MAN%';

select employee_id, last_name, job_id, salary
from nikovits.employees
where salary>=10000
and job_id not like '%MAN%';


select last_name, job_id, salary
from nikovits.employees
where job_id = 'SA_REP'
or job_id = 'AD_PRES'
and salary > 15000;

select last_name, job_id, salary
from nikovits.employees
where (job_id = 'SA_REP'
or job_id = 'AD_PRES')
and salary > 15000;

select last_name, job_id, department_id, hire_date
from nikovits.employees
ORDER BY hire_date;

select last_name, job_id, department_id, hire_date
from nikovits.employees
ORDER BY hire_date desc;

select last_name, job_id, department_id, salary*12 annsal
from nikovits.employees
ORDER BY annsal;

select last_name, job_id, department_id, employee_id
from nikovits.employees
where employee_id = &employee_num;

/* class work---------------------------------*/
--1
select *
from nikovits.emp;


select *
from nikovits.emp
where sal > 2800;
--2
select *
from nikovits.emp
where Deptno in (10,20);
--3
select *
from nikovits.emp
where COMM >600;
--4
select *
from nikovits.emp
where COMM <= 600;

select *
from nikovits.emp
where not COMM > 600;
--5
select *
from nikovits.emp
where COMM is null;
--6
select job
from nikovits.emp;

select distinct job
from nikovits.emp;
--7
select ename,sal*2
from nikovits.emp
where deptno = 10;
--8
select *
from nikovits.emp
where HIREDATE > '1982.01.01';
--9
select *
from nikovits.emp
where mgr is null;
--10
select *
from nikovits.emp
where ename like '%A%';
--11
select *
from nikovits.emp
where ename like '%L%L%';
--12
select *
from nikovits.emp
where sal between 2000 and 3000;
--13
select ename, sal
from nikovits.emp
order by sal;
--14
select ename, sal
from nikovits.emp
order by  sal desc,ename;
--15
select * from nikovits.emp
where mgr='7839';
