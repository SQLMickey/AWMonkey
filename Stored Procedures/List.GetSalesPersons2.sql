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
CREATE PROCEDURE [List].[GetSalesPersons2] 
(@TerritoryIDList AS VARCHAR(200))
AS
BEGIN TRY
	SET NOCOUNT ON;

	----------------------------------------------------
	-------           Test Parameters           --------
	----------------------------------------------------
	--DECLARE @TerritoryIDList varchar(200) = '1,2,5';
	----------------------------------------------------
	----------------------------------------------------

	WITH TerritoryList
	AS
	(
		SELECT
			CONVERT(INT,fs.SeparatedValue) AS TerritoryID
		FROM 
			Utility.dbo.fn_Split(',',@TerritoryIDList) AS fs
	)
	SELECT
		p.LoginUserID
		,p.BusinessEntityID
		,p.FirstName + ' ' + p.LastName AS SalesPerson
		,sp.TerritoryID
		,1 SortOrder
	FROM
		AdventureWorks2008R2.Person.Person AS p
		JOIN AdventureWorks2008R2.Sales.SalesPerson AS sp ON p.BusinessEntityID = sp.BusinessEntityID
		JOIN TerritoryList AS tl ON sp.TerritoryID = tl.TerritoryID
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
