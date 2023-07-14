using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controlador;
using Modelo;

namespace VistaWeb
{
    public partial class ListadoMedicos : System.Web.UI.Page
    {
        public List<Medico> listaMedicos { get; set; }

        public Medico medicoActivo = new Medico();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                especialidadesMedicoAdd.DataSource = especialidadNegocio.listar();
                especialidadesMedicoAdd.DataBind();
                especialidadesMedicoMdf.DataSource = especialidadNegocio.listar();
                especialidadesMedicoMdf.DataBind();
                try
                {
                
                    listaMedicos = medicoNegocio.listar();
                    rowRepeater.DataSource = listaMedicos;
                    rowRepeater.DataBind();
                
                }
                catch (Exception ex)
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
                MedicoNegocio auxMedico = new MedicoNegocio();
                int id = int.Parse(e.CommandArgument.ToString());
                medicoActivo = auxMedico.getMedico(id);
                if (Session["MedicoActivo"] == null) Session.Add("MedicoActivo", medicoActivo);
                else Session["MedicoActivo"] = medicoActivo;

                if (modal == "modalModificarMedico")
                {
                    medicoNombreMdf.Value = medicoActivo.Nombre;
                    medicoApellidoMdf.Value = medicoActivo.Apellido;
                    foreach (ListItem item in especialidadesMedicoMdf.Items)
                    {
                        item.Selected = false;
                    }
                    foreach (Especialidad esp in medicoActivo.Especialidades)
                    {
                        if (especialidadesMedicoMdf.Items.FindByValue(esp.Id.ToString()) != null)
                        {
                            especialidadesMedicoMdf.Items.FindByValue(esp.Id.ToString()).Selected = true;
                        }
                    }
                }
                if (modal == "modalVerHorarios")
                {
                    EspecialidadNegocio auxEsp = new EspecialidadNegocio();
                    especialidadesRepeater.DataSource = auxEsp.getEspecialidadesFromIdMedico(medicoActivo.Id);
                    especialidadesRepeater.DataBind();
                }
                
                if (modal == "modalVerTurnos")
                {
                    TurnoNegocio auxTurno = new TurnoNegocio();
                    List<Turno> listaTurnos = auxTurno.listTurnosByMedicoId(medicoActivo.Id);
                    List<Turno> listaMostrar = listaTurnos.Take(3).ToList();
                    turnosRepeater.DataSource = listaMostrar;
                    turnosRepeater.DataBind();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "openModal('" + modal + "')", true);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
        }
        protected void especialidadesRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem item = e.Item;
            Medico medico = (Medico)Session["MedicoActivo"];
            if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
            {
                Especialidad especialidad = (Especialidad)item.DataItem;
                Repeater horarios = (Repeater)item.FindControl("horarios");
                HorarioNegocio auxHorario = new HorarioNegocio();
                List<Horario> listaHorarios = auxHorario.listarPorMedicoYEspecialidad(medico.Id, especialidad.Id);
                horarios.DataSource = listaHorarios;
                horarios.DataBind();
            }
        }
        protected void btn_Agregar(object sender, EventArgs e)
        {
            try
            {
                MedicoNegocio aux = new MedicoNegocio();
                Medico medico = new Medico();
                TextInfo auxText = new CultureInfo("es-ES", false).TextInfo;
                medico.Nombre = auxText.ToTitleCase(medicoNombreAdd.Value.ToLower());
                medico.Apellido = auxText.ToTitleCase(medicoApellidoAdd.Value.ToLower());
                medico.Especialidades = new List<Especialidad>();
                foreach (ListItem item in especialidadesMedicoAdd.Items)
                {
                    if (item.Selected)
                    {
                        medico.Especialidades.Add(new Especialidad(int.Parse(item.Value), item.Text));
                    }
                }
                aux.agregar(medico);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
                Response.Redirect("ListadoMedicos.aspx");

        }
        protected void btn_Modificar(object sender, EventArgs e)
        {
            try
            {
                medicoActivo = (Medico)Session["MedicoActivo"];
                TextInfo auxText = new CultureInfo("es-ES", false).TextInfo;
                MedicoNegocio aux = new MedicoNegocio();
                Medico medico = new Medico();
                medico = aux.getMedico(medicoActivo.Id);
                medico.Nombre = auxText.ToTitleCase(medicoNombreMdf.Value.ToLower());
                medico.Apellido = auxText.ToTitleCase(medicoApellidoMdf.Value.ToLower());
                medico.Especialidades = new List<Especialidad>();
                foreach (ListItem item in especialidadesMedicoMdf.Items)
                {
                    if (item.Selected)
                    {
                        medico.Especialidades.Add(new Especialidad(int.Parse(item.Value), item.Text));
                    }
                }
                aux.modificar(medico);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
                Response.Redirect("ListadoMedicos.aspx");
            
        }
        protected void btn_Eliminar(object sender, EventArgs e)
        {

            try
            {
                medicoActivo = (Medico)Session["MedicoActivo"];
                MedicoNegocio aux = new MedicoNegocio();
                int id = int.Parse(medicoActivo.Id.ToString());
                aux.bajaLogica(id);
            }
            catch (Exception ex)
            {

                Session.Add("Error", ex.ToString());
                Response.Redirect("Error.aspx", false);
            }
                Response.Redirect("ListadoMedicos.aspx");
        }

    }
}