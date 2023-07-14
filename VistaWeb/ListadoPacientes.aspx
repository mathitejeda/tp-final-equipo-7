<%@ Page Title="Pacientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoPacientes.aspx.cs" Inherits="VistaWeb.ListadoPacientes" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    
    
        <% if (EstaLogueado())
          { %> 
            <% if (EsTipoUsuario("admin") || EsTipoUsuario("recepcionista") || EsTipoUsuario("medico") )
                { %> 
    
    <div class="container">
        <div class="row">
            <h1 class="mb-4">Listado de Pacientes</h1>


            <div class="col-md-12">

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Nombre y Apellido</th>
                                <th>Fecha de Nacimiento</th>
                                <th>DNI</th>
                                <th>Datos de Contacto</th>
                                <th>Turnos</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%if (pacientes != null && pacientes.Count > 0)
                                {%>
                            <asp:Repeater runat="server" ID="repeaterPacientes" OnItemCommand="repeaterPacientes_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td><%#Eval("Id") %></td>
                                        <td><%#Eval("Nombre") + " " + Eval("Apellido")%></td>
                                        <td><%#Eval("FechaNacimiento.Day") + "/" + Eval("FechaNacimiento.Month") + "/" + Eval("FechaNacimiento.Year")%></td>
                                        <td><%#Eval("Dni")%></td>
                                        <td>
                                            <asp:LinkButton runat="server" type="button" ID="btn_detalle_paciente" class="btn btn-info" CommandName="Detalle" CommandArgument='<%#Eval("Id")%>'>
                                                <i class="bi bi-person-circle"></i>
                                                Ver
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton runat="server" ID="btn_verTurnos" type="button" class="btn btn-success" CommandName="VerTurnos" CommandArgument='<%#Eval("Id")%>'>
                                                <i class="bi bi-calendar3"></i>
                                                Ver
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:LinkButton runat="server" ID="btn_modificarPaciente" type="button" class="btn btn-warning" CommandName="Modificar" CommandArgument='<%#Eval("Id")%>'>Modificar</asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btn_eliminarPaciente" type="button" class="btn btn-danger" CommandName="Eliminar" CommandArgument='<%#Eval("Id")%>'>Eliminar</asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <%}
                                else
                                {%>
                            <td colspan="7">
                                <h4>No hay ningun paciente cargado.</h4>
                            </td>
                            <%} %>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarPaciente">Agregar nuevo paciente</button>
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


    <!-- modal ver detalles de paciente -->
    <div class="modal fade" id="modalVerDatos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerDatos" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <asp:Label runat="server" ID="lbl_titleModalVerDatos" class="modal-title fs-5" Text="Datos de NOMBRE_PACIENTE"></asp:Label>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar" onclick="closeModal('modalVerDatos')"></button>
                </div>
                <div class="modal-body">
                    <div class="card mb-3">
                        <div class="card-header">
                            <h6>Datos Personales</h6>
                        </div>
                        <div class="card-body">
                            <div class="card-text">
                                <div>
                                    <i class="bi bi-person-circle"></i>
                                    <asp:Label runat="server" ID="lbl_nombre_apellido" Text="NOMBRE Y APELLIDO PACIENTE"></asp:Label>
                                </div>
                                <div>
                                    <i class="bi bi-calendar-heart"></i>
                                    <asp:Label runat="server" ID="lbl_fechaNac" Text="FECHA DE NACIMIENTO DD/MMM/AAAA"></asp:Label>
                                </div>
                                <div>
                                    <i class="bi bi-calendar-heart"></i>
                                    <asp:Label runat="server" ID="lbl_DNI" Text="xx.xxx.xxx"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-3">
                        <div class="card-header">
                            <h6>Datos de Contacto</h6>
                        </div>
                        <div class="card-body">
                            <div class="card-text">
                                <div>
                                    <i class="bi bi-geo-alt-fill"></i>
                                    <asp:Label runat="server" ID="lbl_direccion" Text="La calle más larga que conocí alguna vez 2558, Los Polvorines"></asp:Label>
                                </div>
                                <div>
                                    <i class="bi bi-telephone-fill"></i>
                                    <asp:Label runat="server" ID="lbl_telefono" Text="xxx-xxx"></asp:Label>
                                </div>
                                <div>
                                    <i class="bi bi-envelope-fill"></i>
                                    <asp:Label runat="server" ID="lbl_email" Text="you@example.com"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal ver -->

    <!-- modal ver turnos x paciente -->
    <div class="modal fade" id="modalVerTurnos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerTurnos" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <asp:Label runat="server" ID="lbl_titleModalVerTurnos" class="modal-title fs-5" Text="Ver turnos del paciente NOMBRE_PACIENTE"></asp:Label>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <%if (pacienteActivo != null && pacienteActivo.Turnos != null && pacienteActivo.Turnos.Count() > 0)
                        {%>
                            <asp:Repeater runat="server" ID="repeaterTurnos">
                                <ItemTemplate>
                                    <div class="card border-dark mb-3">
                                        <div class="card-header text-dark">
                                            <h5><%# Eval("fecha") %></h5>
                                        </div>
                                        <div class="card-body text-dark">
                                            <h6 class="card-title">Datos del turno:</h6>
                                            <p class="card-text">
                                                <ul>
                                                    <li><strong>Médico: </strong><%#Eval("Medico.Nombre") + ", " + Eval("Medico.Apellido") %></li>
                                                    <li><strong>Especialidad: </strong><%# Eval("Especialidad.nombre") %></li>
                                                </ul>
                                            </p>
                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:Repeater>
                    <%}
                        else
                        {%>
                            <h4>El paciente no posee ningun turno aun.</h4>
                    <%} %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal ver -->
    <!-- modal agregar paciente -->
    <div class="modal fade" id="modalAgregarPaciente" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalAgregarPaciente" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalAgregarPaciente">Agregar un nuevo paciente</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="paciente-nombre" class="form-label">Nombre del paciente:</label>
                        <asp:TextBox runat="server" ID="tbx_nombrePaciente" type="text" Style="background: #fff" class="form-control" name="nombre" placeholder="Nombre"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-apellido" class="form-label">Apellido del paciente:</label>
                        <asp:TextBox runat="server" ID="tbx_apellidoPaciente" type="text" Style="background: #fff" class="form-control" name="nombre" placeholder="Apellido"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-dni" class="form-label">DNI:</label>
                        <asp:TextBox runat="server" ID="tbx_dni" type="number" Style="background: #fff" class="form-control" placeholder="DNI"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                        <asp:TextBox runat="server" ID="tbx_fechaNac" type="date" Style="background: #fff" class="form-control" placeholder="Fecha de nacimiento" Text="00-00-0000"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-direccion" class="form-label">Dirección completa:</label>
                        <asp:TextBox runat="server" ID="tbx_direccion" type="text" Style="background: #fff" class="form-control" placeholder="Direccion"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-email" class="form-label">E-mail:</label>
                        <asp:TextBox runat="server" ID="tbx_pacienteEmail" type="text" Style="background: #fff" class="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-telefono" class="form-label">Telefono particular:</label>
                        <asp:TextBox runat="server" ID="tbx_telefono" type="number" Style="background: #fff" class="form-control" placeholder="Telefono"></asp:TextBox>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" class="btn btn-primary" Text="Eliminar" OnClick="agregarPaciente">Agregar paciente</asp:LinkButton>

                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

    <!-- modal Modificar paciente-->
    <div class="modal fade" id="modalModificarPaciente" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalModificarPaciente" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <asp:Label runat="server" ID="lbl_titleModalModificarPaciente" class="modal-title fs-5" Text="Modificar paciente NOMBRE_PACIENTE"></asp:Label>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="paciente-nombre" class="form-label">Nombre del paciente:</label>
                        <asp:TextBox runat="server" ID="tbx_nombreMod" type="text" Style="background: #fff" class="form-control" name="nombre" placeholder="Nombre"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-apellido" class="form-label">Apellido del paciente:</label>
                        <asp:TextBox runat="server" ID="tbx_apellidoMod" type="text" Style="background: #fff" class="form-control" name="nombre" placeholder="Apellido"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-dni" class="form-label">DNI:</label>
                        <asp:TextBox runat="server" ID="tbx_DniMod" type="number" Style="background: #fff" class="form-control" placeholder="Dni"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                        <asp:TextBox runat="server" ID="tbx_fechaNacMod" type="date" Style="background: #fff" class="form-control" placeholder="Fecha de nacimiento"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-direccion" class="form-label">Dirección completa:</label>
                        <asp:TextBox runat="server" ID="tbx_direccionMod" type="text" Style="background: #fff" class="form-control" name="nombre" placeholder="Direccion"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-email" class="form-label">E-mail:</label>
                        <asp:TextBox runat="server" ID="tbx_emailMod" type="text" Style="background: #fff" class="form-control" name="nombre" placeholder="Mail"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-telefono" class="form-label">Telefono particular:</label>
                        <asp:TextBox runat="server" ID="tbx_telefonoMod" type="number" Style="background: #fff" class="form-control"
                            placeholder="Telefono"></asp:TextBox>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" class="btn btn-primary" Text="Modificar" OnClick="modificarPaciente"></asp:LinkButton>

                </div>
            </div>
        </div>
    </div>

    <!-- modal eliminar -->
    <div class="modal fade" id="modalEliminarPaciente" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalEliminarPaciente" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalEliminarPaciente">Eliminar paciente</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>
                        <asp:Literal runat="server" ID="lit_confirmacionPaciente" Text="¿Estás seguro de borrar al paciente (NOMBRE_PACIENTE)?"></asp:Literal></h4>
                    <h5>Todos los turnos pendientes serán dados de baja</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" class="btn btn-primary" Text="Eliminar" OnClick="eliminarPaciente"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

        <% } else
        {
            Session.Add("Error", "Debés tener permisos de administrador, recepcionista o médico para ver esta sección.");
            Response.Redirect("Error.aspx", false);

        } %>
<% } else
        {
            Session.Add("Error", "Debés estar logueado para ver esta sección.");
            Response.Redirect("Error.aspx", false);

        }%>

</asp:Content>
