CREATE TABLE [dbo].[SalesPerson]
(
[BusinessEntityID] [int] NOT NULL,
[TerritoryID] [int] NULL,
[SalesQuota] [money] NULL,
[Bonus] [money] NOT NULL,
[CommissionPct] [smallmoney] NOT NULL,
[SalesYTD] [money] NOT NULL,
[SalesLastYear] [money] NOT NULL,
[rowguid] [uniqueidentifier] NOT NULL,
[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SalesPerson] ADD CONSTRAINT [PK_SalesPerson] PRIMARY KEY CLUSTERED  ([BusinessEntityID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SalesPerson] ADD CONSTRAINT [FK_SalesPerson_Person] FOREIGN KEY ([BusinessEntityID]) REFERENCES [dbo].[Person] ([BusinessEntityID])
GO
