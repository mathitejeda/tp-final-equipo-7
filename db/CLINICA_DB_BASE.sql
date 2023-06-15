use master

GO

Create database DB_CLINICA

GO

use DB_CLINICA

GO

create table usuario (
	id int primary key not null identity (1,1),
	usuario varchar(16) not null unique,
	contrasenia varchar(64) not null,
	estado bit default(1), --1 activo, 0 inactivo
)

GO

create table usuario_desc (
	usuario_id int,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	EMail varchar(100) null,
	DNI varchar(12) null,
	Telefono varchar(20) null,
	Celular varchar(20) null,
	direccion varchar(50) null,
	fecha_nacimiento datetime null,
	tipo int not null default(0),
)

GO

create table especialidad (
	id int primary key identity (1,1),
	detalle varchar(50) not null
)

GO

create table medico_especialidad (
	especialidad_id int not null foreign key references especialidad(id),
	medico_id int not null foreign key references usuario(id),
)

GO

create table horarios (
	medico_id int not null foreign key references usuario(id),
	hora_entrada tinyint,
	hora_salida tinyint,
	dia tinyint,
)

GO

create table turno (
	id int primary key identity(1,1),
	medico_id int not null foreign key references usuario(id),
	paciente_id int not null foreign key references usuario(id),
	observaciones varchar(512),
	estado int default(1), --1 representa un estado nuevo,
	fecha datetime,
)

GO