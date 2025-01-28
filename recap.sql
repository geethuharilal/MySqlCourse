/*
Foundation Recap Exercise
 
Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/

SELECT
    *
FROM
    PatientStay ps
;

/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards
 
2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/

-- Write the SQL statement here
--List the patients in the Oxleas

SELECT
    *
FROM
    PatientStay ps
WHERE 
    ps.Hospital = 'Oxleas';

--List the patients in the Oxleas or PRUH hospitals
-- option 1
SELECT
    *
FROM
    PatientStay ps
WHERE 
    ps.Hospital = 'Oxleas' or ps.Hospital='PRUH';

-- option 2
SELECT
    *
FROM
    PatientStay ps
WHERE 
    ps.Hospital in ('Oxleas', 'PRUH');

-- List the patients in the Oxleas or PRUH hospitals and admitted in February 2024
SELECT
    *
FROM
    PatientStay ps
WHERE 
    ps.Hospital in ('Oxleas', 'PRUH')
    and
    ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-28';

-- List the patients in the Oxleas or PRUH hospitals and admitted in February 2024 and only the Surgery wards
SELECT
    *
FROM
    PatientStay ps
WHERE 
    ps.Hospital in ('Oxleas', 'PRUH')
    and
    (ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-28')
    and ps.Ward LIKE '%Surgery';

-- Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns
SELECT
    ps.PatientId, ps.AdmittedDate, ps.DischargeDate, ps.Hospital, ps.Ward
FROM
    PatientStay ps
WHERE 
    ps.Hospital in ('Oxleas', 'PRUH')
    and
    (ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-28')
    and ps.Ward LIKE '%Surgery';

-- Order results by AdmittedDate (latest first) then PatientID column (high to low)
SELECT
    ps.PatientId, ps.AdmittedDate, ps.DischargeDate, ps.Hospital, ps.Ward
FROM
    PatientStay ps
WHERE 
    ps.Hospital in ('Oxleas', 'PRUH')
    and
    (ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-28')
    and ps.Ward LIKE '%Surgery'
ORDER by ps.AdmittedDate DESC, ps.PatientId DESC;

-- 4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, 
-- inclusive of both admitted and discharge date.
SELECT
    ps.PatientId, 
    ps.AdmittedDate, 
    ps.DischargeDate, 
    ps.Hospital, 
    ps.Ward,
    DATEDIFF(DAY,ps.AdmittedDate,ps.DischargeDate)+1 as LengthOfStay
FROM
    PatientStay ps
WHERE 
    ps.Hospital in ('Oxleas', 'PRUH')
    and
    (ps.AdmittedDate BETWEEN '2024-02-01' AND '2024-02-28')
    and ps.Ward LIKE '%Surgery'
ORDER by ps.AdmittedDate DESC, ps.PatientId DESC;

/*
5. How many patients has each hospital admitted? 
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/


 
-- Write the SQL statement here
-- 5. How many patients has each hospital admitted? 
SELECT
    ps.Hospital,
    COUNT(ps.PatientId) as 'patientCount', COUNT(ps.Ethnicity) as 'count'
FROM
    PatientStay ps
GROUP by ps.Hospital;

--- How much is the total tarriff for each hospital
SELECT
    ps.Hospital,
    COUNT(ps.PatientId) as 'patientCount', sum(ps.Tariff) as 'sumTarrif'
FROM
    PatientStay ps
GROUP by ps.Hospital;

-- 7. List only those hospitals that have admitted over 10 patients
SELECT
    ps.Hospital,
    COUNT(ps.PatientId) as 'patientCount', sum(ps.Tariff) as 'sumTarrif'
FROM
    PatientStay ps
GROUP by ps.Hospital
HAVING COUNT(ps.PatientId)>=10;

-- 8. Order by the hospital with most admissions first
SELECT
    ps.Hospital,
    COUNT(ps.PatientId) as 'patientCount', sum(ps.Tariff) as 'sumTarrif'
FROM
    PatientStay ps
GROUP by ps.Hospital
HAVING COUNT(ps.PatientId)>=10
order by COUNT(ps.PatientId) DESC;