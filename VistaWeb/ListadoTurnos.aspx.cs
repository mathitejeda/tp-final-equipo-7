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
    public partial class ListadoTurnos : System.Web.UI.Page
    {
        public List<Turno> turnos { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_turnos();
            }
        }
        protected void load_turnos()
        {
            if (turnos == null)
            {
                TurnoNegocio turnoNegocio = new TurnoNegocio();
                turnos = turnoNegocio.listTurnos();
                Session.Add("Turnos", turnos);
            }
            repeaterTurnos.DataSource = turnos;
            repeaterTurnos.DataBind();
        }
    }
}