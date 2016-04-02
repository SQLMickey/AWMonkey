/* ***********************************************************************************
Purpose:    Returns Product inventory
Notes:      
Sample:    
            EXEC Report.ProductInventory [Parameters]
Author:     SQLDEMOMONKEY\Administrator
Date:       10/31/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [Report].[ProductInventory] 
AS 
BEGIN TRY
	SET NOCOUNT ON
	SELECT
		pc.Name AS CategoryName
	   ,pc.CategoryColor
	   ,ps.Name AS SubCategoryName
	   ,p.ProductNumber
	   ,p.Name AS ProductName
	   ,pi.LocationID
	   ,pi.Quantity
	   ,p.ReorderPoint
	FROM
		[AdventureWorks2008R2].[Production].[ProductCategory] AS pc
		JOIN AdventureWorks2008R2.Production.ProductSubcategory AS ps ON ps.ProductCategoryID = pc.ProductCategoryID
		JOIN AdventureWorks2008R2.Production.Product AS p ON p.ProductSubcategoryID = ps.ProductSubcategoryID
		JOIN AdventureWorks2008R2.Production.ProductInventory AS pi ON pi.ProductID = p.ProductID

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
