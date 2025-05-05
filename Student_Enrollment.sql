create schema Enrollment;

create database Enrollment;

drop table courses;
drop table enrollments;
drop table students;

create table Students(
					  Student_ID int primary key,
					  S_Name varchar(255),
                      D_O_B date,
                      Email varchar(255) unique);

INSERT INTO Students (Student_ID, S_Name, D_O_B, Email)
VALUES (1, 'Arjun Sharma', '2003-04-12', 'arjun.sharma@example.com'),
		(2, 'Ayesha Patel', '2002-11-23', 'ayesha.patel@example.com'),
		(3, 'Rohan Das', '2001-09-07', 'rohan.das@example.com'),
		(4, 'Priya Singh', '2004-01-15', 'priya.singh@example.com'),
		(5, 'Varun Kumar', '2003-06-05', 'varun.kumar@example.com');
INSERT INTO Students (Student_ID, S_Name, D_O_B, Email)
VALUES (6, 'Nisha Kapoor', '2002-12-16', 'nisha.kapoor@example.com'),
 (7, 'Rahul Verma', '2001-10-05', 'rahul.verma@example.com'),
 (8, 'Sunita Jain', '2003-08-24', 'sunita.jain@example.com'),
 (9, 'Amit Bose', '2002-02-13', 'amit.bose@example.com'),
 (10, 'Kavita Singh', '2004-03-30', 'kavita.singh@example.com'),
 (11, 'Prakash Nayak', '2001-11-12', 'prakash.nayak@example.com'),
 (12, 'Ritu Joshi', '2003-07-19', 'ritu.joshi@example.com'),
 (13, 'Deepak Chandra', '2002-09-26', 'deepak.chandra@example.com'),
 (14, 'Anjali Mehta', '2004-05-14', 'anjali.mehta@example.com'),
 (15, 'Sanjay Kulkarni', '2001-04-18', 'sanjay.kulkarni@example.com');


create table Departments(
    Department_ID int primary key,
    Department_Name varchar(255)
);

INSERT INTO Departments (Department_ID, Department_Name)
VALUES (1, 'Computer Science'),
		(2, 'Mechanical Engineering'),
		(3, 'Electrical Engineering'),
		(4, 'Civil Engineering'),
		(5, 'Biotechnology');

create table Courses(
    Course_ID int primary key,
    Course_name varchar(255),
    Course_description varchar(255),
    Department_ID int,
     foreign key (Department_ID) references Departments(Department_ID)
);

INSERT INTO Courses (Course_ID, Course_name, Course_description, Department_ID)
VALUES (101, 'Algorithms', 'Study of algorithms and their complexity', 1),
		(102, 'Data Structures', 'Study of data structures and their applications', 1),
		(201, 'Thermodynamics', 'Study of thermodynamic principles and systems', 2),
		(202, 'Fluid Mechanics', 'Study of fluid behavior and dynamics', 2),
		(301, 'Circuit Analysis', 'Study of electric circuits and their analysis', 3),
		(302, 'Electromagnetics', 'Study of electromagnetic fields and waves', 3),
		(401, 'Structural Engineering', 'Study of structural design and analysis', 4),
		(402, 'Geotechnical Engineering', 'Study of soil mechanics and foundations', 4),
		(501, 'Genetics', 'Study of genes and heredity', 5),
		(502, 'Microbiology', 'Study of microorganisms and their effects', 5);


create table Enrollments( Enrollment_ID int primary key,
						Student_ID int ,
                        Course_ID int,
                        Enrollment_date date,
                        foreign key (Student_ID) references Students(Student_ID),
                         foreign key (Course_ID) references Courses(Course_ID));


INSERT INTO Enrollments (Enrollment_ID, Student_ID, Course_ID, Enrollment_date)
VALUES (1, 1, 101, '2025-01-10'),
 (2, 2, 102, '2025-01-11'),
 (3, 3, 201, '2025-01-12'),
 (4, 4, 202, '2025-01-13'),
 (5, 5, 301, '2025-01-14'),
 (6, 6, 302, '2025-01-15'),
 (7, 7, 401, '2025-01-16'),
 (8, 8, 402, '2025-01-17'),
 (9, 9, 501, '2025-01-18'),
 (10, 10, 502, '2025-01-19'),
 (11, 11, 101, '2025-01-20'),
 (12, 12, 102, '2025-01-21'),
 (13, 13, 201, '2025-01-22'),
 (14, 14, 202, '2025-01-23'),
 (15, 15, 301, '2025-01-24');

					
create table Professors(
    professor_id int primary key,
    P_Name varchar(255),
    Department_ID int,
    foreign key (Department_ID) references Courses(Department_ID)
);
INSERT INTO Professors (professor_id, P_Name, Department_ID)
VALUES (1, 'Dr. Aakash Gupta', 1),
		(2, 'Dr. Meera Rao', 2),
		(3, 'Dr. Karan Malhotra', 3),
		(4, 'Dr. Rekha Sharma', 4),
		(5, 'Dr. Vijay Patel', 5);

CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT ON Students TO 'user'@'localhost';

SHOW GRANTS FOR 'user'@'localhost';

REVOKE INSERT ON Students FROM 'user'@'localhost';

SHOW GRANTS FOR 'user'@'localhost';

SELECT Students.S_Name, Courses.Course_Name
FROM Students
INNER JOIN Enrollments ON Students.Student_ID = Enrollments.Student_ID
INNER JOIN Courses ON Enrollments.Course_ID = Courses.Course_ID;

CREATE VIEW StudentCourses AS
SELECT Students.S_Name, Courses.Course_Name
FROM Students
JOIN Enrollments ON Students.Student_ID = Enrollments.Student_ID
JOIN Courses ON Enrollments.Course_ID = Courses.Course_ID;

drop procedure Enrollstudent;

DELIMITER $$

CREATE PROCEDURE EnrollStudent (
    IN Student_Name NVARCHAR(50), 
    IN DateOfBirth DATE, 
    IN Email NVARCHAR(50), 
    IN CourseID INT 
)
BEGIN
    DECLARE StudentID INT;

    INSERT INTO Students (S_Name, DateOfBirth, Email)
    VALUES (Name, DateOfBirth, Email);

    SET StudentID = LAST_INSERT_ID();

    INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate)
    VALUES (StudentID, CourseID, NOW());
END $$

DELIMITER ;





