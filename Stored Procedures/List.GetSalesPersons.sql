/* ***********************************************************************************
Purpose:    Returns list of SalesPersons
Notes:      
Sample:    
            EXEC List.GetSalesPersons 1
Author:     THEZOO\mstuewe
Date:       9/16/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [List].[GetSalesPersons] 
(@TerritoryID AS INT)
AS
BEGIN TRY
	SET NOCOUNT ON;

	----------------------------------------------------
	-------           Test Parameters           --------
	----------------------------------------------------
	--DECLARE @TerritoryID INT = 5;
	----------------------------------------------------
	----------------------------------------------------

	SELECT
		@TerritoryID = CASE WHEN @TerritoryID = -1 THEN NULL
							ELSE @TerritoryID
					   END;

	SELECT
		p.LoginUserID AS Login_User_ID
	   ,p.BusinessEntityID
	   ,p.FirstName + ' ' + p.LastName AS SalesPerson
	   ,sp.TerritoryID
	   ,1 AS SortOrder
	FROM
		AdventureWorks2008R2.Person.Person AS p
		JOIN AdventureWorks2008R2.Sales.SalesPerson AS sp ON p.BusinessEntityID = sp.BusinessEntityID
	WHERE
		p.PersonType = 'sp'
		AND sp.TerritoryID = ISNULL(@TerritoryID, sp.TerritoryID)
	UNION ALL
	SELECT
		'All'
	   ,-1
	   ,'All'
	   ,-1
	   ,0
	ORDER BY
		SortOrder
	   ,SalesPerson
	   ,BusinessEntityID;

END TRY
BEGIN CATCH

	DECLARE
		@ErrorMessage AS nvarchar(3000)
		,@ErrorSeverity AS int;
	   
	SET @ErrorMessage = ISNULL(DB_NAME(DB_ID()) + N'.' + SCHEMA_NAME(SCHEMA_ID()) + N'.' + OBJECT_NAME(@@PROCID, DB_ID()), N'SQL Object Name Not Available')
		+ N': Error: ' + CONVERT(nvarchar(10), ERROR_NUMBER()) + N' Line: ' + CONVERT(nvarchar(5), ERROR_LINE()) + N' - ' + ERROR_MESSAGE();   
	   
	SET @ErrorSeverity = ERROR_SEVERITY();
	RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
END CATCH;

SET NOCOUNT OFF;
GO
