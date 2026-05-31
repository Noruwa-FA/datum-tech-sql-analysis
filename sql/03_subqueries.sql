-- ============================================================
-- Datum Tech Academic Analysis - Part 3: Subqueries
-- Author: Success Noruwa
-- Description: Students above average score,
-- teachers below average salary using subqueries
-- ============================================================

-- 1. SUBQUERY: How many students scored above the average score?
SELECT COUNT(*) AS students_above_average
FROM scores
WHERE score > (
    SELECT AVG(score)
    FROM scores
);

-- 2. SUBQUERY: List of students who scored above average
SELECT 
    s.student_name,
    sc.score,
    ROUND((SELECT AVG(score) FROM scores), 2) AS class_average
FROM scores sc
JOIN scores s ON sc.student_id = s.student_id
WHERE sc.score > (
    SELECT AVG(score) FROM scores
)
ORDER BY sc.score DESC;

-- 3. SUBQUERY: Teachers with salaries below the average salary
SELECT 
    teacher_name,
    teacher_salary,
    ROUND((SELECT AVG(teacher_salary) FROM teachers), 2) AS avg_salary
FROM teachers
WHERE teacher_salary < (
    SELECT AVG(teacher_salary)
    FROM teachers
)
ORDER BY teacher_salary ASC;

-- 4. SUBQUERY: Top 20 students across all courses
SELECT 
    s.student_name,
    sc.score,
    c.course_name
FROM scores sc
JOIN scores s ON sc.student_id = s.student_id
JOIN courses c ON sc.course_id = c.course_id
WHERE sc.score IN (
    SELECT score
    FROM scores
    ORDER BY score DESC
    LIMIT 20
)
ORDER BY sc.score DESC;

-- 5. SUMMARY: Department performance overview
SELECT 
    d.department_name,
    COUNT(DISTINCT c.course_id) AS total_courses,
    COUNT(DISTINCT sc.student_id) AS total_students,
    ROUND(AVG(sc.score), 2) AS avg_score
FROM departments d
LEFT JOIN courses c ON d.department_id = c.department
LEFT JOIN scores sc ON c.course_id = sc.course_id
GROUP BY d.department_name
ORDER BY avg_score DESC;
