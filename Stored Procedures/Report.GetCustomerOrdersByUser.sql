/* ***********************************************************************************
Purpose:    Returns Customer Orders for Sales Staff
Notes:      
Sample:    
            EXEC report.GetCustomerOrdersByUser '5/1/2007', '5/1/2015', 'All'
Author:     THEZOO\mstuewe
Date:       9/16/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [Report].[GetCustomerOrdersByUser] 
(
	@StartDate datetime
	,@EndDate datetime
	,@LoginuserID AS varchar(51))
AS 
BEGIN TRY
	SET NOCOUNT ON
----------------------------------------------------
-------           Test Parameters           --------
----------------------------------------------------
--DECLARE 
--		@StartDate AS datetime = '1/1/2008'
--		,@EndDate AS datetime  = '2/1/2008'
	--,@LoginuserID AS varchar(51)
----------------------------------------------------
----------------------------------------------------

SELECT
	soh.SalesOrderNumber
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
   ,pp.PhoneNumber AS CustomerPhoneNumber
FROM
	AdventureWorks2008R2.Sales.SalesOrderHeader AS soh
	JOIN AdventureWorks2008R2.Sales.SalesPerson AS sp ON sp.BusinessEntityID = soh.SalesPersonID
	JOIN AdventureWorks2008R2.Sales.SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID
	JOIN AdventureWorks2008R2.Person.Person AS sal ON sal.BusinessEntityID = sp.BusinessEntityID
	JOIN AdventureWorks2008R2.Sales.Customer AS c ON c.CustomerID = soh.CustomerID
	JOIN AdventureWorks2008R2.Person.Person AS cust ON cust.BusinessEntityID = c.PersonID
	JOIN AdventureWorks2008R2.person.PersonPhone AS pp ON pp.BusinessEntityID = cust.BusinessEntityID
															AND pp.PhoneNumberTypeID = 1
WHERE
	soh.OrderDate BETWEEN @StartDate  AND @EndDate 
	AND (sal.LoginUserID = @LoginuserID OR @LoginuserID = 'All')
	
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
