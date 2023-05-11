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