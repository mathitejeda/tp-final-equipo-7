using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public class Paciente
    {
        private int id;
        private string nombre;
        private string apellido;
        private string dni;
        private string telefono;
        private string direccion;
        private string email;
        private DateTime fechaNacimiento;
        private string obraSocial;
        private string numeroAfiliado;
        private List<Turno> turnos;

        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; } 
        public string Dni { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; } 
        public string Email { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string ObraSocial { get; set; }
        public string NumeroAfiliado { get; set; }
        public List<Turno> Turnos { get; set; }
    }
}
