CREATE DATABASE MOMO_CX_DA 
GO

USE MOMO_CX_DA

SELECT TOP 10 *
FROM Data_ticket

SELECT TOP 10 *
FROM Data_SLA

-- DATA QUALITY ASSESSMENT

--- Check NULL

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Ticket_id IS NULL THEN 1 ELSE 0 END) AS Null_Ticket_ID,
    SUM(CASE WHEN Agent_tiep_nhan IS NULL THEN 1 ELSE 0 END) AS Null_Agent,
    SUM(CASE WHEN [Level] IS NULL THEN 1 ELSE 0 END) AS Null_Level,
    SUM(CASE WHEN Created_date IS NULL THEN 1 ELSE 0 END) AS Null_Created_Date
FROM Data_ticket;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Ticket_id IS NULL THEN 1 ELSE 0 END) AS Null_Ticket_ID,
    SUM(CASE WHEN Chuyen_time IS NULL THEN 1 ELSE 0 END) AS Null_Chuyen_Time,
    SUM(CASE WHEN Phanhoi_time IS NULL THEN 1 ELSE 0 END) AS Null_Phanhoi_Time,
    SUM(CASE WHEN SLA_Camket IS NULL THEN 1 ELSE 0 END) AS Null_SLA_Camket
FROM Data_SLA;

--- Check Duplicate

SELECT
    Ticket_id,
    COUNT(*) AS Duplicate_Count
FROM Data_ticket
GROUP BY Ticket_id
HAVING COUNT(*) > 1;


SELECT
    Ticket_id,
    COUNT(*) AS Duplicate_Count
FROM Data_SLA
GROUP BY Ticket_id
HAVING COUNT(*) > 1;


--- Check Primary Key Coverage

SELECT COUNT(*) AS Missing_SLA
FROM Data_ticket t
LEFT JOIN Data_SLA s
    ON t.Ticket_id = s.Ticket_id
WHERE s.Ticket_id IS NULL;


SELECT COUNT(*) AS Missing_Ticket
FROM Data_SLA s
LEFT JOIN Data_ticket t
    ON s.Ticket_id = t.Ticket_id
WHERE t.Ticket_id IS NULL;



-- JOIN TABLES by key Ticket_ID

SELECT TOP 10 *
FROM Data_ticket

SELECT TOP 10 *
FROM Data_SLA

SELECT 
	t.Ticket_id,
	t.Agent_tiep_nhan,
	t.Level,
	t.Created_date,
	s.Chuyen_time,
	s.Phanhoi_time,
	s.SLA_Camket
INTO Ticket_SLA
FROM Data_ticket AS t
LEFT JOIN Data_SLA AS s
ON t.Ticket_id = s.Ticket_id


SELECT *
FROM Ticket_SLA


-- 1. How many tickets are there per week?

SET DATEFIRST 1; -- Set the first day of week is Monday

ALTER TABLE Ticket_SLA
ADD Created_week INT;

UPDATE Ticket_SLA
SET Created_week = DATEPART(WEEK, Created_date);


-- Calculate total tickets in the period; average, max and min tickets per week

WITH Weekly_Tickets AS (
    SELECT
        Created_week,
        COUNT(*) AS Total_Tickets
    FROM Ticket_SLA
    GROUP BY Created_week
)
SELECT
    SUM(Total_Tickets) AS Total_Tickets,
    AVG(CAST(Total_Tickets AS FLOAT)) AS Average_Tickets_per_Week,

    MAX(Total_Tickets) AS Max_Tickets_per_Week,

    (SELECT TOP 1 Created_week
     FROM Weekly_Tickets
     ORDER BY Total_Tickets DESC) AS Created_Week_with_Max_Tickets,

    MIN(Total_Tickets) AS Min_Tickets_per_Week,

    (SELECT TOP 1 Created_week
     FROM Weekly_Tickets
     ORDER BY Total_Tickets ASC) AS Created_Week_with_Min_Tickets

FROM Weekly_Tickets;



-- 2. What is the SLA on-time rate? Break down by week and by service.

SELECT
    MIN(CAST(Chuyen_time AS TIME)) AS Min_Chuyen_Time,
    MAX(CAST(Chuyen_time AS TIME)) AS Max_Chuyen_Time,
    MIN(CAST(Phanhoi_time AS TIME)) AS Min_Phanhoi_time,
    MAX(CAST(Phanhoi_time AS TIME)) AS Max_Phanhoi_time
FROM Ticket_SLA;

ALTER TABLE Ticket_SLA
ADD Updated_Chuyen_time DATETIME;

ALTER TABLE Ticket_SLA
ADD Updated_Phanhoi_time DATETIME;

