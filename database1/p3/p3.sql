--22
select * from nikovits.emp natural join nikovits.dept where sal>2000 or loc='CHICAGO';
--23
select deptno from nikovits.dept
minus
select distinct deptno from nikovits.emp;
--24
select * from nikovits.emp e1 join nikovits.emp e2 
on e1.mgr=e2.empno
where e1.sal>2000;
--25
select ename from nikovits.emp
minus
select distinct e2.ename from nikovits.emp e1 join nikovits.emp e2 
on e1.mgr=e2.empno
where e1.sal>2000;
--26
select dname, loc from nikovits.emp, nikovits.dept
where nikovits.emp.deptno = nikovits.dept.deptno
and job='ANALYST';
--27
select distinct dname, loc from nikovits.dept
minus
select distinct dname, loc from nikovits.emp, nikovits.dept
where nikovits.emp.deptno = nikovits.dept.deptno
and job='ANALYST';
--28
select ename from nikovits.emp
minus
select e1.ename from nikovits.emp e1 join nikovits.emp e2
on e1.sal < e2.sal;

select ename from nikovits.emp
where sal=(select max(sal) from nikovits.emp);
/* new for today */
select LOWER('ASD')
from dual;
select sysdate from dual;
select sysdate+1/24*20 from dual;

--1
select ename, sal from nikovits.emp where mod(sal,15)=0;
--2
select ename, hiredate from nikovits.emp
where hiredate > to_date('1982.01.01');
--3
select ename from nikovits.emp
where substr(ename,2,1)='A';
--4
select ename from nikovits.emp
where instr(ename,'L',1,2)>0;
--5
select substr(ename,-3,3) from nikovits.emp;
--6
select ename from nikovits.emp where substr(ename,-2,1)='T';
--7
select ename, sal, round(sqrt(sal),2),
trunc(sqrt(sal)) from nikovits.emp;
--8
select ename, hiredate, to_char(hiredate,'MONTH')
from nikovits.emp where ename='ADAMS';
--9
select hiredate,trunc(sysdate-hiredate) from nikovits.emp
where ename='ADAMS';
--10
select ename, hiredate, to_char(hiredate,'DAY') from nikovits.emp 
where to_char(hiredate,'DAY') like 'TUESDAY%';
--11
select e1.ename, e2.ename
from nikovits.emp e1 join nikovits.emp e2 on e1.mgr=e2.empno
where length(e1.ename)=length(e2.ename);
--12
select ename,sal from nikovits.emp join nikovits.sal_cat 
on sal between lowest_sal and highest_sal
where category=1;
--13
select ename,sal from nikovits.emp join nikovits.sal_cat 
on sal between lowest_sal and highest_sal
where mod(category, 2)=0;
--14
select e1.hiredate,e2.hiredate,e1.hiredate-e2.hiredate 
from nikovits.emp e1 join nikovits.emp e2
on e1.ename = 'KING' and e2.ename='JONES';
--15
select hiredate, to_char(last_day(hiredate),'DAY') from nikovits.emp
where ename='KING';
--16
select hiredate, to_char(trunc(hiredate,'MONTH'),'DAY') from nikovits.emp
where ename='KING';
--17
select ename,dname, category 
from nikovits.emp join nikovits.sal_cat 
on sal between lowest_sal and highest_sal
natural join nikovits.dept
where dname like '%C%' and category>=4;
--18 HW
