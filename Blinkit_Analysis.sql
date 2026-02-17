SELECT * FROM blinkit_data


SELECT COUNT(*)  FROM blinkit_data

UPDATE blinkit_data
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data

SELECT CAST(SUM(Sales)/ 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data
WHERE Item_Fat_Content = 'Low Fat'

SELECT CAST(SUM(Sales)/ 1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT CAST(AVG(Sales) AS DECIMAL (10,0)) AS Avg_Sales FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT COUNT(Item_Fat_Content) AS No_Of_Items FROM blinkit_data
WHERE Outlet_Establishment_Year = 2022

SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating FROM blinkit_data


>>>>>>>>>>>>>>>>>Total Sales by Fat Content>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.

SELECT Item_Fat_Content, 
        CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
		CAST(AVG(Sales) AS DECIMAL (10,2)) AS Avg_Sales,
		COUNT(Item_Fat_Content) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content 
ORDER BY Total_Sales_Thousands DESC

>>>>>>>>>>>>>>>>>Total Sales by Item Type>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SELECT TOP 5 Item_Type, 
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Sales) AS DECIMAL (10,2)) AS Avg_Sales,
		COUNT(Item_Fat_Content) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

>>>>>>>>>>>>>>>>>>>>>>>Fat Content by Outlet for Total Sales>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PIVOT ? SQL Server feature to rotate rows into columns (like Excel pivot tables).
SELECT Outlet_Location_Type,
		ISNULL ([Low Fat], 0) AS Low_Fat,
		ISNULL ([Regular], 0) AS Reglar
FROM
(
SELECT Outlet_Location_Type,Item_Fat_Content, 
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
		
FROM blinkit_data
GROUP BY Outlet_Location_Type,Item_Fat_Content
) AS SoureTable
PIVOT
(
	SUM(Total_Sales)
	FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Total Sales by Outlet Establishment>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
SELECT Outlet_Establishment_Year, 
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Sales) AS DECIMAL (10,2)) AS Avg_Sales,
		COUNT(Item_Fat_Content) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
		
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC

>>>>>>>>>>>>>>>>>>>>>>>>>>>Percentage of Sales by Outlet Size>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SELECT Outlet_Size,
		CAST(SUM(Sales)AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0/SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

>>>>>>>>>>>>>>>>>>>>>>>>> Sales by Outlet Location>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SELECT Outlet_Location_Type, 
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0/SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Sales) AS DECIMAL (10,2)) AS Avg_Sales,
		COUNT(Item_Fat_Content) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
		
FROM blinkit_data
WHERE Outlet_Establishment_Year = 2020
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

>>>>>>>>>>>>>>>>>>>>>>>>> Sales by Outlet_Type>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SELECT Outlet_Type, 
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST((SUM(Sales) * 100.0/SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
		CAST(AVG(Sales) AS DECIMAL (10,2)) AS Avg_Sales,
		COUNT(Item_Fat_Content) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
		
FROM blinkit_data

GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;


