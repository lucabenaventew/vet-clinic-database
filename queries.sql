/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered IS true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Pikachu','Agumon');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS true;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.3 AND 17.4;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts IS NULL;
SELECT AVG(weight_kg) FROM animals;
SELECT SUM(escape_attempts) FROM animals WHERE neutered IS true;
SELECT SUM(escape_attempts) FROM animals WHERE neutered IS true;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals WHERE species = 'digimon';
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT AVG(escape_attempts) FROM animals  WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01';


BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deleteAnimals;
SELECT * FROM animals; 
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals; 
ROLLBACK TO deleteAnimals;
UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
