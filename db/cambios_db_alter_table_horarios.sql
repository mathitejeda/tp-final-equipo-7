use DB_CLINICA
GO
alter table horarios add especialidad_id int FOREIGN key references especialidad(id)
update horarios set especialidad_id=1 where medico_id=3 and dia=1 and hora_entrada=8 and hora_salida=16