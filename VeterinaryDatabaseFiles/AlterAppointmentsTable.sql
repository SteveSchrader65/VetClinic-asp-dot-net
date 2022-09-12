ALTER TABLE Appointments WITH CHECK
ADD FOREIGN KEY ([PetID]) REFERENCES [DrDoolittleVet.[dbo].[Pets]([PetID])

ALTER TABLE Appointments WITH CHECK
ADD FOREIGN KEY ([VetID]) REFERENCES [DrDoolittleVet].[dbo].[Vets]([VetID])

