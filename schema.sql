/* Database schema to keep the structure of entire database. */


CREATE TABLE animals(
	id INT GENERATED ALWAYS AS IDENTITY,
	name TEXT NOT NULL,
	dob DATE NOT NULL,
	weight DECIMAL,
	neutered BOOLEAN,
	escape_tries INT
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);



CREATE TABLE owners(
	id SERIAL PRIMARY KEY, 
	full_name TEXT,
	age INTEGER
);

CREATE TABLE species(
	id SERIAL PRIMARY KEY,
	name TEXT
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);

ALTER TABLE animals ADD CONSTRAINT animals_id_unique UNIQUE (id);


CREATE TABLE vets (
	id SERIAL PRIMARY KEY,
	name TEXT,
	age INTEGER,
	date_of_graduation DATE
);

CREATE TABLE specializations (
	id SERIAL PRIMARY KEY,
	species_id INTEGER REFERENCES species(id),
	vet_id INTEGER REFERENCES vets(id)
);

CREATE TABLE visits (
	id SERIAL PRIMARY KEY,
	animal_id INTEGER REFERENCES animals(id),
	vet_id INTEGER REFERENCES vets(id),
	date_of_visit DATE
);