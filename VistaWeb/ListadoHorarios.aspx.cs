using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controlador;
using Microsoft.Ajax.Utilities;
using Modelo;

namespace VistaWeb
{


    public partial class ListadoHorarios : System.Web.UI.Page
    {
        public List<Horario> listaHorarios { get; set; }
        public Horario horarioActual { get; set; }

        public void limpiar_form()
        {
            ddlMedicoAsignado.SelectedIndex = 0;
            ddlEspecialidad.SelectedIndex = 0;
            ddlDiaAtencion.SelectedIndex = 0;
            tbxHsEntrada.Text = "";
            tbxHsSalida.Text = "";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string script = @"
                            <script>
                                window.onload = function() {
                                    var input = document.getElementById('MainContent_tbxHsEntrada');
                                    input.addEventListener('input', function() {
                                        var value = parseInt(this.value);
                                        if (isNaN(value) || value < 0 || value > 23) {
                                            this.value = '';
                                        }
                                    });
                                }
                            </script>";
            ScriptManager.RegisterStartupScript(this, GetType(), "limitarHs", script, false);

            // cargar los médicos al ddlMedicoAsignado
                MedicoNegocio negocioMedico = new MedicoNegocio();
                List<Medico> medicos = negocioMedico.listar();

                foreach (Medico m in medicos)
                {
                    ddlMedicoAsignado.Items.Add(new ListItem("Dr. " + m.Nombre + " " + m.Apellido, m.Id.ToString()));
                }
                
                loadHorarios();
            }

        }
        protected void loadHorarios()
        {
            listaHorarios = (List<Horario>)Session["Horarios"];
            if (listaHorarios == null)
            {
                HorarioNegocio hsNegocio = new HorarioNegocio();
                listaHorarios = hsNegocio.listar();
                Session.Add("Horarios", listaHorarios);
            }
            horariosRepeater.DataSource = listaHorarios;
            horariosRepeater.DataBind();
        }

        protected void horariosRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            //listaHorarios = (List<Horario>)Session["Horarios"];
            
        }

        protected void btn_agregarHorarioModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarHorario').modal('show');", true);

          
            
        }

        protected void ddlMedicoAsignado_SelectedIndexChanged(object sender, EventArgs e)
        {
            //obtener especialidades por médico
            //getEspecialidadesFromIdMedico
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalAgregarHorario').modal('show')", true);


            EspecialidadNegocio negocioEspecialidad = new EspecialidadNegocio();
            List<Especialidad> especialidades = new List<Especialidad>();
            if(ddlMedicoAsignado.SelectedValue != "")
            {
                especialidades = negocioEspecialidad.getEspecialidadesFromIdMedico(int.Parse(ddlMedicoAsignado.SelectedValue));
                ddlEspecialidad.DataSource = especialidades;
                ddlEspecialidad.DataTextField = "Nombre";
                ddlEspecialidad.DataValueField = "Id";
                ddlEspecialidad.DataBind();
            } else
            {
                ddlEspecialidad.Items.Clear();
                ddlEspecialidad.Items.Add(new ListItem("Elegí una especialidad..",""));
            }


        }

        protected void ddlMedicoAsignado_DataBinding(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarHorario').modal('show');", true);

        }

        protected void ddlMedicoAsignado_DataBound(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarHorario').modal('show');", true);

        }

        protected void btn_Volver_Click(object sender, EventArgs e)
        {
            limpiar_form();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarHorario').modal('hide');", true);
        }

        protected void btn_AgregarHorario_Click(object sender, EventArgs e)
        {
            //
            HorarioNegocio aux = new HorarioNegocio();
            MedicoNegocio negocioMedico = new MedicoNegocio();
            EspecialidadNegocio negocioEspecialidad = new EspecialidadNegocio();


            Horario horario = new Horario();
            horario.Medico = negocioMedico.getMedico(int.Parse(ddlMedicoAsignado.SelectedValue));
            horario.Especialidad = negocioEspecialidad.GetEspecialidad(int.Parse(ddlEspecialidad.SelectedValue));
            horario.DiaSem = (Horario.DiaSemana)int.Parse(ddlDiaAtencion.SelectedValue);
            horario.HsEntrada = int.Parse(tbxHsEntrada.Text);
            horario.HsSalida = int.Parse(tbxHsSalida.Text);


            try
            {
                aux.agregar(horario);
                listaHorarios = (List<Horario>)Session["Horarios"];
                listaHorarios.Add(horario);
               
                Session.Add("Horarios", listaHorarios);
                horariosRepeater.DataSource = listaHorarios;
                horariosRepeater.DataBind();
                
                string script = @"<script>
                     var divNuevoUser = document.getElementById('nuevoHorario');
                     if (divNuevoUser) {
                         divNuevoUser.style.display = 'block';
                     }
                     </script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowNuevoDiv", script);
                
                limpiar_form();

            }
            catch (Exception ex)
            {

                throw ex;
            }
               
        }
    }
}
