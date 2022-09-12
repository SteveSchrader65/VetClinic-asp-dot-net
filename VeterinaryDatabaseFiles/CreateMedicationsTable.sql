DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[Medications]
CREATE TABLE [DrDoolittleVet].[dbo].[Medications](
	[DrugID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[DrugName] [nvarchar](20) NOT NULL,
	[DrugSupplier] [nvarchar](50) NOT NULL,
	[DrugCostPrice] [money] NOT NULL,
	[DrugSalePrice] [money] NOT NULL,
	[DrugQuantity] [int] NOT NULL,
) ON [PRIMARY]