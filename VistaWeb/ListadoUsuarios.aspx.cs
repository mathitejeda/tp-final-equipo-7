using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controlador;
using Microsoft.Ajax.Utilities;
using Modelo;

namespace VistaWeb
{
    public partial class ListadoUsuarios : System.Web.UI.Page
    {
        public List<Usuario> listaUsuario { get; set; }

        public Usuario usuarioActivo = new Usuario();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                try
                {
                    listaUsuario = usuarioNegocio.listar();
                    rowRepeater.DataSource = listaUsuario;
                    rowRepeater.DataBind();
                
                }
                catch (Exception ex)
                {
                    throw ex;
                }
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
            usuarioActivo = (Usuario)Session["UsuarioActivo"];
            UsuarioNegocio aux = new UsuarioNegocio();
            Usuario usuario = new Usuario();
            usuario.Id = usuarioActivo.Id;
            usuario.User = usuarioActivo.User;
            usuario.Pass = usuarioActivo.Pass;
            aux.modificar(usuario, usuarioNombrePropioEdit.Value, usuarioApellidoEdit.Value);
            Response.Redirect("ListadoUsuarios.aspx");

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