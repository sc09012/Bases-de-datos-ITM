-- Create schema for the user
CREATE SCHEMA sXXXXXX;

-- Define ENUM types
CREATE TYPE sXXXXXX.ENERGY_TYPE AS ENUM (
    'nuclear',
    'solar'
);

CREATE TYPE sXXXXXX.AIRLOCK_TYPE AS ENUM (
    'internal',
    'external'
);

CREATE TYPE sXXXXXX.MATERIAL_TYPE AS ENUM (
    'metal',
    'glass'
);

-- Create table for Spaceship
CREATE TABLE sXXXXXX.spaceship (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    year_of_construction INT NOT NULL
);

-- Create table for PowerPlant
CREATE TABLE sXXXXXX.powerplant (
    id SERIAL PRIMARY KEY,
    spaceship_id INT REFERENCES sXXXXXX.spaceship(id) NOT NULL,
    status VARCHAR(255) NOT NULL,
    type sXXXXXX.ENERGY_TYPE NOT NULL,
    capacity FLOAT NOT NULL
);

-- Create table for ObservationWindow
CREATE TABLE sXXXXXX.observationwindow (
    id SERIAL PRIMARY KEY,
    spaceship_id INT REFERENCES sXXXXXX.spaceship(id) NOT NULL,
    light_intensity FLOAT NOT NULL,
    light_color VARCHAR(50) NOT NULL,
    size FLOAT NOT NULL,
    material sXXXXXX.MATERIAL_TYPE NOT NULL
);

-- Create table for Airlock
CREATE TABLE sXXXXXX.airlock (
    id SERIAL PRIMARY KEY,
    spaceship_id INT REFERENCES sXXXXXX.spaceship(id) NOT NULL,
    status VARCHAR(255) NOT NULL,
    movement_detected BOOLEAN NOT NULL,
    size FLOAT NOT NULL,
    type sXXXXXX.AIRLOCK_TYPE NOT NULL
);

-- Create table for MovingObject
CREATE TABLE sXXXXXX.movingobject (
    id SERIAL PRIMARY KEY,
    time_sighted TIMESTAMP NOT NULL,
    description TEXT,
    speed FLOAT NOT NULL,
    size FLOAT NOT NULL,
    spaceship_id INT REFERENCES sXXXXXX.spaceship(id) NOT NULL
);

-- Create table for CrewMember
CREATE TABLE sXXXXXX.crewmember (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    spaceship_id INT REFERENCES sXXXXXX.spaceship(id) NOT NULL
);

-- Create table for MaintenanceAssignment (many-to-many relationship)
CREATE TABLE sXXXXXX.maintenanceassignment (
    crewmember_id INT REFERENCES sXXXXXX.crewmember(id) NOT NULL,
    powerplant_id INT REFERENCES sXXXXXX.powerplant(id) NOT NULL,
    date TIMESTAMP NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY (crewmember_id, powerplant_id)
);

-- Insert test data into spaceship table
INSERT INTO sXXXXXX.spaceship (name, status, type, year_of_construction)
VALUES
    ('Voyager', 'Operational', 'Explorer', 2101),
    ('Odyssey', 'Maintenance', 'Cargo', 2095);

-- Insert test data into powerplant table
INSERT INTO sXXXXXX.powerplant (spaceship_id, status, type, capacity)
VALUES
    (1, 'Active', 'nuclear', 5000.0),
    (2, 'Inactive', 'solar', 3000.0);

-- Insert test data into observationwindow table
INSERT INTO sXXXXXX.observationwindow (spaceship_id, light_intensity, light_color, size, material)
VALUES
    (1, 0.8, 'Blue', 2.0, 'glass'),
    (2, 0.6, 'Red', 1.5, 'metal');

-- Insert test data into airlock table
INSERT INTO sXXXXXX.airlock (spaceship_id, status, movement_detected, size, type)
VALUES
    (1, 'Open', TRUE, 1.0, 'internal'),
    (2, 'Closed', FALSE, 1.2, 'external');

-- Insert test data into movingobject table
INSERT INTO sXXXXXX.movingobject (time_sighted, description, speed, size, spaceship_id)
VALUES
    ('2024-05-23 10:00:00', 'Unidentified object', 25000.0, 5.0, 1);

-- Insert test data into crewmember table
INSERT INTO sXXXXXX.crewmember (name, role, age, specialization, spaceship_id)
VALUES
    ('Alice', 'Captain', 45, 'Navigation', 1),
    ('Bob', 'Engineer', 38, 'Mechanical', 1);

-- Insert test data into maintenanceassignment table
INSERT INTO sXXXXXX.maintenanceassignment (crewmember_id, powerplant_id, date, description)
VALUES
    (1, 1, '2024-05-23', 'Regular maintenance check'),
    (2, 1, '2024-05-24', 'System upgrade');
