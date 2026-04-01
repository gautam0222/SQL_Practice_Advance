create database sem5;
use sem5;
#1
CREATE TABLE University (
    UnivID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    Name VARCHAR(100),
    UnivID INT,
    FOREIGN KEY (UnivID) REFERENCES University(UnivID)
);

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    Name VARCHAR(100),
    DeptID INT,
    Salary DECIMAL(10,2),
    isHOD INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Course (
    CourseID VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(100),
    Credits INT,
    DeptID INT,
    InstructorID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE Enrollment (
    StudentID INT,
    CourseID VARCHAR(10),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Section (
    SectionID INT PRIMARY KEY,
    CourseID VARCHAR(10),
    Semester VARCHAR(10),
    Year INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE TimeSlot (
    SlotID INT PRIMARY KEY,
    DayOfWeek VARCHAR(10),
    StartTime TIME,
    EndTime TIME
);

CREATE TABLE Classroom (
    RoomID VARCHAR(10) PRIMARY KEY,
    Building VARCHAR(50),
    Capacity INT
);

CREATE TABLE SectionSchedule (
    SectionID INT,
    SlotID INT,
    RoomID VARCHAR(10),
    PRIMARY KEY (SectionID, SlotID, RoomID),
    FOREIGN KEY (SectionID) REFERENCES Section(SectionID),
    FOREIGN KEY (SlotID) REFERENCES TimeSlot(SlotID),
    FOREIGN KEY (RoomID) REFERENCES Classroom(RoomID)
);

#2
INSERT INTO University VALUES
(1, 'Symbiosis University', 'New York'),
(2, 'Another University', 'Los Angeles'),
(3, 'Third University', 'Chicago'),
(4, 'Fourth University', 'Houston'),
(5, 'Fifth University', 'Phoenix'),
(6, 'Sixth University', 'Philadelphia'),
(7, 'Seventh University', 'San Antonio');

INSERT INTO Department VALUES
(1, 'Computer Science', 1),
(2, 'Mathematics', 1),
(3, 'Physics', 1),
(4, 'Chemistry', 1),
(5, 'Biology', 1),
(6, 'English', 1),
(7, 'History', 1);

INSERT INTO Instructor VALUES
(1, 'John Doe', 1, 75000.00, TRUE),
(2, 'Jane Smith', 1, 70000.00, FALSE),
(3, 'Bob Johnson', 2, 72000.00, TRUE),
(4, 'Alice Brown', 2, 68000.00, FALSE),
(5, 'Charlie Davis', 3, 71000.00, TRUE),
(6, 'Eve Wilson', 3, 69000.00, FALSE),
(7, 'Frank Miller', 4, 73000.00, TRUE);

INSERT INTO Student VALUES
 (101, 'Alice Johnson'), 
 (102, 'Bob Smith'),
 (103, 'Carol Williams'),
 (104, 'David Brown'),
 (105, 'Eve Davis'),
 (106, 'Frank Miller'),
 (107, 'Grace Wilson'), 
 (108, 'Hank Taylor'),
 (109, 'Ivy Anderson'),
 (110, 'Jack White'),
 (111, 'Kathy Moore'), 
 (112, 'Leo Martin'), 
 (113, 'Megan Thomas'),
 (114, 'Nina Jackson'), 
 (115, 'Oliver Lee'),
 (116, 'Pamela Harris'),
 (117, 'Quincy Clark'),
 (118, 'Rachel Lewis'),
 (119, 'Sam Walker'),
 (120, 'Tina Young');
 
INSERT INTO Course VALUES
('CS101', 'Introduction to Computer Science', 4, 1, 1),
('CS102', 'Data Structures', 3, 1, 2), 
('MATH101', 'Calculus I', 4, 2, 3), 
('MATH102', 'Linear Algebra', 3, 2, 4),
('PHY101', 'Physics I', 4, 3, 5),
('PHY102', 'Classical Mechanics', 3, 3, 6),
('CHEM101', 'General Chemistry', 4, 4, 7), 
('BIO101', 'Biology I', 4, 5, NULL),
('ENG101', 'English Literature', 3, 6, NULL), 
('HIST101', 'World History', 3, 7, NULL);

INSERT INTO Enrollment VALUES 
(101, 'CS101'),
(102, 'CS101'), 
(103, 'CS102'), 
(104, 'MATH101'), 
(105, 'MATH102'), 
(106, 'PHY101'), 
(107, 'PHY102'), 
(108, 'CHEM101'), 
(109, 'BIO101'), 
(110, 'ENG101'), 
(111, 'HIST101'), 
(112, 'CS101'), 
(113, 'MATH101'), 
(114, 'PHY101'), 
(115, 'BIO101'), 
(116, 'CS102'), 
(117, 'MATH102'), 
(118, 'CHEM101'), 
(119, 'ENG101'), 
(120, 'HIST101');


INSERT INTO Classroom (RoomID, Building, Capacity) VALUES
('R101', 'Symbio Hall', 50),
('R102', 'Symbio Tower', 60),
('R103', 'Science Block', 40),
('R104', 'Arts Building', 30),
('R105', 'Symbio Pavilion', 70);


#3
UPDATE Instructor
SET Salary = Salary * 1.1
WHERE DeptID IN (SELECT DeptID FROM Department WHERE Name = 'Computer Science');

#4
DELETE FROM Course
WHERE CourseID NOT IN (SELECT CourseID FROM Section);

#5
DELETE FROM Instructor
WHERE DeptID IN (SELECT DeptID FROM Department WHERE Location = 'New York');

#7
UPDATE Instructor
SET Salary = Salary * 1.05 WHERE Salary < 70000;

#8
#a
INSERT INTO Course (CourseID, Title, Credits, DeptID, InstructorID)
VALUES ('CS-001', 'Weekly Seminar', 1, 1, 1); 
#b
INSERT INTO Section (SectionID, CourseID, Semester, Year)
VALUES (1, 'CS-001', 'Fall', 2017);
#c
DELETE FROM Course
WHERE CourseID = 'CS-001'; #errorrr Cannot delete or update a parent row

#10
CREATE TABLE Students (
  StudentID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(100)
);
INSERT INTO Students (Name) VALUES ('Alice'), ('Bob'), ('Charlie');

#11
RENAME TABLE Students TO Pupils;

#12
ALTER TABLE Pupils
ADD COLUMN PINCODE INT NOT NULL;

#9
CREATE VIEW CS_Instructors AS
SELECT i.InstructorID, i.Name, i.Salary
FROM Instructor i
JOIN Department d ON i.DeptID = d.DeptID
WHERE d.Name = 'Computer Science';

CREATE VIEW High_Salary_Instructors AS
SELECT i.InstructorID, i.Name, i.Salary
FROM Instructor i
WHERE i.Salary > 70000
WITH CHECK OPTION;

SELECT * FROM CS_Instructors;

DROP VIEW CS_Instructors;





#practical 3
use sem5;

#a
select AVG(I.Salary) AS AverageSalary
from Instructor I
Join department D on I.DeptID=D.DeptID
where D.Name='Computer Science';

#b
select D.Name As NameList, AVG(I.salary) as AverageSalary
from Instructor I
join department D on I.deptId=D.deptID
group by D.Name;

#c
select sum(Salary) as TotalSalary
from instructor
where salary>30000;

#d
select C.courseID,C.Title, count(E.studentID) as EnrolledStudents
from Course C
left join Enrollment E on C.courseID=E.CourseID
group by C.courseID, C.Title;

#e
SELECT d.Name AS DepartmentName
FROM Department d
JOIN University u ON d.UnivID = u.UnivID
WHERE u.Location LIKE '%Symbio%';

#f
select name from department where lower(name) like '%sci%';

#g
select name, length(name) as namelength from student;

#h
SELECT COUNT(*) AS TotalInstructors
FROM Instructor;

#i
ALTER TABLE Instructor
ADD COLUMN HireDate DATE;
INSERT INTO Instructor (InstructorID, Name, DeptID, Salary, isHOD, HireDate)
VALUES 
(8, 'Emily Adams', 1, 75000.00, FALSE, '2019-05-15'),
(9, 'Michael Brown', 2, 68000.00, FALSE, '2018-07-21'),
(10, 'Linda Green', 3, 70000.00, TRUE, '2017-11-30'),
(11, 'David White', 4, 69000.00, FALSE, '2000-01-10');
SELECT Name
FROM Instructor
WHERE HireDate <= CURDATE() - INTERVAL 5 YEAR;