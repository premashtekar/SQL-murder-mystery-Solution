🕵 SQL Murder Mystery — Walkthrough

Goal: Identify the murderer in SQL City using clues from a structured database.


---

🔎 Step 1: Find the Crime Scene Report

SELECT * 
FROM crime_scene_report 
WHERE type = 'murder' 
  AND city = 'SQL City' 
  AND date = 20180115;

This confirms the crime—a murder in SQL City on January 15, 2018, with a note about two witnesses—one on Northwestern Dr, the other named Annabel on Franklin Ave.  


---

👥 Step 2: Identify & Interview the Witnesses

Witness 1: Last house on Northwestern Dr

SELECT * 
FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC 
LIMIT 1;

Get their interview:

SELECT transcript 
FROM interview 
WHERE person_id = 14887;

Transcript reveals they saw a man with a “Get Fit Now Gym” bag starting with “48Z” and plate including “H42W”.  

Witness 2: Name contains Annabel, lives on Franklin Ave

SELECT * 
FROM person 
WHERE address_street_name = 'Franklin Ave' 
  AND LOWER(name) LIKE '%annabel%';

Interview:

SELECT transcript 
FROM interview 
WHERE person_id = 16371;

She recognized him at the gym on Jan 9, 2018.  


---

🕵‍♂ Step 3: Find the Murderer

Clues:

Membership ID starts with “48Z”

Must be a gold member

Checked in on 2018‑01‑09

License plate contains “H42W”

Male


Query:

WITH gym_checkins AS (
  SELECT gm.person_id, gm.name 
  FROM get_fit_now_member gm
  JOIN get_fit_now_check_in ci 
    ON gm.id = ci.membership_id
  WHERE gm.id LIKE '48Z%'
    AND gm.membership_status = 'gold'
    AND ci.check_in_date = 20180109
)
SELECT p.id, p.name, dl.plate_number
FROM gym_checkins gc
JOIN person p 
  ON gc.person_id = p.id
JOIN drivers_license dl 
  ON p.license_id = dl.id
WHERE dl.plate_number LIKE '%H42W%' 
  AND dl.gender = 'male';

Result:
67318 | Jeremy Bowers | 0H42W2 | male

Confirm with:

INSERT INTO solution VALUES (1, "Jeremy Bowers");


---

🧠 Step 4: The Plot Twist – The Real Mastermind

Interview with Jeremy indicates he was hired by a wealthy red‑haired woman, around 5'5"–5'7", drives a Tesla Model S, and attended the SQL Symphony Concert 3 times in December 2017.

WITH possible AS (
  SELECT dl.id AS license_id
  FROM drivers_license dl
  WHERE dl.gender = 'female'
    AND dl.hair_color = 'red'
    AND dl.height BETWEEN 65 AND 68
    AND dl.car_make = 'Tesla'
    AND dl.car_model = 'Model S'
),
rich AS (
  SELECT p.id AS person_id, p.name, i.annual_income
  FROM possible pp
  JOIN person p ON pp.license_id = p.license_id
  JOIN income i ON p.ssn = i.ssn
),
concert AS (
  SELECT person_id
  FROM facebook_event_checkin
  WHERE event_name = 'SQL Symphony Concert'
    AND date LIKE '201712%'
  GROUP BY person_id
  HAVING COUNT(*) = 3
)
SELECT rs.name, rs.annual_income
FROM rich rs
JOIN concert c ON rs.person_id = c.person_id;

Result:
Miranda Priestly | 310000

Confirm with:

INSERT INTO solution VALUES (1, "Miranda Priestly");


---

🥂 Conclusion

🕵 First suspect: Jeremy Bowers — pulled the trigger.

🧠 Mastermind: Miranda Priestly — hired Jeremy to commit the murder.

---
