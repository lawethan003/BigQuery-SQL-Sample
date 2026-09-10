CREATE OR REPLACE VIEW `analytics.v_Loan_Officer_Leaderboard` AS

WITH Loan_Ledger_Year AS (
  SELECT DISTINCT
    Loan_ID,
    Start_Date
  FROM `analytics.Lender_Details`
  WHERE Start_Date >= DATE_TRUNC(CURRENT_DATE(), YEAR)
    AND Start_Date < DATE_ADD(
      DATE_TRUNC(CURRENT_DATE(), YEAR),
      INTERVAL 1 YEAR
    )
)

SELECT
  l.Loan_Officer,
  EXTRACT(YEAR FROM CURRENT_DATE()) AS Origination_Year,
  COUNT(DISTINCT l.Loan_ID) AS Number_Of_Loans,
  SUM(l.Loan_Amount) AS Total_Principal
FROM `analytics.v_Master_Loans` l
INNER JOIN Loan_Ledger_Year ledger
  ON l.Loan_ID = ledger.Loan_ID
WHERE l.Loan_Officer IS NOT NULL
GROUP BY l.Loan_Officer
ORDER BY Total_Principal DESC;
