INSERT INTO investigadores (id_investigador, nombre, tipo_investigador) VALUES
(1, 'Hugo Ulloa', 'Junior'),
(2, 'Angel Vasquez', 'Senior'),
(3, 'Roberto Gomez', 'Director'),
(4, 'Frankie Rivers', 'Junior'),
(5, 'John Arbaiza', 'Director');

INSERT INTO laboratorios (id_laboratorio, nombre, nivel_bioseguridad, capacidad) VALUES
(1, 'Lab Genómica A', 1, 10),
(2, 'Lab Microbiología', 2, 8),
(3, 'Lab Contención B', 3, 5),
(4, 'Lab Alta Seguridad X', 4, 3),
(5, 'Lab Análisis Clínico', 1, 15);

INSERT INTO equipos (id_equipo, id_laboratorio, nombre, estado, ultima_revision) VALUES
(1, 1, 'Microscopio Electrónico', 'disponible', '2023-10-01'),
(2, 2, 'Centrífuga Refrigerada', 'mantenimiento', '2023-09-15'),
(3, 3, 'Campana de Flujo Laminar', 'disponible', '2023-10-20'),
(4, 4, 'Traje de Presión Positiva', 'disponible', '2023-10-25'),
(5, 5, 'Espectrofotómetro', 'fuera_servicio', '2023-01-10');

INSERT INTO reservas (id_reserva, id_investigador, id_laboratorio, id_equipo, fecha_inicio, fecha_fin) VALUES
(1, 1, 1, 1, '2023-11-01 08:00:00', '2023-11-01 10:00:00'),
(2, 2, 3, 3, '2023-11-01 10:30:00', '2023-11-01 12:30:00'),
(3, 3, 4, 4, '2023-11-02 09:00:00', '2023-11-02 14:00:00'),
(4, 4, 1, 1, '2023-11-01 14:00:00', '2023-11-01 16:00:00'),
(5, 5, 4, 4, '2023-11-03 08:00:00', '2023-11-03 12:00:00');