UPDATE Ticket_SLA
SET Updated_Chuyen_time =
    CASE
        -- Thứ 7 -> Thứ 2 09:00
        WHEN DATEPART(WEEKDAY, Chuyen_time) = 6
            THEN DATEADD(HOUR, 9,
                 CAST(DATEADD(DAY, 2, CAST(Chuyen_time AS DATE)) AS DATETIME))

        -- Chủ nhật -> Thứ 2 09:00
        WHEN DATEPART(WEEKDAY, Chuyen_time) = 7
            THEN DATEADD(HOUR, 9,
                 CAST(DATEADD(DAY, 1, CAST(Chuyen_time AS DATE)) AS DATETIME))

        -- Trước 09:00 -> 09:00 cùng ngày
        WHEN CAST(Chuyen_time AS TIME) < '09:00:00'
            THEN DATEADD(HOUR, 9,
                 CAST(CAST(Chuyen_time AS DATE) AS DATETIME))

        -- Sau 18:00 Thứ 6 -> Thứ 2 09:00
        WHEN DATEPART(WEEKDAY, Chuyen_time) = 5
             AND CAST(Chuyen_time AS TIME) > '18:00:00'
            THEN DATEADD(HOUR, 9,
                 CAST(DATEADD(DAY, 3, CAST(Chuyen_time AS DATE)) AS DATETIME))

        -- Sau 18:00 các ngày khác -> 18:00 cùng ngày
        WHEN CAST(Chuyen_time AS TIME) > '18:00:00'
            THEN DATEADD(HOUR, 18,
                 CAST(CAST(Chuyen_time AS DATE) AS DATETIME))

        ELSE Chuyen_time
    END;


UPDATE Ticket_SLA
SET Updated_Phanhoi_time =
    CASE
        -- Thứ 7 -> Thứ 2 09:00
        WHEN DATEPART(WEEKDAY, Phanhoi_time) = 6
            THEN DATEADD(HOUR, 9,
                 CAST(DATEADD(DAY, 2, CAST(Phanhoi_time AS DATE)) AS DATETIME))

        -- Chủ nhật -> Thứ 2 09:00
        WHEN DATEPART(WEEKDAY, Phanhoi_time) = 7
            THEN DATEADD(HOUR, 9,
                 CAST(DATEADD(DAY, 1, CAST(Phanhoi_time AS DATE)) AS DATETIME))

        -- Trước 09:00 -> 09:00 cùng ngày
        WHEN CAST(Phanhoi_time AS TIME) < '09:00:00'
            THEN DATEADD(HOUR, 9,
                 CAST(CAST(Phanhoi_time AS DATE) AS DATETIME))

        -- Sau 18:00 -> 18:00 cùng ngày
        WHEN CAST(Phanhoi_time AS TIME) > '18:00:00'
            THEN DATEADD(HOUR, 18,
                 CAST(CAST(Phanhoi_time AS DATE) AS DATETIME))

        ELSE Phanhoi_time
    END;


-- Calculate Actual_SLA

ALTER TABLE Ticket_SLA
ADD Actual_SLA INT;

UPDATE Ticket_SLA
SET Actual_SLA = DATEDIFF(MINUTE, Updated_Chuyen_time, Updated_Phanhoi_time) - DATEDIFF(DAY, Updated_Chuyen_time, Updated_Phanhoi_time)*15*60 - DATEDIFF(WEEK, Updated_Chuyen_time, Updated_Phanhoi_time)*2*9*60;

SELECT TOP 10 *
FROM Ticket_SLA


-- Calculate SLA_Ontime_Rate

ALTER TABLE Ticket_SLA
ADD Is_SLA_OnTime BIT;

UPDATE Ticket_SLA
SET Is_SLA_OnTime =
    CASE
        WHEN Actual_SLA <= SLA_Camket THEN 1
        ELSE 0
    END;

-- a. Overall Ontime Rate

SELECT
    ROUND(AVG(CAST(Is_SLA_OnTime AS FLOAT)), 2) AS SLA_OnTime_Rate
FROM Ticket_SLA;

-- b. SLA On-time Rate by week

SELECT
    Created_week,
    ROUND(AVG(CAST(Is_SLA_OnTime AS FLOAT)), 2) AS SLA_OnTime_Rate
FROM Ticket_SLA
GROUP BY Created_week
ORDER BY Created_week;


-- c. SLA On-time Rate by service

SELECT
    [Level] AS Service,
    ROUND(AVG(CAST(Is_SLA_OnTime AS FLOAT)), 2) AS SLA_OnTime_Rate
FROM Ticket_SLA
GROUP BY [Level]
ORDER BY SLA_OnTime_Rate DESC;


-- d. SLA On-time Rate by week and service

SELECT
    Created_week,
    [Level] AS Service,
    ROUND(AVG(CAST(Is_SLA_OnTime AS FLOAT)), 2) AS SLA_OnTime_Rate
FROM Ticket_SLA
GROUP BY Created_week, [Level]
ORDER BY Created_week, [Level];
