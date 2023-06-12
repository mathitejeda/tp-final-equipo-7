# Clases del proyecto
 Si vamos a las clases basicas el proyecto necesita tener al menos las siguientes clases:
 
## Medico:
nombre y apellido, especialidad. Esta especialidad deberia ser una lista de especialidades, la verdad no queria agregarlo asi pero como un medico puede tener varias especialides va a ser necesario.
## Especialidad
Ver medico
## Paciente
nombre y apellido, dni, contacto. Habria que ver como manejar la historia clinica, capaz haya que crear una nueva clase? o capaz una lista que tenga observaciones del mismo, aunque una historia podria tener la fecha en la que esta se creo asi que capaz una fecha seria mas adecuada
## turno
El turno tambien hay que cranearlo un toque, este podria tener diferentes maneras de encararlo y habria que ver cual es la mejor. Capaz ni siquiera se podria agregar una fecha, pero en la base de datos si podria reflejarse algo. En este caso se podria usar un enum para poder agregar eso de si el turno es nuevo, reprogramado, cancelado, o asistio y asi.
## usuario
Una clase usuario es necesaria para poder acceder a los datos requeridos. Aca tambien podria haber un enum, aunque por ahora solo hay 3: Admin, recepcionista y medico. Si queda tiempo una algo piola de agregar seria un nivel de usuario de paciente, en el que este solo podria ver sus turnos, pero no gestionarlos.  En el video de usuario maxi habla de tener permisos y eso, tambien habla de una clase de utilidad. En este caso tambien podria haber permisos por pagina. Estaria bueno agregarlo pero de nuevo se va por el lado de la complejidad. Me causa curiosidad ver como se puede agregar a la clase de utilidad permisos como PUEDEVERX o algo asi, al usuario se le podria agregar algo como usuario.puedeverx, o usuario.esadmin y asi. No se bien como se pueden agregar estas funcionalidades a las diferentes clases. Capaz herrencia?

## utils
Podriamos hacer una clase de utils en la que guardemos diferentes enums, parece una boludez pero podria servir a medida que se avanza con la app
# En la base de datos
Aca estaria lo mas complejo, aunque no necesariamente. En esta parte tendriamos las siguientes tablas:
## Medico
datos personales y no mucho mas. No le agrego contacto porque usualmente en los trabajos es suele ser algo mas personal, aunque capaz se pueda agregar un mail que podria ser interno, capaz.
## Especialidad por medico
En la tarea se especifica que el medico puede tener una o varias especialidades, por lo que habria que tener una tabla asi para poder cubrir ese caso.
## Especialidad
id y detalle
## Paciente
datos personales, a este se le deberian agregar datos de contacto. Capaz tambien conviene tener la cobertura pero la verdad seria toda una rama de complejidad que no estaria viniendo al caso
## Turno
Turno tiene el id del paciente, el id de medico y una observacion; ademas del horario y el estado
## Usuario
Cosas del usuario para poder logearse y eso, no mucho mas que un nombre de usuario y contraseña.
De lo que me queda la duda son los horarios. Deberia arreglar eso con el grupo
