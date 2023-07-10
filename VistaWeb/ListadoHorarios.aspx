<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoHorarios.aspx.cs" Inherits="VistaWeb.ListadoHorarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <div class="container">
        <div class="row" id="fila">
            
            <div id="nuevoHorario" class="alert alert-primary alert-dismissible fade show" role="alert" style="display:none;">
              <strong>Registro exitoso.</strong> Se ha ingresado un nuevo horario.
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <!--
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
                            <asp:Repeater ID="horariosRepeater" runat="server" OnItemCommand="horariosRepeater_ItemCommand" >
                                <ItemTemplate >
                                        
                                <tr>
                                   <td>Dr. <%#Eval("Medico.Nombre")%> <%#Eval("Medico.Apellido")%> </td>
                                   <td><%#Eval("Especialidad.Nombre")%></td>
                                   <td><%#Eval("DiaSem")%></td>       
                                   <td><%#Eval("HsEntrada")%>:00 hs</td>     
                                   <td><%#Eval("HsSalida")%>:00 hs</td>     
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
                            <asp:LinkButton runat="server" OnClick="btn_agregarHorarioModal_Click" id="btn_agregarHorarioModal" type="button" CssClass="btn btn-primary">Agregar un horario</asp:LinkButton>
                            
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

    <!-- modal agregar usuario -->
    <div class="modal fade" id="modalAgregarHorario" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalAgregarHorario" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalAgregarHorario">Agregar un nuevo horario</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="MainContent_ddlMedicoAsignado" class="form-label">Médico asignado:</label>
                                <asp:DropDownList CssClass="form-select" ID="ddlMedicoAsignado" runat="server" OnSelectedIndexChanged="ddlMedicoAsignado_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem value="" Text="Elegí un médico..." Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                        <asp:RequiredFieldValidator ErrorMessage="* médico requerido" ControlToValidate="ddlMedicoAsignado" InitialValue="" runat="server" ForeColor="Red" ValidationGroup="input-horario" Display="Dynamic"/>
                    </div>

                    <div class="mb-3">
                        <label for="MainContent_ddlEspecialidad" class="form-label">Especialidad:</label>
                                <asp:DropDownList CssClass="form-select" ID="ddlEspecialidad" runat="server" >
                                    <asp:ListItem value="" Text="Elegí una especialidad..." Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                        <asp:RequiredFieldValidator ErrorMessage="* especialidad requerida" ControlToValidate="ddlEspecialidad" InitialValue="" runat="server" ForeColor="Red" ValidationGroup="input-horario" Display="Dynamic"/>
                    </div>

                     <div class="mb-3">
                        <label for="MainContent_ddlDiaAtencion" class="form-label">Día de atención:</label>
                        <asp:DropDownList CssClass="form-select" ID="ddlDiaAtencion" runat="server">
                            <asp:ListItem value="" Text="Elegí una opción..." Selected="True"></asp:ListItem>
                            <asp:ListItem value="1" Text="Lunes"></asp:ListItem>
                            <asp:ListItem value="2" Text="Martes"></asp:ListItem>
                            <asp:ListItem value="3" Text="Miércoles"></asp:ListItem>
                            <asp:ListItem value="4" Text="Jueves"></asp:ListItem>
                            <asp:ListItem value="5" Text="Viernes"></asp:ListItem>
                            <asp:ListItem value="6" Text="Sábado"></asp:ListItem>
                            <asp:ListItem value="7" Text="Domingo"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ErrorMessage="* dia de atención requerido" ControlToValidate="ddlDiaAtencion" InitialValue="" runat="server" ForeColor="Red" ValidationGroup="input-horario" Display="Dynamic" />
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <label for="MainContent_tbxHsEntrada" class="form-label">Hora ingreso:</label>
                            <div class="input-group">
                                <asp:TextBox Class="horario" ID="tbxHsEntrada" runat="server" CssClass="form-control" Style="background: #fff;" TextMode="Number" ValidationGroup="input-horarios"></asp:TextBox>
                                <span class="input-group-text">00 hs</span>
                            </div>
                            <asp:CustomValidator ID="ValidarHsEntrada" runat="server" ErrorMessage="* ingrese hora válida (0 a 23hs)" Display="Dynamic" MinimumValue="0" MaximumValue="23" ControlToValidate="tbxHsEntrada" ForeColor="Red" ValidationGroup="input-horario"></asp:CustomValidator>
                            <asp:RequiredFieldValidator ErrorMessage="* horario de ingreso requerido" ControlToValidate="tbxHsEntrada" InitialValue="" runat="server" ForeColor="Red" ValidationGroup="input-horario" />
                        </div>
                        <div class="col">
                            <label for="MainContent_tbxHsSalida" class="form-label">Hora salida:</label>
                            <div class="input-group">
                                <asp:TextBox Class="horario" ID="tbxHsSalida" runat="server" CssClass="form-control" Style="background: #fff;" TextMode="Number" ValidationGroup="input-horarios"></asp:TextBox>
                                <span class="input-group-text">00 hs</span>
                            </div>
                            <asp:CustomValidator ID="ValidarHsSalida" runat="server" ErrorMessage="* ingrese hora válida (0 a 23hs)" Display="Dynamic" MinimumValue="0" MaximumValue="23" ControlToValidate="tbxHsSalida" ForeColor="Red" ValidationGroup="input-horario" ></asp:CustomValidator>
                            <asp:RequiredFieldValidator ErrorMessage="* horario de salida requerido" ControlToValidate="tbxHsSalida" InitialValue="" runat="server" ForeColor="Red" ValidationGroup="input-horario" />
                        </div>

                    </div>



                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btn_Volver" runat="server" OnClick="btn_Volver_Click" type="button" class="btn btn-outline-primary">Volver</asp:LinkButton>
                    <asp:LinkButton ID="btn_AgregarHorario" OnClick="btn_AgregarHorario_Click" runat="server" type="button" class="btn btn-primary" ValidationGroup="input-horario" >Agregar horario</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

</asp:Content>
