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




-- Write queries to answer the following questions:

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_tries = 0;


-- What is the average weight of animals?
SELECT AVG(weight) FROM animals;


-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_tries) AS total_escapes
FROM animals
GROUP BY neutered
ORDER BY total_escapes DESC
LIMIT 1;


-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight) AS min_weight, MAX(weight) AS max_weight
FROM animals
GROUP BY species;


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_tries) AS avg_escapes
FROM animals
WHERE dob BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- What animals belong to Melody Pond?

SELECT animals.name, species.name AS species, owners.full_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.name, species.name AS species
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


-- List all owners and their animals, remember to include those that don't own any animal.

SELECT owners.full_name, animals.name, species.name AS species
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
LEFT JOIN species ON animals.species_id = species.id
ORDER BY owners.full_name, animals.name;


-- How many animals are there per species?

SELECT species.name AS species, COUNT(*) AS num_animals
FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;


-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name, species.name AS species, owners.full_name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';



-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name, species.name AS species, owners.full_name, animals.escape_tries
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_tries = 0;


-- Who owns the most animals?

SELECT owners.full_name, COUNT(*) AS num_animals
FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY num_animals DESC
LIMIT 1;
