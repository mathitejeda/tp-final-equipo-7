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
        public Modelo.Turno turnoActivo { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_turnos();
            }
        }
        protected void load_turnos()
        {
            turnos = (List<Modelo.Turno>)Session["Turnos"];
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
                Modelo.Turno turno = turnos.Find(x => x.id == Convert.ToInt32(e.CommandArgument));

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarTurno').modal('show');", true);
            }
            if (e.CommandName.ToString() == "Eliminar")
            {
                if (turnoActivo == null || turnoActivo.id != Convert.ToInt32(e.CommandArgument))
                {
                    turnoActivo = turnos.Find(x => x.id == Convert.ToInt32(e.CommandArgument));
                    Session.Add("turnoActivo", turnoActivo);
                }
                else
                {
                    Session.Add("turnoActivo", turnoActivo);
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalEliminarTurno').modal('show');", true);
            }

        }
        protected void eliminarTurno(object sender, EventArgs e)
        {
            turnoActivo = (Modelo.Turno)Session["turnoActivo"];
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            turnos.Remove(turnoActivo);
            turnoNegocio.baja(turnoActivo.id);
            repeaterTurnos.DataSource = turnos;
            repeaterTurnos.DataBind();
        }

        protected void btn_agregarTurno_Click(object sender, EventArgs e)
        {
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
            ddl_especialidad.DataSource = especialidadNegocio.listar();
            ddl_especialidad.DataTextField = "Nombre";
            ddl_especialidad.DataValueField = "Id";
            ddl_especialidad.DataBind();
            ddl_especialidad.Items.Insert(0, new ListItem("Seleccione una especialidad", "0"));
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarTurno').modal('show');", true);
        }

        protected void ddl_especialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEspecialidad = Convert.ToInt32(ddl_especialidad.SelectedValue);
            if (idEspecialidad == 0)
            {
                ddl_medicos.Items.Clear();
                ddl_medicos.Items.Insert(0, new ListItem("Seleccione un médico", "0"));
                return;
            }
            ddl_medicos.Items.Clear();
            ddl_medicos.Items.Insert(0, new ListItem("Seleccione un médico", "0"));
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            List<Medico> medicos = medicoNegocio.getMedicosFromEspecialidad(idEspecialidad);
            foreach (Modelo.Medico medico in medicos)
            {
                ddl_medicos.Items.Add(new ListItem($"{medico.Apellido}, {medico.Nombre}", $"{medico.Id}"));
            }
        }
    }
}