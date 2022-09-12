ALTER TABLE Pets WITH CHECK
ADD FOREIGN KEY ([OwnerID]) REFERENCES [DrDoolittleVet.[dbo].[PetOwners]([OwnerID])
