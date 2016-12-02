/*
This migration script replaces uncommitted changes made to these objects:
Customer

Use this script to make necessary schema and data changes for these objects only. Schema changes to any other objects won't be deployed.

Schema changes and migration scripts are deployed in the order they're committed.
*/

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_dbo_Customer]
GO
PRINT N'Rebuilding [dbo].[Customer]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_Customer]
(
[CustomerId] [int] NOT NULL,
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MiddleName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NewColumn] [int] NOT NULL
) ON [PRIMARY]
GO
INSERT INTO dbo.RG_Recovery_1_Customer
(
    CustomerId
   ,FirstName
   ,MiddleName
   ,LastName
   ,NewColumn
)
SELECT
    CustomerId
   ,FirstName
   ,MiddleName
   ,LastName
   ,3
FROM
    dbo.Customer
	GO
DROP TABLE [dbo].[Customer]
GO
EXEC sp_rename N'[dbo].[RG_Recovery_1_Customer]', N'Customer', N'OBJECT'
GO
PRINT N'Creating primary key [PK_dbo_Customer] on [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_dbo_Customer] PRIMARY KEY CLUSTERED  ([CustomerId]) ON [PRIMARY]
GO

