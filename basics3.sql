create database practical6;
use practical6;

create table employees(
	emp_id int primary key,
    emp_name varchar(50),
    dept_id int,
    salary decimal(10,2),
    manager_id  int
);

create table departments(
	dept_id int primary key,
    dept_name varchar(50),
    location varchar(50)
);

create table projects(
	proj_id int primary key,
    proj_name varchar(50),
    dept_id int
);

create table assignments(
	emp_id int,
    proj_id int,
    hours_worked int,
    primary key(emp_id, proj_id),
    foreign key(emp_id) references employees(emp_id),
    foreign key(proj_id) references projects(proj_id)
);

INSERT INTO departments (dept_id, dept_name, location) VALUES
(101, 'Engineering', 'New York'),
(102, 'Human Resources', 'London'),
(103, 'Finance', 'Sydney'),
(104, 'Marketing', 'Tokyo');

INSERT INTO employees (emp_id, emp_name, dept_id, salary, manager_id) VALUES
(1, 'John Smith', 101, 75000.00, 3),
(2, 'Jane Doe', 102, 85000.00, 3),
(3, 'Michael Brown', 101, 95000.00, NULL),
(4, 'Emily Davis', 103, 68000.00, 5),
(5, 'David Wilson', 103, 72000.00, 3),
(6, 'Sarah Johnson', 104, 54000.00, 2),
(7, 'James Taylor', 102, 63000.00, 2),
(8, 'Olivia Martin', 101, 71000.00, 3);

INSERT INTO projects (proj_id, proj_name, dept_id) VALUES
(201, 'Website Redesign', 101),
(202, 'Employee Training', 102),
(203, 'Budget Analysis', 103),
(204, 'Marketing Campaign', 104);

INSERT INTO assignments (emp_id, proj_id, hours_worked) VALUES
(1, 201, 120),
(2, 202, 100),
(3, 201, 150),
(4, 203, 110),
(5, 203, 130),
(6, 204, 90),
(7, 202, 80),
(8, 201, 100);

#1
SELECT employees.emp_id, employees.emp_name, departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.dept_id;

#2
SELECT employees.emp_id, employees.emp_name, departments.dept_name
FROM employees
LEFT JOIN departments ON employees.dept_id = departments.dept_id;

#3
SELECT employees.emp_id, employees.emp_name, departments.dept_name
FROM employees
RIGHT JOIN departments ON employees.dept_id = departments.dept_id;



