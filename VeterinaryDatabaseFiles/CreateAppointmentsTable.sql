DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[Appointments]
CREATE TABLE [DrDoolittleVet].[dbo].[Appointments](
	[AppointID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[PetID] [int] NOT NULL,
	[VetID] [int] NOT NULL,
	[AppointDate] [date] NOT NULL,
	[AppointTime] [time](5) NOT NULL,
	[AppointPrice] [money] NULL,
	[AppointComment] nvarchar(200) NOT NULL,
) ON [PRIMARY]