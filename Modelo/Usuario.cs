using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace Modelo
{
    enum TipoUsuario
    {
        Medico,
        Paciente,
        Recepcionista,
        Administrador
    }
    public class Usuario
    {
        private int id;
        private string user;
        private string pass;
        
        public int Id { get; set; }
        public string User { get; set; }
        public string Pass { get; set; }
        public TipoUsuario Tipo { get; set; }
        
    }
}
