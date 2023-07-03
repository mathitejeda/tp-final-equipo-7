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
                string consulta = "SELECT ud.usuario_id as Id, ud.nombre as Nombre, ud.apellido as Apellido from usuario_desc ud where u.tipo=2";
                datos.SetConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
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
            Medico aux;
            AccesoDatos datos = new AccesoDatos();
            EspecialidadNegocio negocioEspcialidades = new EspecialidadNegocio();
            try
            {
                string consulta = "SELECT ud.usuario_id as Id, ud.nombre as Nombre, ud.apellido as Apellido from usuario_desc ud where ud.usuario_id=@id";
                datos.SetConsulta(consulta);
                datos.setearParametro("@id", id);
                datos.EjecutarLectura();
                if (datos.Lector.Read())
                {
                    aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
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
                int id = negocioUsuario.agregar((aux.Nombre + aux.Apellido).Trim(), "1234", TipoUsuario.Medico);

                string consulta = "INSERT INTO usuario_desc (usuario_id, nombre,apellido) VALUES (@id,@nombre,@apellido)";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@id", id);
                accesoDatos.setearParametro("@nombre", aux.Nombre);
                accesoDatos.setearParametro("@apellido", aux.Apellido);
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
                string consulta =   "UPDATE usuario_desc SET nombre=@nombre, apellido=@apellido WHERE usuario_id=@id\n" +
                                    "DELETE FROM medico_especialidad WHERE medico_id=@id2";
                datos.SetConsulta(consulta);
                datos.setearParametro("@nombre", aux.Nombre);
                datos.setearParametro("@apellido", aux.Apellido);
                datos.setearParametro("@id", aux.Id);
                datos.setearParametro("@id2", aux.Id);
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

        public void eliminar(int id)
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
                accesoDatos.EjecutarAccion();
                consulta = "DELETE FROM medico_especialidad WHERE medico_id=@id";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@id", id);
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
                string consulta =   "SELECT ud.usuario_id as Id, ud.nombre as Nombre, ud.apellido as Apellido " +
                                    "from usuario_desc ud " +
                                    "inner join medico_especialidad me on ud.usuario_id=me.medico_id " +
                                    "where me.especialidad_id=@id";
                datos.SetConsulta(consulta);
                datos.setearParametro("@id", id);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
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

    }
}
