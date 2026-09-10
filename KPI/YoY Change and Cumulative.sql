CREATE OR REPLACE VIEW `Private_Money_Dataset.v_YoY_Change_and_Cumulative` AS
WITH Annual_Origination AS (
  SELECT
    EXTRACT(YEAR FROM Start_Date) AS Year_Start,
    COUNT(Loan_ID) AS Loan_Count,
    ROUND(SUM(Loan_Amount),0) AS Total_Origination
  FROM `Private_Money_Dataset.v_Loans_Summary`
  GROUP BY 1
),

Window_Functions AS(
  SELECT
    Year_Start,
    Loan_Count,
    Total_Origination,
    SUM(Loan_Count) OVER(ORDER BY Year_Start ASC) AS Cumulative_Loan_Count,
    LAG(Total_Origination,1) OVER(ORDER BY Year_Start ASC) AS Lag_Origination,
    LAG(Loan_Count) OVER(ORDER BY Year_Start ASC) AS Lag_Loan_Count,
    SUM(Total_Origination) OVER(ORDER BY Year_Start ASC)AS Cumulative_Origination
  FROM Annual_Origination
),

Cumulative_Lag AS(
    SELECT
      *,
      LAG(Cumulative_Origination,1) OVER(ORDER BY Year_Start ASC) AS Lag_Cumulative,
      LAG(Cumulative_Loan_Count,1) OVER(ORDER BY Year_Start ASC) AS Lag_Cumulative_Count
    FROM Window_Functions
)
--necessary to separate into CTE because of nesting window functions otherwise
SELECT
  Year_Start,
  Loan_Count,
  Cumulative_Loan_Count,
  Total_Origination,
  Cumulative_Origination,
  ROUND(SAFE_DIVIDE(Total_Origination - Lag_Origination, Lag_Origination),4) AS YoY_Pct_Change,
  ROUND(SAFE_DIVIDE(Loan_Count - Lag_Loan_Count,Lag_Loan_Count),4) AS YoY_Count_Change,
  ROUND(SAFE_DIVIDE(Cumulative_Origination - Lag_Cumulative, Lag_Cumulative),4) AS YoY_Cumulative_Growth,
  ROUND(SAFE_DIVIDE(Cumulative_Loan_Count - Lag_Cumulative_Count, Lag_Cumulative_Count),4) AS YoY_Count_Growth
FROM Cumulative_Lag
ORDER BY Year_Start ASC;
