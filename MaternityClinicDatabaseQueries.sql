/*Ngone Lo
March 2020
*/

/*
1. patient_id, reason and scheduled time of all scheduled visit(s) for Doctor Avery on March 12, 2019
*/
SELECT pid AS patient_id, reason, TIME(scheduled_datetime) AS scheduled_time
FROM visits
WHERE sid = (SELECT sid FROM staff WHERE lname = "Avery") AND DATE(scheduled_datetime)="2019-03-12";

/*OR*/

SELECT pid AS patient_id, reason, TIME(scheduled_datetime) AS scheduled_time
FROM visits NATURAL JOIN staff
WHERE lname = "Avery" AND DATE(scheduled_datetime)="2019-03-12";



/*
2. Baby id, delivery type, delivery date, mother first name and mother last name
 of female babie(s) born under Doctor Yang
*/
SELECT bid AS baby_id, delivery_type, DATE(delivery_datetime) AS birth_date,
       fname AS mother_first_name, lname AS mother_last_name
FROM babies AS B INNER JOIN patients AS P ON B.pid = P.pid
WHERE sid = (SELECT sid FROM staff WHERE lname = "Yang") AND B.gender="F";



/*
3. The day with the highest number of visits in March 2019 and its count
*/
SELECT V1.visit_date, v1.visit_count FROM march_visits AS V1
WHERE V1.visit_count >= (SELECT MAX(V2.visit_count) FROM march_visits AS V2);



/*
4. Admission history of patient(s) Racheal Sloan
*/
SELECT * FROM admissions
WHERE pid = (SELECT pid FROM patients
		     WHERE fname = "Rachael" AND lname = "Sloan");
                
/*OR*/

SELECT * FROM admissions NATURAL JOIN (SELECT pid FROM patients 
                                       WHERE fname = "Rachael" AND lname = "Sloan") AS P;



/*
5. Treatment record(s) of all patient(s) with the last name “Nickerson” who gave birth at the clinic in 2018
*/
SELECT * FROM treat
WHERE pid IN (SELECT pid FROM patients WHERE lname = "Nickerson")
	  AND pid IN (SELECT pid FROM babies WHERE YEAR(delivery_datetime)="2018");

/*OR*/

SELECT DISTINCT * 
FROM treat NATURAL JOIN (SELECT pid FROM patients WHERE lname = "Nickerson") AS PPID
			NATURAL JOIN (SELECT pid FROM babies WHERE YEAR(delivery_datetime)="2018") AS BPID;



/*
6. List of unique first name and last name of patient(s) treated by Doctor Shepperd
*/
SELECT DISTINCT fname AS patient_first_name, lname AS patient_last_name
FROM patients
WHERE pid IN (SELECT pid 
			  FROM treat
			  WHERE sid = (SELECT sid FROM staff WHERE lname="Shepperd"));

/*OR*/

SELECT DISTINCT fname AS patient_first_name, lname AS patient_last_name
FROM patients NATURAL JOIN (SELECT pid 
							FROM treat NATURAL JOIN staff
							WHERE lname="Shepperd") AS TPID;

/*OR*/

SELECT DISTINCT fname AS patient_first_name, lname AS patient_last_name
FROM patients
WHERE pid IN (SELECT pid 
			  FROM treat NATURAL JOIN staff
			  WHERE lname="Shepperd");

                

/*
7. Visits checked in by admin Morris for non-consultation, non-checkup/followup reasons
*/
SELECT * FROM visits
WHERE adminid = (SELECT adminid FROM admins NATURAL JOIN staff
				 WHERE lname = "Morris") 
	  AND reason NOT IN ("consultation", "checkup/followup")
	  AND checkedin_datetime IS NOT NULL;

/*OR*/

SELECT * FROM visits NATURAL JOIN (SELECT adminid FROM admins NATURAL JOIN staff WHERE lname = "Morris") AS A
WHERE reason NOT IN ("consultation", "checkup/followup") AND checkedin_datetime IS NOT NULL;



/*
8. The name and emergency contact information of the mother(s) of all babie(s) born by cesarean in 2018
*/
SELECT fname AS mother_first_name, lname AS mother_last_name,
       emergency_contact_name, emergency_contact_phone_number, emergency_contact_relationship
FROM patients
WHERE pid IN (SELECT pid FROM babies 
			  WHERE delivery_type = "cesarean" AND YEAR(delivery_datetime) = "2018");

