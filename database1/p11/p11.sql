/*  A more complicated update
Write a procedure which updates the salaries of some employees in the following way:
Take the employee on each department whose hiredate was the oldest. Increase the 
salary of these employees by n*100 where n is the number of other employees on that department
(besides the firstly hired employee).
After executing the updates, the procedure should print out the new average salary rounded to 2 decimals.
At the very end the procedure should execute a ROLLBACK stetement, so you can run it several times
on the original data.
*/
CREATE OR REPLACE PROCEDURE sal_mod IS 
    avg_sal number;
BEGIN
    update emp2 outer
    set sal = sal + 100*(select count(*)-1 from emp2 where deptno=outer.deptno)
    where (deptno, hiredate) in (
        select deptno, min(hiredate) as hiredate from emp2
        group by deptno
    );
    
    select round(avg(sal),2) into avg_sal from emp2;
    DBMS_OUTPUT.PUT_LINE(avg_sal);
    
    rollback;
END;
/
set serveroutput on
execute sal_mod();

/* Update with a cursor
Write a procedure which updates the salaries on a department (parameter: department number).
The update should increase the salary with n*10000, where n is the number of vowels (A,E,I,O,U)
in the name of the employee. (For ALLEN it is 2, for KING it is 1.)
The procedure should print out the name and new salary of the modified employees.
At the very end the procedure should execute a ROLLBACK stetement, so you can run it several times
on the original data.
*/
CREATE OR REPLACE PROCEDURE curs_upd(p_deptno INTEGER) IS 
    cursor upd_cursor is
        select ename, sal from emp2 where deptno=p_deptno
    for update;
    nr_vowels integer;
BEGIN
    for rec_row in upd_cursor loop
        nr_vowels :=0;
        for i in 1..length(rec_row.ename) loop
            if substr(rec_row.ename,i,1) in ('A','E','I','O','U') then
                nr_vowels := nr_vowels +1;
            end if;
        end loop;
        
        update emp2
        set sal = sal + nr_vowels*10000
        where current of upd_cursor;
        DBMS_OUTPUT.PUT_LINE(rec_row.ename||'-'||to_char(rec_row.sal+nr_vowels+10000));
    end loop;
    rollback;
END;
/
set serveroutput on
execute curs_upd(10);

/* (exception)
Write a function which gets a date parameter in one of the following formats: 
'yyyy.mm.dd' or 'dd.mm.yyyy'. The function should return the name of the 
day, e.g. 'Tuesday'. If the parameter doesn't match any format, the function
should return 'wrong format'.
*/
CREATE OR REPLACE FUNCTION day_name(d varchar2) RETURN varchar2 IS
BEGIN
    return to_char(to_date(d,'yyyy.mm.dd'),'DAY');
EXCEPTION
    when others then
        begin
            return to_char(to_date(d,'dd.mm.yyyy'),'DAY');
        EXCEPTION
            when others then
                return 'wrong format';
        end;
        
END;
/
SELECT day_name('02.05.2017') from dual;
SELECT day_name('2017.05.01'), day_name('02.05.2017'), day_name('abc') FROM dual;


/* (exception, SQLCODE)
Write a procedure which gets a number parameter and prints out the reciprocal,
the sqare root and the factorial of the parameter in different lines. 
If any of these outputs is not defined or causes an overflow, the procedure should 
print out 'not defined' or the error code (SQLCODE) for this part.
(The factorial is defined only for nonnegative integers.)
*/
CREATE OR REPLACE PROCEDURE numbers(n number) IS
    exc_zero exception;
    exc_negative exception;
BEGIN
    if n = 0 then
        raise exc_zero;
    elsif n <0 then
        raise exc_negative;
    end if;
    DBMS_OUTPUT.PUT_LINE(1/n);
    DBMS_OUTPUT.PUT_LINE(sqrt(n));
    DBMS_OUTPUT.PUT_LINE(factor(n));
Exception
    when exc_zero then
        DBMS_OUTPUT.PUT_LINE('The parameter number is zero.');
    when exc_negative then
        DBMS_OUTPUT.PUT_LINE('The parameter number is negative.');
END;
/
set serveroutput on
execute numbers(0);
execute numbers(-2);
execute numbers(10);

/* (exception)
Write a function which returns the sum of the numbers in its string parameter.
The numbers are separated with a '+'. If any expression between the '+' characters
is not a number, the function should consider this expression as 0.
*/
CREATE OR REPLACE FUNCTION sum_of2(p_char VARCHAR2) RETURN number IS
    s Integer := 0; 
    num integer; 
    p1 integer := 1;
    p2 integer; 
BEGIN 
    While instr(p_char, '+', p1, 1) > 0 loop 
        p2 := instr(p_char, '+', p1, 1); 
        begin
            num := to_number (trim(substr(p_char, p1, p2-p1)));
        exception
            when others then
                return 0;
        end;
        s := s + num; 
        p1:=p2+1;
    end loop;
    
    begin
        num := to_number(trim(substr(p_char, p1)));
    exception
        when others then
            return 0;
    end;
    s:= s + num ;
    return s; 
END; 
/
SELECT sum_of2('1+21 + bubu + y1 + 2 + -1 ++') FROM dual;
SELECT sum_of2('1 + 2 + 3 + 4') FROM dual;



