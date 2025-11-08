# 🗳️ Election 2024 Results Analysis (SQL)

## Project Overview

This project is a comprehensive **Structured Query Language (SQL)** analysis of the Election 2024 results data. The objective was to transform raw election data—spread across multiple relational tables (Constituencies, Candidates, States, Parties)—into actionable political intelligence.

The analysis provides detailed breakdowns of alliance performance, state-wise contribution, and candidate-level results.

## Analytical Queries & Key Insights

The SQL script addresses 14 key analytical questions, showcasing proficiency in complex joins and aggregation:

| Category | Key Insights Generated |
| :--- | :--- |
| **Alliance Performance** | Total seats won by the **NDA** and **INDIA** alliances using complex conditional summing (`SUM(CASE WHEN ...)`). |
| **Seat Distribution** | Total number of available seats per state and the total number of seats won by each political party. |
| **Constituency Detail** | Identifying the **Winning Candidate** and the **Runner-up Candidate** for specific states (e.g., Gujarat, Maharashtra). |
| **Vote Analysis** | Breakdown of total votes (EVM vs. Postal) and total number of candidates/parties for specific high-stakes states. |
| **Electoral Metrics** | Calculation of metrics like **Total Candidates**, **Total Parties**, and **Total Votes** for detailed state analysis. |

---

## Technical Details

### Technologies Used

* **Language:** SQL (Structured Query Language)
* **Database:** (Specify the database you used, e.g., MySQL, PostgreSQL, or SQL Server)

### Data Schema (Assumed Tables)

The analysis leverages joins across a minimum of five relational tables:

* `consti_result` (Constituency results/metadata)
* `const_details` (Candidate-level details/votes)
* `states` (State names)
* `state_result` (State-level seat aggregates)
* `party_result` (Party names and alliances)

### Example Query Highlight

The project uses advanced SQL techniques such as ranking candidates within a constituency to easily identify the winner and runner-up, a common requirement in data analysis:

```sql
-- Query to find Winning and Runnerup Candidate for a specific state
WITH RankedCandidates AS (
    SELECT 
        cr.Constituency_ID,
        cd.Candidate,
        ROW_NUMBER() OVER (PARTITION BY cr.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    -- ... JOINS and WHERE clauses ...
)
-- ... Final SELECT statement ...
