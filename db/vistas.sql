use DB_CLINICA

GO

create view vw_usuario_medico
AS
	select ud.usuario_id, ud.nombre, ud.apellido
	from usuario_desc ud
	where ud.tipo=2

GO

create view vw_usuario_paciente
AS
	select ud.usuario_id, ud.nombre, ud.apellido, ud.DNI, ud.Telefono, ud.direccion, ud.Telefono, ud.email, ud.fecha_nacimiento
	from usuario_desc ud
	where ud.tipo=3