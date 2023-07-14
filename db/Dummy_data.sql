USE DB_CLINICA
GO
-- Inserts para la tabla 'usuario'
INSERT INTO usuario (usuario, contrasenia, tipo, estado) VALUES
('admin01', 'admin123', 0, 1),
('recepcion01', 'recep456', 1, 1),
('medico01', 'med789', 2, 1),
('paciente01', 'pac123', 3, 1),
('medico02', 'med654', 2, 1),
('paciente02', 'pac456', 3, 1),
('admin02', 'admin456', 0, 1),
('recepcion02', 'recep789', 1, 1),
('medico03', 'med012', 2, 1),
('paciente03', 'pac345', 3, 1),
('medico04', 'med678', 2, 1),
('paciente04', 'pac901', 3, 1)
-- Agrega más registros de usuario aquí...

-- Inserts para la tabla 'usuario_desc'
INSERT INTO usuario_desc (usuario_id, nombre, apellido, EMail, DNI, Telefono, Celular, direccion, fecha_nacimiento) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '12345678', '123-456-7890', '987-654-3210', '123 Main St', '1980-01-01'),
(2, 'Alice', 'Smith', 'alice.smith@example.com', '87654321', '098-765-4321', '012-345-6789', '456 Oak St', '1990-02-02'),
(3, 'Dr. Robert', 'Johnson', 'dr.johnson@example.com', '56789012', '111-222-3333', '444-555-6666', '789 Elm St', '1975-03-03'),
(4, 'Sarah', 'Brown', 'sarah.brown@example.com', '10293847', '555-444-3333', '666-777-8888', '987 Pine St', '1985-04-04'),
(5, 'Dr. David', 'Miller', 'dr.miller@example.com', '67890123', '666-777-8888', '555-666-7777', '789 Pine St', '1983-09-09'),
(6, 'Olivia', 'Wilson', 'olivia.wilson@example.com', '54321098', '777-888-9999', '666-777-8888', '987 Maple St', '1992-10-10'),
(7, 'Emma', 'Johnson', 'emma.johnson@example.com', '34567890', '222-333-4444', '111-222-3333', '321 Oak St', '1995-05-05'),
(8, 'Michael', 'Davis', 'michael.davis@example.com', '09876543', '444-555-6666', '333-444-5555', '654 Elm St', '1982-06-06'),
(9, 'Dr. Laura', 'Wilson', 'dr.wilson@example.com', '56789012', '777-888-9999', '888-999-0000', '123 Pine St', '1978-07-07'),
(10, 'Emily', 'Taylor', 'emily.taylor@example.com', '65432109', '555-666-7777', '444-555-6666', '987 Maple St', '1987-08-08'),
(11, 'Dr. Daniel', 'Clark', 'dr.clark@example.com', '89012345', '888-999-0000', '777-888-9999', '321 Pine St', '1974-11-11'),
(12, 'Sophia', 'Martin', 'sophia.martin@example.com', '43210987', '999-000-1111', '888-999-0000', '654 Maple St', '1989-12-12')
-- Agrega más registros de usuario_desc aquí...

-- Inserts para la tabla 'especialidad'
INSERT INTO especialidad (detalle) VALUES
('Cardiología'),
('Dermatología'),
('Pediatría'),
('Neurología'),
('Ginecología'),
('Oftalmología'),
('Ortopedia'),
('Psicología')
-- Agrega más registros de especialidad aquí...

-- Inserts para la tabla 'medico_especialidad'
INSERT INTO medico_especialidad (especialidad_id, medico_id) VALUES
(1, 3), -- El médico con ID 3 tiene la especialidad de Cardiología
(2, 3), -- El médico con ID 3 tiene también la especialidad de Dermatología
(3, 5), -- El médico con ID 5 tiene la especialidad de Pediatría
(4, 9), -- El médico con ID 9 tiene la especialidad de Ginecología
(5, 9), -- El médico con ID 9 tiene también la especialidad de Oftalmología
(6, 11) -- El médico con ID 11 tiene la especialidad de Ortopedia
-- Agrega más registros de medico_especialidad aquí...

-- Inserts para la tabla 'horarios'
INSERT INTO horarios (medico_id, especialidad_id, hora_entrada, hora_salida, dia) VALUES
(3, 1, 8, 16, 1), -- El médico con ID 3 tiene horario de 8 AM a 4 PM los lunes para Cardiología
(3, 2, 10, 18, 3), -- El médico con ID 3 tiene horario de 10 AM a 6 PM los miércoles para Dermatología
(5, 3, 9, 17, 2), -- El médico con ID 5 tiene horario de 9 AM a 5 PM los martes para Pediatría
(9, 4, 9, 17, 2), -- El médico con ID 9 tiene horario de 9 AM a 5 PM los martes para Ginecología
(9, 5, 11, 19, 4), -- El médico con ID 9 tiene horario de 11 AM a 7 PM los jueves para Oftalmología
(11, 6, 8, 16, 3) -- El médico con ID 11 tiene horario de 8 AM a 4 PM los miércoles para Ortopedia

-- Agrega más registros de horarios aquí...

-- Inserts para la tabla 'turno'
INSERT INTO turno (medico_id, especialidad_id, paciente_id, observaciones, estado, fecha) VALUES
(3, 1, 4, 'El paciente presenta dolor en el pecho.', 1, '2023-07-15 10:00:00'),
(3, 2, 4, 'El paciente necesita una consulta de rutina.', 1, '2023-07-17 15:30:00'),
(5, 3, 6, 'El paciente tiene fiebre alta.', 1, '2023-07-16 11:15:00'),
(9, 4, 10, 'La paciente necesita una consulta de rutina.', 1, '2023-07-18 14:30:00'),
(9, 5, 12, 'El paciente tiene problemas de visión.', 1, '2023-07-19 16:45:00'),
(11, 6, 12, 'El paciente se fracturó el brazo.', 1, '2023-07-20 10:00:00')

-- Agrega más registros de turno aquí...

-- Inserts para la tabla 'obra_social'
INSERT INTO obra_social (usuario_id, nombre, numero_afiliado) VALUES
(4, 'OSDE', '123456789'),
(6, 'Swiss Medical', '987654321'),
(10, 'OSDE', '111222333'),
(12, 'Swiss Medical', '444555666')
-- Agrega más registros de obra_social aquí...
GO