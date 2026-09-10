CREATE OR REPLACE VIEW `analytics.v_Borrower_Entity_Leaderboard` AS

SELECT
  IFNULL(b.Entity_Name, 'UNKNOWN BORROWER (CHECK IDs)') AS Borrower_Entity,
  l.Borrower_ID,
  COUNT(l.Loan_ID) AS Total_Deals,
  SUM(l.Loan_Amount) AS Total_Borrowed
FROM `analytics.v_Master_Loans_Info` l
LEFT JOIN `analytics.Borrower_Registry` b
  ON l.Borrower_ID = b.Borrower_ID
GROUP BY
  b.Entity_Name,
  l.Borrower_ID
ORDER BY Total_Borrowed DESC;
