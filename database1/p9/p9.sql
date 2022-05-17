/* Write a function which decides if the parameter number is prime or not. 
   In case of yes/no the function returns 1/0.
*/
CREATE OR REPLACE FUNCTION prim(n integer) RETURN number IS
    n_sqrt NUMBER;
    res Number :=1;
BEGIN
    n_sqrt := trunc(sqrt(n));
    For i in 2..n_sqrt loop
        if mod(n,i) = 0 then
            res:=0;
        end if;
    end loop;
    Return res;
END;
/
select prim(4) from dual;

/* Write a procedure which prints out the n-th Fibonacchi number. 
   fib1 = 0, fib2 = 1, fib3 = 1, fib4 = 2 ... etc.
*/
CREATE OR REPLACE PROCEDURE fib(n integer) IS
    n1 number :=0;
    n2 number :=1;
    n_next number;
BEGIN
    For i in 1..n loop
        n_next := n1+n2;
        n1:=n2;
        n2:=n_next;
    end loop;
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(n_next));
END;
/
set serveroutput on
execute fib(10);

/* Write a function which returns the greatest common divisor of two integers */
CREATE OR REPLACE FUNCTION gcd(p1 integer, p2 integer) RETURN number IS
    a Number := p1;
    b Number := p2; 
BEGIN 
    While a <> b loop 
        if a > b then
            a:=a-b; 
        else 
            b :=b - a; 
        end if; 
    end loop; 
    Return a; 
END;
/
SELECT gcd(3570,7293) FROM dual;

/* Write a function which returns the number of times the first string parameter contains 
   the second string parameter. 
*/
CREATE OR REPLACE FUNCTION num_times(p1 VARCHAR2, p2 VARCHAR2) RETURN integer IS
    counter integer := 0; 
BEGIN
    While Instr(p1, p2, 1, counter+1) > 0 loop 
        counter := counter + 1; 
    end loop;
    return counter; 
END;
/
SELECT num_times ('ab c ab ab de ab fg', 'ab') FROM dual;

/* Write a function which returns n factorial. */
CREATE OR REPLACE FUNCTION factor(n integer) RETURN integer IS
BEGIN
    If n = 0 then
        return 1;
    else
        Return n*factor(n-1);
    end if;
END;
/
SELECT factor(10) FROM dual;

/* Write a function which returns the sum of the numbers in its string parameter.
   The numbers are separated with a '+'.
*/
CREATE OR REPLACE FUNCTION sum_of(p_char VARCHAR2) RETURN number IS
    s Integer := 0; 
    num integer; 
    p1 integer := 1;
    p2 integer; 
BEGIN 
    While instr(p_char, '+', p1, 1) > 0 loop 
        p2 := instr(p_char, '+', p1, 1); 
        num := to_number (trim(substr(p_char, p1, p2-p1)));
        s := s + num; 
        p1:=p2+1;
    end loop;
    num := to_number (trim(substr(p_char, p1)));
    s := s + num;
    return s; 
END; 
/
SELECT sum_of('1 + 4 + 13 + 0') FROM dual;

