ALTER TABLE PrescribedMedications WITH CHECK
ADD FOREIGN KEY ([AppointmentID]) REFERENCES [DrDoolittleVet].[dbo].[Appointments]([AppointID])

ALTER TABLE PrescribedMedications WITH CHECK
ADD FOREIGN KEY ([DrugID]) REFERENCES [DrDoolittleVet].[dbo].[Medications]([DrugID])