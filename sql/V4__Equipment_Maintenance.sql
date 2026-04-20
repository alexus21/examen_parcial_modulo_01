-- Añadir columna de tracking de última revisión:
ALTER TABLE equipos ADD COLUMN ultima_revision DATE;

-- Documentación de columnas de mantenimiento:
COMMENT ON COLUMN equipos.ultima_revision IS 'Fecha de la última revisión de mantenimiento realizada al equipo';
