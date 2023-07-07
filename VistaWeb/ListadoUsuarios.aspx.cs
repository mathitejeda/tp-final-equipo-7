using Controlador;
using Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Security.AntiXss;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VistaWeb
{
    public partial class ListadoUsuarios : System.Web.UI.Page
    {
        public List<Usuario> listaUsuario { get; set; }

        public Usuario usuarioActivo { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                loadUsuarios();
            }
        }

        protected void loadUsuarios()
        {
            listaUsuario = (List<Usuario>)Session["Usuarios"];
            if (listaUsuario == null)
            {
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                listaUsuario = usuarioNegocio.listar();
                Session.Add("Usuarios", listaUsuario);
            }
            rowRepeater.DataSource = listaUsuario;
            rowRepeater.DataBind();
        }

        protected void rowRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            listaUsuario = (List<Usuario>)Session["Usuarios"];

            if (e.CommandName.ToString() == "ModificarUsuario")
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                usuarioActivo = listaUsuario.Find(x => x.Id == idUsuario);
                if (Session["usuarioActivo"] == null)
                {
                    Session.Add("usuarioActivo", usuarioActivo);
                }
                else
                {
                    Session["usuarioActivo"] = usuarioActivo;
                }
                /*
                lbl_titleModalModificarPaciente.Text = $"Modificar paciente {pacienteActivo.Nombre}";
                tbx_nombreMod.Text = pacienteActivo.Nombre;
                tbx_apellidoMod.Text = pacienteActivo.Apellido;
                tbx_DniMod.Text = pacienteActivo.Dni;
                tbx_fechaNacMod.Text = pacienteActivo.FechaNacimiento.ToString("yyyy-MM-dd");
                tbx_direccionMod.Text = pacienteActivo.Direccion;
                tbx_emailMod.Text = pacienteActivo.Email;
                tbx_telefonoMod.Text = pacienteActivo.Telefono;
                */
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarUsuario').modal('show');", true);

            }

            if (e.CommandName.ToString() == "EliminarUsuario")
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                usuarioActivo = listaUsuario.Find(x => x.Id == idUsuario);
                if (Session["usuarioActivo"] == null)
                {
                    Session.Add("usuarioActivo", usuarioActivo);
                }
                else
                {
                    Session["usuarioActivo"] = usuarioActivo;
                }
                //lit_confirmacionUsuario.Text = $"¿Estás seguro de borrar al usuario {usuarioActivo.Nombre}?";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalEliminarUsuario').modal('show');", true);
            }
        }


        protected void Modals_btn(object sender, CommandEventArgs e)
        {
            string modal = e.CommandName.ToString();
            UsuarioNegocio aux = new UsuarioNegocio();
            int id = int.Parse(e.CommandArgument.ToString());
            usuarioActivo = aux.getUsuario(id);
            if (Session["UsuarioActivo"] == null) Session.Add("UsuarioActivo", usuarioActivo);
            else Session["UsuarioActivo"] = usuarioActivo;

            if (modal == "modalModificarUsuario")
            {
                nombreUsuarioEdit.Value = usuarioActivo.User;
                passwordUsuarioEdit.Value = usuarioActivo.Pass;
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "openModal('" + modal + "')", true);

        }
        protected void btn_Agregar(object sender, EventArgs e)
        {
            UsuarioNegocio aux = new UsuarioNegocio();
            Usuario usuario = new Usuario();
            usuario.User = usuarioNombreAdd.Value;
            usuario.Pass = usuarioPasswordAdd.Value;
            int tipo;
            switch(tipoUsuarioDropdown.DataValueField)
            {
                case "Administrador":
                    {
                    tipo = 0;
                    }
                break;
                case "Recepcionista":
                    {
                    tipo = 1;
                    }
                    break;
                case "Médico":
                    {
                    tipo = 2;
                    }
                break;
                case "Paciente":
                    {
                    tipo = 3;
                    }
                break;
                default:
                    {
                        tipo = 3;
                    }
                    break;
            }
            try
            {
                aux.agregar(usuarioNombreAdd.Value, usuarioPasswordAdd.Value,usuarioNombrePropioAdd.Value, usuarioApellidoAdd.Value,tipo);
                Response.Redirect("ListadoUsuarios.aspx");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        protected void btn_Modificar(object sender, EventArgs e)
        {
            /*
            usuarioActivo = (Usuario)Session["UsuarioActivo"];
            UsuarioNegocio aux = new UsuarioNegocio();
            Usuario usuario = new Usuario();
            usuario.Id = usuarioActivo.Id;
            usuario.User = usuarioActivo.User;
            usuario.Pass = usuarioActivo.Pass;
            aux.modificar(usuario, usuarioNombrePropioEdit.Value, usuarioApellidoEdit.Value);
            Response.Redirect("ListadoUsuarios.aspx");
            */

        }
        protected void btn_Eliminar(object sender, EventArgs e)
        {
            /*
            medicoActivo = (Medico)Session["MedicoActivo"];
            MedicoNegocio aux = new MedicoNegocio();
            int id = int.Parse(medicoActivo.Id.ToString());
            aux.eliminar(id);
            Response.Redirect("ListadoMedicos.aspx");*/
            
        }
    }
}