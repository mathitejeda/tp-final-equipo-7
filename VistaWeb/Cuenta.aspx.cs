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
    public partial class Cuenta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnIniciarSesionSubmit_Click(object sender, EventArgs e)
        {
            Usuario user;
            UsuarioNegocio  negocioUsuario = new UsuarioNegocio();
            try
            {
                user = new Usuario(tbxUsernameLogin.Text, tbxPasswordLogin.Text);
                if (negocioUsuario.VerificarLogin(user))
                {
                    int id = negocioUsuario.findIdByUserName(tbxUsernameLogin.Text);
                    user = negocioUsuario.getUsuario(id);
                    Session.Add("UsuarioLogueado", user);
                    Response.Redirect("Cuenta.aspx", false);
                } else
                {
                    Session.Add("Error", "Los datos ingresados no son correctos. Intente nuevamente");
                    Response.Redirect("Error.aspx", false);
                }

            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
            }
        }
    }
}