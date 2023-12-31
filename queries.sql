/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

-- Update the species column to "unspecified"
UPDATE animals
SET species = 'unspecified';

-- Verify the change
SELECT * FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify that the species column went back to the state before the transaction
SELECT * FROM animals;


BEGIN;

-- Update animals with names ending in "mon" to have species "digimon"
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update animals with no species already set to have species "pokemon"
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Verify the changes
SELECT * FROM animals;

COMMIT;

-- Verify that changes persist after commit
SELECT * FROM animals;

BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Rollback the transaction
ROLLBACK;

-- Verify if all records in the animals table still exist
SELECT * FROM animals;


BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT weight_update;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO weight_update;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';


SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';


SELECT o.full_name, a.name AS animal_name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;


SELECT s.name AS species, COUNT(*) AS num_animals
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;


SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';


SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
LEFT JOIN escape_attempts e ON a.id = e.animal_id
WHERE o.full_name = 'Dean Winchester' AND (e.attempts IS NULL OR e.attempts = 0);


SELECT o.full_name, COUNT(*) AS num_animals_owned
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY num_animals_owned DESC
LIMIT 1;

SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY v.visit_date DESC
LIMIT 1;


SELECT COUNT(DISTINCT a.id) AS number_of_animals_seen
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');


SELECT v.name AS vet_name, COALESCE(s.name, 'No Specialty') AS specialty
FROM vets v
LEFT JOIN specializations vs ON v.id = vs.vet_id
LEFT JOIN species s ON vs.species_id = s.id;


SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez')
  AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';


SELECT a.name AS animal_name, COUNT(v.id) AS number_of_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY number_of_visits DESC
LIMIT 1;


SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY v.visit_date ASC
LIMIT 1;


SELECT a.name AS animal_name, v.name AS vet_name, v.visit_date AS visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits);


SELECT COUNT(*) AS number_of_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
LEFT JOIN specializations vs ON ve.id = vs.vet_id AND a.species_id = vs.species_id
WHERE vs.id IS NULL;


SELECT s.name AS specialty
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets ve ON v.vet_id = ve.id
JOIN specializations vs ON ve.id = vs.vet_id
JOIN species s ON vs.species_id = s.id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY s.name
ORDER BY COUNT(v.id) DESC
LIMIT 1;

CREATE INDEX idx_email ON owners(email);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE email = 4;

CREATE INDEX idx_vet_id ON visits(vet_id);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE vet_id = 4;


SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;
