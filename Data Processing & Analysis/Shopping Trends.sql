--1. Find all records where Size is missing and the purchase_amount is greater than 
--50. 
--Expected Columns: Customer ID, Size, purchase_amount, Item 
--Purchased
SELECT customer_id,size,purchase_amount,item_purchased
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
WHERE size IS NULL AND purchase_amount > 50;
---------------------------------------------------------------
--2. List the total number of purchases grouped by Season, treating NULL values a
-- s 'Unknown Season'. 
--Expected Columns: Season, Total Purchases 
SELECT COALESCE(Season, 'Unknown Season') AS Season,
    COUNT(item_purchased) AS Total_Purchases
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY COALESCE(Season, 'Unknown Season');
----------------------------------------------------------------
--3. Count how many customers used each Payment Method, treating NULLs as 
--'Not Provided'. 
--Expected Columns: Payment Method, Customer Count
SELECT IFNULL(Payment_Method, 'Not Provided') AS Payment_Method,
    COUNT(customer_id) AS Customer_Count
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY IFNULL(Payment_Method, 'Not Provided');
--------------------------------------------------------------------
--4. Show customers where Promo Code Used is NULL and Review Rating is below 
--3.0. 
--Expected Columns: Customer ID, Promo Code Used, Review Rating, Item Purchased.

SELECT Customer_ID, Promo_Code_Used, Review_Rating, Item_Purchased
   FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
    WHERE Promo_code_used IS NULL AND Review_Rating <3.0;
-------------------------------------------------------------------------
--5. Group customers by Shipping 
--Type, and return the average purchase_amount, treating missing values as 0. 
--Expected Columns: Shipping Type, Average purchase_amount.

SELECT shipping_type,
    AVG(COALESCE(purchase_amount, 0)) AS Average_purchase_amount
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY shipping_type;
--------------------------------------------------------------------------
--6. Display the number of purchases per Location only for those with more than 
--5 purchases and no NULL Payment Method. 
--Expected Columns: Location, Total Purchases 

SELECT location AS Location,
    COUNT(*) AS Total_Purchases
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
WHERE payment_method IS NOT NULL
GROUP BY location
HAVING COUNT(*) > 5;
----------------------------------------------------------------
--7. Create a column Spender Category that classifies customers using CASE: 
--'High' if amount > 80, 'Medium' if BETWEEN 50 AND 80, 
--'Low' otherwise. Replace NULLs in purchase_amount with 0. 
--Expected Columns: Customer ID, purchase_amount, Spender Category

SELECT customer_id AS Customer_ID,
    COALESCE(purchase_amount, 0) AS purchase_amount,
    CASE 
     WHEN purchase_amount > 80 THEN 'High'
     WHEN purchase_amount BETWEEN 50 AND 80 THEN 'Medium'
     WHEN purchase_amount IS NULL THEN 'Low'
    ELSE 'Low'
    END AS Spender_Category
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS;
---------------------------------------------------------------
--8. Find customers who have no Previous 
--Purchases value but whose Color is not NULL. 
--Expected Columns: Customer ID, Color, Previous Purchases 

SELECT Customer_ID, Color, Previous_Purchases
 FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
 WHERE Previous_Purchases IS NULL
  AND Color IS NOT NULL;
----------------------------------------------------------------
--9. Group records by Frequency of 
--Purchases and show the total amount spent per group, treating NULL frequenc
--ies as 'Unknown'. 
--Expected Columns: Frequency of Purchases, Total purchase_amount

SELECT COALESCE(frequency_of_purchases,'Unknown')AS Frequency_of_Purchases,
    SUM(purchase_amount) AS Total_Purchase_Amount
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
  GROUP BY COALESCE(frequency_of_purchases,'Unknown');
--------------------------------------------------------------------------
--10. Display a list of all Category values with the number of times each was purcha
--sed, excluding rows where Categoryis NULL. 
--Expected Columns: Category, Total Purchases 

SELECT Category, 
  COUNT(*) AS Total_Purchases
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
WHERE Category IS NOT NULL
GROUP BY Category;
------------------------------------------------------------------------------
--11. Return the top 
--5 Locations with the highest total purchase_amount, replacing NULLs in amount 
--with 0. 
--Expected Columns: Location, Total purchase_amount

