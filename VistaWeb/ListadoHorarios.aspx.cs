using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;
using Controlador;
using Modelo;

namespace VistaWeb
{


    public partial class ListadoHorarios : System.Web.UI.Page
    {
        public List<Horario> listaHorarios { get; set; }
        public Horario horarioActual { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            loadHorarios();
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
    }
}