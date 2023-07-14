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
    public partial class ModificarMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    int medicoActivo = 0;
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
                    fechaNac.Value = aux.FechaNacimiento.ToString("yyyy-MM-dd");
                    EspecialidadNegocio aux2 = new EspecialidadNegocio();
                    especialidadesMedicoMdf.DataSource = aux2.listar();
                    especialidadesMedicoMdf.DataBind();

                    foreach (Especialidad esp in aux.Especialidades)
                    {
                        if (especialidadesMedicoMdf.Items.FindByValue(esp.Id.ToString()) != null)
                        {
                            especialidadesMedicoMdf.Items.FindByValue(esp.Id.ToString()).Selected = true;
                        }
                    }
                }
                catch (Exception ex) { Session.Add("Error", ex.ToString()); Response.Redirect("Error.aspx", false); }

            }
        }

        protected void btn_modificar(object sender, EventArgs e)
        {
            try
            {
                Medico aux = new Medico();
                MedicoNegocio auxMedico = new MedicoNegocio();
                aux.Id = int.Parse(Request.QueryString["id"]);
                aux.Nombre = nombre.Value;
                aux.Apellido = apellido.Value;
                aux.Mail = mail.Value;
                aux.Dni = dni.Value;
                aux.Telefono = telefono.Value;
                aux.Direccion = direccion.Value;
                aux.FechaNacimiento = DateTime.Parse(fechaNac.Value);
                aux.Especialidades = new List<Especialidad>();
                foreach (ListItem item in especialidadesMedicoMdf.Items)
                {
                    if (item.Selected)
                    {
                        aux.Especialidades.Add(new Especialidad(int.Parse(item.Value), item.Text));
                    }
                }
                auxMedico.modificar(aux);
                Response.Redirect("ListadoMedicos.aspx");
            }
            catch (Exception ex) { Session.Add("Error", ex.ToString()); Response.Redirect("Error.aspx", false); }
        }
    }
}