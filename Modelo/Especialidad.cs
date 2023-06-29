using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public class Especialidad
    {
        private int id;
        private string nombre;
        
        public int Id { get; set; }
        public string Nombre { get; set; }
        public Especialidad() { }
        public Especialidad(int id, string nombre)
        {
            Id = id;
            Nombre = nombre;
        }
        public override string ToString()
        {
            return Nombre;
        }
    }
}
