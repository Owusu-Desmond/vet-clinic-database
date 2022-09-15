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



-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.

create table vets (
    id int generated always as identity,
    name varchar(255),
    age int,
    date_of_graduation date,
    primary key (id)
)

create table specializations (
    vet_id int references vets(id),
    species_id int references species(id),
)

create table visits (
    vet_id int references vets(id),
    animal_id int references animals(id),
    visit_date date,
)
