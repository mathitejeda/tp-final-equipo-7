using Modelo;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

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
                datos.SetConsulta("select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha, t.especialidad_id from turno t where t.estado=1");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    EspecialidadNegocio especialidad = new EspecialidadNegocio();
                    aux.id = (int)datos.Lector["id"];
                    aux.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                    aux.Paciente = pacienteNegocio.getPacienteById((int)datos.Lector["paciente_id"]);
                    aux.Observaciones = datos.Lector["observaciones"].ToString();
                    aux.Estado = (EstadoTurno)datos.Lector["estado"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                    aux.Especialidad = especialidad.GetEspecialidad((int)datos.Lector["especialidad_id"]);
                    turnos.Add(aux);
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
                datos.SetConsulta($"select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha, t.especialidad_id from turno t where t.medico_id={id}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
                    aux.id = (int)datos.Lector["id"];
                    aux.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                    aux.Paciente = pacienteNegocio.getPacienteById((int)datos.Lector["paciente_id"]);
                    aux.Observaciones = datos.Lector["observaciones"].ToString();
                    aux.Estado = (EstadoTurno)datos.Lector["estado"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                    aux.Especialidad = especialidadNegocio.GetEspecialidad((int)datos.Lector["especialidad_id"]);
                    turnos.Add( aux );
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
                datos.SetConsulta($"select t.id, t.medico_id, t.paciente_id, t.observaciones, t.estado, t.fecha, t.especialidad_id from turno t where t.paciente_id={id}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    EspecialidadNegocio especialidad = new EspecialidadNegocio();
                    aux.id = (int)datos.Lector["id"];
                    aux.Medico = medicoNegocio.getMedico((int)datos.Lector["medico_id"]);
                    aux.Paciente = pacienteNegocio.getPacienteByIdSinTurnos((int)datos.Lector["paciente_id"]);
                    aux.Observaciones = datos.Lector["observaciones"].ToString();
                    aux.Estado = (EstadoTurno)datos.Lector["estado"];
                    aux.Fecha = (DateTime)datos.Lector["fecha"];
                    aux.Especialidad = especialidad.GetEspecialidad((int)datos.Lector["especialidad_id"]);
                    turnos.Add( aux );
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
            if (turno.Observaciones == null)
            {
                turno.Observaciones = "";
            }
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("insert into turno(medico_id, paciente_id, observaciones, fecha, estado, especialidad_id) values(@medico_id, @paciente_id, @observaciones, @fecha, @estado, @especialidad_id)");
                datos.setearParametro("@medico_id", turno.Medico.Id);
                datos.setearParametro("@paciente_id", turno.Paciente.Id);
                datos.setearParametro("@observaciones", turno.Observaciones);
                datos.setearParametro("@fecha", turno.Fecha);
                datos.setearParametro("@estado", EstadoTurno.Nuevo);
                datos.setearParametro("@especialidad_id", turno.Especialidad.Id);
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
            if (turno.Observaciones == null)
            {
                turno.Observaciones = "";
            }
            try
            {
                datos.SetConsulta($"UPDATE turno SET medico_id=@medico_id, especialidad_id=@especialidad_id, observaciones=@observaciones, estado=@estado, fecha=@fecha WHERE id={turno.id}");
                datos.setearParametro("@medico_id", turno.Medico.Id);
                datos.setearParametro("@especialidad_id", turno.Especialidad.Id);
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
