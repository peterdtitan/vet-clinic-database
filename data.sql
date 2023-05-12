/* Populate database with sample data. */

INSERT INTO animals (name, dob, weight, neutered, escape_tries) VALUES ('Agumon', '2020-02-03', 10.23, true, 0);
INSERT INTO animals (name, dob, weight, neutered, escape_tries) VALUES ('Gabumon', '2018-11-15', 8, true, 2);
INSERT INTO animals (name, dob, weight, neutered, escape_tries) VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);
INSERT INTO animals (name, dob, weight, neutered, escape_tries) VALUES ('Devimon', '2017-05-12', 11, true, 5);

/* Animal: His name is Charmander. 
*  He was born on Feb 8th, 2020, and currently weighs -11kg. 
*  He is not neutered and he has never tried to escape. 
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Charmander', '02-08-2020', -11, FALSE, 0);


/* Animal: Her name is Plantmon. 
*  She was born on Nov 15th, 2021, and currently weighs -5.7kg. 
*  She is neutered and she has tried to escape 2 times.
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Plantmon', '11-15-2021', -5.7, TRUE, 2);



/* Animal: His name is Squirtle. 
*  He was born on Apr 2nd, 1993, and currently weighs -12.13kg. 
*  He was not neutered and he has tried to escape 3 times.
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Squirtle', '05-02-1993', -12.13, FALSE, 3);



/* Animal: His name is Angemon. 
*  He was born on Jun 12th, 2005, and currently weighs -45kg. 
*  He is neutered and he has tried to escape once.
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Angemon', '06-12-2005', -45, TRUE, 1);



/* Animal: His name is Boarmon. 
*  He was born on Jun 7th, 2005, and currently weighs 20.4kg. 
*  He is neutered and he has tried to escape 7 times.
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Boarmon', '06-07-2005', 20.4, TRUE, 7);



/* Animal: Her name is Blossom. 
*  She was born on Oct 13th, 1998, and currently weighs 17kg. 
*  She is neutered and she has tried to escape 3 times.
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Blossom', '10-13-1998', 17, TRUE, 3);




/* Animal: His name is Ditto. 
*  He was born on May 14th, 2022, and currently weighs 22kg. 
*  He is neutered and he has tried to escape 4 times.
*/

INSERT INTO animals(name, dob, weight, neutered, escape_tries) 
VALUES ('Ditto', '05-14-2022', 17, TRUE, 4);





INSERT INTO owners(full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO owners(full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners(full_name, age)
VALUES ('Bob', 45);

INSERT INTO owners(full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO owners(full_name, age)
VALUES ('Dean Winchester', 14);

INSERT INTO owners(full_name, age)
VALUES ('Jodie Whittaker', 38);




INSERT INTO species(name)
VALUES('Pokemon');

INSERT INTO species(name)
VALUES('Digimon');


UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE name NOT LIKE '%mon';

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name LIKE '%mon';




UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');




INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');


INSERT INTO specializations (vet_id, species_id) VALUES
    ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
    ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
    ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));



INSERT INTO visits (animal_id, vet_id, visit_date) VALUES
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
    ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
    ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');


