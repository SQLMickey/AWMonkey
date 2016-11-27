CREATE TABLE [dbo].[Customer]
(
[CustomerId] [int] NOT NULL,
[FirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MiddleName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_dbo_Customer] PRIMARY KEY CLUSTERED  ([CustomerId]) ON [PRIMARY]
GO
