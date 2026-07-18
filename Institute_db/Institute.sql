-- ===========================================
-- CREATE STUDENTS TABLE
-- Creates a table to store student details
-- ===========================================

CREATE TABLE students (
    s_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- ===========================================
-- INSERT STUDENT DATA
-- Adds sample students into the students table
-- ===========================================

INSERT INTO students (name)
VALUES
    ('Rahul'),
    ('Shreya'),
    ('Aman'),
    ('Priya'),
    ('Neha'),
    ('Rohan'),
    ('Anjali');


-- ===========================================
-- CREATE COURSES TABLE
-- Creates a table to store course details
-- ===========================================

CREATE TABLE courses (
    c_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    fee NUMERIC NOT NULL
);

-- ===========================================
-- INSERT COURSE DATA
-- Adds sample courses into the courses table
-- ===========================================

INSERT INTO courses (name, fee)
VALUES
    ('Python Programming', 12000),
    ('Java Development', 15000),
    ('Web Development', 18000),
    ('Data Structures', 14000),
    ('Database Management', 16000);


-- ===========================================
-- CREATE ENROLLMENT TABLE
-- Stores information about which student
-- is enrolled in which course.
-- ===========================================

CREATE TABLE enrollment (

    -- Primary Key: Uniquely identifies each enrollment
    enrollment_id SERIAL PRIMARY KEY,

    -- Foreign Key: Refers to the student ID
    s_id INT NOT NULL,

    -- Foreign Key: Refers to the course ID
    c_id INT NOT NULL,

    -- Stores the enrollment date
    enrollment_date DATE NOT NULL,

    -- Creates a foreign key relationship with the students table
    FOREIGN KEY (s_id)
    REFERENCES students(s_id),

    -- Creates a foreign key relationship with the courses table
    FOREIGN KEY (c_id)
    REFERENCES courses(c_id)

);

-- ===========================================
-- INSERT ENROLLMENT DATA
-- Assigns students to different courses
-- ===========================================

INSERT INTO enrollment (s_id, c_id, enrollment_date)
VALUES
    (1, 1, '2024-01-15'),
    (2, 3, '2024-01-18'),
    (3, 2, '2024-02-01'),
    (4, 5, '2024-02-10'),
    (5, 4, '2024-03-05'),
    (6, 1, '2024-03-20'),
    (7, 3, '2024-04-01');


-- ===========================================
-- DISPLAY STUDENT ENROLLMENT DETAILS
-- Shows student name, enrolled course,
-- enrollment date and course fee
-- ===========================================

SELECT
    s.name AS student_name,
    c.name AS course_name,
    e.enrollment_date,
    c.fee
FROM enrollment e
JOIN students s
    ON e.s_id = s.s_id
JOIN courses c
    ON e.c_id = c.c_id;