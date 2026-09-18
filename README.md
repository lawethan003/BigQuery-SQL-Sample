# Sample Data Warehouse
## Overview
This repository contains a collection of production-ready BigQuery SQL scripts designed to transform raw, unstructured loan records into structured, analytics-ready tables and views. These queries power core portfolio tracking metrics, risk segmentation models, lender distributions, and executive performance leaderboards for a loan origination pipeline.

---

## Script Breakdown
| Script Name | Description | Key Techniques |
| :--- | :--- | :--- | 
| `YoY Change and Cumulative.sql` | Calculates annual origination totals alongside cumulative running sums and YoY% changes for loan count and volume | `LAG()`, `OVER()`, `SAFE_DIVIDE` |
| `Borrower FICO Buckets.sql` | Credit Risk Segmentation. Filters borrowers from active and closed loans into standardized FICO score buckets, calculating portfolio concentration percentages per status | `INNER JOIN`, `CASE WHEN`, `PARTITION BY` |
| `Loan Officer Leaderboard.sql` | Ranks loan officers by total principal originated within the current year | `DATE_TRUNC`, `DATE_ADD`, `CURRENT_DATE` |
| `Borrower Entity Leaderboard.sql` | Aggregates total deals and borrowed capital by borrower entity, featuring fallback logic for missing registry inputs | `LEFT JOIN`, `IFNULL`|
| `Lender_Details.sql` | Parses string-formatted financial inputs (rates, contributions, returns) into normalized numeric formats | `REGEXP_REPLACE`, `SAFE_CAST` |
| `Full Address Names.sql` | Concatenates and trims property address , city, state, and ZIP and assigns property loan status | `CONCAT`, `TRIM` |
