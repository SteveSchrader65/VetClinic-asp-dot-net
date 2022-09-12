DROP TABLE IF EXISTS [DrDoolittleVet].[dbo].[PrescribedMedications]

CREATE TABLE [DrDoolittleVet].[dbo].[PrescribedMedications](
	[AppointmentID] [int] NOT NULL,
	[DrugID] [int] NOT NULL
) ON [PRIMARY]
