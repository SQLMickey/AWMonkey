/* ***********************************************************************************
Purpose:    Returns details for one Order.
Notes:      
Sample:    
            EXEC Report.GetOrderDetail [Parameters]
Author:     mstuewe
Date:       9/17/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [Report].[GetOrderDetail] 
(
	@SalesOrderID AS int
)
AS 
BEGIN TRY
	SET NOCOUNT ON


----------------------------------------------------
-------           Test Parameters           --------
----------------------------------------------------
--DECLARE	@SalesOrderID AS int = 43662
----------------------------------------------------
----------------------------------------------------
		
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
   ,pp.PhoneNumber AS CustomerPhoneNumber
   ,sod.SalesOrderDetailID
   ,sod.CarrierTrackingNumber
   ,sod.OrderQty
   ,p.Name AS ProductName
   ,sod.SpecialOfferID
   ,sod.UnitPrice
   ,sod.UnitPriceDiscount
   ,sod.LineTotal
FROM
	AdventureWorks2008R2.Sales.SalesOrderHeader AS soh
	JOIN AdventureWorks2008R2.Sales.SalesPerson AS sp ON sp.BusinessEntityID = soh.SalesPersonID
	JOIN AdventureWorks2008R2.Sales.SalesTerritory AS st ON sp.TerritoryID = st.TerritoryID
	JOIN AdventureWorks2008R2.Person.Person AS sal ON sal.BusinessEntityID = sp.BusinessEntityID
	JOIN AdventureWorks2008R2.Sales.Customer AS c ON c.CustomerID = soh.CustomerID
	JOIN AdventureWorks2008R2.Person.Person AS cust ON cust.BusinessEntityID = c.PersonID
	JOIN AdventureWorks2008R2.person.PersonPhone AS pp ON pp.BusinessEntityID = cust.BusinessEntityID
														  AND pp.PhoneNumberTypeID = 1
	JOIN AdventureWorks2008R2.sales.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
	JOIN AdventureWorks2008R2.Production.Product AS p ON p.ProductID = sod.ProductID
WHERE
	soh.SalesorderID = @SalesOrderID


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
