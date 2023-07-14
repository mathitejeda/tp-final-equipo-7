using Controlador;
using Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VistaWeb
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Error"] != null)
            {
                lbl_ErrorMsj.Text = Session["Error"].ToString();
            }

        }
        public bool EstaLogueado()
        {
            if (((Modelo.Usuario)Session["UsuarioLogueado"]) != null)
            {
                return true;
            }
            return false;
        }
        public bool EsTipoUsuario(string tipo)
        {

            if (tipo == "admin" && ((Usuario)Session["UsuarioLogueado"]).TipoUsuario == TipoUsuario.Administrador)
            {
                return true;
            }
            if (tipo == "recepcionista" && ((Usuario)Session["UsuarioLogueado"]).TipoUsuario == TipoUsuario.Recepcionista)
            {
                return true;
            }
            if (tipo == "medico" && ((Usuario)Session["UsuarioLogueado"]).TipoUsuario == TipoUsuario.Medico)
            {
                return true;
            }
            if (tipo == "paciente" && ((Usuario)Session["UsuarioLogueado"]).TipoUsuario == TipoUsuario.Paciente)
            {
                return true;
            }
            return false;
        }
    }
}