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
    public partial class ListadoTurnos : System.Web.UI.Page
    {
        public List<Turno> turnos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_turnos();
            }
        }
        protected void load_turnos()
        {
            if (turnos == null)
            {
                TurnoNegocio turnoNegocio = new TurnoNegocio();
                turnos = turnoNegocio.listTurnos();
                Session.Add("Turnos", turnos);
            }
            repeaterTurnos.DataSource = turnos;
            repeaterTurnos.DataBind();
        }

        protected void repeaterTurnos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            turnos = (List<Modelo.Turno>)Session["Turnos"];
            if (e.CommandName.ToString() == "Detalle")
            {
                Modelo.Turno turno = turnos.Find(x => x.id == Convert.ToInt32(e.CommandArgument));
                lbl_titulo.Text = $"Turno para {turno.Especialidad.Nombre}";
                lbl_nombrePaciente.Text = $"{turno.Paciente.Apellido}, {turno.Paciente.Nombre}";
                lbl_fecha.Text = turno.Fecha.ToString();
                lbl_medico.Text = $"{turno.Medico.Apellido}, {turno.Medico.Nombre} - {turno.Especialidad}";
                lbl_observaciones.Text = (turno.Observaciones == "") ? "Sin observaciones" : turno.Observaciones;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalVerTurno').modal('show');", true);
            }
            if (e.CommandName.ToString() == "Modificar")
            {

            }
            if (e.CommandName.ToString() == "Eliminar")
            {

            }

        }
    }
}