-- ============================================================
-- Datum Tech Academic Analysis - Part 2: CASE, COALESCE, CAST
-- Author: Success Noruwa
-- Description: Student categorisation, NULL handling,
-- data type conversion and salary formatting
-- ============================================================

-- 1. CASE: Categorise students by score (Distinction, Pass, Fail)
SELECT 
    s.student_name,
    sc.score,
    CASE
        WHEN sc.score >= 70 THEN 'Distinction'
        WHEN sc.score >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS performance_category
FROM scores sc
JOIN scores s ON sc.student_id = s.student_id
ORDER BY sc.score DESC;

-- 2. CASE: Categorise teachers by salary (Senior, Mid, Junior)
SELECT 
    teacher_name,
    teacher_salary,
    CASE
        WHEN teacher_salary >= 80000 THEN 'Senior'
        WHEN teacher_salary >= 50000 THEN 'Mid'
        ELSE 'Junior'
    END AS teacher_level
FROM teachers
ORDER BY teacher_salary DESC;

-- 3. COALESCE: Total course units per department, NULL replaced with 0
SELECT 
    d.department_name,
    COALESCE(SUM(c.course_unit), 0) AS total_course_units
FROM departments d
LEFT JOIN courses c ON d.department_id = c.department
GROUP BY d.department_name
ORDER BY total_course_units DESC;

-- 4. COALESCE: All teachers and courses, NULLs replaced with descriptive text
SELECT 
    COALESCE(t.teacher_name, 'NO TEACHER ASSIGNED') AS teacher,
    COALESCE(c.course_name, 'NO COURSE ASSIGNED') AS course
FROM teachers t
FULL OUTER JOIN courses c ON t.teacher_course = c.course_id;

-- 5. CAST: Teacher salaries formatted to 2 decimal places
SELECT 
    teacher_name,
    CAST(teacher_salary AS DECIMAL(10,2)) AS salary_formatted
FROM teachers
ORDER BY teacher_salary DESC;

-- 6. CAST: Teacher salaries displayed with dollar sign
SELECT 
    teacher_name,
    '$' || CAST(teacher_salary AS VARCHAR) AS salary_in_dollars
FROM teachers;
