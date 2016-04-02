CREATE ROLE [SSRSReporting]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'SSRSReporting', N'SSRSUser'
GO
EXEC sp_addrolemember N'SSRSReporting', N'Victoria Smith'
GO
