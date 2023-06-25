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
                string consulta = "SELECT ud.usuario_id as Id, ud.nombre as Nombre, ud.apellido as Apellido from usuario_desc ud where ud.tipo=2";
                datos.SetConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                   // List<Especialidad> especialidades = new List<Especialidad>();
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                   // especialidades = negocioEspecialidades.getEspecialidadesFromIdMedico(aux.Id);
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
                string consulta = "SELECT ud.usuario_id as Id, ud.nombre as Nombre, ud.apellido as Apellido from usuario_desc ud where ud.tipo=2 and ud.usuario_id=@id";
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
                string consulta = "INSERT INTO usuario_desc (usuario_id, nombre,apellido,tipo) VALUES (@id,'@nombre','@apellido',2)";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@nombre", aux.Nombre);
                accesoDatos.setearParametro("@apellido", aux.Apellido);
                accesoDatos.setearParametro("@id", aux.Id);
                accesoDatos.EjecutarAccion();
                try
                {
                    foreach (Especialidad especialidad in aux.Especialidades)
                    {
                        consulta = "INSERT INTO medico_especialidad (medico_id, especialidad_id) VALUES (@medico_id,@especialidad_id)";
                        accesoDatos.SetConsulta(consulta);
                        accesoDatos.setearParametro("@medico_id", aux.Id);
                        accesoDatos.setearParametro("@especialidad_id", especialidad.Id);
                        accesoDatos.EjecutarAccion();
                    }

                }
                catch (SqlException ex)
                {
                    throw ex;
                }

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
                string consulta = "UPDATE usuario_desc SET nombre='@nombre', apellido='@apellido' WHERE usuario_id=@id";
                datos.SetConsulta(consulta);
                datos.setearParametro("@nombre", aux.Nombre);
                datos.setearParametro("@apellido", aux.Apellido);
                datos.setearParametro("@id", aux.Id);
                datos.EjecutarAccion();
                try
                {
                    consulta = "DELETE FROM medico_especialidad WHERE medico_id=@id";
                    datos.SetConsulta(consulta);
                    datos.setearParametro("@id", aux.Id);
                    datos.EjecutarAccion();
                    foreach (Especialidad especialidad in aux.Especialidades)
                    {
                        consulta = "INSERT INTO medico_especialidad (medico_id, especialidad_id) VALUES (@medico_id,@especialidad_id)";
                        datos.SetConsulta(consulta);
                        datos.setearParametro("@medico_id", aux.Id);
                        datos.setearParametro("@especialidad_id", especialidad.Id);
                        datos.EjecutarAccion();
                    }
                }
                catch (SqlException ex)
                {
                    throw ex;
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

        public void eliminar(int id)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                string consulta = "DELETE FROM usuario_desc WHERE usuario_id=@id";
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

    }
}
