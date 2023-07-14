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
        public bool EstaLogueado()
        {
            if(((Modelo.Usuario)Session["UsuarioLogueado"]) != null)
            {
                return true;
            }
            return false;
        }

        public void imprimirDatos(string type)
        {
            if (type == "user")
            {
                Response.Write(((Modelo.Usuario)Session["UsuarioLogueado"]).User);
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["UsuarioLogueado"] != null)
            {
                // cargo la pass en el textbox
                //tbx_CambiarPass.Text = ((Usuario)Session["UsuarioLogueado"]).Pass;
                if (!IsPostBack && (bool)Session["MensajeLeido"] == false)
                {
                    string script = @"<script>
                             var div = document.getElementById('loginExitoso');
                             if (div) {
                                 div.style.display = 'block';
                             }
                             </script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowLogin", script);
                    Session.Add("MensajeLeido", true);
                }

            }

        }

        protected void btnIniciarSesionSubmit_Click(object sender, EventArgs e)
        {
            Usuario user;
            UsuarioNegocio negocioUsuario = new UsuarioNegocio();
            try
            {
                user = new Usuario(tbxUsernameLogin.Text, tbxPasswordLogin.Text);
                if (negocioUsuario.VerificarLogin(user))
                {
                    int id = negocioUsuario.findIdByUserName(tbxUsernameLogin.Text);
                    user = negocioUsuario.getUsuario(id);
                    Session.Add("UsuarioLogueado", user);
                    Response.Redirect("Cuenta.aspx", false);
                    Session.Add("MensajeLeido", false);
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

        protected void btnLogoutCuentaSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UsuarioLogueado"] != null)
            {
                Session.Remove("UsuarioLogueado");
            }
        }

        protected void btnCambiarPasswordSubmit_Click(object sender, EventArgs e)
        {
            Usuario usuario = (Usuario)Session["UsuarioLogueado"];
            UsuarioNegocio aux = new UsuarioNegocio();

            usuario.Pass = tbx_CambiarPass.Text;

            try
            {
                aux.modificar(usuario);
                Session.Add("UsuarioLogueado", usuario);
                string script = @"<script>
                         var divModificarUser = document.getElementById('modificarUser');
                         if (divModificarUser) {
                             divModificarUser.style.display = 'block';
                         }
                        </script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowModificarDiv", script);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);

            }

        }
    }
}