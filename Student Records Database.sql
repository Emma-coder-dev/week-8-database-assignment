-- 💣 Step 1: Drop the existing database (be careful, this deletes all its data)
DROP DATABASE IF EXISTS StudentRecordsDB;

-- ✅ Step 2: Create the database again
CREATE DATABASE StudentRecordsDB;

-- 📌 Step 3: Select it for use
USE StudentRecordsDB;

-- 📂 Step 4: Create the tables

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Students table
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DepartmentID INT,
    DateOfBirth DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Instructors table
CREATE TABLE Instructors (
    InstructorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Courses table
CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    CourseCode VARCHAR(20) NOT NULL UNIQUE,
    InstructorID INT,
    DepartmentID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT (CURRENT_DATE),
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE (StudentID, CourseID)
);

INSERT INTO Departments (DepartmentName) VALUES
('Computer Science'),
('Mathematics'),
('Physics'),
('Literature');

INSERT INTO Students (FirstName, LastName, Email, DepartmentID, DateOfBirth) VALUES
('Alice', 'Mwangi', 'alice@example.com', 1, '2002-04-15'),
('Brian', 'Otieno', 'brian@example.com', 2, '2001-11-22'),
('Catherine', 'Njeri', 'catherine@example.com', 1, '2003-01-05'),
('David', 'Kimani', 'david@example.com', 3, '2000-07-30');

INSERT INTO Instructors (FirstName, LastName, Email, DepartmentID) VALUES
('Dr. James', 'Kiptoo', 'kiptoo@example.com', 1),
('Prof. Susan', 'Omondi', 'susan@example.com', 2),
('Dr. Mark', 'Njoroge', 'mark@example.com', 3);

INSERT INTO Courses (CourseName, CourseCode, InstructorID, DepartmentID) VALUES
('Database Systems', 'CS101', 1, 1),
('Calculus I', 'MTH101', 2, 2),
('Physics I', 'PHY101', 3, 3),
('Operating Systems', 'CS102', 1, 1);

INSERT INTO Enrollments (StudentID, CourseID, Grade) VALUES
(1, 1, 'A'),
(1, 4, 'B'),
(2, 2, 'A'),
(3, 1, 'C'),
(4, 3, 'B');

SELECT * FROM Enrollments;
SELECT 
    CONCAT(s.FirstName, ' ', s.LastName) AS StudentName,
    c.CourseName,
    e.Grade,
    e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;
