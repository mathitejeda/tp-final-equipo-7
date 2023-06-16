use DB_CLINICA

GO

insert into usuario (usuario,contrasenia) values('admin', '1234')
insert into usuario (usuario,contrasenia) values('hugo_recep', '1234')
insert into usuario (usuario,contrasenia) values('dramor', '1234')

GO

insert into usuario_desc (usuario_id,nombre,apellido) values(3, 'esteban', 'amor')

GO

insert into especialidad values('cardiologo')

GO

insert into medico_especialidad values(1,3)

GO