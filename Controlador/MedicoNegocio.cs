using System;
using System.Collections.Generic;
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
            try
            {
                string consulta = "SELECT ud.usuario_id as Id, ud.nombre as Nombre, ud.apellido as Apellido from usuario_desc ud where ud.tipo=2";
                datos.SetConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    List<Especialidad> especialidades = new List<Especialidad>();
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];

                    //falta sumar especialidades de la db a la lista
                    //aux.Especialidades = especialidades;
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
