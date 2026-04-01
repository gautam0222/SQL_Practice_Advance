create database practical5;
use practical5;

CREATE TABLE departments (
    deptno INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE emp (
    emp_no INT PRIMARY KEY,
    birth_date DATE NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    gender ENUM('M','F') NOT NULL,
    hire_date DATE NOT NULL,
    salary FLOAT DEFAULT 7850.00,
    job VARCHAR(20) NOT NULL,
    deptno INT,
    manager_id INT,
    FOREIGN KEY (deptno) REFERENCES departments(deptno)
);

INSERT INTO departments (deptno, dept_name, location) VALUES
(10, 'ACCOUNTING', 'New York'),
(20, 'RESEARCH', 'Dallas'),
(30, 'SALES', 'Chicago'),
(40, 'OPERATIONS', 'Boston');

INSERT INTO emp (emp_no, birth_date, first_name, last_name, gender, hire_date, salary, job, deptno, manager_id) VALUES
(7839, '1955-11-17', 'John', 'Smith', 'M', '1990-06-09', 5000.00, 'MANAGER', 10, NULL),
(7566, '1960-02-21', 'James', 'Brown', 'M', '1991-04-02', 2450.00, 'CLERK', 20, 7839),
(7654, '1963-12-09', 'Scott', 'Allen', 'M', '1989-06-04', 2975.00, 'SALESMAN', 30, 7839),
(7934, '1970-12-03', 'Adam', 'Martin', 'M', '1993-07-09', 1300.00, 'CLERK', 30, 7839),
(7788, '1961-05-23', 'Alan', 'Walker', 'M', '1990-09-14', 3000.00, 'ANALYST', 20, 7566),
(7902, '1958-11-07', 'Alice', 'Jones', 'F', '1988-12-12', 1600.00, 'CLERK', 30, 7654),
(7876, '1962-01-14', 'George', 'Black', 'M', '1989-01-20', 1100.00, 'CLERK', 40, 7566),
(7844, '1965-09-28', 'Diana', 'White', 'F', '1992-05-21', 2950.00, 'SALESMAN', 30, 7654),
(7900, '1972-06-19', 'Bob', 'King', 'M', '1991-08-18', 850.00, 'CLERK', 10, 7839);

#1
select first_name, last_name
from emp
where first_name like 'a%' and length(first_name) >= 3;  #a% is for starting with a and anything after it, %a is last letter a and anything before it, %a% is a in between

#2
select dept_name, location
from departments
where location in ('Dallas','New York','Chicago');

#3
select first_name, last_name, job
from emp
where (job='CLERK' or job='SALESMAN' or job='ANALYST') and salary>=3000;

#4
select first_name, last_name
from emp
where job != 'MANAGER';

#5
select first_name, last_name
from emp
where salary>=all(select salary from emp);

#6
select emp_no,first_name,last_name 
from emp
where job='CLERK'
order by salary desc
limit 1;

select emp_no, first_name,last_name
from emp
where salary>=all(select salary from emp where job='CLERK')
limit 1;

#7
select first_name, last_name
from emp
where job='CLERK'
and salary>((select salary from emp where first_name='James') or salary<(select salary from emp where first_name='Scott'));

#8
select e1.first_name, e1.last_name, e1.salary, e1.deptno
from emp e1
where e1.salary in(
	select max(e2.salary)
    from emp e2
    where e2.deptno=e1.deptno
);

#9
select e1.first_name,e1.last_name
from emp e1
join emp e2 on e1.manager_id=e2.emp_no
where e1.deptno=e2.deptno;

select first_name, last_name
from emp
where salary>=3000 and salary<=5000;



#a
SELECT first_name, last_name
FROM emp
WHERE salary BETWEEN 3000 AND 5000;

#b
SELECT first_name, last_name
FROM emp
WHERE deptno IN (SELECT deptno FROM departments WHERE dept_name IN ('Sales', 'Marketing'));

#d
SELECT first_name, last_name
FROM emp
WHERE salary NOT BETWEEN 2000 AND 4000;

#e
SELECT first_name, last_name
FROM emp
WHERE first_name LIKE 'a%n';

#f
SELECT first_name, last_name
FROM emp
WHERE salary > (SELECT AVG(salary) FROM emp);

#g
SELECT first_name, last_name
FROM emp
WHERE salary < (SELECT salary FROM emp WHERE first_name = 'Scott');

#h
SELECT first_name, last_name
FROM emp
WHERE salary BETWEEN 1000 AND 3000
OR deptno = (SELECT deptno FROM departments WHERE dept_name = 'Research');

#i
SELECT first_name, last_name
FROM emp
WHERE salary > 2000 AND job != 'Manager';