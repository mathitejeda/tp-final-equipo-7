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
        public List <Horario> listar()
        {
            List<Horario> listaHorarios = new List<Horario>();
            AccesoDatos datos = new AccesoDatos();  

            MedicoNegocio negocioMedico = new MedicoNegocio();
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();

            try
            {
                string query = "select medico_id, cast(dia as int) as dia, hora_entrada, hora_salida, especialidad_id from horarios";
                datos.SetConsulta(query);
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


    }
}
