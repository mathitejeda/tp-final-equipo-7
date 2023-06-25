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
        protected void Page_Load(object sender, EventArgs e)
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
                throw ex;
            }
        }
    }
}