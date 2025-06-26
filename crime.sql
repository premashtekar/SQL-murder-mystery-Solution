--Murder
--15/01/2018
--SQL City

--ERD - ENTITY RELATIONSHIP DIAGRAM

--SELECT * FROM person LIMIT 10;
CREATE DATABASE crime_scene_report;

USE crime_scene_report;

SELECT DISTINCT type FROM crime_scene_report ;

--About using keywords

SELECT * FROM person WHERE name='Prem Ashtekar'; --These are clauses used in a query to filter results , for specifications

-- AND keyword allows us multiple filtering criteria

-- OR keyword in cases of one among multiple conditions

SELECT * FROM crime_scene_report WHERE type = 'theft' AND city = 'PUNE'; -- If we type lowercase pune instead of Pune then we wont get any matched data from the TABLE

SELECT * FROM crime_scene_report WHERE type = 'murder' AND city = 'SQL City';

-- WILDCARDS


SELECT DISTINCT city FROM crime_scene_report WHERE city LIKE 'P%'; -- it will give results like Pune , Patna , Panji

SELECT DISTINCT person FROM crime_scene_report WHERE person LIKE 'A_' ;
--Gives results like Ad , Am , Aw


-- Between operator

SELECT DISTINCT city FROM crime_scene_report WHERE city BETWEEN 'W%' AND 'Z%';
-- All names between w y z will be included

SELECT DISTINCT id FROM crime_scene_report WHERE (id>89900 AND id<90000);
--id should be between given numbers - use of less or greater operator


SELECT DISTINCT city FROM crime_scene_report WHERE LOWER(city)='sql city';
-- OUTPUT - SQL City as stored


/* Aggregate functions 
COUNT - to know how many
MAX - maximum value
MIN - minimum value
SUM - calculates sum of specified values
AVG - calculates average*/

SELECT max(age) FROM drivers_license;
SELECT AVG(age) FROM drivers_license;
SELECT COUNT(age) FROM drivers_license;


-- First Witness - COMMENT

/*SELECT * FROM person WHERE address_street_name = 'Northwestern Dr' ORDER BY address_number DESC LIMIT 1 ;
-- Let me explain you that we have limited it to one so that we can get the first witness 

-- So the first witness is Monty Schapiro

--Second witness 

SELECT * FROM COMMENT  person WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave'

-- Second witness - Annabel Miller 



-- Join - To identify biggest annual earners in database
*/
SELECT person_name , income.annual_income FROM income JOIN person ON income.ssn=person.ssn WHERE annual_income>450000;

--Five people - claudio , felice , buena , numbers , Truman

-- Now about Interview Transcripts for two subjects


SELECT person_name = interview.transcript FROM person JOIN interview ON person.id = interview.person_id
WHERE person_id = 14887 OR person_id = 16371;

-- HINTS :  Gunshot - Get fit now gym - initials - 48Z , only gold members have it , Car no plate - H42W 
--14290

-- I am trying to find the killer by car number plate in the 'order by' section

-- Jeremy Bowers
