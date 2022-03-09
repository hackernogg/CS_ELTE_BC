select employee_id , job_id
from nikovits.employees
union
select employee_id, job_id
from nikovits.job_history
order by employee_id;


select employee_id , job_id
from nikovits.employees
intersect
select employee_id, job_id
from nikovits.job_history
order by employee_id;

select employee_id , job_id
from nikovits.employees
MINUS
select employee_id, job_id
from nikovits.job_history
order by employee_id;
/* class work*/
select * from nikovits.likes;
--1
select fruits 
from nikovits.likes
where name = 'Winnie';
--2
select distinct fruits 
from nikovits.likes
where name != 'Winnie';
--3
select name 
from nikovits.likes
where fruits = 'apple';
--4
select name 
from nikovits.likes
minus
select name 
from nikovits.likes where fruits = 'pear';
--5
select distinct name
from nikovits.likes where fruits in ('raspberry','pear');

select name from nikovits.likes where fruits = 'raspberry'
union
select name from nikovits.likes where fruits = 'pear';
--6
select name from nikovits.likes where fruits = 'apple'
intersect
select name from nikovits.likes where fruits = 'pear';
--7
select name from nikovits.likes where fruits = 'apple'
minus
select name from nikovits.likes where fruits = 'pear';

/* join action (more than one table)*/
select * from nikovits.emp;
select * from nikovits.dept;
select * from nikovits.emp natural join nikovits.dept;
select * from nikovits.emp join nikovits.dept using (deptno);
select e.ename, d.dname from nikovits.emp e join nikovits.dept d using (deptno);
select * from nikovits.emp e join nikovits.dept d on e.deptno = d.deptno;

select e1.ename,e2.ename from nikovits.emp e1 join nikovits.emp e2 on e1.mgr=e2.empno
where e2.ename='KING';
select e1.ename,e2.ename from nikovits.emp e1 join nikovits.emp e2 on e1.sal>e2.sal;

select e.last_name, e.department_id, d.department_name
from nikovits.employees e LEFT OUTER JOIN nikovits.departments d on (e.department_id = d.department_id); 

select last_name, department_name
from nikovits.employees
cross join nikovits.departments;
--8
select distinct l1.NAME from nikovits.likes l1 join nikovits.likes l2 on l1.name=l2.name and l1.fruits != l2.fruits;
--9
select distinct l1.NAME from nikovits.likes l1 join nikovits.likes l2 on l1.name=l2.name and l1.fruits != l2.fruits
join nikovits.likes l3 on l3.name=l1.name and l3.name = l2.name and l3.fruits != l1.fruits and l3.fruits != l2.fruits;

select distinct l1.NAME from nikovits.likes l1 cross join nikovits.likes l2 cross join nikovits.likes l3
where  l1.name=l2.name and l1.fruits != l2.fruits
and l3.name=l1.name and l3.name = l2.name and l3.fruits != l1.fruits and l3.fruits != l2.fruits;

--10
select name from nikovits.likes
minus
select distinct l1.NAME from nikovits.likes l1 cross join nikovits.likes l2 cross join nikovits.likes l3
where  l1.name=l2.name and l1.fruits != l2.fruits
and l3.name=l1.name and l3.name = l2.name and l3.fruits != l1.fruits and l3.fruits != l2.fruits;
--11
select distinct l1.NAME from nikovits.likes l1 join nikovits.likes l2 on l1.name=l2.name and l1.fruits != l2.fruits
intersect
(select name from nikovits.likes
minus
select distinct l1.NAME from nikovits.likes l1 cross join nikovits.likes l2 cross join nikovits.likes l3
where  l1.name=l2.name and l1.fruits != l2.fruits
and l3.name=l1.name and l3.name = l2.name and l3.fruits != l1.fruits and l3.fruits != l2.fruits);
--16
select e2.ename from nikovits.emp e1 inner join nikovits.emp e2 on e1.empno=e2.mgr
where e1.ename='KING';
--17
select * from nikovits.emp;
select distinct e1.ename from nikovits.emp e1 inner join nikovits.emp e2 on e1.empno=e2.mgr
where e1.job !='MANAGER';
--18
select distinct e2.ename from nikovits.emp e1 inner join nikovits.emp e2 on e1.empno=e2.mgr
where e1.sal <e2.sal;
--19
select distinct e1.ename from
nikovits.emp e1, nikovits.emp e2, nikovits.emp e3
where e1.mgr=e2.empno and e2.mgr = e3.empno and  e3.ename = 'KING';
--20
select ename from nikovits.emp natural join nikovits.dept
where loc in ('DALLAS','CHICAGO');
