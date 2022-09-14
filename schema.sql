/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY
    name TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

--query to add species column to table

ALTER TABLE animals ADD COLUMN species TEXT;

-- create a new table called owners
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
    age INT,
);

-- create a new table called species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
);

-- set already existing column id in animals table as primary key
ALTER TABLE animals ADD CONSTRAINT pk_animals PRIMARY KEY (id);

-- delete the species column from the animals table
ALTER TABLE animals DROP COLUMN species;

-- add a new column called species_id to the animals table
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);

-- add a new column called owner_id to the animals table
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);
