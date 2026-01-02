/* ==========================================================================
   DATABASE SETUP
   ==========================================================================
*/
CREATE DATABASE IF NOT EXISTS telecom_churn;
USE telecom_churn;

/* 1. OVERALL CHURN RATE
   Target File: overall churn rate.csv
*/
CREATE OR REPLACE VIEW view_overall_churn_rate AS
SELECT 
    COUNT(`Customer ID`) AS Total_Customers,
    SUM(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) AS Churned_Count,
    ROUND(SUM(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(`Customer ID`), 2) AS Churn_Rate_Percentage
FROM telecom_churn_data;

/* 2. CHURN BY CONTRACT TYPE
   Target File: churn_contract type.csv
*/
CREATE OR REPLACE VIEW view_churn_contract_type AS
SELECT 
    `Contract`,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate,
    ROUND(SUM(CASE WHEN `Customer Status` = 'Churned' THEN `Total Revenue` ELSE 0 END), 2) AS Revenue_Loss
FROM telecom_churn_data
GROUP BY `Contract`
ORDER BY Churn_Rate DESC;

/* 3. CHURN BY GEOGRAPHY
   Target File: churn_geographyType.csv
*/
CREATE OR REPLACE VIEW view_churn_geography AS
SELECT 
    `City`,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate_Percent,
    ROUND(SUM(CASE WHEN `Customer Status` = 'Churned' THEN `Total Revenue` ELSE 0 END), 2) AS Revenue_Lost
FROM telecom_churn_data
GROUP BY `City`
ORDER BY Revenue_Lost DESC;

/* 4. HIGH-VALUE CUSTOMER LEAKAGE
   Target File: churn_highValueCustomerLeakage.csv
   Note: High-Value is defined as the Top 20% by Total Revenue (~1409 customers)
*/
CREATE OR REPLACE VIEW view_high_value_leakage AS
WITH SegmentedData AS (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY `Total Revenue` DESC) AS Revenue_Rank
    FROM telecom_churn_data
)
SELECT 
    CASE WHEN Revenue_Rank <= 0.20 THEN 'High-Value (Top 20%)' ELSE 'Other Customers' END AS Customer_Segment,
    `City`,
    `Internet Service`,
    `Contract`,
    `Premium Tech Support`,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate_Percent,
    ROUND(SUM(CASE WHEN `Customer Status` = 'Churned' THEN `Total Revenue` ELSE 0 END), 2) AS Revenue_Lost
FROM SegmentedData
GROUP BY Customer_Segment, `City`, `Internet Service`, `Contract`, `Premium Tech Support`
ORDER BY Revenue_Lost DESC;

/* 5. CHURN BY INTERNET TYPE
   Target File: churn_internet type.csv
*/
CREATE OR REPLACE VIEW view_churn_internet_type AS
SELECT 
    COALESCE(`Internet Type`, 'No Internet Service') AS `Internet Type`,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) AS Churned_Count,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate
FROM telecom_churn_data
GROUP BY `Internet Type`
ORDER BY Churn_Rate DESC;

/* 6. CHURN BY OFFER TYPE
   Target File: churn_offerType.csv
*/
CREATE OR REPLACE VIEW view_churn_offer_type AS
SELECT 
    CASE WHEN `Offer` = 'None' OR `Offer` IS NULL THEN 'No Offer' ELSE `Offer` END AS Offer_Type,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate
FROM telecom_churn_data
GROUP BY Offer_Type
ORDER BY Churn_Rate DESC;

/* 7. SERVICE GAP ANALYSIS
   Target File: churn_serviceGap.csv
*/
CREATE OR REPLACE VIEW view_service_gap AS
SELECT 
    `Contract`,
    `Internet Service`,
    CASE WHEN `Premium Tech Support` IS NULL OR `Premium Tech Support` = '' THEN 'No Internet Service' ELSE `Premium Tech Support` END AS `Premium Tech Support`,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate_Percent,
    ROUND(AVG(`Monthly Charge`), 2) AS Avg_Monthly_Charge
FROM telecom_churn_data
GROUP BY `Contract`, `Internet Service`, `Premium Tech Support`
ORDER BY Churn_Rate_Percent DESC;

/* 8. TENURE DROPOFF ANALYSIS
   Target File: churn_tenureDropoff.csv
*/
CREATE OR REPLACE VIEW view_tenure_dropoff AS
SELECT 
    CASE 
        WHEN `Tenure in Months` <= 6 THEN '0-6 Months'
        WHEN `Tenure in Months` <= 12 THEN '6-12 Months'
        WHEN `Tenure in Months` <= 24 THEN '1-2 Years'
        ELSE 'Over 2 Years' 
    END AS Tenure_Cohort,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate
FROM telecom_churn_data
GROUP BY Tenure_Cohort
ORDER BY FIELD(Tenure_Cohort, '0-6 Months', '6-12 Months', '1-2 Years', 'Over 2 Years');

/* 9. SUPPORT IMPACT ANALYSIS
   Target File: support_impact.csv
*/
CREATE OR REPLACE VIEW view_support_impact AS
SELECT 
    `Premium Tech Support`,
    `Online Security`,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(CASE WHEN `Customer Status` = 'Churned' THEN 1 ELSE 0 END) * 100.0, 2) AS Churn_Rate
FROM telecom_churn_data
WHERE `Internet Service` = 'Yes'
GROUP BY `Premium Tech Support`, `Online Security`
ORDER BY Churn_Rate DESC;

-- Verification: Run a select on any view to see the output
SELECT * FROM view_service_gap;