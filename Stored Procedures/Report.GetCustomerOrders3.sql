/* ***********************************************************************************
Purpose:    Returns Customer Orders for Sales Staff
Notes:      
Sample:    
            EXEC report.GetCustomerOrders3 '1/1/2008','2/1/2008', -1
Author:     THEZOO\mstuewe
Date:       9/16/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [Report].[GetCustomerOrders3] 
(
	@StartDate datetime
	,@EndDate datetime
	,@SalesPersonID AS int
)
AS 
BEGIN TRY
	SET NOCOUNT ON

	SELECT
		soh.SalesOrderID
		,soh.SalesOrderNumber
	   ,soh.OrderDate
	   ,soh.DueDate
	   ,soh.ShipDate
	   ,soh.AccountNumber
	   ,soh.SubTotal
	   ,soh.TaxAmt
	   ,soh.Freight
	   ,soh.TotalDue
	   ,sp.TerritoryID
	   ,st.Name AS Territory
	   ,st.[Group] AS CountryRegion
	   ,sp.CommissionPct
	   ,soh.SalesPersonID
	   ,sal.FirstName AS SalesFirstName
	   ,sal.LastName AS SalesLastName
	   ,soh.CustomerID
	   ,cust.FirstName AS CustomerFirstName
	   ,cust.LastName AS CustomerLastName
	FROM
		AdventureWorks2008R2.Sales.SalesOrderHeader AS soh
		JOIN AdventureWorks2008R2.Sales.SalesPerson AS sp ON sp.BusinessEntityID = soh.SalesPersonID
		JOIN AdventureWorks2008R2.Sales.SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID
		JOIN AdventureWorks2008R2.Person.Person AS sal ON sal.BusinessEntityID = sp.BusinessEntityID
		JOIN AdventureWorks2008R2.Sales.Customer AS c ON c.CustomerID = soh.CustomerID
		JOIN AdventureWorks2008R2.Person.Person AS cust ON cust.BusinessEntityID = c.PersonID
	WHERE
		soh.OrderDate BETWEEN @StartDate  AND @EndDate 
		AND 
		(
			@SalesPersonID = -1
			OR soh.SalesPersonID = @SalesPersonID
		);
	
END TRY
BEGIN CATCH

	DECLARE
	    @ErrorMessage AS nvarchar(3000)
	   ,@ErrorSeverity AS int
	   
	SET @ErrorMessage = ISNULL(DB_NAME(DB_ID()) + N'.' + SCHEMA_NAME(SCHEMA_ID()) + N'.' + OBJECT_NAME(@@PROCID, DB_ID()),
						N'SQL Object Name Not Available') + N': Error: ' + CONVERT(nvarchar(10), ERROR_NUMBER()) + N' Line: ' 
						+ CONVERT(nvarchar(5), ERROR_LINE()) + N' - ' + ERROR_MESSAGE()   
	   
	SET @ErrorSeverity = ERROR_SEVERITY()
	RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
END CATCH

SET NOCOUNT OFF
GO
