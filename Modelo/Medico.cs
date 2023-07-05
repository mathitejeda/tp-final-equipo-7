using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public class Medico
    {
        private int id;
        private string nombre;
        private string apellido;
        private List<Especialidad> especialidades;
        private string mail=null;
        private string dni=null;
        private string telefono=null;
        private string direccion=null;
        private DateTime fechaNacimiento;

        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Mail { get; set; }
        public string Dni { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public List<Especialidad> Especialidades { get; set; }

        public void addEspecialidad(Especialidad especialidad)
        {
            Especialidades.Add(especialidad);
        }
    }
}
