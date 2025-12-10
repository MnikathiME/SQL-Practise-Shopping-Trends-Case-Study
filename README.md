1. Overview

This case study focused on using SQL to clean, analyze, and interpret customer shopping data from the shopping_trends.csv dataset. The work involved identifying missing values, replacing NULL fields, grouping data, and generating insights that reflect customer behavior and purchasing patterns. A total of 20 SQL tasks were completed, each testing a specific ability to work with NULL values, aggregations, conditions, and classification logic in Snowflake.

2. How the Case Study Was Completed & Insights Found
The dataset was uploaded into Snowflake.
Each question was solved individually using clean, well-structured SQL queries.
Functions such as COALESCE, IFNULL, and CASE were used to manage missing values and classify customers.
Aggregations (COUNT, SUM, AVG, MAX) were used to analyze trends.
Groupings were applied to understand purchasing behavior across categories.
Filtering conditions helped isolate records with missing fields or specific behaviors.

*Insights Found

High and medium spenders could be clearly identified once NULL purchase amounts were handled.
Some locations showed significantly higher purchase activity and total spending.
Several product categories maintained high average review ratings even after replacing missing values.
Some items were frequently purchased despite having missing shipping information, revealing process gaps.
Proper NULL handling was essential to avoid misleading results and allowed clearer insights into customer behavior.

3. Tool used

Snowflake

