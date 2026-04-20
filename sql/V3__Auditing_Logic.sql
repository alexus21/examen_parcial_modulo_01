-- Función para verificar reglas de negocio antes de reservar
CREATE OR REPLACE FUNCTION fn_verificar_reserva()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_bio INT;
    v_rango VARCHAR(50);
    v_estado_equipo VARCHAR(50);
BEGIN
    SELECT nivel_bioseguridad INTO v_nivel_bio FROM laboratorios WHERE id_laboratorio = NEW.id_laboratorio;
    SELECT tipo_investigador INTO v_rango FROM investigadores WHERE id_investigador = NEW.id_investigador;
    SELECT estado INTO v_estado_equipo FROM equipos WHERE id_equipo = NEW.id_equipo;

    -- Solo Director en bioseguridad nivel 4
    IF v_nivel_bio = 4 AND v_rango != 'Director' THEN
        RAISE EXCEPTION 'Acceso denegado: Laboratorios Nivel 4 exclusivos para Directores.';
    END IF;

    IF v_estado_equipo != 'Disponible' THEN
        RAISE EXCEPTION 'Reserva fallida: El equipo se encuentra en %', v_estado_equipo;
    END IF;

    -- Investigador no puede tener reservas solapadas en el mismo horario
    IF EXISTS (
        SELECT 1 FROM reservas
        WHERE id_investigador = NEW.id_investigador
        AND NEW.fecha_inicio < fecha_fin AND NEW.fecha_fin > fecha_inicio
    ) THEN
        RAISE EXCEPTION 'Conflicto: El investigador ya tiene una reserva en este horario.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para validar reglas antes de insertar/actualizar
CREATE TRIGGER trg_verificar_reserva
BEFORE INSERT OR UPDATE ON reservas
FOR EACH ROW EXECUTE FUNCTION fn_verificar_reserva();

-- Función para registrar la auditoría
CREATE OR REPLACE FUNCTION fn_auditar_reserva()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_auditoria (usuario, accion)
    VALUES (current_user, 'Reserva registrada o modificada para el equipo ID: ' || NEW.id_equipo);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger de auditoría después de la inserción
CREATE TRIGGER trg_auditar_reserva
AFTER INSERT OR UPDATE ON reservas
FOR EACH ROW EXECUTE FUNCTION fn_auditar_reserva();