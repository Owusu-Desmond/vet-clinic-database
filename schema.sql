/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY
    name TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);
