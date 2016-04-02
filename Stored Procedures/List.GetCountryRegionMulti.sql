/* ***********************************************************************************
Purpose:    Returns list of Territory Groups to be used in a Multi Select Listbox.
Notes:      
Sample:    
            EXEC List.GetCountryRegionMulti
Author:     THEZOO\mstuewe
Date:       9/16/2014

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [List].[GetCountryRegionMulti]
AS
	BEGIN TRY
		SET NOCOUNT ON

		SELECT DISTINCT
			[Group] AS CountryRegion
		FROM
			AdventureWorks2008R2.Sales.SalesTerritory AS st;

	END TRY
	BEGIN CATCH

		DECLARE
			@ErrorMessage AS nvarchar(3000)
		   ,@ErrorSeverity AS int
	   
		SET @ErrorMessage = ISNULL(DB_NAME(DB_ID()) + N'.' + SCHEMA_NAME(SCHEMA_ID()) + N'.' + OBJECT_NAME(@@PROCID, DB_ID()), N'SQL Object Name Not Available')
			+ N': Error: ' + CONVERT(nvarchar(10), ERROR_NUMBER()) + N' Line: ' + CONVERT(nvarchar(5), ERROR_LINE()) + N' - ' + ERROR_MESSAGE()   
	   
		SET @ErrorSeverity = ERROR_SEVERITY()
		RAISERROR(@ErrorMessage, @ErrorSeverity, 1)
	END CATCH

	SET NOCOUNT OFF
GO
