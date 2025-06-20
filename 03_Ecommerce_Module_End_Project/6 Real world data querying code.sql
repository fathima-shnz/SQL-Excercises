 -- Impute Mean
SELECT ROUND(AVG(WarehouseToHome)) FROM customer_churn WHERE WarehouseToHome IS NOT NULL;
SELECT ROUND(AVG(HourSpendOnApp)) FROM customer_churn WHERE HourSpendOnApp IS NOT NULL;
SELECT ROUND(AVG(OrderAmountHikeFromlastYear)) FROM customer_churn WHERE OrderAmountHikeFromlastYear IS NOT NULL;
SELECT ROUND(AVG(DaySinceLastOrder)) FROM customer_churn WHERE DaySinceLastOrder IS NOT NULL;

UPDATE customer_churn
SET WarehouseToHome = 16
WHERE WarehouseToHome IS NULL;

UPDATE customer_churn
SET HourSpendOnApp = 3
WHERE HourSpendOnApp IS NULL;

UPDATE customer_churn
SET OrderAmountHikeFromlastYear = 16 
WHERE OrderAmountHikeFromlastYear IS NULL;

UPDATE customer_churn
SET DaySinceLastOrder = 5 
WHERE DaySinceLastOrder IS NULL;

 -- Impute Mode
SELECT Tenure
FROM customer_churn
GROUP BY Tenure
ORDER BY COUNT(*) DESC
LIMIT 1;

UPDATE customer_churn 
SET Tenure = 1
WHERE Tenure IS NULL;

SELECT CouponUsed
FROM customer_churn
GROUP BY CouponUsed
ORDER BY COUNT(*) DESC
LIMIT 1;

UPDATE customer_churn
SET CouponUsed = 1 
WHERE CouponUsed IS NULL;

SELECT OrderCount
FROM customer_churn
GROUP BY OrderCount
ORDER BY COUNT(*) DESC
LIMIT 1;

UPDATE customer_churn
SET OrderCount = 2
WHERE OrderCount IS NULL;

 -- Handle Outliers
DELETE FROM customer_churn
WHERE WarehouseToHome > 100;
 
  -- Handle Inconsistencies
UPDATE customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';

UPDATE customer_churn
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';

UPDATE customer_churn
SET PreferredPaymentMode = 'Cash On Delivery'
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';

 -- Column Renaming
ALTER TABLE customer_churn
CHANGE PreferedOrderCat PreferredOrderCat VARCHAR(20);

ALTER TABLE customer_churn
CHANGE HourSpendOnApp HoursSpentOnApp INT;

 -- Add Columns
ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(3);

UPDATE customer_churn
SET ComplaintReceived = IF(Complain = 1, 'Yes', 'No');

ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(7);

UPDATE customer_churn
SET ChurnStatus = IF (Churn =1, 'Churned', 'Active'); 

 -- Drop Columns
 ALTER TABLE customer_churn
 DROP COLUMN Churn,
 DROP COLUMN Complain;
 
-- Exploration and Analysis
SELECT ChurnStatus, COUNT(*) AS Customer_Count
FROM customer_churn
GROUP BY ChurnStatus;
 
SELECT 
AVG(Tenure) AS Avg_Tenure,
SUM(CashbackAmount) AS TotalCashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';
 
SELECT 
  ((SELECT COUNT(*) FROM customer_churn WHERE Churn = 'Churned' AND Complain = 'Yes') * 100) / 
  (SELECT COUNT(*) FROM customer_churn WHERE Churn = 'Churned') AS ComplaintPercent;
  
SELECT CityTier, COUNT(*) AS ChurnedCustomers
FROM customer_churn
WHERE Churn = 'Churned'
AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Churn DESC
LIMIT 1;

SELECT PreferredPaymentMode, COUNT(*) AS MostPreferredPayment
FROM customer_churn
WHERE Churn = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY Churn DESC
LIMIT 1;

SELECT SUM(OrderAmountHikeFromlastYear) AS TotalOrderHike
FROM customer_churn
WHERE MaritalStatus = 'Single'
AND PreferredOrderCat = 'Mobile Phone';

SELECT AVG(NumberOfDeviceRegistered)
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';

SELECT CityTier, COUNT(CustomerID) AS CustomerCount
FROM customer_churn
GROUP BY CityTier
ORDER BY CustomerCount DESC
LIMIT 1;

SELECT Gender, SUM(CouponUsed) AS TotalCoupons
FROM customer_churn
GROUP BY Gender
ORDER BY TotalCoupons DESC
LIMIT 1;

SELECT PreferredOrderCat, SUM(CustomerID) AS TotalCustomers, SUM(HoursSpentOnApp) AS TotalHours
FROM customer_churn
GROUP BY PreferredOrderCat;

SELECT SUM(OrderCount) AS TotalOrderCount
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
AND SatisfactionScore = 5;

SELECT AVG(SatisfactionScore) AS AvgSatisfacion
FROM customer_churn
WHERE Complain = 'Yes';

SELECT PreferredOrderCat, CouponUsed
FROM customer_churn 
WHERE CouponUsed > 5
ORDER BY CouponUsed DESC;

SELECT PreferredOrderCat, AVG(CashbackAmount) AS AvgCashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY AvgCashback DESC
LIMIT 3;

SELECT PreferredPaymentMode, SUM(OrderCount)
FROM customer_churn
GROUP BY PreferredPaymentMode
HAVING ROUND(AVG(Tenure)) = 10 
	AND SUM(OrderCount) > 500;
    
SELECT 
  IF(WarehouseToHome <= 5, 'Very Close Distance',
    IF(WarehouseToHome <= 10, 'Close Distance',
      IF(WarehouseToHome <= 15, 'Moderate Distance', 'Far Distance')))
	AS DistanceCategory,
  ChurnStatus
FROM customer_churn
GROUP BY DistanceCategory, ChurnStatus
ORDER BY DistanceCategory, ChurnStatus;
	
SELECT * FROM customer_churn
WHERE MaritalStatus = 'Married'
	AND CityTier = 1
    AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);
    
CREATE TABLE customer_returns(
	ReturnID INT PRIMARY KEY NOT NULL,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount INT
    );
    
INSERT INTO customer_returns(ReturnID,CustomerID,ReturnDate,RefundAmount) VALUES
	(1001,50022,'2023-01-01',2130),
	(1002,50316,'2023-01-23',2000),
	(1003,51099,'2023-02-14',2290),
	(1004,52321,'2023-03-08',2510),
	(1005,52928,'2023-03-20',3000),
	(1006,53749,'2023-04-17',1740),
	(1007,54206,'2023-04-21',3250),
	(1008,54838,'2023-04-30',1990);
    
SELECT * FROM customer_churn cc
JOIN customer_returns cr
ON cc.CustomerID = cr.CustomerID
WHERE Churn = 'Churned'
	AND Complain = 'Yes';

    
    
	
    
    
    

    































