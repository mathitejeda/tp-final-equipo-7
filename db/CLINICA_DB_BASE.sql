use master
GO

DROP DATABASE DB_CLINICA
GO

Create database DB_CLINICA
GO

use DB_CLINICA
GO

create table usuario (
	id int primary key not null identity (1,1),
	usuario varchar(16) not null unique,
	contrasenia varchar(64) not null,
	tipo int not null default(0),
	estado bit default(1), --1 activo, 0 inactivo
)
GO

create table usuario_desc (
	usuario_id int foreign key references usuario(id),
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	EMail varchar(100) null,
	DNI varchar(12) null,
	Telefono varchar(20) null,
	Celular varchar(20) null,
	direccion varchar(50) null,
	fecha_nacimiento date null,
)
GO

create table especialidad (
	id int primary key identity (1,1),
	detalle varchar(50) not null,
	CONSTRAINT especialidad_unica UNIQUE(detalle)
)
GO

create table medico_especialidad (
	especialidad_id int not null foreign key references especialidad(id),
	medico_id int not null foreign key references usuario(id),
	constraint especialidad_repetida unique(especialidad_id, medico_id)
)

GO

create table horarios (
	id_horario int primary key identity(1,1) not null,
	medico_id int not null foreign key references usuario(id),
	especialidad_id int FOREIGN key references especialidad(id),
	hora_entrada tinyint,
	hora_salida tinyint,
	dia tinyint,
	estado bit default(1) not null
)
GO

create table turno (
	id int primary key identity(1,1),
	medico_id int not null foreign key references usuario(id),
	especialidad_id int FOREIGN key references especialidad(id),
	paciente_id int not null foreign key references usuario(id),
	observaciones varchar(512),
	estado int default(1), --1 representa un estado nuevo,
	fecha datetime,
)
GO

create table obra_social (
	usuario_id int not null foreign key references usuario(id) unique,
	nombre varchar(20) not null,
	numero_afiliado varchar(50) not null,
	CONSTRAINT afiliado_repetido unique(nombre, numero_afiliado)
)
GO