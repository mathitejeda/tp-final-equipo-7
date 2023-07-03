using Microsoft.Win32;
using Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Controlador
{
    public class UsuarioNegocio
    {
        public int agregar(string user, string pass, TipoUsuario tipo = TipoUsuario.Administrador)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "INSERT INTO USUARIO (usuario,contrasenia, tipo) output inserted.Id VALUES (@user,@pass, @tipo)";
                datos.SetConsulta(consulta);
                datos.setearParametro("@user", user);
                datos.setearParametro("@pass", pass);
                datos.setearParametro("@tipo", (int)tipo);

                return datos.EjecutarAccionScalar();
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

        public int findByUserID(int user_id)
        {
            AccesoDatos datos = new AccesoDatos();
            int id = -1;
            try
            {
                datos.SetConsulta($"select id from usuario where id={user_id}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    id = (int)datos.Lector["id"];
                }
                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int findIdByUserName(string user_name)
        {
            AccesoDatos datos = new AccesoDatos();
            int id = -1;
            try
            {
                datos.SetConsulta($"select id from usuario where usuario={user_name}");
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    id = (int)datos.Lector["id"];
                }
                return id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int GetUltimoID()
        {
            int n = 0;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.SetConsulta("SELECT TOP(1) A.Id from usuario A ORDER BY Id DESC\r\n");
                datos.EjecutarLectura();
                if (datos.Lector.Read())
                {
                    n = (int)datos.Lector["Id"];
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
            return n;
        }

    }
}
