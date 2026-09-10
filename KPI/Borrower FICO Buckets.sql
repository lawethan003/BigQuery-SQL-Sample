CREATE OR REPLACE VIEW `analytics.v_FICO_Buckets` AS

WITH loan_borrower_join AS (
  SELECT
    a.Loan_ID,
    a.Status,
    b.Mid_FICO
  FROM `analytics.v_Master_Loans` a
  INNER JOIN `analytics.Borrower_Registry` b
    ON a.Borrower_ID = b.Borrower_ID
  WHERE a.Status IN ('Active', 'Closed')
    AND b.Mid_FICO IS NOT NULL
),

FICO_Buckets AS (
  SELECT
    Loan_ID,
    Status,
    Mid_FICO,
    CASE
      WHEN Mid_FICO < 580 THEN '6. Very Poor (<580)'
      WHEN Mid_FICO BETWEEN 580 AND 619 THEN '5. Poor (580–619)'
      WHEN Mid_FICO BETWEEN 620 AND 669 THEN '4. Fair (620–669)'
      WHEN Mid_FICO BETWEEN 670 AND 739 THEN '3. Good (670–739)'
      WHEN Mid_FICO BETWEEN 740 AND 799 THEN '2. Very Good (740–799)'
      WHEN Mid_FICO BETWEEN 800 AND 850 THEN '1. Exceptional (800–850)'
    END AS FICO_Bucket
  FROM loan_borrower_join
)

SELECT
  Status,
  FICO_Bucket,
  COUNT(Loan_ID) AS Loan_Count,
  ROUND(
    SAFE_DIVIDE(
      COUNT(Loan_ID),
      SUM(COUNT(Loan_ID)) OVER (PARTITION BY Status)
    ) * 100,
    1
  ) AS Pct_of_Status
FROM FICO_Buckets
GROUP BY
  Status,
  FICO_Bucket
ORDER BY
  Status,
  FICO_Bucket;
