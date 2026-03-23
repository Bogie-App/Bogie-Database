-- Table des stations de métro
-- schema et table temporaire pour le chargement des données
CREATE TABLE IF NOT EXISTS stations (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50)  NOT NULL,
    address VARCHAR(100) NOT NULL,
    line int NOT NULL, 
    latitude  FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP --mettre un trigger pour update_at
);