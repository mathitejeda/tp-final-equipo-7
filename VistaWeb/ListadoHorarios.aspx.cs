using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controlador;
using Microsoft.Ajax.Utilities;
using Modelo;
using static System.Collections.Specialized.BitVector32;

namespace VistaWeb
{


    public partial class ListadoHorarios : System.Web.UI.Page
    {
        public List<Horario> listaHorarios { get; set; }
        public Horario horarioActual { get; set; }
        public void cargarDdlMedicoAsignado()
        {
            // cargar los médicos al ddlMedicoAsignado
            MedicoNegocio negocioMedico = new MedicoNegocio();
            List<Medico> medicos = negocioMedico.listar();
                ddlMedicoAsignado.Items.Clear();
            ddlMedicoAsignado.Items.Add(new ListItem("Elegí un médico...", ""));
            foreach (Medico m in medicos)
            {
                ddlMedicoAsignado.Items.Add(new ListItem("Dr. " + m.Nombre + " " + m.Apellido, m.Id.ToString()));
            }
        }
        public void cargarDdlMedicoAsignadoMod()
        {
            // cargar los médicos al ddlMedicoAsignadoMod
            MedicoNegocio negocioMedico = new MedicoNegocio();
            List<Medico> medicos = negocioMedico.listar();
            ddlMedicoAsignadoMod.Items.Clear();

            foreach (Medico m in medicos)
            {
                ddlMedicoAsignadoMod.Items.Add(new ListItem("Dr. " + m.Nombre + " " + m.Apellido, m.Id.ToString()));
            }
        }

        public void cargarDdlEspecialidadMod(int id_medico)
        {
            EspecialidadNegocio negocioEspecialidad = new EspecialidadNegocio();
            List<Especialidad> especialidades = new List<Especialidad>();
            if (id_medico != -1)
            {
                especialidades = negocioEspecialidad.getEspecialidadesFromIdMedico(id_medico);
                ddlEspecialidadMod.DataSource = especialidades;
                ddlEspecialidadMod.DataTextField = "Nombre";
                ddlEspecialidadMod.DataValueField = "Id";
                ddlEspecialidadMod.DataBind();
            }
            else
            {
                ddlEspecialidadMod.Items.Clear();
                ddlEspecialidadMod.Items.Add(new ListItem("Elegí una especialidad..", ""));
            }
        }
        public void limpiar_form()
        {
            ddlMedicoAsignado.SelectedIndex = 0;
            ddlDiaAtencion.SelectedIndex = 0;
            ddlEspecialidad.Items.Clear();
            ddlEspecialidad.Items.Add(new ListItem("Elegí una opción...", ""));
            tbxHsEntrada.Text = "";
            tbxHsSalida.Text = "";
        }
        public void limpiar_formMod()
        {
            ddlMedicoAsignadoMod.SelectedIndex = 0;
            ddlDiaAtencionMod.SelectedIndex = 0;
            ddlEspecialidadMod.Items.Clear();
            ddlEspecialidadMod.Items.Add(new ListItem("Elegí una opción...", ""));
            tbxHsEntradaMod.Text = "";
            tbxHsSalidaMod.Text = "";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string script = @"
                           <script>
                            window.onload = function() {
                                var inputs = document.getElementsByClassName('horario');
                                for (var i = 0; i < inputs.length; i++) {
                                    inputs[i].addEventListener('input', function() {
                                        var value = parseInt(this.value);
                                        if (isNaN(value) || value < 0 || value > 23) {
                                            this.value = '';
                                        }
                                    });
                                }
                            }
                        </script>";
            ScriptManager.RegisterStartupScript(this, GetType(), "limitarHs", script, false);
            if (!IsPostBack)
            {
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
            listaHorarios = (List<Horario>)Session["Horarios"];

            
            if (e.CommandName.ToString() == "ModificarHorario")
            {
                int idHorario = Convert.ToInt32(e.CommandArgument);
                horarioActual = listaHorarios.Find(x => x.Id == idHorario);
                if (Session["HorarioActual"] == null)
                {
                    Session.Add("HorarioActual", horarioActual);
                }
                else
                {
                    Session["HorarioActual"] = horarioActual;
                }
                
                labelBtnmodalmodalModificarHorario.Text = $"Modificar horario de {horarioActual.Especialidad.Nombre}";
                
                cargarDdlMedicoAsignadoMod();
                int idMedicoHorario = horarioActual.Medico.Id;
                ListItem item = ddlMedicoAsignadoMod.Items.FindByValue(idMedicoHorario.ToString());
                ddlMedicoAsignadoMod.SelectedIndex = ddlMedicoAsignadoMod.Items.IndexOf(item);

                cargarDdlEspecialidadMod(idMedicoHorario);
                int idEspecialidad = horarioActual.Especialidad.Id;
                ListItem itemEsp = ddlEspecialidadMod.Items.FindByValue(idEspecialidad.ToString());
                ddlEspecialidadMod.SelectedIndex = ddlEspecialidadMod.Items.IndexOf(itemEsp);
                //-----

                ddlDiaAtencionMod.SelectedIndex = ((int)horarioActual.DiaSem);
                tbxHsEntradaMod.Text = horarioActual.HsEntrada.ToString();
                tbxHsSalidaMod.Text = horarioActual.HsSalida.ToString();


            }

            if (e.CommandName.ToString() == "EliminarHorario")
            {
                int idHorario = Convert.ToInt32(e.CommandArgument);
                horarioActual = listaHorarios.Find(x => x.Id == idHorario);
                if (Session["HorarioActual"] == null)
                {
                    Session.Add("HorarioActual", horarioActual);
                }
                else
                {
                    Session["HorarioActual"] = horarioActual;
                }
                labelBtnmodalEliminarHorario.Text = $"¿Estás seguro de borrar el horario para {horarioActual.Especialidad.Nombre}?";
                lbl_BorrarHorario.Text = $"Este horario es atendido por { horarioActual.Medico.Nombre } {horarioActual.Medico.Apellido} ";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalEliminarHorario').modal('show');", true);
            }


        }

        protected void btn_agregarHorarioModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalAgregarHorario').modal('show');", true);
            cargarDdlMedicoAsignado();



        }

