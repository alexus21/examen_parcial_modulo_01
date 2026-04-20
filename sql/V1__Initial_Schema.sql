CREATE TABLE investigadores (
    id_investigador SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo_investigador VARCHAR(50) NOT NULL
);

CREATE TABLE laboratorios (
    id_laboratorio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nivel_bioseguridad INT NOT NULL,
    capacidad INT NOT NULL
);

CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    id_laboratorio INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_investigador INT NOT NULL,
    id_laboratorio INT NOT NULL,
    id_equipo INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL
);

CREATE TABLE log_auditoria (
    id_log SERIAL PRIMARY KEY,
    usuario VARCHAR(100) NOT NULL,
    accion TEXT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);