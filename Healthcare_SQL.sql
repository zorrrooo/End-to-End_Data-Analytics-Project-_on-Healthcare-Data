## Healthcare Management _Project 3
CREATE SCHEMA healthcare;
USE healthcare;

# Confirming the file upload
SELECT * FROM diabetic_data;

# Calculate the total number of patient encounters in the healthcare dataset
SELECT COUNT(*) AS total_patient_encounters
FROM diabetic_data;

SELECT COUNT(DISTINCT encounter_id) AS total_patient_encounters
FROM diabetic_data;

# Identify the top 10 most frequent diagnoses in the dataset
SELECT diag_1 AS diagnosis, COUNT(*) AS frequency FROM diabetic_data
GROUP BY diag_1
ORDER BY frequency DESC
LIMIT 10;

# Calculate the average length of hospital stay for each admission type 
SELECT 
    admission_type_id,
    AVG(time_in_hospital) AS avg_length_of_stay
FROM diabetic_data
GROUP BY admission_type_id
ORDER BY avg_length_of_stay DESC;

# Determine the number of readmitted patients and the percentage of total encounters that they represent
SELECT 
    COUNT(*) AS readmitted_patients,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM diabetic_data), 2) AS percentage_of_total
FROM diabetic_data
WHERE readmitted != 'NO';

# Identify the age distribution of patients
SELECT 
    age,
    COUNT(*) AS patient_count
FROM diabetic_data
GROUP BY age
ORDER BY age;

# Identify the most common procedures performed during patient encounters
SELECT 
    num_procedures,
    COUNT(*) AS frequency
FROM diabetic_data
GROUP BY num_procedures
ORDER BY frequency DESC;

# Calculate the average number of medications prescribed for patients in each age group
SELECT 
    age,
    COUNT(*) AS total_patients,
    AVG(num_medications) AS avg_medications
FROM diabetic_data
GROUP BY age
ORDER BY age;

# Identify the distribution of readmission rates across different payer codes
SELECT 
    payer_code,
    SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) AS readmitted_count,
    COUNT(*) AS total_encounters,
    ROUND(
        (SUM(CASE WHEN readmitted != 'NO' THEN 1 ELSE 0 END) * 100.0)
        / COUNT(*),
        2
    ) AS readmission_rate
FROM diabetic_data
GROUP BY payer_code
ORDER BY readmission_rate DESC;




