-- Definir ENUM types
CREATE TYPE ENERGY_TYPE AS ENUM (
    'nuclear',
    'solar'
);

CREATE TYPE AIRLOCK_TYPE AS ENUM (
    'internal',
    'external'
);

CREATE TYPE MATERIAL_TYPE AS ENUM (
    'metal',
    'glass'
);

-- Crear  table Spaceship
CREATE TABLE spaceship (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    year_of_construction INT NOT NULL
);

-- Crear table  PowerPlant
CREATE TABLE powerplant (
    id SERIAL PRIMARY KEY,
    spaceship_id INT REFERENCES spaceship(id) NOT NULL,
    status VARCHAR(255) NOT NULL,
    type ENERGY_TYPE NOT NULL,
    capacity FLOAT NOT NULL
);

-- Crear table  ObservationWindow
CREATE TABLE observationwindow (
    id SERIAL PRIMARY KEY,
    spaceship_id INT REFERENCES spaceship(id) NOT NULL,
    light_intensity FLOAT NOT NULL,
    light_color VARCHAR(50) NOT NULL,
    size FLOAT NOT NULL,
    material MATERIAL_TYPE NOT NULL
);

-- Crear table for Airlock
CREATE TABLE airlock (
    id SERIAL PRIMARY KEY,
    spaceship_id INT REFERENCES spaceship(id) NOT NULL,
    status VARCHAR(255) NOT NULL,
    movement_detected BOOLEAN NOT NULL,
    size FLOAT NOT NULL,
    type AIRLOCK_TYPE NOT NULL
);

-- Crear table  MovingObject
CREATE TABLE movingobject (
    id SERIAL PRIMARY KEY,
    time_sighted TIMESTAMP NOT NULL,
    description TEXT,
    speed FLOAT NOT NULL,
    size FLOAT NOT NULL,
    spaceship_id INT REFERENCES spaceship(id) NOT NULL
);

-- Crear table  CrewMember
CREATE TABLE crewmember (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    spaceship_id INT REFERENCES spaceship(id) NOT NULL
);

-- Crear  table  MaintenanceAssignment (many-to-many relationship)
CREATE TABLE maintenanceassignment (
    crewmember_id INT REFERENCES crewmember(id) NOT NULL,
    powerplant_id INT REFERENCES powerplant(id) NOT NULL,
    date TIMESTAMP NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY (crewmember_id, powerplant_id)
);

-- Insert test data into spaceship table
INSERT INTO spaceship (name, status, type, year_of_construction)
VALUES
    ('Voyager', 'Operational', 'Explorer', 2101),
    ('Odyssey', 'Maintenance', 'Cargo', 2095);

-- Insert test data into powerplant table
INSERT INTO powerplant (spaceship_id, status, type, capacity)
VALUES
    (1, 'Active', 'nuclear', 5000.0),
    (2, 'Inactive', 'solar', 3000.0);

-- Insert test data into observationwindow table
INSERT INTO observationwindow (spaceship_id, light_intensity, light_color, size, material)
VALUES
    (1, 0.8, 'Blue', 2.0, 'glass'),
    (2, 0.6, 'Red', 1.5, 'metal');

-- Insert test data into airlock table
INSERT INTO airlock (spaceship_id, status, movement_detected, size, type)
VALUES
    (1, 'Open', TRUE, 1.0, 'internal'),
    (2, 'Closed', FALSE, 1.2, 'external');

-- Insert test data into movingobject table
INSERT INTO movingobject (time_sighted, description, speed, size, spaceship_id)
VALUES
    ('2024-05-23 10:00:00', 'Unidentified object', 25000.0, 5.0, 1);

-- Insert test data into crewmember table
INSERT INTO crewmember (name, role, age, specialization, spaceship_id)
VALUES
    ('Alice', 'Captain', 45, 'Navigation', 1),
    ('Bob', 'Engineer', 38, 'Mechanical', 1);

-- Insert test data into maintenanceassignment table
INSERT INTO maintenanceassignment (crewmember_id, powerplant_id, date, description)
VALUES
    (1, 1, '2024-05-23', 'Regular maintenance check'),
    (2, 1, '2024-05-24', 'System upgrade');
