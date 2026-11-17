/* ==========================================================================
   design_lab1_starter.sql
   CIS 4720 Database Management and SQL
   Design Lab 1, From a Spreadsheet to Tables

   WHAT THIS FILE IS
   The campus tutoring center keeps its records in a spreadsheet. This file
   loads that spreadsheet into a table called tutoring_sheet, exactly as the
   center keeps it, and has a numbered heading for every step of the lab.

   HOW TO RUN IT
   One statement at a time. Put the cursor on it and press Ctrl + E twice.

   LABELING AND COMMENTING IS REQUIRED
   Above every statement you write, put a short comment in your own words
   saying what it does. Some steps also ask you to answer a question in a
   comment. The comments are graded.
   ========================================================================== */


-- =================================================================
-- SETUP. Run these three first, one at a time, while you are still
-- connected to information_schema.
-- =================================================================

-- every schema on this server. tutoring_db will not be in the list yet.
show databases;



-- make yours. IF NOT EXISTS means it is safe to run twice.
create database if not exists tutoring_db;

-- switch into it, so everything below lands in the right place.
use tutoring_db;


-- ======================================================================
-- THE SPREADSHEET. One row per tutoring session. Look at the students
-- column: every student who came is crammed into one cell.
-- ======================================================================

CREATE TABLE tutoring_sheet (
    session_id   INT,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    students     VARCHAR(200)
);
INSERT INTO tutoring_sheet VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS), 1003 Chloe Nguyen (CIS)');
INSERT INTO tutoring_sheet VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting)');
INSERT INTO tutoring_sheet VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', '1001 Ana Lopez (CIS), 1004 Dev Patel (Biology), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', '1002 Ben Ortiz (Accounting), 1005 Elena Ruiz (Undeclared)');
INSERT INTO tutoring_sheet VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', '1003 Chloe Nguyen (CIS), 1004 Dev Patel (Biology)');
INSERT INTO tutoring_sheet VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', '1001 Ana Lopez (CIS)');

-- CHECK. Six rows, sessions 101 to 106.
SELECT * FROM tutoring_sheet;


-- ######################################################################
-- YOUR DESIGN LAB 1 WORK STARTS BELOW THIS LINE
--
-- LABELING AND COMMENTING IS REQUIRED. It is worth a full point.
-- ######################################################################


-- =================================================================
-- STEP 3. Ask the spreadsheet two questions
--
-- Copy the queries from the handout. Answer the question in a comment.
-- =================================================================

-- how many sessions did Ana come to? search inside the text
-- 3 times, sessions 101, 103, and 106
SELECT COUNT(*) FROM tutoring_sheet WHERE students LIKE '%Ana Lopez%';
-- how many student visits were there in total?
-- 11 student visits in total
SELECT COUNT(*) FROM tutoring_sheet;

--The students column holds a list, so the database sees one value per row, not one value per student. That is what 1NF forbids.

-- =================================================================
-- STEP 4. First normal form, one value per cell
--
-- Write the CREATE TABLE. Then run the DATA FOR STEP 4 block below it.
-- =================================================================

--
CREATE TABLE if not exists tutoring_1nf (
    session_id   INT NOT NULL,
    session_date DATE,
    room         VARCHAR(10),
    tutor_id     INT,
    tutor_name   VARCHAR(40),
    tutor_email  VARCHAR(60),
    course_code  VARCHAR(10),
    course_title VARCHAR(40),
    student_id   INT NOT NULL,
    student_name VARCHAR(40),
    student_major        VARCHAR(30),
    rating       INT CHECK (rating BETWEEN 1 AND 5),
    PRIMARY KEY (session_id, student_id)
);

