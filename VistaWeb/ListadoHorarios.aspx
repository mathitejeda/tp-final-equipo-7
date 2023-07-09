<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoHorarios.aspx.cs" Inherits="VistaWeb.ListadoHorarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <div class="container">
        <div class="row" id="fila">
            <!--
            <div id="nuevoUser" class="alert alert-primary alert-dismissible fade show" role="alert" style="display:none;">
              <strong>Registro exitoso.</strong> Se ha ingresado un nuevo usuario.
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            
            <div id="errorUser" class="alert alert-danger alert-dismissible fade show" role="alert" style="display:none;">
              <strong>Ha ocurrido un error.</strong> El usuario ingresado ya existe. Prueba con otro
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

            <div id="modificarUser" class="alert alert-secondary alert-dismissible fade show" role="alert" style="display:none;">
              <strong>Modificación exitosa.</strong> Se han modificado los datos del usuario.
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>

            <div id="eliminarUser" class="alert alert-primary alert-dismissible fade show" role="alert" style="display:none;">
              <strong>Registro eliminado.</strong> Se eliminó con éxito al usuario.
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            -->
            <h1 class="mb-4">Horarios</h1>

            <div class="col-md-12">
               
                
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>Médico asignado</th>
                                <th>Especialidad</th>
                                <th>Día</th>
                                <th>Horario Entrada</th>
                                <th>Horario Salida</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="horariosRepeater" runat="server">
                                <ItemTemplate >
                                        
                                <tr>
                                   <td>Dr. <%#Eval("Medico.Nombre")%> <%#Eval("Medico.Apellido")%> </td>
                                   <td><%#Eval("Especialidad.Nombre")%></td>
                                   <td><%#Eval("DiaSem")%></td>       
                                   <td><%#Eval("HsEntrada")%></td>     
                                   <td><%#Eval("HsSalida")%></td>     
                                   <td>
                                       <p>acciones</p>
                                        <!--<asp:LinkButton runat="server" ID="btn_modificarUsuario" type="button" CssClass="btn btn-warning" CommandArgument='<%//#Eval("Id")%>' CommandName="ModificarUsuario">Modificar</asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="btn_eliminarUsuario" type="button" CssClass="btn btn-danger" CommandArgument='<%//#Eval("Id")%>' CommandName="EliminarUsuario">Eliminar</asp:LinkButton>-->
                                   </td>
                                </tr>
                            
                               </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" id="agregarUser" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">Agregar nuevo usuario</button>
                        </div>
                        <!--
                        <div>
                            <nav aria-label="Menu de navegación del listado">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item"><a class="page-link" href="#">Anterior</a></li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item"><a class="page-link" href="#">Siguiente</a></li>
                                </ul>
                            </nav>
                        </div>
                        -->
                    </div>

                </div>
            </div>


        </div>
    </div>

</asp:Content>
