using System;
using System.Collections.Generic;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            try
            {
                List<Medico> lista = medicoNegocio.listar();
                MedicoRep.DataSource = lista;
                MedicoRep.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}