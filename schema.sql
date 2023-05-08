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
