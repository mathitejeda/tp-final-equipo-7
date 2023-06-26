using Microsoft.Win32;
using Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Controlador
{
    public class PacienteNegocio
    {
        public List<Paciente> listar()
        {
            List<Paciente> pacientes = new List<Paciente>();
            AccesoDatos datos = new AccesoDatos();
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            try
            {
                datos.SetConsulta("select ud.usuario_id, ud.nombre, ud.apellido, ud.DNI, ud.direccion, ud.Telefono, ud.email, ud.fecha_nacimiento, os.nombre as obra_social, os.numero_afiliado from usuario_desc ud join usuario u on (u.id=ud.usuario_id) join obra_social os on (os.usuario_id=u.id) where ud.tipo = 3 and u.estado!=0");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Paciente aux = new Paciente();
                    aux.Id = (int)datos.Lector["usuario_id"];
                    aux.Nombre = (string)datos.Lector["nombre"];
                    aux.Apellido = (string)datos.Lector["apellido"];
                    aux.Dni = (string)datos.Lector["DNI"];
                    aux.Direccion = (string)datos.Lector["direccion"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["email"];
                    aux.FechaNacimiento = (DateTime)datos.Lector["fecha_nacimiento"];
                    aux.ObraSocial = (string)datos.Lector["obra_social"];
                    aux.NumeroAfiliado = (string)datos.Lector["numero_afiliado"];
                    aux.Turnos = turnoNegocio.listTurnosByPacienteID(aux.Id);
                    pacientes.Add(aux);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return pacientes;
        }
        public Paciente getPacienteById(int id)
        {
            List<Paciente> pacientes = new List<Paciente>();
            AccesoDatos datos = new AccesoDatos();
            Paciente paciente = new Paciente();
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            try
            {
                datos.SetConsulta($"select ud.usuario_id, ud.nombre, ud.apellido, ud.DNI, ud.direccion, ud.Telefono, ud.email, ud.fecha_nacimiento, os.nombre as obra_social, os.numero_afiliado from usuario_desc ud join usuario u on (u.id=ud.usuario_id) join obra_social os on (os.usuario_id=u.id) where ud.usuario_id={id}");
                datos.EjecutarLectura();

                paciente.Id = (int)datos.Lector["usuario_id"];
                paciente.Nombre = (string)datos.Lector["nombre"];
                paciente.Apellido = (string)datos.Lector["apellido"];
                paciente.Dni = (string)datos.Lector["DNI"];
                paciente.Direccion = (string)datos.Lector["direccion"];
                paciente.Telefono = (string)datos.Lector["Telefono"];
                paciente.Email = (string)datos.Lector["email"];
                paciente.FechaNacimiento = (DateTime)datos.Lector["fecha_nacimiento"];
                paciente.ObraSocial = (string)datos.Lector["obra_social"];
                paciente.NumeroAfiliado = (string)datos.Lector["numero_afiliado"];
                paciente.Turnos = turnoNegocio.listTurnosByPacienteID(paciente.Id);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return paciente;
        }
        public void agregar(Paciente aux)
        {
            AccesoDatos datos = new AccesoDatos();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            try
            {
                string genericPass = aux.FechaNacimiento.Year.ToString() + aux.FechaNacimiento.Day.ToString(); //estaria bueno crear una variable de firstlogin para que la primera vez que se ingrese se requiera obligatoriamente que se cambie la contrasena por motivos de seguridad
                Usuario usr = new Usuario(aux.Dni, genericPass, TipoUsuario.Paciente);
                usuarioNegocio.agregar(usr.User, usr.Pass);
                usr.Id = usuarioNegocio.findIdByUserName(usr.User);
                datos.SetConsulta("insert into usuario_desc (usuario_id, nombre, apellido, DNI, direccion, Telefono, email, fecha_nacimiento) values (@id, @nombre, @apellido, @dni, @direccion, @telefono, @email, @fecha_nacimiento, @tipo)");
                datos.setearParametro("@id", usr.Id);
                datos.setearParametro("@nombre", aux.Nombre);
                datos.setearParametro("@apellido", aux.Apellido);
                datos.setearParametro("@dni", aux.Dni);
                datos.setearParametro("@direccion", aux.Direccion);
                datos.setearParametro("@telefono", aux.Telefono);
                datos.setearParametro("@email", aux.Email);
                datos.setearParametro("@fecha_nacimiento", aux.FechaNacimiento.ToString());
                datos.setearParametro("@tipo", TipoUsuario.Paciente);
                datos.EjecutarAccion();
                datos.SetConsulta("insert into obra_social (usuario_id, nombre, numero_afiliado) values(@id, @nombre, @afiliado)");
                datos.setearParametro("@id", usr.Id);
                datos.setearParametro("@nombre", aux.ObraSocial);
                datos.setearParametro("@afiliado", aux.NumeroAfiliado);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }

        public void baja (int paciente_id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta($"update usuario set estado=0 where id={paciente_id}");
                datos.EjecutarAccion();
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
        public void modificacion(Paciente paciente)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("UPDATE usuario_desc SET nombre='@nombre', apellido='@apellido' DNI='@dni', direccion='@direccion', Telefono='@telefono', email='@email', fecha_nacimiento='@fecha_nacimiento' WHERE usuario_id=@id");
                datos.setearParametro("@id", paciente.Id);
                datos.setearParametro("@nombre", paciente.Nombre);
                datos.setearParametro("@apellido", paciente.Apellido);
                datos.setearParametro("@dni", paciente.Dni);
                datos.setearParametro("@direccion", paciente.Direccion);
                datos.setearParametro("@telefono", paciente.Telefono);
                datos.setearParametro("@email", paciente.Email);
                datos.setearParametro("@fecha_nacimiento", paciente.FechaNacimiento.ToString());
                datos.EjecutarAccion();
                datos.SetConsulta("UPDATE obra_social set nombre='@nombre', numero_afiliado='@numero_afiliado' where usuario_id=@id");
                datos.setearParametro("@id", paciente.Id);
                datos.setearParametro("@nombre", paciente.ObraSocial);
                datos.setearParametro("@afiliado", paciente.NumeroAfiliado);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
