/* ***********************************************************************************
Purpose:    Returns list of SalesPersons to be used in a multi select list box.
Notes:      
Sample:    
            EXEC List.GetSalesPersonsMulti '7,8'
Author:     THEZOO\mstuewe
Date:       9/16/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [List].[GetSalesPersonsMulti] 
(
	@TerritoryIDs AS VARCHAR(200)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT
		p.LoginUserID AS Login_User_ID
	   ,p.BusinessEntityID
	   ,p.FirstName + ' ' + p.LastName AS SalesPerson
	   ,sp.TerritoryID
	FROM
		AdventureWorks2008R2.Person.Person AS p
		JOIN AdventureWorks2008R2.Sales.SalesPerson AS sp ON p.BusinessEntityID = sp.BusinessEntityID
		JOIN Utility.dbo.fn_Split(',',@TerritoryIDs) AS fs ON sp.TerritoryID = CONVERT(INT,fs.SeparatedValue)
	WHERE
		p.PersonType = 'sp'
	ORDER BY
	    SalesPerson
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
