/*Queries that provide answers to the questions from all projects.*/

-- Write queries for the following quests:


-- Find all animals whose name ends in "mon".
SELECT name FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Writing transaction for the following every transaction statement:

-- Fist transaction

-- Inside a transaction update the animals table by setting the species column to unspecified. 
-- Verify that change was made. 
-- Then roll back the change and 
-- verify that the species columns went back to the state before the transaction.

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Second transaction

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Third transaction

-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT savepoint_name;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO savepoint_name;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

-- Fourth transaction

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

-- additional queries performed after the transactions

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered ORDER BY COUNT(*) DESC LIMIT 1;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- queries for the following quests:

-- What animals belong to Melody Pond?
select * from animals join owners on animals.owner_id = owners.id where full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
select A.name, S.name from animals A join species S on A.species_id = S.id where S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
select * from owners left join animals on owners.id = animals.owner_id;

-- How many animals are there per species?
select count(*) as count, S.name from animals A join species S on A.species_id = S.id group by S.name;

-- List all Digimon owned by Jennifer Orwell.
select A.name from animals A join owners O on A.owner_id = O.id join species S on A.species_id = S.id where O.full_name = 'Jennifer Orwell' and S.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
select * from animals A join owners O on A.owner_id = O.id where O.full_name = 'Dean Winchester' and A.escape_attempts = 0;

-- Who owns the most animals?
select O.full_name, count(*) as count from animals A join owners O on A.owner_id = O.id group by O.full_name order by count desc limit 1;

-- 8 more queries for the following quests:

-- Who was the last animal seen by William Tatcher?
select * from animals where id = (select animal_id from visits where vet_id = 1 order by visit_date desc limit 1)

-- How many different animals did Stephanie Mendez see?

select count(distinct animal_id) from visits where vet_id = 3

-- List all vets and their specialties, including vets with no specialties.

select v.name, s.species_id from vets v left join specializations s on v.id = s.vet_id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

select a.name from animals a join visits v on a.id = v.animal_id where v.vet_id = 3 and v.visit_date between '2020-04-01' and '2020-08-30'

-- What animal has the most visits to vets?
select a.name, count(v.animal_id) from animals a join visits v on a.id = v.animal_id group by a.name order by count(v.animal_id) desc limit 1

-- Who was Maisy Smith's first visit?
select a.name from animals a join visits v on a.id = v.animal_id where v.vet_id = 2 order by v.visit_date asc limit 1

-- Details for most recent visit: animal information, vet information, and date of visit.
select a.name, v.visit_date, v.vet_id from animals a join visits v on a.id = v.animal_id order by v.visit_date desc limit 1

-- How many visits were with a vet that did not specialize in that animal's species?
select count(*) from visits v join specializations s on v.vet_id = s.vet_id where v.animal_id = s.species_id

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select s.species_id from specializations s join visits v on s.vet_id = v.vet_id where v.vet_id = 2 group by s.species_id order by count(s.species_id) desc limit 1

-- explain analyze queries.

explain analyze select count(*) from visits where animal_id = 4;

explain analyze select * from visits where vet_id = 2;

explain analyze select * from owners where email = 'owner_18327@mail.com';

