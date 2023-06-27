use DB_CLINICA

GO

insert into usuario (usuario,contrasenia) values('admin', '1234')
insert into usuario (usuario,contrasenia) values('hugo_recep', '1234')
insert into usuario (usuario,contrasenia) values('dramor', '1234')
insert into usuario (usuario, contrasenia) values('jramir', '1234')
insert into usuario (usuario, contrasenia) values('dbowie', '1234')

GO

insert into usuario_desc (usuario_id,nombre,apellido) values(3, 'esteban', 'amor')

GO

insert into especialidad values('cardiologo')

GO

insert into medico_especialidad values(1,3)

GO

insert into usuario_desc (usuario_id, nombre, apellido, DNI, direccion, Telefono, email, fecha_nacimiento, tipo) values (4, 'juan', 'ramirez', '20.20.20', 'algunlado 1234', '000000', 'jram@gmail.com', '1997-12-17', 3)
insert into usuario_desc (usuario_id, nombre, apellido, DNI, direccion, email, fecha_nacimiento, tipo) values (5, 'david', 'bowie', '124.168.0.1', 'el cielo f', 'eldebo@hotmail.com', '1947-01-08', 3)