show full tables;
-- ----------------------------------------------------------------------
-- DATA FOR STEP 4. Run these eleven INSERTs AFTER your CREATE TABLE for
-- tutoring_1nf. They only work if your columns are in the same order as
-- the table in the handout. One row per student per session.
-- ----------------------------------------------------------------------
-- inserts 
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (101, '2026-09-08', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (102, '2026-09-08', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 3);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1001, 'Ana Lopez', 'CIS', 4);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1004, 'Dev Patel', 'Biology', 5);
INSERT INTO tutoring_1nf VALUES (103, '2026-09-10', 'LIB 110', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'MATH 1600', 'Statistics', 1005, 'Elena Ruiz', 'Undeclared', 2);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1002, 'Ben Ortiz', 'Accounting', 4);
INSERT INTO tutoring_1nf VALUES (104, '2026-09-15', 'LIB 112', 502, 'Omar Haddad', 'omar.haddad@tutor.edu', 'ACC 2100', 'Financial Accounting', 1005, 'Elena Ruiz', 'Undeclared', 3);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1003, 'Chloe Nguyen', 'CIS', 5);
INSERT INTO tutoring_1nf VALUES (105, '2026-09-17', 'LIB 110', 503, 'Priya Shah', 'priya.shah@tutor.edu', 'CIS 2000', 'Information Systems', 1004, 'Dev Patel', 'Biology', 4);
INSERT INTO tutoring_1nf VALUES (106, '2026-09-22', 'LIB 114', 501, 'Maya Chen', 'maya.chen@tutor.edu', 'CIS 2000', 'Information Systems', 1001, 'Ana Lopez', 'CIS', 5);

-- STEP 4, continued. visits per student, now that ervey visit is its own row
select * from tutoring_1nf;
SELECT student_name, COUNT(*) AS sessions
FROM tutoring_1nf
GROUP BY student_name
ORDER BY student_name;
-- =================================================================
-- STEP 5. Make a copy to break
-- =================================================================

--copy table tutoring_1nf as anomaly_copy
CREATE table amomaly_copy AS
SELECT * FROM tutoring_1nf;


SELECT COUNT(*) FROM amomaly_copy;


-- =================================================================
-- STEP 6. The update problem
--
-- Copy the UPDATE from the handout. Answer the question in a comment.
-- =================================================================
--update maya's email address to the new one
--view the table to see that it has been updated for all of her sessions
SELECT * FROM amomaly_copy;

--change maya's email address to the new one
UPDATE amomaly_copy
SET tutor_email = 'maya.chen@campus.edu'
WHERE session_id =101;

--what does the database say her new email is?
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM amomaly_copy
WHERE tutor_id = 501;




-- =================================================================
-- STEP 7. The insert problem
--
-- Write the INSERT. Copy the error into a comment.
-- =================================================================

-- insert into anomaly copy including course code = cis4720 and title
insert into amomaly_copy (course_code, course_title) values ( "CIS 4720", "Database Management)");


--answer: session_id and student_id form the key so every row needs both.
--

-- =================================================================
-- STEP 8. The delete problem
--
-- Write the DELETE and the check. Answer the question in a comment.
-- =================================================================

-- session 103 was entered by mistake. Delete it, and check that the course is gone.
SELECT DISTINCT course_code, course_title
FROM amomaly_copy
ORDER BY course_code;

--

-- =================================================================
-- STEP 9. Find the dependencies, and design third normal form
--
-- Answer in comments. Use the template in the handout.
-- =================================================================


SELECT student_id,
COUNT(DISTINCT student_name) AS names,
COUNT(DISTINCT student_major) AS majors
FROM tutoring_1nf
GROUP BY student_id;

/*the key is student_id and session_id
columnn         Determined            by kind
session_date     session_id            parital:needs only part of the key
tutor_name        tutor_id              transitive
room             session_id            parital
tutor_id          session_id            parital
tutor_email       tutor_id              transitive
course_code       session_id            parital
course_title      course_code           transitive
student_name      student_id            parital
student_major     student_id            parital
rating            session_id, student_id  full key
*/



-- =================================================================
-- STEP 10. Build the five tables
--
-- Order matters: a table that is pointed at must exist first.
-- =================================================================

-- one row per student. student_id is the key
CREATE TABLE student (
student_id INT PRIMARY KEY,
student_name VARCHAR(40) NOT NULL,
student_major VARCHAR(30)
);

--one row per tutor. thr rmail can never be shared
CREATE TABLE tutor (
tutor_id INT PRIMARY KEY,
tutor_name VARCHAR(40) NOT NULL,
tutor_email VARCHAR(60) UNIQUE
);

--one row per course
CREATE TABLE course (
course_code VARCHAR(10) PRIMARY KEY,
course_title VARCHAR(40) NOT NULL
);

