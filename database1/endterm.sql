/*
1.	Ordinary PL/SQL program  + Associative array/Record:

Write the following program. The input is a text field, containing multiple sentences. 
The program should extract the number of words in each sentence, and put them into an associative array.
Print out the number of sentences and the total number of words in the text. Ex: ?I code. I eat. I sleep.” -> array: [2, 2, 2] -> output: {3, 6}.

*/

/*
2.	Cursors

Write a PL/SQL program that queries the department location, average salary and the number of people on each department. 
Print out these values for each department. Round the number values to 2 decimals.

*/
CREATE OR REPLACE PROCEDURE cur_salcat IS
    cursor dept_cursor is
        Select deptno, round(avg(sal), 2)  as avg_sal ,count(*) as num_emp
        From nikovits.emp
        Group by deptno;
BEGIN
    for each_info in dept_cursor loop
        DBMS_OUTPUT.PUT_LINE('deptno: '||each_info.deptno||' avg sal: '||each_info.avg_sal||' num people:'|| each_info.num_emp);
    end loop;
END;
/
set serveroutput on
execute cur_salcat();

/*
3.	DML in PL/SQL

Create a procedure that increments the salary of the people on the department with the longest department location (i.e. longest string).
The increment should be the average salary in the current person’s salary category.
*/
CREATE OR REPLACE PROCEDURE upd_longest_dept IS
    cursor upd_emp_cursor is
        Select ename,sal,deptno
        From emp2 for update;---natural join nikovits.dept
        ---where length(LOC)= (SELECT max(length(loc)) FROM nikovits.dept) for update;
    cat integer;
    deptno_long integer;
    avg_sal number;
    test_avg number;
BEGIN
    for emp_info in upd_emp_cursor loop
        select category into cat from emp2 join nikovits.sal_cat on sal between lowest_sal and highest_sal
        where ename = emp_info.ename;
        select avg(sal) into avg_sal from emp2 join nikovits.sal_cat on sal between lowest_sal and highest_sal
        where category=cat;
        select deptno into deptno_long from NIKOVITS.dept where length(LOC)= (SELECT max(length(loc)) FROM nikovits.dept);
        if emp_info.deptno = deptno_long then
                    update emp2
                    set sal = sal + avg_sal
                    where current of upd_emp_cursor;
        end if;
    end loop;
    select avg(sal) into test_avg from emp2;
    DBMS_OUTPUT.PUT_LINE(test_avg);
    rollback;
END;
/
set serveroutput on
execute upd_longest_dept();

/*
4.	DML in PL/SQL (WHERE CURRENT OF):
Write a PL/SQL program that updates the commission of each employee. The increment is n*20, 
where n is equal to the product of digits in the salary of the employee (omit the zeros from the product). 
Ex: 1550 -> n = 25. Print out the new commission for each row.
*/
CREATE OR REPLACE function get_product(a varchar2) return number is
    pro number := 1;
BEGIN
    for i in 1..length(a) loop
        if TO_NUMBER(SUBSTR(a, i, 1)) = 0 then
            pro:= pro *1;
        else
            pro :=  pro * TO_NUMBER(SUBSTR(a, i, 1));
        end if;
    end loop;
    return pro;
END;
/
select get_product('120') from dual;

CREATE OR REPLACE PROCEDURE upd_comm IS
    cursor upd_emp_cursor is
        select ename,sal,comm from emp2 for update;
    test_avg number;
BEGIN
    for emp_info in upd_emp_cursor loop
        update emp2
        set comm = comm + get_product(to_char(sal))*20
        where current of upd_emp_cursor;
        DBMS_OUTPUT.PUT_LINE(emp_info.comm);
    end loop;
    select avg(comm) into test_avg from emp2;
    rollback;
END;
/
set serveroutput on
execute upd_comm();

/*
5.	Cursor/Select Into + Exception Handling:
Write a PL/SQL function that queries the upper salary limit of a specific salary category. 
Use exception handling for the invalid salary category values (print out a custom error message,
eg. ’Invalid salary category’). 
*/
CREATE OR REPLACE FUNCTION get_sal_limits(p_cat INTEGER) RETURN VARCHAR IS
    higest integer;
BEGIN
    select highest_sal into higest from nikovits.sal_cat
    where category = p_cat;
    return to_char(higest);
EXCEPTION
    when others then
        return 'Invalid salary category';
END;
/
select get_sal_limits(4) from dual;


/*
6.	SQL Hierarchical Query

Write a PL/SQL procedure, which prints out all the grandchildren of the parameter person. 
Only hierarchical query-based solutions are acceptable. Use the nikovits.PARENTOF table.

*/
CREATE OR REPLACE PROCEDURE find_grandchildren(p_grandp VARCHAR2) 	IS
    rel_len integer;
BEGIN
    for rec_path in (
    select SYS_CONNECT_BY_PATH(name, '-') as path
    from nikovits.PARENTOF
    ---where connect_by_root orig = dest
    start with name = p_grandp
    connect by nocycle prior name = parent
    ) loop
    rel_len := (length(rec_path.path)-length(replace(rec_path.path,'-','')));
    if rel_len=3 then
    DBMS_OUTPUT.PUT_LINE(rec_path.path);
    DBMS_OUTPUT.PUT_LINE(regexp_substr(rec_path.path, '[^-]+', 1, 3));
    
    end if;
    end loop;
END;
/
set serveroutput on
execute find_grandchildren('ADAM');
