﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    public enum TipoUsuario
    {
        Administrador = 0,
        Recepcionista = 1,
        Medico = 2,
        Paciente = 3,
    }
    public class Usuario
    {
        private int id;
        private string user;
        private string pass;
        TipoUsuario TipoUsuario { get; set; }

        public int Id { get; set; }
        public string User { get; set; }
        public string Pass { get; set; }

        public Usuario () { }
        public Usuario (string user, string pass, TipoUsuario tipo)
        {
            this.user = user;
            this.pass = pass;
            this.TipoUsuario = tipo;
        }
    }
}
