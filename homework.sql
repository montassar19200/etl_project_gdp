SELECT * FROM "Person"
SELECT * FROM "Course"
SELECT * FROM "Department"
SELECT * FROM "StudentGrade"


--1

SELECT COUNT(*) AS NumberOfStudents
FROM "Person"
WHERE "Discriminator" = 'Student';


SELECT COUNT(*) AS NumberOfCourses, STRING_AGG("Title", ', ') AS CourseNames
FROM "Course";


SELECT COUNT(*) AS NumberOfDepartments, STRING_AGG("Name", ', ') AS DepartmentNames
FROM "Department";

SELECT COUNT(*) AS NumberOfTeachers
FROM "Person"
WHERE "Discriminator" = 'Instructor';





--2 

CREATE VIEW StudentGradesView AS
SELECT 
    sg."StudentID", 
    sg."CourseID", 
    c."Title" AS CourseName, 
    c."Credits", 
    sg."Grade"
FROM 
    "StudentGrade" sg
JOIN
    "Course" c
ON 
    sg."CourseID" = c."CourseID";


SELECT * FROM StudentGradesView;	


--3

SELECT 
    sg."StudentID", 
    sg."Grade", 
    sg."CourseID", 
    sg."coursename", 
    sg."Credits", 
    p."LastName", 
    p."FirstName"
FROM 
    StudentGradesView AS sg
INNER JOIN 
    "Person" AS p
ON 
    sg."StudentID" = p."PersonID"
WHERE 
    p."Discriminator" = 'Student';






---

SELECT 
    sg."StudentID", 
    sg."Grade", 
    (sg."Grade" * 5) AS "GradeOutOf20",  -- Nouvelle colonne avec la note sur 20
    sg."CourseID", 
    sg."coursename", 
    sg."Credits", 
    p."LastName", 
    p."FirstName"
FROM 
    StudentGradesView AS sg
INNER JOIN 
    "Person" AS p
ON 
    sg."StudentID" = p."PersonID"
WHERE 
    p."Discriminator" = 'Student';



----

SELECT 
    p."FirstName", 
    p."LastName", 
    sg."StudentID", 
    -- Moyenne pondérée des notes (sur 20) en fonction des crédits
   ROUND((SELECT SUM((sg."Grade" * 5) * sg."Credits")  -- Note sur 20 * Crédits
     FROM StudentGradesView AS sg
     WHERE sg."StudentID" = p."PersonID") 
    /
    (SELECT SUM(sg."Credits")  -- Somme des crédits pour l'étudiant
     FROM StudentGradesView AS sg
     WHERE sg."StudentID" = p."PersonID"),2) 
    AS "AverageGrade"  -- La moyenne pondérée
FROM 
    "Person" AS p
JOIN 
    "StudentGrade" AS sg ON sg."StudentID" = p."PersonID" -- Ajout de la jointure ici
WHERE 
    p."Discriminator" = 'Student';  -- S'assurer qu'on sélectionne les étudiants uniquement


	
	
------

SELECT 
    p."FirstName", 
    p."LastName", 
    sg."StudentID", 
    -- Moyenne pondérée des notes (sur 20) en fonction des crédits
   ROUND((SELECT SUM((sg."Grade" * 5) * sg."Credits")  -- Note sur 20 * Crédits
     FROM StudentGradesView AS sg
     WHERE sg."StudentID" = p."PersonID") 
    /
    (SELECT SUM(sg."Credits")  -- Somme des crédits pour l'étudiant
     FROM StudentGradesView AS sg
     WHERE sg."StudentID" = p."PersonID"),2) 
    AS "AverageGrade"  -- La moyenne pondérée
FROM 
    "Person" AS p
JOIN 
    "StudentGrade" AS sg ON sg."StudentID" = p."PersonID" -- Ajout de la jointure ici
WHERE 
    p."Discriminator" = 'Student' -- S'assurer qu'on sélectionne les étudiants uniquement

ORDER BY "AverageGrade"
	

