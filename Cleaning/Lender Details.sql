CREATE OR REPLACE TABLE `analytics.lender_details` AS

SELECT
  Lender_Allocation_ID,
  Loan_ID,
  Loan_Officer,
  Start_Date,
  Payoff_Date,
  Payoff_Time,
  Year,
  Address,
  Status,
  SAFE_CAST(REGEXP_REPLACE(Total_Loan_Amount, r'[\$,]', '') AS NUMERIC) AS Total_Loan_Amount,
  SAFE_CAST(REGEXP_REPLACE(Lender_Contribution, r'[\$,]', '') AS NUMERIC) AS Lender_Contribution,
  SAFE_CAST(REGEXP_REPLACE(Total_Interest_Return, r'[\$,]', '') AS NUMERIC) AS Total_Interest_Return,
  SAFE_CAST(REGEXP_REPLACE(Lender_Interest_Return, r'[\$,]', '') AS NUMERIC) AS Lender_Interest_Return,
  SAFE_CAST(REGEXP_REPLACE(ACG_Servicing_Return, r'[\$,]', '') AS NUMERIC) AS ACG_Servicing_Return,
  Lender,
  Lender_ID,
  SAFE_CAST(REGEXP_REPLACE(Lender_Interest_Rate, r'[\$,%]', '') AS NUMERIC) AS Lender_Interest_Rate,
  SAFE_CAST(REGEXP_REPLACE(ACG_Interest_Rate, r'[\$,%]', '') AS NUMERIC) AS ACG_Interest_Rate,
  SAFE_CAST(REGEXP_REPLACE(Total_Interest_Rate, r'[\$,%]', '') AS NUMERIC) AS Total_Interest_Rate,
  SAFE_CAST(REGEXP_REPLACE(Percent_Owned, r'[\$,%]', '') AS NUMERIC) AS Percent_Owned,
  Notes
FROM `analytics.raw_lender_details`;
