-- ==========================================
-- TELECOM ANALYTICS
-- SQL SERVER VALIDATION QUERIES
-- ==========================================

USE TelecomAnalytics;
GO

-- ==========================================
-- VERIFY ANALYTICAL TABLES
-- ==========================================

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
  AND TABLE_NAME IN ('Experience', 'Engagement', 'Satisfaction')
ORDER BY TABLE_NAME;

-- ==========================================
-- ROW COUNT VALIDATION
-- ==========================================

SELECT
    'Experience' AS Dataset_Name,
    COUNT(*) AS Total_Rows
FROM dbo.Experience

UNION ALL

SELECT
    'Engagement' AS Dataset_Name,
    COUNT(*) AS Total_Rows
FROM dbo.Engagement

UNION ALL

SELECT
    'Satisfaction' AS Dataset_Name,
    COUNT(*) AS Total_Rows
FROM dbo.Satisfaction;

-- ==========================================
-- SAMPLE DATA VALIDATION
-- Purpose:
-- Verify that the uploaded analytical tables
-- contain the expected customer-level data.
-- ==========================================

--  Verify Experience Dataset
SELECT TOP (10)
    [MSISDN_Number],
    [Average_TCP_Retransmission],
    [Average_RTT],
    [Handset_Type],
    [Average_Throughput],
    [Experience_Cluster]
FROM dbo.Experience;


--  Verify Engagement Dataset
SELECT TOP (10)
    [MSISDN_Number],
    [xDR_Sessions],
    [Total_Session_Duration_ms],
    [Total_Traffic_Bytes],
    [Engagement_Cluster]
FROM dbo.Engagement;


--  Verify Satisfaction Dataset
SELECT TOP (10)
    [MSISDN_Number],
    [Engagement_Score],
    [Experience_Score],
    [Satisfaction_Score],
    [Satisfaction_Cluster]
FROM dbo.Satisfaction;




-- ==========================================
-- TOP 10 SATISFIED CUSTOMERS
-- Purpose:
-- Identify the top 10 customers based on
-- the calculated Satisfaction Score.
-- Higher score = higher distance from the
-- less-engaged and weaker-experience reference
-- clusters used in the project.
-- ==========================================

SELECT TOP (10)
    [MSISDN_Number],
    [Engagement_Score],
    [Experience_Score],
    [Satisfaction_Score],
    [Satisfaction_Cluster]
FROM dbo.Satisfaction
ORDER BY [Satisfaction_Score] DESC;