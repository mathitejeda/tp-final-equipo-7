﻿using Controlador;
using Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Remoting.Messaging;
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

        protected void limpiar_Form()
        {
            tbx_NombreUsuario.Text = "";
            tbx_PasswordUsuario.Text = "";
            tipoUsuarioDropdown.SelectedIndex = 0;
            tbx_NombrePropioUser.Text = "";
            tbx_ApellidoUser.Text = "";
        }

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
                if (Session["UsuarioActivo"] == null)
                {
                    Session.Add("UsuarioActivo", usuarioActivo);
                }
                else
                {
                    Session["UsuarioActivo"] = usuarioActivo;
                }
                
                labelBtnmodalModificarUsuario.Text = $"Modificar usuario {usuarioActivo.User}";
                tbx_NombreUsuarioMod.Text = usuarioActivo.User;
                tbx_PasswordUsuarioMod.Text = usuarioActivo.Pass;
                tipoUsuarioDropdownEditMod.SelectedIndex = ((int)usuarioActivo.TipoUsuario)+1;

                UsuarioNegocio aux = new UsuarioNegocio();

                tbx_NombrePropioUserMod.Text = aux.getDatosPersonales(usuarioActivo.Id, "nombre");
                tbx_ApellidoUserMod.Text = aux.getDatosPersonales(usuarioActivo.Id, "apellido");

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarUsuario').modal('show');", true);

            }

            if (e.CommandName.ToString() == "EliminarUsuario")
            {
                int idUsuario = Convert.ToInt32(e.CommandArgument);
                usuarioActivo = listaUsuario.Find(x => x.Id == idUsuario);
                if (Session["UsuarioActivo"] == null)
                {
                    Session.Add("UsuarioActivo", usuarioActivo);
                }
                else
                {
                    Session["UsuarioActivo"] = usuarioActivo;
                }
                labelBtnmodalEliminarUsuario.Text = $"¿Estás seguro de borrar al usuario {usuarioActivo.User}?";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalEliminarUsuario').modal('show');", true);
            }

        }
        protected void btn_Agregar(object sender, EventArgs e)
        {
            UsuarioNegocio aux = new UsuarioNegocio();
            if (aux.findIdByUserName(tbx_NombreUsuario.Text) == -1)
            {
                Usuario usuario = new Usuario();
                usuario.User = tbx_NombreUsuario.Text;
                usuario.Pass = tbx_PasswordUsuario.Text;


                switch (tipoUsuarioDropdown.DataValueField)
                {
                    case "Administrador":
                        {
                            usuario.TipoUsuario = TipoUsuario.Administrador;
                        }
                    break;
                    case "Recepcionista":
                        {
                            usuario.TipoUsuario = TipoUsuario.Recepcionista;
                        }
                        break;
                    case "Médico":
                        {
                            usuario.TipoUsuario = TipoUsuario.Medico;
                        }
                    break;
                    case "Paciente":
                        {
                            usuario.TipoUsuario = TipoUsuario.Paciente;
                        }
                    break;

                }
                try
                {
                    aux.agregar(usuario, tbx_NombrePropioUser.Text, tbx_ApellidoUser.Text);
                    usuario.Id = aux.findIdByUserName(usuario.User);
                    listaUsuario = (List<Usuario>)Session["Usuarios"];
                    listaUsuario.Add(usuario);
                    Session.Add("Usuarios", listaUsuario);
                    rowRepeater.DataSource = listaUsuario;
                    rowRepeater.DataBind();
                    limpiar_Form();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            } else
            {
                // MSJ DE ERROR
            }

        }
        protected void btn_Modificar(object sender, EventArgs e)
        {
            
            usuarioActivo = (Usuario)Session["UsuarioActivo"];
            listaUsuario = (List<Usuario>)Session["Usuarios"];

            usuarioActivo.User = tbx_NombreUsuarioMod.Text;
            usuarioActivo.Pass = tbx_PasswordUsuarioMod.Text;
            usuarioActivo.TipoUsuario = (TipoUsuario)tipoUsuarioDropdownEditMod.SelectedIndex-1;
            string nombreUser = tbx_NombrePropioUserMod.Text;
            string apellidoUser = tbx_ApellidoUserMod.Text;
            
            UsuarioNegocio aux = new UsuarioNegocio();
           
            aux.modificar(usuarioActivo, nombreUser, apellidoUser);
            Response.Redirect("ListadoUsuarios.aspx");

            listaUsuario = (List<Usuario>)Session["Usuarios"];

            listaUsuario.Add(usuarioActivo);
            Session.Add("Usuarios", listaUsuario);
            rowRepeater.DataSource = listaUsuario;
            rowRepeater.DataBind();


        }

    protected void btn_Eliminar(object sender, EventArgs e)
        {

            usuarioActivo = (Usuario)Session["UsuarioActivo"];
            listaUsuario = (List<Usuario>)Session["Usuarios"];
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            listaUsuario.Remove(usuarioActivo);
            usuarioNegocio.eliminar(usuarioActivo.Id);
            Session.Add("Usuario", listaUsuario);
            rowRepeater.DataSource = listaUsuario;
            rowRepeater.DataBind();

        }

        protected void volver_Click(object sender, EventArgs e)
        {
            limpiar_Form();
        }
    }
}