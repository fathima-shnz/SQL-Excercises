In this exercise, you will work with an e-commerce customer dataset to perform data cleaning, transformation, and analysis using MySQL. Your task is to identify patterns related to customer churn and gain actionable business insights.

## Sample Code

 -- Impute Mode
SELECT Tenure
FROM customer_churn
GROUP BY Tenure
ORDER BY COUNT(*) DESC
LIMIT 1;

UPDATE customer_churn 
SET Tenure = 1
WHERE Tenure IS NULL;
