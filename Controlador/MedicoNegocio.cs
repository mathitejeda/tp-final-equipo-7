using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Modelo;

namespace Controlador
{
    public class MedicoNegocio
    {
        public List<Medico> listar()
        {
            List<Medico> listaMedicos = new List<Medico>();
            AccesoDatos datos = new AccesoDatos();
            EspecialidadNegocio negocioEspecialidades = new EspecialidadNegocio();
            try
            {
                string consulta =   "SELECT ud.usuario_id as Id, ud.nombre, ud.apellido, ud.email, ud.dni, ud.telefono, ud.direccion, ud.fecha_nacimiento " +
                                    "from usuario_desc ud " +
                                    "INNER join usuario u on u.id=ud.usuario_id " +
                                    "where u.tipo=2 and u.estado=1";
                datos.SetConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Mail = datos.Lector["Email"] == DBNull.Value ? null : (string)datos.Lector["Email"];
                    aux.Dni = datos.Lector["DNI"] == DBNull.Value ? null : (string)datos.Lector["DNI"];
                    aux.Telefono =  datos.Lector["Telefono"] == DBNull.Value ? null : (string)datos.Lector["Telefono"];
                    aux.Direccion = datos.Lector["Direccion"] == DBNull.Value ? null : (string)datos.Lector["Direccion"];
                    aux.FechaNacimiento = datos.Lector["Fecha_Nacimiento"] == DBNull.Value ? DateTime.MinValue : (DateTime)datos.Lector["Fecha_Nacimiento"];
                    aux.Especialidades = negocioEspecialidades.getEspecialidadesFromIdMedico(aux.Id);
                    listaMedicos.Add(aux);
                }
                return listaMedicos;
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

        public Medico getMedico(int id)
        {
            Medico aux = new Medico();
            AccesoDatos datos = new AccesoDatos();
            EspecialidadNegocio negocioEspcialidades = new EspecialidadNegocio();
            try
            {
                string consulta = "SELECT ud.usuario_id as Id, ud.nombre, ud.apellido, ud.email, ud.dni, ud.telefono, ud.direccion, ud.fecha_nacimiento " +
                                    "from usuario_desc ud " +
                                    "INNER join usuario u on u.id=ud.usuario_id " +
                                    "where u.tipo=2 and u.estado=1 and u.id=@id";
                datos.SetConsulta(consulta);
                datos.setearParametro("@id", id);
                datos.EjecutarLectura();
                if (datos.Lector.Read())
                {
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Mail = datos.Lector["Email"] == DBNull.Value ? null : (string)datos.Lector["Email"];
                    aux.Dni = datos.Lector["DNI"] == DBNull.Value ? null : (string)datos.Lector["DNI"];
                    aux.Telefono = datos.Lector["Telefono"] == DBNull.Value ? null : (string)datos.Lector["Telefono"];
                    aux.Direccion = datos.Lector["Direccion"] == DBNull.Value ? null : (string)datos.Lector["Direccion"];
                    aux.FechaNacimiento = datos.Lector["Fecha_Nacimiento"] == DBNull.Value ? DateTime.MinValue : (DateTime)datos.Lector["Fecha_Nacimiento"];
                    aux.Especialidades = negocioEspcialidades.getEspecialidadesFromIdMedico(aux.Id);
                    return aux;
                }
                else
                {
                    return null;
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
        }

        public void agregar(Medico aux)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                UsuarioNegocio negocioUsuario = new UsuarioNegocio();

                int id = negocioUsuario.agregar(aux.Dni, aux.Dni, (int)TipoUsuario.Medico);

                string consulta =   "INSERT INTO usuario_desc (usuario_id, nombre, apellido, email, dni, telefono, direccion, fecha_nacimiento) " +
                                    "VALUES (@id,@nombre,@apellido,@mail,@dni,@telefono,@direccion,@fechaNac)";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@id", id);
                accesoDatos.setearParametro("@nombre", aux.Nombre);
                accesoDatos.setearParametro("@apellido", aux.Apellido);
                accesoDatos.setearParametro("@mail", aux.Mail);
                accesoDatos.setearParametro("@dni", aux.Dni);
                accesoDatos.setearParametro("@telefono", aux.Telefono);
                accesoDatos.setearParametro("@direccion", aux.Direccion);
                accesoDatos.setearParametro("@fechaNac", aux.FechaNacimiento.ToString("dd/MM/yyyy"));
                accesoDatos.EjecutarAccion();
                aux.Id = id;
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                especialidadNegocio.asociarEsp(aux);
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

        public void modificar(Medico aux)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta =   "UPDATE usuario_desc " +
                                    "SET nombre=@nombre, apellido=@apellido, email=@mail, dni=@dni, telefono=@telefono, direccion=@direccion, fecha_nacimiento = @fechanac " +
                                    "WHERE usuario_id=@id\n" +
                                    "DELETE FROM medico_especialidad WHERE medico_id=@id2";
                datos.SetConsulta(consulta);
                datos.setearParametro("@nombre", aux.Nombre);
                datos.setearParametro("@apellido", aux.Apellido);
                datos.setearParametro("@id", aux.Id);
                datos.setearParametro("@id2", aux.Id);
                datos.setearParametro("@mail", aux.Mail);
                datos.setearParametro("@dni", aux.Dni);
                datos.setearParametro("@telefono", aux.Telefono);
                datos.setearParametro("@direccion", aux.Direccion);
                datos.setearParametro("@fechanac", aux.FechaNacimiento.ToString("dd/MM/yyyy"));
                datos.EjecutarAccion();
                EspecialidadNegocio auxEsp = new EspecialidadNegocio();
                auxEsp.asociarEsp(aux);
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

        public void eliminar(int id) //no usar
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                string consulta = "DELETE FROM usuario_desc WHERE usuario_id=@id\nDELETE FROM medico_especialidad WHERE medico_id=@id2\nDELETE FROM usuario where id=@id3";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@id", id);
                accesoDatos.setearParametro("@id2", id);
                accesoDatos.setearParametro("@id3", id);
                accesoDatos.EjecutarAccion();
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
        public void bajaLogica(int id)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                string consulta = "UPDATE usuario SET estado=0 WHERE id=@id";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@id", id);
                accesoDatos.SetConsulta(consulta);
                accesoDatos.EjecutarAccion();
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

        public List<Medico> getMedicosFromEspecialidad(int id)
        {
            List<Medico> listaMedicos = new List<Medico>();
            AccesoDatos datos = new AccesoDatos();
            EspecialidadNegocio negocioEspecialidades = new EspecialidadNegocio();
            try
            {
                string consulta =   "SELECT ud.usuario_id as Id " +
                                    "from usuario_desc ud " +
                                    "inner join medico_especialidad me on ud.usuario_id=me.medico_id " +
                                    "inner join usuario u on u.id = ud.usuario_id " +
                                    "where me.especialidad_id=@id and u.estado=1";
                datos.SetConsulta(consulta);
                datos.setearParametro("@id", id);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    MedicoNegocio auxNegocio = new MedicoNegocio();
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux = auxNegocio.getMedico(aux.Id);
                    listaMedicos.Add(aux);
                }
                return listaMedicos;
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
