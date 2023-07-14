use DB_CLINICA

alter table turno add especialidad_id int FOREIGN key references especialidad(id)