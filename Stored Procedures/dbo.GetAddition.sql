/* ***********************************************************************************
Purpose:    Adding Numbers
Notes:      
Sample:    
            EXEC dbo.GetAddition 5, 4
Author:     2014HAPPYMONKEY\Administrator
Date:       10/16/2016

Revision History
(Change Date)	(Author)		(Description of Change)
-----------------------------------------------------------------
************************************************************************************ */
CREATE PROCEDURE [dbo].[GetAddition] 
(
	@NumOne AS INTEGER
    ,@Numtwo AS INTEGER	
)
AS 
BEGIN TRY
	SET NOCOUNT ON

	SELECT 
		@NumOne + @Numtwo AS AddedNumbers

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
