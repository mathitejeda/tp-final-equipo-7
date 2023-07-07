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
        public List<Usuario> listar()
        {
            List<Usuario> listaUsuarios = new List<Usuario>();

            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "select id, usuario, tipo from usuario order by id asc";
                datos.SetConsulta(consulta);
                datos.EjecutarLectura();
                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["id"];
                    aux.User = (string)datos.Lector["usuario"];
                    aux.TipoUsuario = (TipoUsuario)datos.Lector["tipo"];
                    listaUsuarios.Add(aux);
                }
                return listaUsuarios;
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
        public int agregar(string user, string pass, int tipo)
        {
            AccesoDatos datos = new AccesoDatos();
            int id = -1;
            try
            {
                string consulta = "INSERT INTO USUARIO (usuario,contrasenia, tipo) output inserted.Id VALUES (@user,@pass, @tipo)";
                datos.SetConsulta(consulta);
                datos.setearParametro("@user", user);
                datos.setearParametro("@pass", pass);
                datos.setearParametro("@tipo", (int)tipo);

                id = datos.EjecutarAccionScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CerrarConexion();
            }
            return id;
        }

        public void agregar(string user, string pass, string nombre, string apellido, int tipo)
        {
            this.agregar(user, pass, tipo); // agrego el user a la tabla usuarios
            int id = this.GetUltimoID();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "insert into usuario_desc (usuario_id, nombre, apellido, tipo) values (@id, @nombre, @apellido, @tipo)";
                datos.SetConsulta(consulta);
                datos.setearParametro("@id", id);
                datos.setearParametro("@nombre", nombre);
                datos.setearParametro("@apellido", apellido);
                datos.setearParametro("@tipo", tipo);

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
                datos.SetConsulta($"select id from usuario where usuario='{user_name}'");
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

        public Usuario getUsuario(int id)
        {
            Usuario aux;
            AccesoDatos datos = new AccesoDatos();
            try
            {
                string consulta = "select id, usuario, contrasenia from usuario u where id=@id";
                datos.SetConsulta(consulta);
                datos.setearParametro("@id", id);
                datos.EjecutarLectura();
                if (datos.Lector.Read())
                {
                    aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.User = (string)datos.Lector["Usuario"];
                    aux.Pass = (string)datos.Lector["Contrasenia"];
                    return aux;
                }
                else
                {
                    return null;
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
        }

    }
}
