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
    public partial class AgregarMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EspecialidadNegocio aux = new EspecialidadNegocio();
                especialidadesMedicoAdd.DataSource = aux.listar();
                especialidadesMedicoAdd.DataBind();
            }
        }

        protected void btn_agregar(object sender, EventArgs e)
        {
            try
            {
                Medico aux = new Medico();
                MedicoNegocio auxMedico = new MedicoNegocio();
                aux.Nombre = nombre.Value;
                aux.Apellido = apellido.Value;
                aux.Mail = mail.Value;
                aux.Dni = dni.Value;
                aux.Telefono = telefono.Value;
                aux.Direccion = direccion.Value;
                aux.FechaNacimiento = DateTime.Parse(fechaNac.Value);
                aux.Especialidades = new List<Especialidad>();
                foreach (ListItem item in especialidadesMedicoAdd.Items)
                {
                    if (item.Selected)
                    {
                        aux.Especialidades.Add(new Especialidad(int.Parse(item.Value), item.Text));
                    }
                }
                auxMedico.agregar(aux);
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