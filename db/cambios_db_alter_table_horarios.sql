use DB_CLINICA
GO
alter table horarios add especialidad_id int FOREIGN key references especialidad(id)