-- one row per session, pointing at its tutor and its course
CREATE TABLE session (
session_id INT PRIMARY KEY,
session_date DATE NOT NULL,
room VARCHAR(10),
tutor_id INT NOT NULL,
course_code VARCHAR(10) NOT NULL,
FOREIGN KEY (tutor_id) REFERENCES tutor(tutor_id),
FOREIGN KEY (course_code) REFERENCES course(course_code)
);

-- the bridge between students and sessions. its key is the two keys it connects
CREATE TABLE attendance (
session_id INT NOT NULL,
student_id INT NOT NULL,
rating INT,
PRIMARY KEY (session_id, student_id),
FOREIGN KEY (session_id) REFERENCES session(session_id),
FOREIGN KEY (student_id) REFERENCES student(student_id)
);

show full tables;

-- =================================================================
-- STEP 11. Load the five tables from tutoring_1nf
-- =================================================================

-- each table loaded from tutoring_inf. DISTINCR removes repeats
-- INSERT can take its rows from a select instead of a values list
INSERT INTO student (student_id, student_name, student_major)
SELECT DISTINCT student_id, student_name, student_major
FROM tutoring_1nf;

INSERT INTO tutor (tutor_id, tutor_name, tutor_email)
SELECT DISTINCT tutor_id, tutor_name, tutor_email
FROM tutoring_1nf;

INSERT INTO course (course_code, course_title)
SELECT DISTINCT course_code, course_title
FROM tutoring_1nf;

INSERT INTO session (session_id, session_date, room, tutor_id, course_code)
SELECT DISTINCT session_id, session_date, room, tutor_id, course_code
FROM tutoring_1nf;

-- no DISTINCT: every 1NF row is already one attendance
INSERT INTO attendance (session_id, student_id, rating)
SELECT DISTINCT session_id, student_id, rating
FROM tutoring_1nf;

-- =================================================================
-- STEP 12. Put the spreadsheet back together
--
-- Copy the view and the check from the handout.
-- =================================================================

-- the five tables joined back into the 1NF shape
CREATE VIEW tutoring_rebuilt AS
SELECT se.session_id, se.session_date, se.room,
t.tutor_id, t.tutor_name, t.tutor_email,
c.course_code, c.course_title,
st.student_id, st.student_name, st.student_major,
a.rating
FROM attendance a
JOIN session se ON a.session_id = se.session_id
JOIN tutor t ON se.tutor_id = t.tutor_id
JOIN course c ON se.course_code = c.course_code
JOIN student st ON a.student_id = st.student_id;
-- how many rows match tutoring_1nf on every column?
-- 11
SELECT COUNT(*)
FROM tutoring_1nf o
JOIN tutoring_rebuilt r
ON o.session_id = r.session_id AND o.student_id = r.student_id
WHERE o.session_date = r.session_date AND o.room = r.room
AND o.tutor_email = r.tutor_email AND o.course_title = r.course_title
AND o.student_name = r.student_name AND o.student_major = r.student_major
AND o.rating = r.rating;

SELECT * FROM tutoring_rebuilt;

-- =================================================================
-- STEP 13. Show the three problems are gone
-- =================================================================

-- update: change Mayas email in the one place it it stored
UPDATE tutor SET tutor_email = 'maya.chen@campus.edu' WHERE tutor_id = 501;

-- all six of her sessions now show the same email
SELECT DISTINCT tutor_email FROM tutoring_rebuilt WHERE tutor_id = 501;

-- insert: a course with no sessions can now be recorded
INSERT INTO course (course_code, course_title) VALUES ( 'CIS 4720', 'DATABASE MANAGEMENT');

-- delete: refused, because three attendance rows point at session 103
DELETE FROM session WHERE session_id = 103;

-- cannot delete or update a parent row: a foregin key constraint fails
-- update: the email is stored once in tutor, so one change fixes every session
-- insert: a course has its own table and no longer needs a session to exist.
-- delete: the course lives in itw own table so removing a session could not
-- remove the course, the foreign key


-- =================================================================
-- STEP 14 and 15. Push to GitHub and submit the URL
--
-- Nothing to write here. Follow the handout.
-- =================================================================

-- your comment goes here
-- your statements go here
