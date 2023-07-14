using Controlador;
using Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VistaWeb
{
    public partial class ListadoTurnos : System.Web.UI.Page
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
            try
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
                    Session.Add("turnoActivo", turno);
                    // cargamos especialidades
                    if (Session["Especialidades"] is null)
                    {
                        EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                        Session.Add("Especialidades", especialidadNegocio.listar());
                        ddl_especialidad_modificar.DataSource = (List<Especialidad>)Session["Especialidades"];
                    }
                    else ddl_especialidad_modificar.DataSource = (List<Especialidad>)Session["Especialidades"];
                    ddl_especialidad_modificar.DataTextField = "Nombre";
                    ddl_especialidad_modificar.DataValueField = "Id";
                    ddl_especialidad_modificar.DataBind();
                    // en el ddl se selecciona la especialidad del turno
                    ddl_especialidad_modificar.SelectedValue = turno.Especialidad.Id.ToString();
                    // cargamos medicos
                    MedicoNegocio medicoNegocio = new MedicoNegocio();
                    ddl_medicos_modificar.DataSource = medicoNegocio.getMedicosFromEspecialidad(turno.Especialidad.Id);
                    ddl_medicos_modificar.DataTextField = "NombreCompleto";
                    ddl_medicos_modificar.DataValueField = "Id";
                    ddl_medicos_modificar.DataBind();
                    // en el ddl se selecciona el medico del turno
                    ddl_medicos_modificar.SelectedValue = turno.Medico.Id.ToString();
                    calendarAgenda_modificar.Visible = true;
                    calendarAgenda_modificar.SelectedDate = turno.Fecha;
                    calendarAgenda_modificar_SelectionChanged(null, EventArgs.Empty);
                    ddl_hora_modificar.SelectedValue = turno.Fecha.ToString("HH:mm");

                    ddl_estado_modificar.SelectedValue = turno.Estado.ToString();

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
                repeaterTurnos.DataSource = (List<Turno>)Session["Turnos"];
                repeaterTurnos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
        protected void eliminarTurno(object sender, EventArgs e)
        {
            try
            {
                turnoActivo = (Modelo.Turno)Session["turnoActivo"];
                turnos = (List<Modelo.Turno>)Session["Turnos"];
                TurnoNegocio turnoNegocio = new TurnoNegocio();
                turnos.Remove(turnoActivo);
                turnoNegocio.baja(turnoActivo.id);
                repeaterTurnos.DataSource = turnos;
                repeaterTurnos.DataBind();
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btn_agregarTurno_Click(object sender, EventArgs e)
        {
            try
            {
                // cargamos especialidades
                if (Session["Especialidades"] is null)
                {
                    EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                    Session.Add("Especialidades", especialidadNegocio.listar());
                    ddl_especialidad.DataSource = (List<Especialidad>)Session["Especialidades"];
                }
                else ddl_especialidad.DataSource = (List<Especialidad>)Session["Especialidades"];
                ddl_especialidad.DataTextField = "Nombre";
                ddl_especialidad.DataValueField = "Id";
                ddl_especialidad.DataBind();
                ddl_especialidad.Items.Insert(0, new ListItem("Seleccione una especialidad", "0"));

                if (Session["Pacientes"] is null)
                {
                    PacienteNegocio pacienteNegocio = new PacienteNegocio();
                    Session.Add("Pacientes", pacienteNegocio.listar());
                    ddl_paciente.DataSource = (List<Paciente>)Session["Pacientes"];
                }
                else ddl_paciente.DataSource = (List<Paciente>)Session["Pacientes"];
                ddl_paciente.DataTextField = "NombreCompletoYDni";
                ddl_paciente.DataValueField = "Id";
                ddl_paciente.DataBind();
                ddl_paciente.Items.Insert(0, new ListItem("Seleccione un paciente", "0"));

                repeaterTurnos.DataSource = (List<Turno>)Session["Turnos"];
                repeaterTurnos.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarTurno').modal('show');", true);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void ddl_especialidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
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
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
        protected void ddl_medicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idMedico = Convert.ToInt32(ddl_medicos.SelectedValue);
            if (idMedico == 0)
            {
                calendarAgenda.Visible = false;
                return;
            }
            calendarAgenda.Visible = true;
        }
        protected void calendarAgenda_DayRender(object sender, DayRenderEventArgs e)
        {
            try
            {
                DateTime fechaActual = DateTime.Now;
                DateTime fechaLimite = fechaActual.AddDays(30);

                // si ddl especialidad y ddl medico tienen valores seleccionados se obtienen los horarios del medico
                List<int> diasTrabajo = new List<int>();
                if (ddl_especialidad.SelectedValue != "0" && ddl_medicos.SelectedValue != "0")
                {
                    int idMedico = Convert.ToInt32(ddl_medicos.SelectedValue);
                    int idEspecialidad = Convert.ToInt32(ddl_especialidad.SelectedValue);
                    HorarioNegocio horarioNegocio = new HorarioNegocio();
                    List<Horario> horarios = horarioNegocio.listarPorMedicoYEspecialidad(idMedico, idEspecialidad);
                    foreach (Modelo.Horario horario in horarios)
                    {
                        diasTrabajo.Add((int)horario.DiaSem);
                    }
                }
                int day = (int)e.Day.Date.DayOfWeek;
                if ((e.Day.Date <= fechaActual || e.Day.Date >= fechaLimite) || (diasTrabajo.Count > 0 && !diasTrabajo.Contains(day)))
                {
                    e.Day.IsSelectable = false;
                    e.Cell.ForeColor = System.Drawing.Color.Gray;
                }
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void calendarAgenda_SelectionChanged(object sender, EventArgs e)
        {
            try
            {
                DateTime fechaSeleccionada = calendarAgenda.SelectedDate;
                HorarioNegocio horarioNegocio = new HorarioNegocio();
                List<Horario> horarios = horarioNegocio.listarPorMedicoYEspecialidad(Convert.ToInt32(ddl_medicos.SelectedValue), Convert.ToInt32(ddl_especialidad.SelectedValue));
                List<int> horasDisponibles = new List<int>();

                turnos = (List<Modelo.Turno>)Session["Turnos"];
                List<Turno> turnos_filtrados = turnos.FindAll(x => x.Fecha.Date == fechaSeleccionada && x.Medico.Id == Convert.ToInt32(ddl_medicos.SelectedValue));

                int diaSemana = (int)fechaSeleccionada.DayOfWeek;
                Horario horarioDelDia = horarios.Find(x => (int)x.DiaSem == diaSemana);
                ddl_hora.Items.Clear();
                for (int i = horarioDelDia.HsEntrada; i <= horarioDelDia.HsSalida; i++)
                {
                    string hora = i.ToString("00");

                    if (turnos_filtrados.Find(x => x.Fecha.ToString("HH") == hora) != null)
                    {
                        continue;
                    }
                    ddl_hora.Items.Add(new ListItem($"{hora} HS", $"{i}"));
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btn_aceptaragregarTurno_Click(object sender, EventArgs e)
        {
            try
            {
                Turno turno = new Turno();
                turnos = (List<Modelo.Turno>)Session["Turnos"];
                TurnoNegocio turnoNegocio = new TurnoNegocio();
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                turno.Paciente = pacienteNegocio.getPacienteById(Convert.ToInt32(ddl_paciente.SelectedValue));
                turno.Medico = medicoNegocio.getMedico(Convert.ToInt32(ddl_medicos.SelectedValue));
                turno.Especialidad = especialidadNegocio.GetEspecialidad(Convert.ToInt32(ddl_especialidad.SelectedValue));

                DateTime fecha = calendarAgenda.SelectedDate;
                fecha = fecha.AddHours(Convert.ToInt32(ddl_hora.SelectedValue));
                turno.Fecha = fecha;
                turnoNegocio.alta(turno);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarTurno').modal('hide');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "alert('Turno agregado correctamente');", true);
                turnos.Add(turno);
                Session["Turnos"] = turnos;
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
            Response.Redirect("ListadoTurnos.aspx");
        }

        protected void ddl_especialidad_modificar_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEspecialidad = Convert.ToInt32(ddl_especialidad_modificar.SelectedValue);
            if (idEspecialidad == 0)
            {
                ddl_medicos_modificar.Items.Clear();
                ddl_medicos_modificar.Items.Insert(0, new ListItem("Seleccione un médico", "0"));
                return;
            }
            ddl_medicos_modificar.Items.Clear();
            ddl_medicos_modificar.Items.Insert(0, new ListItem("Seleccione un médico", "0"));
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            List<Medico> medicos = medicoNegocio.getMedicosFromEspecialidad(idEspecialidad);
            foreach (Modelo.Medico medico in medicos)
            {
                ddl_medicos_modificar.Items.Add(new ListItem($"{medico.Apellido}, {medico.Nombre}", $"{medico.Id}"));
            }
        }

        protected void ddl_medicos_modificar_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idMedico = Convert.ToInt32(ddl_medicos_modificar.SelectedValue);
            if (idMedico == 0)
            {
                calendarAgenda_modificar.Visible = false;
                return;
            }
            calendarAgenda_modificar.Visible = true;
        }

        protected void calendarAgenda_modificar_SelectionChanged(object sender, EventArgs e)
        {
            DateTime fechaSeleccionada = calendarAgenda_modificar.SelectedDate;
            HorarioNegocio horarioNegocio = new HorarioNegocio();
            List<Horario> horarios = horarioNegocio.listarPorMedicoYEspecialidad(Convert.ToInt32(ddl_medicos_modificar.SelectedValue), Convert.ToInt32(ddl_especialidad_modificar.SelectedValue));
            List<int> horasDisponibles = new List<int>();

            turnos = (List<Modelo.Turno>)Session["Turnos"];
            List<Turno> turnos_filtrados = turnos.FindAll(x => x.Fecha.Date == fechaSeleccionada.Date && x.Medico.Id == Convert.ToInt32(ddl_medicos_modificar.SelectedValue));
            int diaSemana = (int)fechaSeleccionada.DayOfWeek;
            Horario horarioDelDia = horarios.Find(x => (int)x.DiaSem == diaSemana);
            ddl_hora_modificar.Items.Clear();
            for (int i = horarioDelDia.HsEntrada; i <= horarioDelDia.HsSalida; i++)
            {
                string hora = i.ToString("00");

                if (turnos_filtrados.Find(x => x.Fecha.ToString("HH") == hora) != null)
                {
                    continue;
                }
                ddl_hora_modificar.Items.Add(new ListItem($"{hora} HS", $"{i}"));
            }
        }

        protected void calendarAgenda_modificar_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime fechaActual = DateTime.Now;
            DateTime fechaLimite = fechaActual.AddDays(30);

            // si ddl especialidad y ddl medico tienen valores seleccionados se obtienen los horarios del medico
            List<int> diasTrabajo = new List<int>();
            if (ddl_especialidad_modificar.SelectedValue != "0" && ddl_medicos_modificar.SelectedValue != "0")
            {
                int idMedico = Convert.ToInt32(ddl_medicos_modificar.SelectedValue);
                int idEspecialidad = Convert.ToInt32(ddl_especialidad_modificar.SelectedValue);
                HorarioNegocio horarioNegocio = new HorarioNegocio();
                List<Horario> horarios = horarioNegocio.listarPorMedicoYEspecialidad(idMedico, idEspecialidad);
                foreach (Modelo.Horario horario in horarios)
                {
                    diasTrabajo.Add((int)horario.DiaSem);
                }
            }
            int day = (int)e.Day.Date.DayOfWeek;
            if ((e.Day.Date <= fechaActual || e.Day.Date >= fechaLimite) || (diasTrabajo.Count > 0 && !diasTrabajo.Contains(day)))
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.Gray;
            }
        }

        protected void btn_aceptarModificarTurno_Click(object sender, EventArgs e)
        {
            Turno turno = Session["turnoActivo"] as Turno;
            TurnoNegocio turnoNegocio = new TurnoNegocio();
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            turno.Medico = medicoNegocio.getMedico(Convert.ToInt32(ddl_medicos_modificar.SelectedValue));
            turno.Especialidad = especialidadNegocio.GetEspecialidad(Convert.ToInt32(ddl_especialidad_modificar.SelectedValue));

            DateTime fecha = calendarAgenda_modificar.SelectedDate.Date;
            fecha = fecha.AddHours(Convert.ToInt32(ddl_hora_modificar.SelectedValue));
            turno.Fecha = fecha;
            turno.Estado = (EstadoTurno)Convert.ToInt32(ddl_estado_modificar.SelectedValue);
            turnoNegocio.modificacion(turno);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarTurno').modal('hide');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "alert('Turno agregado correctamente');", true);
            Response.Redirect("ListadoTurnos.aspx");
        }
    }
}