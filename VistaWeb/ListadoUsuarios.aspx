<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoUsuarios.aspx.cs" Inherits="VistaWeb.ListadoUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script type="text/javascript">
        function openModal( modalName) {
            $('#'+modalName).modal('show');
        }
        function closeModal( modalName) {
            $('#'+modalName).modal('hide');
        }
    </script>
    <div class="container">
        <div class="row">
            <h1 class="mb-4">Listado de Usuarios (admin)</h1>


            <div class="col-md-12">
                <!--

                <ul class="nav nav-tabs" id="myTab" role="tablist">
                  <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="medicos-tab" data-bs-toggle="tab" data-bs-target="#medicos-tab-pane" type="button" role="tab" aria-controls="medicos-tab-pane" aria-selected="true">Médicos</button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pacientes-tab" data-bs-toggle="tab" data-bs-target="#pacientes-tab-pane" type="button" role="tab" aria-controls="pacientes-tab-pane" aria-selected="false">Pacientes
                    </button>
                  </li>
                  <li class="nav-item" role="presentation">
                    <button class="nav-link" id="recepcionistas-tab" data-bs-toggle="tab" data-bs-target="#recepcionistas-tab-pane" type="button" role="tab" aria-controls="recepcionistas-tab-pane" aria-selected="false">Recepcionistas</button>
                  </li>
                </ul>

                <div class="tab-content" id="myTabContent">
                  <div class="tab-pane fade show active" id="medicos-tab-pane" role="tabpanel" aria-labelledby="medicos-tab" tabindex="0">
                      MÉDICOS
                  </div>
                  <div class="tab-pane fade" id="pacientes-tab-pane" role="tabpanel" aria-labelledby="pacientes-tab" tabindex="0">
                      PACIENTES
                  </div>
                  <div class="tab-pane fade" id="recepcionistas-tab-pane" role="tabpanel" aria-labelledby="recepcionistas-tab" tabindex="0">
                      RECEPCIONISTAS
                  </div>
                </div>

                -->


                
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                           <asp:Repeater runat="server" id="rowRepeater">
                               <ItemTemplate >
                                        
                                <tr>
                                   <td><%#Eval("Id")%> </td>
                                   <td><%#Eval("User")%></td>
                                                        
                                    <td>
                                        <asp:LinkButton runat="server" OnCommand="Modals_btn" CommandArgument='<%#Eval("Id")%>'  CommandName="modalModificarUsuario" type="button" class="btn btn-warning" Text="Modificar"></asp:LinkButton>
                                        <asp:button runat="server" OnCommand="Modals_btn" CommandArgument='<%#Eval("Id")%>' CommandName="modalEliminarUsuario" type="button" class="btn btn-danger" Text="Eliminar"></asp:button>
                                    </td>
                                </tr>
                            
                               </ItemTemplate>
                           </asp:Repeater>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">Agregar nuevo usuario</button>
                        </div>
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
                    </div>

                </div>
            </div>


        </div>
    </div>

    <!-- modal agregar usuario -->
    <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalAgregarUsuario" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalAgregarUsuario">Agregar un nuevo usuario</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="usuario-nombre" class="form-label">Nombre del usuario:</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="usuarioNombreAdd" name="usuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="medico-apellido" class="form-label">Contraseña:</label>
                        <input runat="server" type="password" style="background: #fff" class="form-control" id="usuarioPasswordAdd" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="tipoUsuarioDropdown" class="form-label">Elegí un rol para este usuario:</label>
                        <asp:DropDownList CssClass="form-select" ID="tipoUsuarioDropdown" runat="server">
                            <asp:ListItem Text="Elegí una opción..." Selected="True"></asp:ListItem>
                            <asp:ListItem value="Administrador" Text="Administrador"></asp:ListItem>
                            <asp:ListItem value="Recepcionista">Recepcionista</asp:ListItem>
                            <asp:ListItem value="Médico">Médico</asp:ListItem>
                            <asp:ListItem value="Paciente">Paciente</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <h4>Datos personales</h4>
                        <label for="usuarioNombrePropioAdd" class="form-label">Nombre: </label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="usuarioNombrePropioAdd" name="nombre" required>
                        <label for="usuarioApellidoAdd" class="form-label">Apellido: </label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="usuarioApellidoAdd" name="apellido" required>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <asp:button runat="server" OnClick="btn_Agregar" type="button" class="btn btn-primary" Text="Agregar médico"></asp:button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

    <!-- modal Modificar usuario-->
    <div class="modal fade" id="modalModificarUsuario" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalModificarUsuario" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalModificarUsuario">Modificar un usuario</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="nombreUsuarioEdit" class="form-label">Nombre del usuario:</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="nombreUsuarioEdit" name="usuario" required>
                    </div>
                    <div class="mb-3">
                        <label for="passwordUsuarioEdit" class="form-label">Contraseña:</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="passwordUsuarioEdit" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="tipoUsuarioDropdownEdit" class="form-label">Elegí un rol para este usuario:</label>
                        <asp:DropDownList CssClass="form-select" ID="tipoUsuarioDropdownEdit" runat="server">
                            <asp:ListItem Value="" Selected="True">Elegí una opción</asp:ListItem>
                            <asp:ListItem value="Administrador" Text="Administrador"></asp:ListItem>
                            <asp:ListItem value="Recepcionista">Recepcionista</asp:ListItem>
                            <asp:ListItem value="Médico">Médico</asp:ListItem>
                            <asp:ListItem value="Paciente">Paciente</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <h4>Datos personales</h4>
                        <label for="usuarioNombrePropioEdit" class="form-label">Nombre: </label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="usuarioNombrePropioEdit" name="nombre" required>
                        <label for="usuarioApellidoEdit" class="form-label">Apellido: </label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="usuarioApellidoEdit" name="apellido" required>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <asp:button runat="server" OnClick="btn_Modificar" type="button" class="btn btn-primary" Text="Modificar usuario"></asp:button>
                </div>
            </div>
        </div>
    </div>
    <!-- 
    <div class="modal fade" id="modalEliminarMedico" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalEliminarMedico" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalEliminarMedico">Eliminar médico</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar al médico <%//:medicoActivo.Apellido+", "+medicoActivo.Nombre%>?</h4>
                    <h5>Todos los turnos que debe atender serán cambiados a estado PENDIENTE</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:button runat="server" OnClick="btn_Eliminar" type="button" class="btn btn-primary" Text="Eliminar"></asp:button>
                </div>
            </div>
        </div>
    </div>
        -->
</asp:Content> 
