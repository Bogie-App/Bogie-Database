-- Table des stations de métro
CREATE TABLE IF NOT EXISTS stations (
    id          SERIAL PRIMARY KEY,
    stop_id     VARCHAR(50)  NOT NULL UNIQUE,
    name        VARCHAR(50)  NOT NULL,
    description VARCHAR(100),
    latitude    FLOAT        NOT NULL,
    longitude   FLOAT        NOT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS lines (
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS station_line (
    station_id     INT NOT NULL,
    line_id        INT NOT NULL,
    stop_sequence  INT NOT NULL,
    PRIMARY KEY (station_id, line_id),
    FOREIGN KEY (station_id) REFERENCES stations(id),
    FOREIGN KEY (line_id)    REFERENCES lines(id)
);

CREATE TABLE IF NOT EXISTS station_timing (
    id             SERIAL PRIMARY KEY,
    station_id     INT  NOT NULL,
    line_id        INT  NOT NULL,
    arrival_time   TIME NOT NULL,
    departure_time TIME NOT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (station_id) REFERENCES stations(id),
    FOREIGN KEY (line_id)    REFERENCES lines(id),
    UNIQUE (station_id, line_id, arrival_time, departure_time)
);

-- Trigger pour mettre à jour updated_at automatiquement
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_stations_updated_at
    BEFORE UPDATE ON stations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE OR REPLACE TRIGGER trg_lines_updated_at
    BEFORE UPDATE ON lines
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE OR REPLACE TRIGGER trg_station_timing_updated_at
    BEFORE UPDATE ON station_timing
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();
