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


