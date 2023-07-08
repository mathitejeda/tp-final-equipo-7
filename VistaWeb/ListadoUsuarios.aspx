<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoUsuarios.aspx.cs" Inherits="VistaWeb.ListadoUsuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <div class="container">
        <div class="row">
            
            <div id="#errorUser" class="alert alert-danger alert-dismissible fade show" role="alert">
              <strong>Ha ocurrido un error.</strong> El usuario ingresado ya existe. Prueba con otro
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
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
                                <th>Tipo de Usuario</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                           <asp:Repeater runat="server" id="rowRepeater" OnItemCommand="rowRepeater_ItemCommand">
                               <ItemTemplate >
                                        
                                <tr>
                                   <td><%#Eval("Id")%> </td>
                                   <td><%#Eval("User")%></td>
                                   <td><%#Eval("TipoUsuario")%></td>                  
                                    <td>
                                        <asp:LinkButton runat="server" ID="btn_modificarUsuario" type="button" CssClass="btn btn-warning" CommandArgument='<%#Eval("Id")%>' CommandName="ModificarUsuario">Modificar</asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="btn_eliminarUsuario" type="button" CssClass="btn btn-danger" CommandArgument='<%#Eval("Id")%>' CommandName="EliminarUsuario">Eliminar</asp:LinkButton>
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
                        <label for="tbx_NombreUsuario" class="form-label">Nombre del usuario:</label>
                        <asp:TextBox runat="server" type="text" ID="tbx_NombreUsuario" Style="background: #fff" class="form-control" name="usuario" placeholder="Nombre de usuario" required="true"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="tbx_PasswordUsuario" class="form-label">Contraseña del usuario:</label>
                        <asp:TextBox runat="server" type="password" ID="tbx_PasswordUsuario" Style="background: #fff" class="form-control" name="contraseña" placeholder="Ingresa una contraseña" required="true"></asp:TextBox>
                   </div>
                    <div class="mb-3">
                        <label for="tipoUsuarioDropdown" class="form-label">Elegí un rol para este usuario:</label>
                        <asp:DropDownList CssClass="form-select" ID="tipoUsuarioDropdown" runat="server">
                            <asp:ListItem value="" Text="Elegí una opción..." Selected="True"></asp:ListItem>
                            <asp:ListItem value="Administrador" Text="Administrador">Administrador</asp:ListItem>
                            <asp:ListItem value="Recepcionista">Recepcionista</asp:ListItem>
                            <asp:ListItem value="Médico">Médico</asp:ListItem>
                            <asp:ListItem value="Paciente">Paciente</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <h4>Datos personales</h4>
                        
                        <label for="tbx_NombrePropioUser" class="form-label">Nombre:</label>
                        <asp:TextBox runat="server" type="text" ID="tbx_NombrePropioUser" Style="background: #fff" class="form-control" name="Nombre" placeholder="Ingresa el nombre" required="true"></asp:TextBox>
                        <label for="tbx_ApellidoUser" class="form-label">Apellido:</label>
                        <asp:TextBox runat="server" type="text" ID="tbx_ApellidoUser" Style="background: #fff" class="form-control" name="Nombre" placeholder="Ingresa el apellido" required="true"></asp:TextBox>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" OnClick="btn_Agregar" type="button" class="btn btn-primary">Agregar usuario</asp:LinkButton>
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
                    <h5><asp:Label ID="labelBtnmodalModificarUsuario" runat="server" Text="Modificar un usuario"></asp:Label></h5>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar" onclick="closeModal('modalVerDatos')"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="tbx_NombreUsuarioMod" class="form-label">Nombre del usuario:</label>
                        <asp:TextBox runat="server" type="text" ID="tbx_NombreUsuarioMod" Style="background: #fff" class="form-control" name="usuario" placeholder="Nombre de usuario" required="true"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="tbx_PasswordUsuarioMod" class="form-label">Contraseña del usuario:</label>
                        <asp:TextBox runat="server" type="password" ID="tbx_PasswordUsuarioMod" Style="background: #fff" class="form-control" name="contraseña" placeholder="Ingresa una contraseña" required="true"></asp:TextBox>
                   </div>
                    <div class="mb-3">
                        <label for="tipoUsuarioDropdownEditMod" class="form-label">Elegí un rol para este usuario:</label>
                        <asp:DropDownList CssClass="form-select" ID="tipoUsuarioDropdownEditMod" runat="server">
                            <asp:ListItem Value="" Selected="True">Elegí una opción</asp:ListItem>
                            <asp:ListItem value="Administrador" Text="Administrador"></asp:ListItem>
                            <asp:ListItem value="Recepcionista">Recepcionista</asp:ListItem>
                            <asp:ListItem value="Médico">Médico</asp:ListItem>
                            <asp:ListItem value="Paciente">Paciente</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <h4>Datos personales</h4>
                        
                        <label for="tbx_NombrePropioUserMod" class="form-label">Nombre:</label>
                        <asp:TextBox runat="server" type="text" ID="tbx_NombrePropioUserMod" Style="background: #fff" class="form-control" name="Nombre" placeholder="Ingresa el nombre" required="true"></asp:TextBox>
                        <label for="tbx_ApellidoUserMod" class="form-label">Apellido:</label>
                        <asp:TextBox runat="server" type="text" ID="tbx_ApellidoUserMod" Style="background: #fff" class="form-control" name="Nombre" placeholder="Ingresa el apellido" required="true"></asp:TextBox>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" OnClick="btn_Modificar" type="button" class="btn btn-primary" Text="Modificar usuario"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="modalEliminarUsuario" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalEliminarUsuario" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5><asp:Label ID="labelBtnmodalEliminarUsuario" runat="server" Text="Eliminar un usuario"></asp:Label></h5>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar" onclick="closeModal('modalVerDatos')"></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lbl_BorrarUsuario" runat="server" CssClass="">¿Estás seguro de borrar al usuario USER?</asp:Label>
                    <h5>Se eliminarán todos los datos relacionados a este usuario.</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" OnClick="btn_Eliminar" type="button" class="btn btn-primary" Text="Eliminar usuario"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content> 
