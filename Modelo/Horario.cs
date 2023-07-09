using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public class Horario
    {
        public Medico Medico { get; set; }
        public int DiaSem { get; set; }
        public int HsEntrada { get; set; }
        public int HsSalida { get; set; }
        public Especialidad Especialidad { get; set; } 
           
        
        public Horario() { }
        public Horario(Medico med, int dia, int hsE, int hsS, Especialidad especialidad)
        {
            this.Medico = med;
            this.DiaSem = dia;
            this.HsEntrada = hsE;
            this.HsSalida = hsS;
            this.Especialidad = especialidad;
        }

    }
}
