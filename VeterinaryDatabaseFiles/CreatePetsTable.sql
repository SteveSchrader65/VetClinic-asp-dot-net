DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[Pets]
CREATE TABLE [DrDoolittleVet].[dbo].[Pets](
	[PetID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[OwnerID] [int] NOT NULL,
	[PetName] [nvarchar](20) NOT NULL,
	[PetBreed] [nvarchar](20) NOT NULL,
	[PetGender] [nvarchar](20) NOT NULL, 
	[PetBirthDate] [date] NOT NULL,
	[PetMedicalHistory] [nvarchar](2500) NULL
) ON [PRIMARY]
