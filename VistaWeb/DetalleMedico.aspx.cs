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
    public partial class DetalleMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            
            if (!IsPostBack)
            {
                int medicoActivo= 0;
                if (Request.QueryString["id"] != null) { medicoActivo = int.Parse(Request.QueryString["id"]); }
                else Response.Redirect("ListadoMedicos.aspx");
                Medico aux = new Medico();
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                aux = medicoNegocio.getMedico(medicoActivo);
                nombre.Value = aux.Nombre;
                apellido.Value = aux.Apellido;
                mail.Value = aux.Mail;
                dni.Value = aux.Dni;
                telefono.Value = aux.Telefono;
                direccion.Value = aux.Direccion;
                fechaNac.Value = aux.FechaNacimiento.ToString("dd-MM-yyyy");
                especialidadesMedicoLista.DataSource = aux.Especialidades;
                especialidadesMedicoLista.DataBind();
            }
        }
    }
}