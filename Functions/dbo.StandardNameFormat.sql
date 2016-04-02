
CREATE FUNCTION [dbo].[StandardNameFormat] ( @Name AS VARCHAR(50) )
RETURNS VARCHAR(50)
AS
    BEGIN
        RETURN 
	(SELECT CONCAT(UPPER(LEFT(LOWER(@Name), 1)), RIGHT(LOWER(@Name),LEN(@Name) - 1)));

    END;
GO
