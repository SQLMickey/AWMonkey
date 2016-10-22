CREATE TABLE [dbo].[DependentWard]
(
[DependentWardId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateOfBirth] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DependentWard] ADD CONSTRAINT [PK__Dependen__280985FDA6EC510A] PRIMARY KEY CLUSTERED  ([DependentWardId]) ON [PRIMARY]
GO
