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



-- VETS TABLE AND QUERIES

-- Who was the last animal seen by William Tatcher?

SELECT animals.name 
FROM animals 
JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date DESC
LIMIT 1;


-- How many different animals did Stephanie Mendez see?

SELECT COUNT(DISTINCT visits.animal_id) 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez';


-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name, COALESCE(string_agg(DISTINCT species.name, ', '), 'No specialty') AS specialties 
FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON specializations.species_id = species.id 
GROUP BY vets.id;


-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name 
FROM animals 
JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez' 
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


-- What animal has the most visits to vets?

SELECT animals.name, COUNT(*) AS num_visits 
FROM animals 
JOIN visits ON animals.id = visits.animal_id 
GROUP BY animals.id, animals.name 
ORDER BY num_visits DESC 
LIMIT 1;


-- Who was Maisy Smith's first visit?

SELECT a.name FROM animals a 
JOIN visits v ON a.id = v.animal_id 
WHERE v.vet_id = 2 ORDER BY v.date_of_visit ASC 
LIMIT 1


-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name AS animal_name, vets.name AS vet_name, visits.date_of_visit 
FROM animals 
JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON visits.vet_id = vets.id 
WHERE visits.date_of_visit = (SELECT MAX(date_of_visit) FROM visits) 
LIMIT 1;


-- How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) 
FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id 
WHERE specializations.id IS NULL;


-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name, COUNT(*) AS num_visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species.name
ORDER BY num_visits DESC
LIMIT 1;


