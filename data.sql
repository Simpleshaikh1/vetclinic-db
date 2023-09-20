/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

-- Insert Charmander
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Charmander', '2020-02-08', -11.0, false, 0);

-- Insert Plantmon
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Plantmon', '2021-11-15', -5.7, true, 2);

-- Insert Squirtle
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Squirtle', '1993-04-02', -12.13, false, 3);

-- Insert Angemon
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Angemon', '2005-06-12', -45.0, true, 1);

-- Insert Boarmon
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Boarmon', '2005-06-07', 20.4, true, 7);

-- Insert Blossom
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Blossom', '1998-10-13', 17.0, true, 3);

-- Insert Ditto
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Ditto', '2022-05-14', 22.0, true, 4);


-- Insert data into the "owners" table
INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into the "species" table
INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');


-- Update animals to set species_id based on the name
UPDATE animals
SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);


-- Update animals to set owner_id based on owner information
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


-- Insert Vet William Tatcher
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

-- Insert Vet Maisy Smith
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

-- Insert Vet Stephanie Mendez
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

-- Insert Vet Jack Harkness
INSERT INTO vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');


-- Assuming you have the vet and species data in their respective tables
-- Insert specialization records

-- Vet William Tatcher is specialized in Pokemon
INSERT INTO specializations (vet_id, species_id)
VALUES (
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon
INSERT INTO specializations (vet_id, species_id)
VALUES (
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM species WHERE name = 'Digimon')
),
(
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  (SELECT id FROM species WHERE name = 'Pokemon')
);

-- Vet Jack Harkness is specialized in Digimon
INSERT INTO specializations (vet_id, species_id)
VALUES (
  (SELECT id FROM vets WHERE name = 'Jack Harkness'),
  (SELECT id FROM species WHERE name = 'Digimon')
);


-- Assuming you have the animal and vet data in their respective tables
-- Insert visit records

-- Agumon visited William Tatcher on May 24th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (
  (SELECT id FROM animals WHERE name = 'Agumon'),
  (SELECT id FROM vets WHERE name = 'William Tatcher'),
  '2020-05-24'
);

-- Agumon visited Stephanie Mendez on Jul 22th, 2020
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (
  (SELECT id FROM animals WHERE name = 'Agumon'),
  (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
  '2020-07-22'
);

-- Continue with the remaining visit records...
-- Please note that you should insert data for each visit in the same manner.
