﻿using Controlador;
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
    public partial class ListadoPacientes : System.Web.UI.Page
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
        public List<Modelo.Paciente> pacientes { get; set; }
        public Modelo.Paciente pacienteActivo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadPacientes();
            }
        }

        protected void loadPacientes()
        {
            pacientes = (List<Paciente>)Session["Pacientes"];
            if (pacientes == null)
            {
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                pacientes = pacienteNegocio.listar();
                Session.Add("Pacientes", pacientes);
            }
            repeaterPacientes.DataSource = pacientes;
            repeaterPacientes.DataBind();
        }

        protected void repeaterPacientes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                pacientes = (List<Paciente>)Session["Pacientes"];
                if (e.CommandName.ToString() == "Detalle")
                {
                    int idPaciente = Convert.ToInt32(e.CommandArgument);
                    Modelo.Paciente aux = pacientes.Find(x => x.Id == idPaciente);
                    lbl_titleModalVerDatos.Text = $"Datos de {aux.Nombre} {aux.Apellido}";
                    lbl_nombre_apellido.Text = $"{aux.Apellido}, {aux.Nombre}";
                    lbl_fechaNac.Text = $"Fecha de nacimiento: {aux.FechaNacimiento.Date}";
                    lbl_DNI.Text = $"{aux.Dni}";
                    lbl_direccion.Text = $"{aux.Direccion}";
                    lbl_telefono.Text = $"{aux.Telefono}";
                    lbl_email.Text = $"{aux.Email}";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalVerDatos').modal('show');", true);
                }
                if (e.CommandName.ToString() == "VerTurnos")
                {
                    int idPaciente = Convert.ToInt32(e.CommandArgument);
                    Modelo.Paciente aux = pacientes.Find(x => x.Id == idPaciente);
                    lbl_titleModalVerTurnos.Text = $"Ver turnos del paciente {aux.Nombre}";
                    pacienteActivo = aux;
                    repeaterTurnos.DataSource = aux.Turnos;
                    repeaterTurnos.DataBind();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalVerTurnos').modal('show');", true);
                }
                if (e.CommandName.ToString() == "Modificar")
                {
                    int idPaciente = Convert.ToInt32(e.CommandArgument);
                    pacienteActivo = pacientes.Find(x => x.Id == idPaciente);
                    if (Session["pacienteActivo"] == null)
                    {
                        Session.Add("pacienteActivo", pacienteActivo);
                    }
                    else
                    {
                        Session["pacienteActivo"] = pacienteActivo;
                    }
                    lbl_titleModalModificarPaciente.Text = $"Modificar paciente {pacienteActivo.Nombre}";
                    tbx_nombreMod.Text = pacienteActivo.Nombre;
                    tbx_apellidoMod.Text = pacienteActivo.Apellido;
                    tbx_DniMod.Text = pacienteActivo.Dni;
                    tbx_fechaNacMod.Text = pacienteActivo.FechaNacimiento.ToString("yyyy-MM-dd");
                    tbx_direccionMod.Text = pacienteActivo.Direccion;
                    tbx_emailMod.Text = pacienteActivo.Email;
                    tbx_telefonoMod.Text = pacienteActivo.Telefono;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarPaciente').modal('show');", true);

                }
                if (e.CommandName.ToString() == "Eliminar")
                {
                    int idPaciente = Convert.ToInt32(e.CommandArgument);
                    pacienteActivo = pacientes.Find(x => x.Id == idPaciente);
                    if (Session["pacienteActivo"] == null)
                    {
                        Session.Add("pacienteActivo", pacienteActivo);
                    }
                    else
                    {
                        Session["pacienteActivo"] = pacienteActivo;
                    }
                    lit_confirmacionPaciente.Text = $"¿Estás seguro de borrar al paciente {pacienteActivo.Nombre}?";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalEliminarPaciente').modal('show');", true);
                }
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
        protected void eliminarPaciente(object sender, EventArgs e)
        {
            try
            {
                pacienteActivo = (Modelo.Paciente)Session["pacienteActivo"];
                pacientes = (List<Paciente>)Session["Pacientes"];
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                pacientes.Remove(pacienteActivo);
                pacienteNegocio.baja(pacienteActivo.Id);
                Session.Add("Pacientes", pacientes);
                repeaterPacientes.DataSource = pacientes;
                repeaterPacientes.DataBind();
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }

        }
        protected void modificarPaciente(object sender, EventArgs e)
        {
            try
            {
                pacienteActivo = (Modelo.Paciente)Session["pacienteActivo"];
                pacientes = (List<Paciente>)Session["Pacientes"];
                pacienteActivo.Nombre = tbx_nombreMod.Text;
                pacienteActivo.Apellido = tbx_apellidoMod.Text;
                pacienteActivo.Dni = tbx_DniMod.Text;
                pacienteActivo.FechaNacimiento = DateTime.Parse(tbx_fechaNacMod.Text);
                pacienteActivo.Direccion = tbx_direccionMod.Text;
                pacienteActivo.Email = tbx_emailMod.Text;
                pacienteActivo.Telefono = tbx_telefonoMod.Text;

                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                pacienteNegocio.modificacion(pacienteActivo);

                pacientes = (List<Paciente>)Session["Pacientes"];
                pacientes.Add(pacienteActivo);
                Session.Add("Pacientes", pacientes);
                repeaterPacientes.DataSource = pacientes;
                repeaterPacientes.DataBind();
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void agregarPaciente(object sender, EventArgs e)
        {
            try
            {
                Modelo.Paciente aux = new Modelo.Paciente();
                aux.Nombre = tbx_nombrePaciente.Text;
                aux.Apellido = tbx_apellidoPaciente.Text;
                aux.Dni = tbx_dni.Text;
                aux.FechaNacimiento = DateTime.Parse(tbx_fechaNac.Text);
                aux.Direccion = tbx_direccion.Text;
                aux.Email = tbx_pacienteEmail.Text;
                aux.Telefono = tbx_telefono.Text;

                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                pacienteNegocio.agregar(aux);

                pacientes = (List<Paciente>)Session["Pacientes"];
                pacientes.Add(aux);
                Session.Add("Pacientes", pacientes);
                repeaterPacientes.DataSource = pacientes;
                repeaterPacientes.DataBind();
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
    }
}