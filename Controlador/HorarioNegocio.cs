using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
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
                string query = "select medico_id, dia, hora_entrada, hora_salida, especialidad_id from horarios";
                datos.SetConsulta(query);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Horario aux = new Horario();
                    aux.Medico = negocioMedico.getMedico((int)datos.Lector["medico_id"]);
                    aux.DiaSem = datos.Lector.GetByte(1);
                    aux.HsEntrada = datos.Lector.GetByte(2);
                    aux.HsSalida = datos.Lector.GetByte(3);
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
       

    }
}
