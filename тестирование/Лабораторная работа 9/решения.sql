-- MySQL. Выбрать соответствующую БД в SQL Academy.

-- 1 Вылеты с 13 до 15 часов
SELECT *
FROM Trip
WHERE time_out BETWEEN '1900-01-01 13:00:00'
                   AND '1900-01-01 15:00:00'
ORDER BY time_out, id;

-- 2 Компании с самолётами Boeing
SELECT DISTINCT c.name
FROM Company AS c
JOIN Trip AS t ON t.company = c.id
WHERE t.plane LIKE 'Boeing%'
ORDER BY c.name;

-- 3 Старший член семьи без даты рождения
SELECT member_name
FROM FamilyMembers
WHERE birthday = (SELECT MIN(birthday) FROM FamilyMembers)
ORDER BY member_name;

-- 4 Заполненность классов
SELECT c.name, COUNT(sic.student) AS student_count
FROM Class AS c
LEFT JOIN Student_in_class AS sic ON sic.class = c.id
GROUP BY c.id, c.name
ORDER BY student_count DESC, c.name;

-- 4 Дополнение без 8 А и 8 Б
SELECT c.name, COUNT(sic.student) AS student_count
FROM Class AS c
LEFT JOIN Student_in_class AS sic ON sic.class = c.id
WHERE REPLACE(c.name, ' ', '')
      NOT IN ('8A', '8B', '8А', '8Б')
GROUP BY c.id, c.name
ORDER BY student_count DESC, c.name;

-- 5 Учителя и количество занятий
SELECT t.first_name, t.last_name,
       COUNT(s.id) AS lesson_count
FROM Teacher AS t
LEFT JOIN Schedule AS s ON s.teacher = t.id
GROUP BY t.id, t.first_name, t.last_name
ORDER BY lesson_count DESC, t.last_name, t.first_name;

-- 5 Дополнение больше пяти занятий
SELECT t.first_name, t.last_name,
       COUNT(s.id) AS lesson_count
FROM Teacher AS t
JOIN Schedule AS s ON s.teacher = t.id
GROUP BY t.id, t.first_name, t.last_name
HAVING COUNT(s.id) > 5
ORDER BY lesson_count DESC, t.last_name, t.first_name;

-- 6 Перелёты Aeroflot
SELECT t.*, c.name AS company_name
FROM Trip AS t
JOIN Company AS c ON c.id = t.company
WHERE c.name = 'Aeroflot'
ORDER BY t.id;

-- 6 Дополнение остальные компании
SELECT t.*, c.name AS company_name
FROM Trip AS t
JOIN Company AS c ON c.id = t.company
WHERE c.name <> 'Aeroflot'
ORDER BY t.id;

-- 7 Студенты без отчества
SELECT first_name, last_name
FROM Student
WHERE middle_name IS NULL OR TRIM(middle_name) = ''
ORDER BY last_name, first_name;

-- 8 Учителя и студенты с именем Mariya
SELECT 'Teacher' AS person_type, first_name, last_name
FROM Teacher
WHERE first_name = 'Mariya'
UNION ALL
SELECT 'Student' AS person_type, first_name, last_name
FROM Student
WHERE first_name = 'Mariya'
ORDER BY person_type, last_name, first_name;