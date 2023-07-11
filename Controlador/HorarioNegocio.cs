using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Modelo;


namespace Controlador
{
    public class HorarioNegocio
    {

        public List<Horario> listarPorMedicoYEspecialidad(int idMedico, int idEspecialidad)
        {
            List<Horario> listaHorarios = new List<Horario>();
            AccesoDatos datos = new AccesoDatos();

            MedicoNegocio negocioMedico = new MedicoNegocio();
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
            try
            {
                string query = "select medico_id, cast(dia as int) as dia, hora_entrada, hora_salida, especialidad_id from horarios " +
                                "WHERE medico_id=@id and especialidad_id=@id2 " +
                                "ORDER BY dia ASC";
                datos.SetConsulta(query);
                datos.setearParametro("@id", idMedico);
                datos.setearParametro("@id2", idEspecialidad);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Horario aux = new Horario();
                    aux.Medico = negocioMedico.getMedico((int)datos.Lector["medico_id"]);
                    aux.DiaSem = (Horario.DiaSemana)datos.Lector["dia"];
                    aux.HsEntrada = (Byte)datos.Lector["hora_entrada"];
                    aux.HsSalida = (Byte)datos.Lector["hora_salida"];
                    aux.Especialidad = especialidadNegocio.GetEspecialidad((int)datos.Lector["especialidad_id"]);
                    listaHorarios.Add(aux);
                }
                return listaHorarios;
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
        public List <Horario> listar()
        {
            List<Horario> listaHorarios = new List<Horario>();
            AccesoDatos datos = new AccesoDatos();  

            MedicoNegocio negocioMedico = new MedicoNegocio();
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();

            try
            {
                string query = "select h.id_horario, h.medico_id, cast(h.dia as int) as dia, h.hora_entrada, h.hora_salida, h.especialidad_id from horarios h inner join especialidad e on h.especialidad_id = e.id inner join usuario u on h.medico_id = u.id WHERE h.estado = 1 and u.estado = 1";
                datos.SetConsulta(query);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Horario aux = new Horario();
                    aux.Id = (int)datos.Lector["id_horario"];
                    aux.Medico = negocioMedico.getMedico((int)datos.Lector["medico_id"]);
                    aux.DiaSem = (Horario.DiaSemana)datos.Lector["dia"];
                    aux.HsEntrada = (Byte)datos.Lector["hora_entrada"];
                    aux.HsSalida = (Byte)datos.Lector["hora_salida"];
                    aux.Especialidad = especialidadNegocio.GetEspecialidad((int)datos.Lector["especialidad_id"]);
                    listaHorarios.Add(aux);
                }
                return listaHorarios;
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

        public void agregar(Horario aux)
        {
            AccesoDatos accesoDatos = new AccesoDatos();
            try
            {
                string consulta = "INSERT into horarios (medico_id, especialidad_id, dia, hora_entrada, hora_salida) " +
                    " values(@medico_id, @especialidad_id, @dia, @hsEntrada, @hsSalida)";
                accesoDatos.SetConsulta(consulta);
                accesoDatos.setearParametro("@medico_id", aux.Medico.Id);
                accesoDatos.setearParametro("@especialidad_id", aux.Especialidad.Id);
                accesoDatos.setearParametro("@dia", aux.DiaSem);
                accesoDatos.setearParametro("@hsEntrada", aux.HsEntrada);
                accesoDatos.setearParametro("@hsSalida", aux.HsSalida);
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

        public void modificar(Horario aux)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("update horarios set medico_id=@med_id, especialidad_id=@esp_id, dia=@diasem, hora_entrada=@hsEntrada, hora_salida=@hsSalida where id_horario=@id");
                datos.setearParametro("@id", aux.Id);
                datos.setearParametro("@med_id", aux.Medico.Id);
                datos.setearParametro("@esp_id", aux.Especialidad.Id);
                datos.setearParametro("@diasem", ((int)aux.DiaSem));
                datos.setearParametro("@hsEntrada", aux.HsEntrada);
                datos.setearParametro("@hsSalida", aux.HsSalida);
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

        public void eliminar(int id_horario)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta($"update horarios set estado=0 where id_horario={id_horario}");
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

    }
}
