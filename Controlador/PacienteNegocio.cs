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
                datos.SetConsulta("select ud.usuario_id, ud.nombre, ud.apellido, ud.DNI, ud.direccion, ud.Telefono, ud.email, ud.fecha_nacimiento, os.nombre as obra_social, os.numero_afiliado from usuario u join usuario_desc ud on (ud.usuario_id=u.id) left join obra_social os on (os.usuario_id=u.id) where u.tipo=3 and u.estado!=0");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Paciente aux = new Paciente();
                    aux.Id = (int)datos.Lector["usuario_id"];
                    aux.Nombre = datos.Lector["nombre"].ToString();
                    aux.Apellido = datos.Lector["apellido"].ToString();
                    aux.Dni = datos.Lector["DNI"].ToString();
                    aux.Direccion = datos.Lector["direccion"].ToString();
                    aux.Telefono = datos.Lector["Telefono"].ToString();
                    aux.Email = datos.Lector["email"].ToString();
                    aux.FechaNacimiento = (DateTime)datos.Lector["fecha_nacimiento"];
                    aux.ObraSocial = datos.Lector["obra_social"].ToString();
                    aux.NumeroAfiliado = datos.Lector["numero_afiliado"].ToString();
                    aux.Turnos = turnoNegocio.listTurnosByPacienteID(aux.Id);
                    pacientes.Add(aux);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
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
                datos.SetConsulta($"select ud.usuario_id, ud.nombre, ud.apellido, ud.DNI, ud.direccion, ud.Telefono, ud.email, ud.fecha_nacimiento, os.nombre as obra_social, os.numero_afiliado from usuario_desc ud join usuario u on (u.id=ud.usuario_id) left join obra_social os on (os.usuario_id=u.id) where ud.usuario_id={id}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    paciente.Id = (int)datos.Lector["usuario_id"];
                    paciente.Nombre = datos.Lector["nombre"].ToString();
                    paciente.Apellido = datos.Lector["apellido"].ToString();
                    paciente.Dni = datos.Lector["DNI"].ToString();
                    paciente.Direccion = datos.Lector["direccion"].ToString();
                    paciente.Telefono = datos.Lector["Telefono"].ToString();
                    paciente.Email = datos.Lector["email"].ToString();
                    paciente.FechaNacimiento = (DateTime)datos.Lector["fecha_nacimiento"];
                    paciente.ObraSocial = datos.Lector["obra_social"].ToString();
                    paciente.NumeroAfiliado = datos.Lector["numero_afiliado"].ToString();
                    paciente.Turnos = turnoNegocio.listTurnosByPacienteID(paciente.Id);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
            return paciente;
        }
        public Paciente getPacienteByIdSinTurnos(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            Paciente paciente = new Paciente();
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            try
            {
                datos.SetConsulta($"select ud.usuario_id, ud.nombre, ud.apellido, ud.DNI, ud.direccion, ud.Telefono, ud.email, ud.fecha_nacimiento, os.nombre as obra_social, os.numero_afiliado from usuario_desc ud join usuario u on (u.id=ud.usuario_id) left join obra_social os on (os.usuario_id=u.id) where ud.usuario_id={id}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                paciente.Id = (int)datos.Lector["usuario_id"];
                paciente.Nombre = datos.Lector["nombre"].ToString();
                paciente.Apellido = datos.Lector["apellido"].ToString();
                paciente.Dni = datos.Lector["DNI"].ToString();
                paciente.Direccion = datos.Lector["direccion"].ToString();
                paciente.Telefono = datos.Lector["Telefono"].ToString();
                paciente.Email = datos.Lector["email"].ToString();
                paciente.FechaNacimiento = (DateTime)datos.Lector["fecha_nacimiento"];
                paciente.ObraSocial = datos.Lector["obra_social"].ToString();
                paciente.NumeroAfiliado = datos.Lector["numero_afiliado"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
            return paciente;
        }
        public void agregar(Paciente aux)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            try
            {
                string genericPass = aux.FechaNacimiento.Year.ToString() + aux.FechaNacimiento.Day.ToString(); //estaria bueno crear una variable de firstlogin para que la primera vez que se ingrese se requiera obligatoriamente que se cambie la contrasena por motivos de seguridad
                Usuario usr = new Usuario(aux.Dni, genericPass, TipoUsuario.Paciente);
                usr.Id = usuarioNegocio.agregar(usr.User, usr.Pass, (int)TipoUsuario.Paciente);
                accesoDatos.SetConsulta("insert into usuario_desc (usuario_id, nombre, apellido, DNI, direccion, Telefono, email, fecha_nacimiento) values (@id, @nombre, @apellido, @dni, @direccion, @telefono, @email, @fecha_nacimiento)");
                accesoDatos.setearParametro("@id", usr.Id);
                accesoDatos.setearParametro("@nombre", aux.Nombre);
                accesoDatos.setearParametro("@apellido", aux.Apellido);
                accesoDatos.setearParametro("@dni", aux.Dni);
                accesoDatos.setearParametro("@direccion", aux.Direccion);
                accesoDatos.setearParametro("@telefono", aux.Telefono);
                accesoDatos.setearParametro("@email", aux.Email);
                accesoDatos.setearParametro("@fecha_nacimiento", aux.FechaNacimiento.Date);
                accesoDatos.EjecutarAccion();
                //accesoDatos.SetConsulta("insert into obra_social (usuario_id, nombre, numero_afiliado) values(@id, @nombre, @afiliado)");
                //accesoDatos.setearParametro("@id", usr.Id);
                //accesoDatos.setearParametro("@nombre", aux.ObraSocial);
                //accesoDatos.setearParametro("@afiliado", aux.NumeroAfiliado);
                //accesoDatos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                accesoDatos.CerrarConexion();
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
                datos.SetConsulta("UPDATE usuario_desc SET nombre=@nombre, apellido=@apellido, DNI=@dni, direccion=@direccion, Telefono=@telefono, email=@email, fecha_nacimiento=@fecha_nacimiento WHERE usuario_id=@id");
                datos.setearParametro("@id", paciente.Id);
                datos.setearParametro("@nombre", paciente.Nombre);
                datos.setearParametro("@apellido", paciente.Apellido);
                datos.setearParametro("@dni", paciente.Dni);
                datos.setearParametro("@direccion", paciente.Direccion);
                datos.setearParametro("@telefono", paciente.Telefono);
                datos.setearParametro("@email", paciente.Email);
                datos.setearParametro("@fecha_nacimiento", paciente.FechaNacimiento.Date);
                datos.EjecutarAccion();
                //datos.SetConsulta("UPDATE obra_social set nombre='@nombre', numero_afiliado='@numero_afiliado' where usuario_id=@id");
                //datos.setearParametro("@nombre", paciente.ObraSocial);
                //datos.setearParametro("@afiliado", paciente.NumeroAfiliado);
                //datos.EjecutarAccion();
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