        protected void ddlMedicoAsignado_SelectedIndexChanged(object sender, EventArgs e)
        {
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
        protected void ddlMedicoAsignadoMod_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#modalModificarHorario').modal('show')", true);

            int idMedicoHorario = int.Parse(ddlMedicoAsignadoMod.SelectedItem.Value);
            cargarDdlEspecialidadMod(idMedicoHorario);
            //-!!
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

        protected void btn_modificarHorario_Click1(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarHorario').modal('show');", true);
        }

        protected void btn_ModificarHorarioSubmit_Click(object sender, EventArgs e)
        {
            horarioActual = (Horario)Session["HorarioActual"];
            HorarioNegocio aux = new HorarioNegocio();

            // VERIFICACIÓN PARA VER SI LA MODIFICACIÓN AFECTA A OTROS HORARIOS
            // EJEMPLO
            /*
            if (tbx_NombreUsuarioMod.Text != usuarioActivo.User)
            {
                if (aux.findIdByUserName(tbx_NombreUsuarioMod.Text) != -1)
                {
                    string script2 = @"<script>
                     var divErrorUser = document.getElementById('errorUser');
                     if (divErrorUser) {
                         divErrorUser.style.display = 'block';
                     }
                     </script>";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowErrorDiv", script2);
                    limpiar_Form();
                    return;
                }
            }
            */

            /**/

            MedicoNegocio auxMed = new MedicoNegocio();
            horarioActual.Medico = auxMed.getMedico(int.Parse(ddlMedicoAsignadoMod.SelectedValue));
            EspecialidadNegocio auxEsp = new EspecialidadNegocio();
            horarioActual.Especialidad = auxEsp.GetEspecialidad(int.Parse(ddlEspecialidadMod.SelectedValue));

            horarioActual.DiaSem = (Horario.DiaSemana)int.Parse(ddlDiaAtencionMod.SelectedValue);

            horarioActual.HsEntrada = int.Parse(tbxHsEntradaMod.Text);
            horarioActual.HsSalida = int.Parse(tbxHsSalidaMod.Text);

        
            aux.modificar(horarioActual);

            listaHorarios = (List<Horario>)Session["Horarios"];

            horariosRepeater.DataSource = listaHorarios;
            horariosRepeater.DataBind();

            string script = @"<script>
                     var divModificarUser = document.getElementById('modificarHorario');
                     if (divModificarUser) {
                         divModificarUser.style.display = 'block';
                     }
                 </script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowModificarDiv", script);

            // FALTA ENVIAR
            limpiar_formMod();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarHorario').modal('hide');", true);

        }


        protected void btn_Volver_ClickMod_Click(object sender, EventArgs e)
        {
            // FALTA LIMPIAR
            limpiar_formMod();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "$('#modalModificarHorario').modal('hide');", true);
        }

        protected void btn_eliminarHorario_Click(object sender, EventArgs e)
        {
            horarioActual = (Horario)Session["HorarioActual"];
            listaHorarios = (List<Horario>)Session["Horarios"];
            HorarioNegocio negocioHorario = new HorarioNegocio();
            listaHorarios.Remove(horarioActual);
            negocioHorario.eliminar(horarioActual.Id);
            Session.Add("Horarios", listaHorarios);
            horariosRepeater.DataSource = listaHorarios;
            horariosRepeater.DataBind();


            string script = @"<script>
                     var divEliminar = document.getElementById('eliminarHorario');
                     if (divEliminar) {
                         divEliminar.style.display = 'block';
                     }
                 </script>";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowEliminarDiv", script);
        }
    }
   
}
