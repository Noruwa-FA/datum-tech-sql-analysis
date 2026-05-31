-- ============================================================
-- Datum Tech Academic Analysis - Part 1: JOINs
-- Author: Success Noruwa
-- Description: Course distribution and student performance
-- using INNER, LEFT, RIGHT and FULL OUTER JOINs
-- ============================================================

-- 1. INNER JOIN: List course names and their departments
SELECT 
    c.course_name,
    d.department_name
FROM courses c
INNER JOIN departments d ON c.department = d.department_id;

-- 2. INNER JOIN: Students scoring above 75 with their courses
SELECT 
    s.student_name,
    c.course_name,
    sc.score
FROM scores sc
INNER JOIN courses c ON sc.course_id = c.course_id
INNER JOIN scores s ON sc.student_id = s.student_id
WHERE sc.score > 75
ORDER BY sc.score DESC;

-- 3. LEFT JOIN: All courses including those without assigned teachers
SELECT 
    c.course_name,
    t.teacher_name
FROM courses c
LEFT JOIN teachers t ON c.course_id = t.teacher_course;

-- 4. LEFT JOIN: All courses with their average scores
SELECT 
    c.course_name,
    ROUND(AVG(sc.score)) AS average_score
FROM courses c
LEFT JOIN scores sc ON c.course_id = sc.course_id
GROUP BY c.course_name
ORDER BY average_score DESC;

-- 5. RIGHT JOIN: All students with their courses (including unenrolled)
SELECT 
    s.student_name,
    c.course_name
FROM courses c
RIGHT JOIN scores s ON c.course_id = s.course_id;

-- 6. RIGHT JOIN: Courses and their total student enrollments
SELECT 
    c.course_name,
    COUNT(s.student_id) AS total_enrollments
FROM scores s
RIGHT JOIN courses c ON s.course_id = c.course_id
GROUP BY c.course_name
ORDER BY total_enrollments DESC;

-- 7. FULL OUTER JOIN: All courses and all teachers
SELECT 
    c.course_name,
    t.teacher_name
FROM courses c
FULL OUTER JOIN teachers t ON c.course_id = t.teacher_course;
