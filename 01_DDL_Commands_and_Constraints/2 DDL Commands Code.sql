CREATE DATABASE Student_Db;
USE Student_Db;

CREATE TABLE Students(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INT,
    course VARCHAR(30) DEFAULT 'Computer Science'
    );
    
INSERT INTO Students (name, age) VALUES ('Fathima', 20);
INSERT INTO Students (name, age, course) VALUES ('Shana', 22, 'Statistics');

ALTER TABLE Students
ADD email VARCHAR(100) UNIQUE;

ALTER TABLE Students
CHANGE name full_name VARCHAR (50) NOT NULL;

UPDATE Students
SET age = 21 WHERE student_id = 1;

DELETE FROM Students
WHERE student_id = 2;


