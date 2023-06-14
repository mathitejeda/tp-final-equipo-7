using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public class Medico : Usuario
    {
        private int id;
        private string nombre;
        private string apellido;
        private List<Especialidad> especialidades;

        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public List<Especialidad> Especialidades { get; set; }

        public void addEspecialidad(Especialidad especialidad)
        {
            Especialidades.Add(especialidad);
        }
        
    }


}
