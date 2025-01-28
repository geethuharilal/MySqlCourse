
/*
This is a scalar subquery returning a single value to use in the WHERE <column> =
List the patient stays with the lowest tariff
*/

SELECT
	ps.PatientId
	, ps.Hospital
	, ps.Tariff
FROM
	PatientStay ps
WHERE
	ps.Tariff = (
    SELECT MIN(ps2.Tariff) FROM PatientStay ps2
   );

   /*
This is a scalar subquery returning a single value to use in the WHERE <column> =
List the patient stays with the average tariff
*/

SELECT
	ps.PatientId
	, ps.Hospital
	, ps.Tariff
FROM
	PatientStay ps
WHERE
	ps.Tariff = (
    SELECT avg(ps2.Tariff) FROM PatientStay ps2
   );

/*
This is a scalar subquery returning a single value to use in the WHERE <column> =
List the patient stays greater than the average tariff
*/

SELECT
	ps.PatientId
	, ps.Hospital
	, ps.Tariff
FROM
	PatientStay ps
WHERE
	ps.Tariff > (
    SELECT avg(ps2.Tariff) FROM PatientStay ps2
   );