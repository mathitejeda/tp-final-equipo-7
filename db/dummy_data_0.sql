use DB_CLINICA

GO

insert into usuario (usuario,contrasenia) values('admin', '1234')
insert into usuario (usuario,contrasenia) values('hugo_recep', '1234')
insert into usuario (usuario,contrasenia, tipo) values('dramor', '1234', 2)
insert into usuario (usuario, contrasenia, tipo) values('jramir', '1234', 3)
insert into usuario (usuario, contrasenia, tipo) values('dbowie', '1234', 3)

GO

insert into usuario_desc (usuario_id,nombre,apellido) values(3, 'esteban', 'amor')

GO

insert into especialidad values('cardiologo')

GO

insert into medico_especialidad values(1,3)

GO

insert into horarios (medico_id, hora_entrada, hora_salida, dia) values (3, 08, 16, 1)

GO

insert into usuario_desc (usuario_id, nombre, apellido, DNI, direccion, Telefono, email, fecha_nacimiento) values (4, 'juan', 'ramirez', '20.20.20', 'algunlado 1234', '000000', 'jram@gmail.com', '1997-12-17')
insert into usuario_desc (usuario_id, nombre, apellido, DNI, direccion, Telefono, email, fecha_nacimiento) values (5, 'david', 'bowie', '124.168.0.1', 'el cielo f', '123123123', 'eldebo@hotmail.com', '1947-01-08')

GO

insert into turno (medico_id, paciente_id, fecha) values(3, 4, '2023-12-17 12:00:00')

GO