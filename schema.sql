/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

-- Create the "owners" table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    age INT
);

-- Create the "species" table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


-- Drop the existing "animals" table
DROP TABLE IF EXISTS animals;

-- Create a new "animals" table with the desired modifications
CREATE TABLE animals (
    id SERIAL PRIMARY KEY, -- Autoincremented primary key
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    species_id INT REFERENCES species(id), -- Foreign key referencing species table
    owner_id INT REFERENCES owners(id) -- Foreign key referencing owners table
);


CREATE TABLE vets (
    id serial PRIMARY KEY,
    name varchar(255) NOT NULL,
    age integer,
    date_of_graduation date
);

CREATE TABLE specializations (
    vet_id integer REFERENCES vets(id),
    species_id integer REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);


CREATE TABLE visits (
    visit_id serial PRIMARY KEY,
    animal_id integer REFERENCES animals(id),
    vet_id integer REFERENCES vets(id),
    visit_date date,
    CONSTRAINT unique_visit_animal_vet UNIQUE (animal_id, vet_id, visit_date)
);

ALTER TABLE visits ADD COLUMN date_of_visit timestamp;

SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;


SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;


SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

CREATE INDEX idx_animal_id ON visits(animal_id);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;

CREATE INDEX idx_vet_id ON visits(vet_id);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE vet_id = 4;


CREATE INDEX idx_email ON owners(email);
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE email = 4;
