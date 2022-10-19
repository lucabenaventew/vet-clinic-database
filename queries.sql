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

-- 3
SELECT name FROM animals INNER JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';
SELECT animals.name FROM animals INNER JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT animals.name, owners.full_name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
SELECT COUNT(*), species.name AS species FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT animals.name AS digimons_name, owners.full_name AS owner_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.species_id = 2 AND owners.full_name = 'Jennifer Orwell';
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
SELECT full_name, COUNT(full_name) AS owns FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name ORDER BY owns DESC LIMIT 1;

-- 4
SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT animals.name, vets.name FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT vets.name, species.name FROM vets LEFT JOIN specializations
ON vets.id = specializations.vet_id LEFT JOIN species
ON specializations.species_id = species.id;

SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date > '2020-04-01'
AND visits.visit_date <= '2020-08-30'
ORDER BY visits.visit_date DESC;

SELECT animals.name, COUNT(visits.animal_id) FROM visits JOIN animals 
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

SELECT animals.name, vets.name, visits.visit_date FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
species.name AS specie, owners.full_name AS owner, vets.name AS vet, vets.age AS vet_age,
vets.date_of_graduation AS vet_grad, visits.visit_date AS visit_date FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owner_id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(visits.animal_id) FROM visits JOIN animals 
ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations 
    WHERE vet_id = vets.id
    );

SELECT species.name, COUNT(animals.species_id) FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(animals.species_id) DESC
LIMIT 1;
