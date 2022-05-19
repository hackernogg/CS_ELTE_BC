/*
1.	Ordinary PL/SQL program  + Associative array/Record:
Write the following program. Take the first n (n>=1) non-prime numbers (num>=4). 
Put the number and its greatest non-trivial divisor into a record object, 
and collect these records into an associative array (table). 
Example: n=5 -> [{4, 2}, {6, 3}, {8, 4}, {9, 3}, {10, 5}]). Print out the last element of the array.
*/
CREATE OR REPLACE FUNCTION greatest_non_trivial_div(n integer) RETURN number IS
    ans number := n-1;
BEGIN
    while ans > 0 loop
        if(gcd(n,ans))=ans then
            return ans;
        else
            ans := ans-1;
        end if;
    end loop;
END;
/
select greatest_non_trivial_div(10) from dual;

CREATE OR REPLACE PROCEDURE num_highdiv(n integer) IS
    type non_prime_rec is record(
        n1 integer,
        n2 integer
    );
    Type arr_type is table of non_prime_rec index by binary_integer;
    non_prime_arr arr_type;
    i integer := 0;
    non_prime integer := 4;
    
BEGIN
    while i < n loop
        if prim(non_prime)=0 then
        non_prime_arr(i+1).n1:= non_prime;
        non_prime_arr(i+1).n2:= greatest_non_trivial_div(non_prime);
        i:=i+1;
        non_prime := non_prime+1;
        else
            non_prime := non_prime+1;
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE(non_prime_arr(non_prime_arr.last).n1||'-'||non_prime_arr(non_prime_arr.last).n2);
END;
/
set serveroutput on
execute num_highdiv(5);


/*
2.	Cursors/Select Into
Write a PL/SQL function which returns the sum of salaries of an employee¡¯s direct subordinates. 
Return 0 if there are no subordinates.
*/
CREATE OR REPLACE FUNCTION subord_sum(p_empno integer) RETURN INTEGER IS
    Cursor emp_cursor is
        select emp1.ename,emp2.sal from emp2 emp1
        join emp2 on emp1.EMPNO = emp2.MGR;
    p_ename varchar2(500);
    ans_sum integer:=0;
BEGIN
    select ename into p_ename from emp2 where emp2.empno = p_empno;
    for emp_info in emp_cursor loop
        if emp_info.ename = p_ename then
            ans_sum:=ans_sum + emp_info.sal;
        end if;
    end loop;
    return ans_sum;
    
END;
/
select subord_sum(7369) from dual;
select subord_sum(7566) from dual;
/*
3.	DML in PL/SQL (where current of):
Write a PL/SQL program that updates the salaries of each employee. 
The increment is n*100, where n is equal to the sum of digits in the salary of the employee. 
Ex: 1550 -> n = 11. Print out the new salary for each row.
*/
CREATE OR REPLACE PROCEDURE upd_sal IS
    cursor upd_emp_cursor is
        select ename,sal from emp2 for update;
    test_avg number;
BEGIN
    for emp_info in upd_emp_cursor loop
        update emp2
        set sal = sal + (length(to_char(sal)))*100
        where current of upd_emp_cursor;
    end loop;
    select avg(sal) into test_avg from emp2;
    DBMS_OUTPUT.PUT_LINE(test_avg);
    rollback;
END;
/
set serveroutput on
execute upd_sal();

--select length(to_char(111)) from dual;
--select avg(sal) from emp2;

/*
4.	Cursor/Select Into + Exception Handling:
Write a PL/SQL function that queries the name and salary of an employee with the specified empno. 
Use exception handling for the case when the empno is invalid. Return ¡¯wrong empno¡¯ in such cases.
*/
CREATE OR REPLACE FUNCTION get_emp_info(p_empno integer) RETURN VARCHAR IS
    emp_info varchar2(500);
    emp_name varchar2(500);
    emp_sal integer;
BEGIN
    select ename,sal into emp_name,emp_sal from emp2 where emp2.empno = p_empno;
    emp_info := concat(emp_name,to_char(emp_sal));
    return emp_info;
EXCEPTION
    when others then
        return 'wrong empno';
END;
/
select get_emp_info(7566) from dual;
select get_emp_info(9999) from dual;

/*
5.	SQL recursion

Write a PL/SQL program that receives two cities (city A, city B) as parameters. 
The program returns the shortest distance between the 2 cities. 
The distance is measured as the number of direct flights you have to take to reach city B from city A. 
Use a hierarchical query on the paltamas.flight table.

*/
select * from paltamas.flight;
CREATE OR REPLACE FUNCTION find_dist(A VARCHAR2, B VARCHAR2) return integer IS
    dist integer := 999;
    temp integer;
BEGIN
    for rec_path in (
    select SYS_CONNECT_BY_PATH(orig, '-') ||'-'|| dest as path
    from paltamas.flight
    where dest = B
    start with orig = A
    connect by nocycle prior dest = orig
    ) loop
        temp:=(length(rec_path.path)-length(replace(rec_path.path,'-','')));
        if temp <= dist then
            dist :=temp;
        end if;
    end loop;
    return dist-1;
END;
/

select find_dist('Denver','Dallas') from dual;
select find_dist('San Francisco','Denver') from dual;---1
select find_dist('San Francisco','New York') from dual;---2




