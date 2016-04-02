/* ***********************************************************************************
Purpose:    Returns list of Territory Groups.
Notes:      
Sample:    
            EXEC List.[GetTerritory] 'Europe'
Author:     THEZOO\mstuewe
Date:       9/16/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [List].[GetTerritory]
	(@CountryRegion AS nvarchar(50))
AS
	BEGIN TRY

		SET NOCOUNT ON;

		SELECT
			st.TerritoryID
		   ,st.Name AS Territory
		   ,1 AS SortOrder
		FROM
			AdventureWorks2008R2.Sales.SalesTerritory AS st
		WHERE
			[Group] = @CountryRegion OR @CountryRegion = 'ALL'
		UNION ALL
		SELECT
			-1
		   ,'All'
		   ,0
		WHERE
			@CountryRegion = 'All'
		ORDER BY
			SortOrder
			,Territory;
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
