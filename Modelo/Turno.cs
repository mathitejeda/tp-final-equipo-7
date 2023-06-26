using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public enum EstadoTurno
    {
        Cerrado = 0,
        Nuevo = 1,
        Cancelado = 2,
        Atendido = 3,
        Reprogramado = 4,
		No_asistio = 5
    }
    public class Turno
    {
        public int id {  get; set; }
        public Paciente Paciente { get; set; } 
        public Medico Medico { get; set; }
        private DateTime fecha;
        private string observaciones;
        private EstadoTurno estado;

        public DateTime Fecha { get; set; }
        public string Observaciones { get; set; }
        public EstadoTurno Estado { get; set; }
    }
}
