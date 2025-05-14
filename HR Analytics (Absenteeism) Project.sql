--Create a join table
SELECT * 
FROM Absenteeism_at_work AS ab
JOIN compensation AS co
	ON co.ID = ab.ID
JOIN Reasons AS re
	ON re.Number = ab.Reason_for_absence

--Find the healthiest employees for the bonus
--(Criteria: Smoke, Drink, BMI and Absenteeism time in hours)
SELECT * 
FROM Absenteeism_at_work
WHERE Social_smoker = 0 AND Social_drinker = 0
AND Body_mass_index < 25
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work) 


--Compensation rate increase for non-smokers/ Budget: $983,221
-- 983,221 / (5 x 8 x 52 x 686) = $0,68 increase per hours / $1,414.4 per year 
SELECT COUNT(*)AS Non_smokers FROM Absenteeism_at_work
WHERE Social_smoker = 0

--Optimize this query
SELECT ab.ID, re.Reason,
ab.Month_of_absence,
CASE WHEN ab.Month_of_absence IN (12,1,2) THEN 'Winter'
	WHEN ab.Month_of_absence IN (3,4,5) THEN 'Spring'
	WHEN ab.Month_of_absence IN (6,7,8) THEN 'Summer'
	WHEN ab.Month_of_absence IN (9,10,11) THEN 'Fall'
ELSE 'Unknown'
END AS Season_of_the_year,
ab.Body_mass_index,
CASE WHEN ab.Body_mass_index < 18.5 THEN 'Underweight'
	WHEN ab.Body_mass_index BETWEEN 18.5 AND 24.9 THEN 'Healthy'
	WHEN ab.Body_mass_index BETWEEN 25 AND 29.9 THEN 'Overweight'
	WHEN ab.Body_mass_index >= 30 THEN 'Obese'
ELSE 'Unknown'
END AS BMI_Category,
Seasons,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker, Social_smoker,
Pet,
Disciplinary_failure, Age,
Work_load_Average_day,
Absenteeism_time_in_hours
FROM Absenteeism_at_work AS ab
JOIN compensation AS co
	ON co.ID = ab.ID
JOIN Reasons AS re
	ON re.Number = ab.Reason_for_absence