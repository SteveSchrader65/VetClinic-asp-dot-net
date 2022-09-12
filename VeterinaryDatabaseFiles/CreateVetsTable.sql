DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[Vets]
CREATE TABLE [DrDoolittleVet].[dbo].[Vets](
	[VetID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Title] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Address1] [nvarchar](30) NOT NULL,
	[Address2] [nvarchar](30) NOT NULL,
	[State] [nvarchar](3) NOT NULL,
	[PostCode] [int] NOT NULL,
	[PhoneNumber] [nvarchar](12) NOT NULL,
	[Qualification] [nvarchar](200) NOT NULL,
	[EmailAddress] [nvarchar](60) NOT NULL,
	[Password] [nvarchar](30),
) ON [PRIMARY]
