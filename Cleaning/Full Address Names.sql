CREATE OR REPLACE VIEW `analytics.v_Full_Address_Name` AS
SELECT
  a.Loan_ID,
  CONCAT(
    a.Address_ID, ', ',
    TRIM(a.City), ' ',
    TRIM(a.State), ', ',
    TRIM(a.ZIP)
  ) AS Full_Address,
  TRIM(b.Status) AS Status
FROM `analytics.Master_Loan_Property` a
LEFT JOIN `analytics.Master_Loans_Info` b
  ON a.Loan_ID = b.Loan_ID;
