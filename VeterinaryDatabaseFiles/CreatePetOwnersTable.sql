DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[PetOwners]
CREATE TABLE [DrDoolittleVet].[dbo].[PetOwners](
	[OwnerID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Address1] [nvarchar](30) NOT NULL,
	[Address2] [nvarchar](30) NOT NULL,
	[State] [nvarchar](3) NOT NULL,
	[PostCode] [int] NOT NULL,
	[PhoneNumber] [nvarchar](12) NOT NULL,
	[EmailAddress] [nvarchar](60) NOT NULL,
	[ProofType] [nvarchar](20) NOT NULL,
	[ProofNumber] [nvarchar](20) NOT NULL,
) ON [PRIMARY]

