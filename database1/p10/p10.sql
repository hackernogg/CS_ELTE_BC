/* SELECT ... INTO ...
Write a function which returns the average salary within a salary category (parameter).
*/
CREATE OR REPLACE FUNCTION cat_avg(p_category integer) RETURN number IS
    avg_sal Number;
BEGIN 
    Select avg(sal)
    into avg_sal
    from nikovits.emp , nikovits.sal_cat
    where sal between lowest_sal and highest_sal
    and category=p_category;
    return avg_sal;
END;
/
SELECT cat_avg(2) FROM dual;

/* SELECT ... INTO ...
Write a procedure which prints out the number of employees and average salary of the employees 
whose hiredate was the day which is the parameter of the procedure (e.g. 'Monday'). 
*/
CREATE OR REPLACE PROCEDURE day_avg(d varchar2) IS
    num_emps integer;
    avg_sal number;
BEGIN
    select count(*), avg(sal)
    into num_emps, avg_sal
    from nikovits.emp
    where d = trim(to_char(hiredate, 'Day'));
    DBMS_OUTPUT.PUT_LINE (num_emps || ' ' || avg_sal);
END;
/
set serveroutput on
call day_avg('Thursday');  /* output example: Number of emps: 4, Average sal: 2481.25 */


/* Insert, Delete, Update
Write a procedure which increases the salary of employees who has salary category p (p is parameter).
The increment should be the minimal salary of the employee's own department.
After executing the update statement, the procedure should print out the new average salary rounded to 2 decimals.
At the very end the procedure should execute a ROLLBACK stetement, so you can run it several times
on the original data.
*/
CREATE OR REPLACE PROCEDURE upd_cat(p integer) IS
avg_sal Number;
BEGIN
    Update emp2 emp_outer
    Set sal = sal + (select min(sal) from emp2 where deptno=emp_outer.deptno)
    Where empno In ( 
    Select empno from emp2 join nikovits.sal_cat on sal between lowest_sal and highest_sal
    where category=p 
    );
    select round(avg(sal),2)
    into avg_sal
    from emp2;
    DBMS_OUTPUT.PUT_LINE(avg_sal) ;
    Rollback;
END;
/
set serveroutput on
execute upd_cat(2);

/* Cursor (SELECT resulting several tuples)
Write a procedure which takes the employees working on the parameter department
in alphabetical order, and prints out the jobs of the employees in a concatenated string.
*/
CREATE OR REPLACE PROCEDURE print_jobs(d_name varchar2) IS
    Cursor emp_cursor Is
        select job from nikovits.emp natural join nikovits.dept
        where dname=d_name order by ename;
    jobs varchar2(500) := ''; 
BEGIN
    For rec_emp In emp_cursor loop
    jobs := jobs || '-' || rec_emp.job;
    end loop;
    jobs := trim(leading '-' from jobs);
    DBMS_OUTPUT.PUT_LINE(jobs) ;
END;
/
set serveroutput on
call print_jobs('ACCOUNTING');  /* output example: MANAGER-PRESIDENT-CLERK */


/* Cursor
Write a function which takes the employees working on the parameter department
in alphabetical order, and returns in a concatenated string the jobs of the employees.
*/
CREATE OR REPLACE FUNCTION get_jobs(d_name varchar2) RETURN VARCHAR2 IS
    Cursor emp_cursor Is
        select job from nikovits.emp natural join nikovits.dept
        where dname=d_name order by ename;
    jobs varchar2(500) := ''; 
BEGIN
    For rec_emp In emp_cursor loop
    jobs := jobs || '-' || rec_emp.job;
    end loop;
    jobs := trim(leading '-' from jobs);
    return jobs;
END;
/
SELECT get_jobs('ACCOUNTING') FROM dual;  /* output example: MANAGER-PRESIDENT-CLERK */

/* Associative array --> TABLE OF ... INDEX BY
Write a procedure which takes the first n (n is the parameter) prime numbers and puts them into 
an associative array. The procedure should print out the last prime and the total sum of the prime numbers.
*/

CREATE OR REPLACE PROCEDURE primes(n integer) IS
    Type arr_type Is table of integer index by binary_integer; 
    prime_arr arr_type; 
    num integer := 1; 
    i integer := 0; 
    total integer := 0; 
BEGIN 
    while i < n loop 
        if prim(num) = 1 then 
            prime_arr(i+1) := num; 
            i:=i+1; 
        end if; 
        num := num + 1; 
    end loop;
    for k in prime_arr.first..prime_arr.last loop
        total:=total + prime_arr(k);
    end loop;
    DBMS_OUTPUT.PUT_LINE(prime_arr(prime_arr.last)||'-'||total);
end;
/
set serveroutput on
execute primes(100);

select prim(4) from dual;

/* Cursor and associative array
Write a plsql procedure which takes the employees in alphabetical order
and puts every second employee's name (1st, 3rd, 5th etc.) and salary into an associative array.
The program should print out the penultimate values (the one before the last) from the array.
*/
CREATE OR REPLACE PROCEDURE curs_array IS
    cursor emp_cursor is
        select ename, sal from nikovits.emp order by ename;
    type emp_rec_type is table of emp_cursor%rowtype index by binary_integer;
    emp_arr emp_rec_type;
    i integer:= 1;
BEGIN
    for row_rec in emp_cursor loop
        if mod(i,2)=1 then
            emp_arr(ceil(i/2)) := row_rec;
        end if;
        i := i+1;
    end loop;
    DBMS_OUTPUT.PUT_LINE(emp_arr(emp_arr.last-1).ename || '-' ||emp_arr(emp_arr.last-1).sal);
END;
/
set serveroutput on
execute curs_array();


