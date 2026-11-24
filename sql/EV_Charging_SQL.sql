
USE ev_charging_analytics;


-- CHECK THE TABLE STRUCTURE AND DATA TYPES


-- Shows every column and its current data type.
DESCRIBE charging_raw;

-- Alternative: view column names, data types, and null settings.
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ev_charging_analytics'
  AND TABLE_NAME = 'charging_raw'
ORDER BY ORDINAL_POSITION;



-- CHECK ROW COUNT

SELECT COUNT(*) AS total_rows
FROM charging_raw;



-- STEP 3: FIND NULL OR BLANK VALUES

SELECT 'UserID' AS column_name,
       SUM(CASE WHEN UserID IS NULL OR TRIM(CAST(UserID AS CHAR)) = '' THEN 1 ELSE 0 END) AS null_or_blank_count
FROM charging_raw
UNION ALL
SELECT 'ChargerID',
       SUM(CASE WHEN ChargerID IS NULL OR TRIM(CAST(ChargerID AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'ChargerCompany',
       SUM(CASE WHEN ChargerCompany IS NULL OR TRIM(CAST(ChargerCompany AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'Location',
       SUM(CASE WHEN Location IS NULL OR TRIM(Location) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'ChargerType',
       SUM(CASE WHEN ChargerType IS NULL OR TRIM(CAST(ChargerType AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'StartDay',
       SUM(CASE WHEN StartDay IS NULL OR TRIM(CAST(StartDay AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'StartTime',
       SUM(CASE WHEN StartTime IS NULL OR TRIM(CAST(StartTime AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'EndDay',
       SUM(CASE WHEN EndDay IS NULL OR TRIM(CAST(EndDay AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'EndTime',
       SUM(CASE WHEN EndTime IS NULL OR TRIM(CAST(EndTime AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'StartDatetime',
       SUM(CASE WHEN StartDatetime IS NULL OR TRIM(CAST(StartDatetime AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'EndDatetime',
       SUM(CASE WHEN EndDatetime IS NULL OR TRIM(CAST(EndDatetime AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'Duration',
       SUM(CASE WHEN Duration IS NULL OR TRIM(CAST(Duration AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw
UNION ALL
SELECT 'Demand',
       SUM(CASE WHEN Demand IS NULL OR TRIM(CAST(Demand AS CHAR)) = '' THEN 1 ELSE 0 END)
FROM charging_raw;

--  CHECK DUPLICATE RECORDS

SELECT
    UserID,
    ChargerID,
    ChargerCompany,
    Location,
    ChargerType,
    StartDay,
    StartTime,
    EndDay,
    EndTime,
    StartDatetime,
    EndDatetime,
    Duration,
    Demand,
    COUNT(*) AS copies_of_record
FROM charging_raw
GROUP BY
    UserID, ChargerID, ChargerCompany, Location, ChargerType,
    StartDay, StartTime, EndDay, EndTime, StartDatetime, EndDatetime,
    Duration, Demand
HAVING COUNT(*) > 1
ORDER BY copies_of_record DESC;


-- CHECK POTENTIAL DATA QUALITY ISSUES-->unusual values


-- Check missing or negative durations.
SELECT COUNT(*) AS missing_or_negative_duration_rows
FROM charging_raw
WHERE Duration IS NULL OR Duration < 0;

-- Check whether the end time is earlier than the start time.

SELECT *
FROM charging_raw
WHERE StartDatetime IS NOT NULL
  AND EndDatetime IS NOT NULL
  AND CAST(EndDatetime AS DATETIME) < CAST(StartDatetime AS DATETIME)
LIMIT 20;



-- CONVERT DATA TYPES IN A SEPARATE CLEAN TABLE


DROP TABLE IF EXISTS charging_clean;

CREATE TABLE charging_clean (
    UserID INT,
    ChargerID INT,
    ChargerCompany INT,
    Location VARCHAR(100),
    ChargerType INT,
    StartDay DATE,
    StartTime TIME,
    EndDay DATE,
    EndTime TIME,
    StartDatetime DATETIME,
    EndDatetime DATETIME,
    Duration INT,
    Demand DECIMAL(12,4)
);

INSERT INTO charging_clean (
    UserID, ChargerID, ChargerCompany, Location, ChargerType,
    StartDay, StartTime, EndDay, EndTime,
    StartDatetime, EndDatetime, Duration, Demand
)
SELECT
    CAST(NULLIF(TRIM(CAST(UserID AS CHAR)), '') AS UNSIGNED),
    CAST(NULLIF(TRIM(CAST(ChargerID AS CHAR)), '') AS UNSIGNED),
    CAST(NULLIF(TRIM(CAST(ChargerCompany AS CHAR)), '') AS UNSIGNED),
    NULLIF(TRIM(Location), ''),
    CAST(NULLIF(TRIM(CAST(ChargerType AS CHAR)), '') AS UNSIGNED),
    CAST(NULLIF(TRIM(CAST(StartDay AS CHAR)), '') AS DATE),
    CAST(NULLIF(TRIM(CAST(StartTime AS CHAR)), '') AS TIME),
    CAST(NULLIF(TRIM(CAST(EndDay AS CHAR)), '') AS DATE),
    CAST(NULLIF(TRIM(CAST(EndTime AS CHAR)), '') AS TIME),
    CAST(NULLIF(TRIM(CAST(StartDatetime AS CHAR)), '') AS DATETIME),
    CAST(NULLIF(TRIM(CAST(EndDatetime AS CHAR)), '') AS DATETIME),
    CAST(NULLIF(TRIM(CAST(Duration AS CHAR)), '') AS SIGNED),
    CAST(NULLIF(TRIM(CAST(Demand AS CHAR)), '') AS DECIMAL(12,4))
FROM charging_raw;


-- Check whether the number of rows still matches after conversion.
SELECT
    (SELECT COUNT(*) FROM charging_raw) AS raw_rows,
    (SELECT COUNT(*) FROM charging_clean) AS clean_rows;


-- Confirm the new data types.
DESCRIBE charging_clean;


-- Check NULL values after conversion.
SELECT
    SUM(UserID IS NULL) AS null_UserID,
    SUM(ChargerID IS NULL) AS null_ChargerID,
    SUM(Location IS NULL OR TRIM(Location) = '') AS null_or_blank_Location,
    SUM(StartDatetime IS NULL) AS null_StartDatetime,
    SUM(EndDatetime IS NULL) AS null_EndDatetime,
    SUM(Duration IS NULL) AS null_Duration,
    SUM(Demand IS NULL) AS null_Demand
FROM charging_clean;


--  BUSINESS QUESTIONS


-- QUESTION 1: How many charging sessions are in the dataset?
SELECT COUNT(*) AS total_charging_sessions
FROM charging_clean;


-- QUESTION 2: How many different users used the charging stations?
SELECT COUNT(DISTINCT UserID) AS different_users
FROM charging_clean;


-- QUESTION 3: Which locations are included, and how many sessions occurred
-- at each location?
SELECT
    Location,
    COUNT(*) AS total_sessions
FROM charging_clean
GROUP BY Location
ORDER BY total_sessions DESC;


-- QUESTION 4: Which location has the most charging sessions?
SELECT
    Location,
    COUNT(*) AS total_sessions
FROM charging_clean
GROUP BY Location
ORDER BY total_sessions DESC
LIMIT 1;


-- QUESTION 5: What is the average charging duration at each location?
SELECT
    Location,
    ROUND(AVG(Duration), 2) AS average_duration_minutes
FROM charging_clean
GROUP BY Location
ORDER BY average_duration_minutes DESC;


-- QUESTION 6: How many charging sessions happened each month?
SELECT
    DATE_FORMAT(StartDatetime, '%Y-%m') AS session_month,
    COUNT(*) AS total_sessions
FROM charging_clean
GROUP BY DATE_FORMAT(StartDatetime, '%Y-%m')
ORDER BY session_month;


-- QUESTION 7: What hour of the day is busiest?
SELECT
    HOUR(StartTime) AS start_hour,
    COUNT(*) AS total_sessions
FROM charging_clean
GROUP BY HOUR(StartTime)
ORDER BY total_sessions DESC;


-- QUESTION 8: Which 10 chargers handled the most sessions?
SELECT
    ChargerID,
    Location,
    COUNT(*) AS total_sessions
FROM charging_clean
GROUP BY ChargerID, Location
ORDER BY total_sessions DESC
LIMIT 10;


-- QUESTION 9: What is the total and average Demand at each location?
-- The unit of Demand is not assumed.
SELECT
    Location,
    ROUND(SUM(Demand), 2) AS total_demand,
    ROUND(AVG(Demand), 2) AS average_demand
FROM charging_clean
GROUP BY Location
ORDER BY total_demand DESC;


-- QUESTION 10: How many sessions fall into each duration group?
SELECT
    CASE
        WHEN Duration < 15 THEN 'Under 15 minutes'
        WHEN Duration < 30 THEN '15 to 29 minutes'
        WHEN Duration < 60 THEN '30 to 59 minutes'
        WHEN Duration < 120 THEN '60 to 119 minutes'
        ELSE '120 minutes or more'
    END AS duration_group,
    COUNT(*) AS total_sessions
FROM charging_clean
GROUP BY
    CASE
        WHEN Duration < 15 THEN 'Under 15 minutes'
        WHEN Duration < 30 THEN '15 to 29 minutes'
        WHEN Duration < 60 THEN '30 to 59 minutes'
        WHEN Duration < 120 THEN '60 to 119 minutes'
        ELSE '120 minutes or more'
    END
ORDER BY MIN(Duration);



