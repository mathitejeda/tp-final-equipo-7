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

        public void imprimirDatos(string type)
        {
            Usuario aux = (Usuario)Session["UsuarioLogueado"];
            UsuarioNegocio negocioUsuario = new UsuarioNegocio();

            if (type == "user")
            {
                Response.Write(aux.User);
            }
            if (type == "nombre")
            {
                string nombre = negocioUsuario.getDatosPersonales(aux.Id, "nombre");
                Response.Write(nombre.ToUpperInvariant());
            }
            if (type == "apellido")
            {
                string apellido = negocioUsuario.getDatosPersonales(aux.Id, "apellido");
                Response.Write(apellido.ToUpperInvariant());
            }
            if (type == "dni")
            {
                string dni = negocioUsuario.getDatosPersonales(aux.Id, "dni");
                Response.Write(dni);
            }
            if (type == "fechaNac")
            {
                string fechaNac = negocioUsuario.getDatosPersonales(aux.Id, "fechaNac");
                Response.Write(fechaNac);
            }
            List<string> datosContacto = negocioUsuario.getDatosContacto(aux.Id);
            if (type == "email")
            {
                Response.Write(datosContacto[0]);
            }
            if (type == "telefono")
            {
                Response.Write(datosContacto[1]);
            }
            if (type == "celular")
            {
                Response.Write(datosContacto[2]);
            }
            if (type == "direccion")
            {
                Response.Write(datosContacto[3]);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UsuarioLogueado"] != null)
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
                if (EsTipoUsuario("paciente"))
                {
                    List<Turno> turnos = new List<Turno>();
                    TurnoNegocio aux = new TurnoNegocio();
                    Usuario usuario = (Usuario)Session["UsuarioLogueado"];
                    turnos = aux.listTurnosByPacienteID(usuario.Id);
                    turnosRepeater.DataSource = turnos;
                    turnosRepeater.DataBind();
                }
            }

        }

        protected void btnIniciarSesionSubmit_Click(object sender, EventArgs e)
        {
            Usuario user;
            UsuarioNegocio negocioUsuario = new UsuarioNegocio();
                user = new Usuario(tbxUsernameLogin.Text, tbxPasswordLogin.Text);
                if (negocioUsuario.VerificarLogin(user))
                {
                    int id = negocioUsuario.findIdByUserName(tbxUsernameLogin.Text);
                    user = negocioUsuario.getUsuario(id);
                    Session.Add("UsuarioLogueado", user);
                    Response.Redirect("Cuenta.aspx", false);
                    Session.Add("MensajeLeido", false);
                }
                else
                {
                    Session.Add("Error", "Los datos ingresados no son correctos. Intente nuevamente");
                    Response.Redirect("Error.aspx", false);
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