SELECT Location AS Location,
      SUM(COALESCE(Purchase_Amount,0)) AS Total_purchase_amount
      FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
      GROUP BY Location
      ORDER BY Total_Purchase_Amount DESC
      LIMIT 5;
-------------------------------------------------------------------------------
--12. Group customers by Gender and Size, and count how many entries have a NUL
--L Color. 
--Expected Columns: Gender, Size, Null Color Count 

SELECT Gender, Size,
    COUNT(CASE WHEN color IS NULL THEN 1 END) AS Null_Color_Count
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY Gender, Size
ORDER BY Gender, Size;
----------------------------------------------------------------------------------
--13. Identify all Item Purchased where more than 3 purchases had NULL Shipping 
--Type. 
--Expected Columns: Item Purchased, NULL Shipping Type Count

SELECT 
    item_purchased,
    COUNT(CASE WHEN shipping_type IS NULL THEN 1 END) AS NULL_Shipping_Type_CounT
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY item_purchased
HAVING COUNT(CASE WHEN shipping_type IS NULL THEN 1 END) > 3
-----------------------------------------------------------------------------------
--14. Show a count of how many customers per Payment Method have NULL Review 
--Rating. 
--Expected Columns: Payment Method, Missing Review Rating Count 

SELECT Payment_Method,
       COUNT(CASE WHEN Review_Rating IS NULL THEN 1 END) AS Missing_Rating_Count
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY Payment_Method;
------------------------------------------------------------------------------------
--15. Group by Category and return the average Review Rating, replacing NULLs with 
--0, and filter only where average is greater than 3.5. 
--Expected Columns: Category, Average Review Rating 

SELECT category,
    COALESCE(AVG(review_rating), 0) AS Average_Review_Rating 
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY category
HAVING COALESCE(AVG(review_rating), 0) > 3.5;
-----------------------------------------------------------------------------------
--16. List all Colors that are missing (NULL) in at least 
--2 rows and the average Age of customers for those rows. 
--Expected Columns: Color, Average Age

SELECT Color,
    AVG(Age) AS "Average Age"
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
WHERE Color IS NOT NULL
GROUP BY Color
HAVING COUNT(*) >= 2;
-----------------------------------------------------------------------------------
--17. Use CASE to create a column Delivery Speed: 'Fast' if Shipping Type is 'Express' or 
--'Next Day Air', 'Slow' if 'Standard', 
--'Other' for all else including NULL. Then count how many customers fall into 
--each category. 
--Expected Columns: Delivery Speed, Customer Count 

SELECT CASE 
        WHEN shipping_type IN ('Express', 'Next Day Air') THEN 'Fast'
        WHEN shipping_type = 'Standard' THEN 'Slow'
        ELSE 'Other'
    END AS delivery_speed,
    COUNT(*) AS customer_count
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY 
    CASE 
        WHEN shipping_type IN ('Express', 'Next Day Air') THEN 'Fast'
        WHEN shipping_type = 'Standard' THEN 'Slow'
        ELSE 'Other'
    END
ORDER BY customer_count;
--------------------------------------------------------------------------------
--18. Find customers whose purchase_amount is NULL and whose Promo Code Used is 
--'Yes'. 
--Expected Columns: Customer ID, purchase_amount, Promo Code Used

SELECT Customer_id, Purchase_amount, Promo_Code_Used
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
WHERE purchase_amount IS NULL
AND Promo_Code_Used = 'Yes';
---------------------------------------------------------------------------------
--19. Group by Location and show the maximum Previous 
--Purchases, replacing NULLs with 0, only where the average rating is above 4.0. 
--Expected Columns: Location, Max Previous Purchases, Average 
--Review Rating

SELECT Location,
  COALESCE(MAX(Previous_Purchases),0) AS Max_Previous_Purchases,
  AVG(Review_Rating) AS Average_Review_Rating
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
GROUP BY Location
HAVING AVG(Review_Rating) > 4.0;
--------------------------------------------------------------------------------
--20. Show customers who have a NULL Shipping 
--Type but made a purchase in the range of 30 to 70 USD. 
--Expected Columns: Customer ID, Shipping 
--Type, purchase_amount, Item Purchased

SELECT Customer_id, Shipping_Type, purchase_amount, Item_Purchased
FROM PRACTICE3.NULL_FUNCTIONS.SHOPING_TRENDS
WHERE Shipping_Type IS NULL
    AND purchase_amount BETWEEN 30 AND 70;
