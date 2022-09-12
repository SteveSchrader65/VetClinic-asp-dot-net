DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[VetRoster]
CREATE TABLE [DrDoolittleVet].[dbo].[VetRoster](
	[VetID] [int] NOT NULL PRIMARY KEY,
	[roster1] [Bit] NOT NULL DEFAULT 0,
    [roster2] [Bit] NOT NULL DEFAULT 0,
	[roster3] [Bit] NOT NULL DEFAULT 0,
	[roster4] [Bit] NOT NULL DEFAULT 0,
	[roster5] [Bit] NOT NULL DEFAULT 0,
	[roster6] [Bit] NOT NULL DEFAULT 0,
	[roster7] [Bit] NOT NULL DEFAULT 0,
) ON [PRIMARY]