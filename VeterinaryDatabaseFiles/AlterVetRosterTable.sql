ALTER TABLE VetRoster WITH CHECK
ADD FOREIGN KEY ([VetID]) REFERENCES [DrDoolittleVet].[dbo].[Vets]([VetID])
