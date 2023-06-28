using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Modelo;
using Controlador;

namespace VistaWeb
{
    public partial class ListadoEspecialidades : System.Web.UI.Page
    {
        public int activeId;
        public string EspecialidadActiva { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EspecialidadNegocio negocio = new EspecialidadNegocio();
                try
                {
                    EspecialidadActiva = "Test";
                    List<Especialidad> lista = new List<Especialidad>();
                    lista = negocio.listar();
                    rowRepeater.DataSource = lista;
                    rowRepeater.DataBind();
                }
                catch(Exception ex)
                {
                    throw ex;
                }
            }
        }

        public void setActiveId(int id)
        {
            EspecialidadNegocio aux = new EspecialidadNegocio();

            activeId = id;
            EspecialidadActiva = aux.GetEspecialidad(activeId).Nombre;
        }
        
     

        protected void Medico_Command(object sender, CommandEventArgs e)
        {
            string nombre = e.CommandArgument.ToString();
            EspecialidadActiva= nombre;
            string modal = e.CommandName.ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "openModal('"+modal+"')", true);
        }

        protected void Modal_btn(object sender, CommandEventArgs e)
        {
            string modal = e.CommandName.ToString();
            string nombre = e.CommandArgument.ToString();
            
            EspecialidadActiva = nombre;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "openModal('" + modal + "')", true);

        }
    }
}