/*OR*/

SELECT DISTINCT fname AS mother_first_name, lname AS mother_last_name,
				emergency_contact_name, emergency_contact_phone_number, emergency_contact_relationship
FROM patients AS P INNER JOIN babies AS B ON P.pid = B.pid
WHERE delivery_type = "cesarean" AND YEAR(delivery_datetime)="2018";



/*
9. The sid, first name and last name of nurse(s) who cared for patient Rachael Sloan
between January 24, 2018 and January 27, 2018
*/
SELECT sid, fname AS nurse_first_name, lname AS nurse_last_name
FROM staff
WHERE sid IN (SELECT sid FROM care_for NATURAL JOIN patients
			  WHERE fname = "Rachael" AND lname = "Sloan" 
					AND DATE(care_datetime) BETWEEN "2018-01-24" AND "2018-01-27");
                    
/*OR*/

SELECT DISTINCT sid, fname AS nurse_first_name, lname AS nurse_last_name
FROM staff NATURAL JOIN (SELECT sid FROM care_for NATURAL JOIN patients
			             WHERE fname = "Rachael" AND lname = "Sloan" 
						       AND DATE(care_datetime) BETWEEN "2018-01-24" AND "2018-01-27") AS C;



/*
10. The sid, first name and last name of doctor(s) who got 3 or more visits from patients referred to the clinic by a friend or family member
*/
SELECT S.sid, fname AS doctor_first_name, lname AS doctor_last_name, COUNT(S.sid) AS visit_count
FROM staff AS S INNER JOIN visits AS V ON S.sid = V.sid
WHERE pid IN (SELECT pid FROM patients WHERE referred_by IN ("Friend", "Family"))
GROUP BY S.sid
HAVING visit_count >= 3
ORDER BY visit_count DESC;

/*OR*/

SELECT S.sid, fname AS doctor_first_name, lname AS doctor_last_name, COUNT(S.sid) AS visit_count
FROM (staff AS S INNER JOIN visits AS V ON S.sid = V.sid)
	 NATURAL JOIN (SELECT pid FROM patients WHERE referred_by IN ("Friend", "Family")) AS P
GROUP BY S.sid
HAVING visit_count >= 3
ORDER BY visit_count DESC;



/*
11. Insert record of nurse Carrie Nelson (4552013) caring for patient Erin Liu (2018448) on 2019-09-28 15:20:00 in the care_for relation
*/
INSERT INTO care_for(care_datetime,sid,pid) VALUES ("2019-09-28 15:20:00",4552013,2018448);



/*
12. Suppose we do have a new relation, freq_staff_patient, where we store the interactions
between staff and patient(s) with a frequency equal or greater than 2. The DDL to create freq_staff_patient is as follow:

CREATE TABLE `freq_staff_patient` (
  `sid` int(7) NOT NULL,
  `pid` int(7) NOT NULL,
  `interaction_count` int(7) NOT NULL,
  PRIMARY KEY (`sid`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

Insert the result of the query for nurse(s) and patient(s) with 2 or more interactions into freq_staff_patient
*/
INSERT INTO freq_staff_patient (SELECT sid, pid, COUNT(*) AS interaction_count
								FROM care_for
                                GROUP BY sid, pid
                                HAVING interaction_count >= 2
                                ORDER BY interaction_count);



/*
13. Update left_date(current date), phone number(457-432-3684) and sid(7262011) for staff (nurse) Colin Walker
This should update Colin Walker's sid on the nurses and care_for relations as well
*/
UPDATE staff SET left_date = CURDATE(), phone_number = "457-432-3684", sid = "7262011"
WHERE fname="Colin" AND lname = "Walker";



/*
14. Update babies's delivery type from natural to assisted childbirth
*/
UPDATE babies SET delivery_type = "assisted childbirth"
WHERE delivery_type="natural";



/*
15. Delete admission record(s) of patient(s) whose first name start with J
*/
DELETE FROM admissions WHERE pid IN (SELECT pid FROM patients WHERE fname LIKE "J%");



/*
16. Delete all tuples in the relation freq_staff_patient. In other words, empty it!!!
*/
DELETE FROM freq_staff_patient;



/*
16backup. Delete record(s) of babies(s) born before 2018
*/
DELETE FROM babies WHERE YEAR(delivery_datetime)<"2018";