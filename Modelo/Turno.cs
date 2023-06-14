using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    enum EstadoTurno
    {
        Pendiente = 1,
        Cancelado = 2,
        Atendido = 3,
        Reprogramado = 4
    }
    public class Turno
    {
        private int idPaciente;
        private int idMedico;
        private DateTime fecha;
        private string observaciones;
        private EstadoTurno estado;

        public int IdPaciente { get; set; }
        public int IdMedico { get; set; }
        public DateTime Fecha { get; set; }
        public string Observaciones { get; set; }
        public EstadoTurno Estado { get; set; }

    }
}
