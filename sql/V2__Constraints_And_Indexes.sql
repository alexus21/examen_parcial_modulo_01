-- Un equipo debe pertenecer a un laboratorio existente:
ALTER TABLE equipos
    ADD CONSTRAINT fk_equipos_laboratorios
        FOREIGN KEY (id_laboratorio)
            REFERENCES laboratorios(id_laboratorio)
            ON DELETE RESTRICT
            ON UPDATE CASCADE;

-- Una reserva debe ser de un investigador existente:
ALTER TABLE reservas
    ADD CONSTRAINT fk_reservas_investigadores
        FOREIGN KEY (id_investigador)
            REFERENCES investigadores(id_investigador)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

-- Una reserva debe ser de un laboratorio existente:
ALTER TABLE reservas
    ADD CONSTRAINT fk_reservas_laboratorios
        FOREIGN KEY (id_laboratorio)
            REFERENCES laboratorios(id_laboratorio)
            ON DELETE RESTRICT
            ON UPDATE CASCADE;

-- Una reserva debe ser de un equipo existente:
ALTER TABLE reservas
    ADD CONSTRAINT fk_reservas_equipos
        FOREIGN KEY (id_equipo)
            REFERENCES equipos(id_equipo)
            ON DELETE RESTRICT
            ON UPDATE CASCADE;

-- Según normativa de bioseguridad, los niveles van del nivel 1 al nivel 4:
ALTER TABLE laboratorios
    ADD CONSTRAINT chk_laboratorios_nivel_bioseguridad
        CHECK (nivel_bioseguridad BETWEEN 1 AND 4);

-- Un laboratorio no puede tener capacidad 0 o negativa:
ALTER TABLE laboratorios
    ADD CONSTRAINT chk_laboratorios_capacidad_positiva
        CHECK (capacidad > 0);

-- Estandariza los posibles estados de un equipo:
ALTER TABLE equipos
    ADD CONSTRAINT chk_equipos_estado
        CHECK (estado IN ('disponible', 'mantenimiento', 'fuera_servicio'));

-- Una reserva no puede terminar antes de empezar:
ALTER TABLE reservas
    ADD CONSTRAINT chk_reservas_fechas_logicas
        CHECK (fecha_fin > fecha_inicio);

-- Estandariza los tipos de investigadores:
ALTER TABLE investigadores
    ADD CONSTRAINT chk_investigadores_tipo
        CHECK (tipo_investigador IN ('Junior', 'Senior', 'Director'));

-- Optimiza consultas como de reservas:
CREATE INDEX idx_reservas_fechas
    ON reservas(fecha_inicio, fecha_fin);

-- Para búsquedas de reservas por investigador:
CREATE INDEX idx_reservas_investigador
    ON reservas(id_investigador);

-- Para laboratorios por nivel de bioseguridad:
CREATE INDEX idx_laboratorios_nivel_bioseguridad
    ON laboratorios(nivel_bioseguridad);

-- Para equipos por laboratorio:
CREATE INDEX idx_equipos_laboratorio
    ON equipos(id_laboratorio);

-- Para investigadores por tipo:
CREATE INDEX idx_investigadores_tipo
    ON investigadores(tipo_investigador);

-- Comentarios de documentación de las tablas:
COMMENT ON TABLE laboratorios IS 'Almacena información de los laboratorios de investigación';
COMMENT ON COLUMN laboratorios.nivel_bioseguridad IS 'Nivel de bioseguridad del laboratorio (1-4), donde 4 es el máximo nivel de contención';

COMMENT ON TABLE equipos IS 'Almacena los equipos disponibles en cada laboratorio';
COMMENT ON COLUMN equipos.estado IS 'Estado actual del equipo: disponible, mantenimiento o fuera_servicio';

COMMENT ON TABLE reservas IS 'Registra las reservas de laboratorios y equipos por parte de investigadores';
COMMENT ON COLUMN reservas.fecha_inicio IS 'Fecha y hora de inicio de la reserva';
COMMENT ON COLUMN reservas.fecha_fin IS 'Fecha y hora de finalización de la reserva';

COMMENT ON TABLE investigadores IS 'Almacena información de los investigadores del sistema';
COMMENT ON COLUMN investigadores.tipo_investigador IS 'Jerarquía del investigador: Junior, Senior o Director';

COMMENT ON TABLE log_auditoria IS 'Tabla de auditoría que registra cambios en el sistema';
COMMENT ON COLUMN log_auditoria.accion IS 'Descripción de la acción realizada en el sistema';