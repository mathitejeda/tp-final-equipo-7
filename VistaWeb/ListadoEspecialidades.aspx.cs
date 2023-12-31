﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modelo;
using Controlador;
using System.Globalization;
using System.Web.UI.HtmlControls;

namespace VistaWeb
{
    public partial class ListadoEspecialidades : System.Web.UI.Page
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

        public Especialidad EspecialidadActiva = new Especialidad(0,"A");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                try
                {
                    
                    List<Especialidad> lista = new List<Especialidad>();
                    lista = negocio.listar();
                    rowRepeater.DataSource = lista;
                    rowRepeater.DataBind();
                }
                catch(Exception ex)
                {
                    Session.Add("Error", ex.ToString());
                    Response.Redirect("Error.aspx", false);
                }
            }
        }


        protected void Modal_btn(object sender, CommandEventArgs e)
        {
            try
            {
                string modal = e.CommandName.ToString();
                EspecialidadNegocio aux = new EspecialidadNegocio();
                int id = int.Parse(e.CommandArgument.ToString());
                EspecialidadActiva = aux.GetEspecialidad(id);
                if (Session["EspecialidadActiva"] == null) Session.Add("EspecialidadActiva", EspecialidadActiva);
                else Session["EspecialidadActiva"] = EspecialidadActiva;

                if (modal == "modalVerMedicos")
                {
                    MedicoNegocio auxMedic = new MedicoNegocio();
                    medicRepeater.DataSource = auxMedic.getMedicosFromEspecialidad(EspecialidadActiva.Id);
                    medicRepeater.DataBind();
                }

                especialidadNombreMdf.Value = EspecialidadActiva.Nombre;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "openModal('" + modal + "')", true);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
            

        }
        protected void medicRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                EspecialidadActiva = (Especialidad)Session["EspecialidadActiva"];
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    Medico medico = (Medico)e.Item.DataItem;
                    Repeater horario = (Repeater)e.Item.FindControl("horarios");

                    HorarioNegocio aux = new HorarioNegocio();
                    List<Horario> horarios = aux.listarPorMedicoYEspecialidad(medico.Id, EspecialidadActiva.Id);

                    // Vincular los horarios al repeater anidado
                    horario.DataSource = horarios;
                    horario.DataBind();
                }
            }
            catch (Exception ex) { Session.Add("Error", ex.ToString()); Response.Redirect("Error.aspx", false); }
            
        }

        protected void btn_Modificar(object sender, EventArgs e)
        {
            try
            {
                EspecialidadActiva = (Especialidad)Session["EspecialidadActiva"];
                TextInfo aux = new CultureInfo("es-ES",false).TextInfo;
                EspecialidadActiva.Nombre = aux.ToTitleCase(especialidadNombreMdf.Value.ToLower());
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                negocio.modificar(EspecialidadActiva);
            }
            catch(Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
                Response.Redirect("ListadoEspecialidades.aspx");
        }

        protected void btn_Agregar(object sender, EventArgs e)
        {

            try
            {
                TextInfo aux = new CultureInfo("es-ES", false).TextInfo;
                EspecialidadActiva.Nombre = aux.ToTitleCase(especialidadNombreAdd.Value.ToLower());
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                negocio.agregar(EspecialidadActiva.Nombre);
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
                Response.Redirect("ListadoEspecialidades.aspx");
            
        }
        protected void btn_Eliminar(object sender, EventArgs e)
        {

            try
            {
                EspecialidadActiva = (Especialidad)Session["EspecialidadActiva"];
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                negocio.eliminar(EspecialidadActiva.Id);
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
                Response.Redirect("ListadoEspecialidades.aspx");
            
        }

    }
}