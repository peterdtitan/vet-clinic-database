-- Inside a transaction update the animals table by setting the species column to unspecified. 
-- Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

SELECT * FROM animals;


-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

SELECT * FROM animals;


-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.

BEGIN;
DELETE FROM animals;
ROLLBACK;

SELECT * FROM animals;


-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction.

BEGIN;
DELETE FROM animals WHERE dob > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight = weight * (-1);
ROLLBACK TO my_savepoint;
UPDATE animals SET weight = weight * (-1) WHERE weight < 0;
COMMIT;

SELECT * FROM animals;

