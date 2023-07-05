using Modelo;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Controlador
{
    public class TurnoNegocio
    {
        public List<Turno> listTurnos()
        {
            List<Turno> turnos = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            PacienteNegocio pacienteNegocio = new PacienteNegocio();
            try
            {
                datos.SetConsulta("select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha from turno t");
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.id = (int)datos.Lector["id"];
                    aux.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                    aux.Paciente = pacienteNegocio.getPacienteById((int)datos.Lector["paciente_id"]);
                    aux.Observaciones = (string)datos.Lector["observaciones"];
                    aux.Estado = (EstadoTurno)datos.Lector["estado"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
            return turnos;
        }
        public List<Turno> listTurnosByMedicoId(int id)
        {
            List<Turno> turnos = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            PacienteNegocio pacienteNegocio = new PacienteNegocio();
            try
            {
                datos.SetConsulta($"select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha from turno t where t.medico_id={id}");
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.id = (int)datos.Lector["id"];
                    aux.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                    aux.Paciente = pacienteNegocio.getPacienteById((int)datos.Lector["paciente_id"]);
                    aux.Observaciones = (string)datos.Lector["observaciones"];
                    aux.Estado = (EstadoTurno)datos.Lector["estado"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
            return turnos;
        }
        public List<Turno> listTurnosByPacienteID(int id)
        {
            List<Turno> turnos = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            PacienteNegocio pacienteNegocio = new PacienteNegocio();
            try
            {
                datos.SetConsulta($"select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha from turno t where t.paciente_id={id}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.id = (int)datos.Lector["id"];
                    aux.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                    aux.Paciente = pacienteNegocio.getPacienteByIdSinTurnos((int)datos.Lector["paciente_id"]);
                    aux.Observaciones = datos.Lector["observaciones"].ToString();
                    aux.Estado = (EstadoTurno)datos.Lector["estado"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
            return turnos;
        }
        public Turno getTurnoById(int id)
        {
            Turno turno = new Turno();
            AccesoDatos datos = new AccesoDatos();
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            PacienteNegocio pacienteNegocio = new PacienteNegocio();
            try
            {
                datos.SetConsulta($"select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha from turno t where t.id={id}");
                turno.id = (int)datos.Lector["id"];
                turno.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                turno.Paciente = pacienteNegocio.getPacienteById((int)datos.Lector["paciente_id"]);
                turno.Observaciones = (string)datos.Lector["observaciones"];
                turno.Estado = (EstadoTurno)datos.Lector["estado"];
                turno.Fecha = (DateTime)datos.Lector["fecha"];
                return turno;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
        public void alta(Turno turno)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("insert into turnos (medico_id, paciente_id, observaciones, estado, fecha) values(@medico_id, @paciente_id, @observaciones, @estado, @fecha)");
                datos.setearParametro("@medico_id", turno.Medico.Id);
                datos.setearParametro("@paciente_id", turno.Paciente.Id);
                datos.setearParametro("@observaciones", turno.Observaciones);
                datos.setearParametro("@estado", EstadoTurno.Nuevo);
                datos.setearParametro("@fecha", turno.Fecha.Date);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
        public void baja(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta($"update turno set estado=0 where id={id}");
                datos.EjecutarAccion();
            }
            catch (Exception)
            {

                throw;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
        public void modificacion(Turno turno) 
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta($"UPDATE turno SET medico_id='@medico_id', paciente_id='@paciente_id' observaciones='@observaciones', estado='@estado', fecha='@fecha' WHERE id={turno.id}");
                datos.setearParametro("@medico_id", turno.Medico.Id);
                datos.setearParametro("@paciente_id", turno.Paciente.Id);
                datos.setearParametro("@observaciones", turno.Observaciones);
                datos.setearParametro("@estado", turno.Estado);
                datos.setearParametro("@fecha", turno.Fecha.Date);
                datos.EjecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
        }
    }
}
