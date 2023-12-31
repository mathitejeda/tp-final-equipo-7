﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public class Horario
    {
        public enum DiaSemana
        {
            Lunes = 1,
            Martes = 2,
            Miércoles = 3,
            Jueves = 4,
            Viernes = 5,
            Sábado = 6,
            Domingo = 0
        }
        public int Id { get; set; }
        public Medico Medico { get; set; }
        public DiaSemana DiaSem { get; set; }
        public int HsEntrada { get; set; }
        public int HsSalida { get; set; }
        public Especialidad Especialidad { get; set; } 
        public bool Estado { get; set; }
        
        public Horario() { }
        public Horario(int id, Medico med, DiaSemana dia, int hsE, int hsS, Especialidad especialidad)
        {

            this.Id = id;
            this.Medico = med;
            this.DiaSem = dia;
            this.HsEntrada = hsE;
            this.HsSalida = hsS;
            this.Especialidad = especialidad;
            this.Estado = true;
        }

    }
}
