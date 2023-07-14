<%@ Page Title="Turnos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoTurnos.aspx.cs" Inherits="VistaWeb.ListadoTurnos" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <% if (EstaLogueado())
        { %>
    <% if (EsTipoUsuario("admin") || EsTipoUsuario("recepcionista") || EsTipoUsuario("medico"))
        { %>

    <div class="container">
        <div class="row">
            <h1>Listado de Turnos</h1>

            <!-- VISTA DEL RECEPCIONISTA -->
            <div class="col-md-12">
                <div class="alert alert-secondary">
                    <div class="d-flex">

                        <div class="p-1">
                            <label for="filtro-dia" class="form-label">Día:</label>

                            <asp:DropDownList runat="server" ID="ddl_filtro_dia" CssClass="form-select">
                                <asp:ListItem Text="Todos los días" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Lunes" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Martes" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Miércoles" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Jueves" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Viernes" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Sábado" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Domingo" Value="7"></asp:ListItem>
                            </asp:DropDownList>

                        </div>
                        <div class="p-1">
                            <label for="filtro-especialidad" class="form-label">Especialidad:</label>
                            <asp:DropDownList runat="server" ID="ddl_filtro_especialidad" Visible="false" CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                        <div class="p-1">
                            <label for="filtro-medico" class="form-label">Médico:</label>
                            <asp:DropDownList runat="server" ID="ddl_filtro_medico" Visible="false" CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                        <div class="my-auto pt-4 ml-3">
                            <asp:LinkButton runat="server" ID="btn_filtrar" CssClass="btn btn-outline-primary px-4" Text="Filtrar" OnClick="btn_filtrar_Click"></asp:LinkButton>
                            <asp:LinkButton runat="server" ID="btn_limpiarFiltros" CssClass="btn btn-outline-secondary" Text="Limpiar filtros" OnClick="btn_limpiarFiltros_Click"></asp:LinkButton>
                        </div>

                    </div>

                </div>
            </div>
            <div class="col-md-12">

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>Fecha</th>
                                <th>Horario</th>
                                <th>Especialidad</th>
                                <th>Médico</th>
                                <th>Paciente</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <%if (repeaterTurnos.DataSource != null)
                            {%>
                        <asp:Repeater runat="server" ID="repeaterTurnos" OnItemCommand="repeaterTurnos_ItemCommand">
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td><%# DataBinder.Eval(Container.DataItem,"Fecha", "{0:d}") %></td>
                                        <td><%# DataBinder.Eval(Container.DataItem,"Fecha", "{0:t}") %></td>
                                        <td><%# Eval("Especialidad.Nombre") %></td>
                                        <td><%# Eval("Medico.Nombre") %></td>
                                        <td><%# Eval("Paciente.nombre") + " " + Eval("Paciente.apellido") %></td>
                                        <td>
                                            <asp:LinkButton runat="server" type="button" ID="btn_detalleTurno" class="btn btn-info" CommandName="Detalle" CommandArgument='<%#Eval("Id")%>'>
                                                <i class="bi bi-eye"></i>
                                                Ver
                                            </asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btn_modificarTurno" type="button" class="btn btn-warning" CommandName="Modificar" CommandArgument='<%#Eval("Id")%>'>Modificar</asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btn_eliminarTurno" type="button" class="btn btn-danger" CommandName="Eliminar" CommandArgument='<%#Eval("Id")%>'>Eliminar</asp:LinkButton>
                                        </td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                        </asp:Repeater>
                        <%}
                            else
                            {%>
                        <td colspan="7">
                            <h4>No se encuentra ningún turno con los criterios especificados.</h4>
                        </td>
                        <%}%>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <%if (EsTipoUsuario("admin") || EsTipoUsuario("recepcionista"))
                                {%>
                            <asp:LinkButton runat="server" ID="btn_agregarTurno" CssClass="btn btn-primary" Text="Agregar un turno" OnClick="btn_agregarTurno_Click"></asp:LinkButton>
                            <%} %>
                        </div>
                        <div>
                            <%--                            <nav aria-label="Menu de navegación del listado">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item"><a class="page-link" href="#">Anterior</a></li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item"><a class="page-link" href="#">Siguiente</a></li>
                                </ul>
                            </nav>--%>
                        </div>
                    </div>

                </div>
            </div>


        </div>
    </div>


    <!-- modal ver -->
    <div class="modal fade" id="modalVerTurno" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnModalAgregarTurno" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <asp:Label runat="server" ID="lbl_titulo" Text="Turno para (ESPECIALIDAD)" CssClass="modal-title fs-5"></asp:Label>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p>
                        <strong>Paciente: </strong>
                        <asp:Label runat="server" ID="lbl_nombrePaciente" Text="Nombre de paciente"></asp:Label>
                    </p>
                    <p>
                        <strong>Fecha y hora: </strong>
                        <asp:Label runat="server" ID="lbl_fecha" Text="fecha"></asp:Label>
                    </p>
                    <p>
                        <strong>Médico asignado: </strong>
                        <asp:Label runat="server" ID="lbl_medico" Text="Apellido, nombre - especialidad"></asp:Label>
                    </p>
                    <p>
                        <strong>Observaciones: </strong>
                        <asp:Label runat="server" ID="lbl_observaciones" Text="Observaciones"></asp:Label>
                    </p>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal ver -->
    <!-- modal Agregar -->
    <div class="modal fade" id="modalAgregarTurno" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnModalAgregarTurno" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnModalAgregarTurno">Agregar turno</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <!-- Inicio Form Datos Turno -->
                    <div class="mb-3">
                        <label for="turno-especialidad" class="form-label">Especialidad:</label>
                        <asp:DropDownList runat="server" ID="ddl_especialidad" CssClass="form-select" OnSelectedIndexChanged="ddl_especialidad_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="turno-medico" class="form-label">Medico:</label>
                                <asp:DropDownList runat="server" ID="ddl_medicos" CssClass="form-select" OnSelectedIndexChanged="ddl_medicos_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_especialidad" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="turno-fecha" class="form-label">Fecha:</label>
                                <asp:Calendar ID="calendarAgenda" runat="server" OnDayRender="calendarAgenda_DayRender" OnSelectionChanged="calendarAgenda_SelectionChanged" Visible="false"></asp:Calendar>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_medicos" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="turno-hora" class="form-label">Hora:</label>
                                <asp:DropDownList runat="server" ID="ddl_hora" CssClass="form-select" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="calendarAgenda" EventName="SelectionChanged" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <div class="mb-3">
                        <label for="turno-paciente" class="form-label">Paciente:</label>
                        <asp:DropDownList runat="server" ID="ddl_paciente" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <!-- -->

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" ID="btn_aceptaragregarTurno" CssClass="btn btn-primary" OnClick="btn_aceptaragregarTurno_Click">Agregar turno</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

    <!-- modal modificar -->
    <div class="modal fade" id="modalModificarTurno" tabindex="-1" data-backdrop="static" data-keyboard="false" aria-labelledby="labelBtnModalModificarTurno" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnModalModificarTurno">Modificar turno</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <!-- Inicio Form Datos Turno -->
                    <div class="mb-3">
                        <label for="turno-especialidad" class="form-label">Especialidad:</label>
                        <asp:DropDownList runat="server" ID="ddl_especialidad_modificar" CssClass="form-select" OnSelectedIndexChanged="ddl_especialidad_modificar_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>

                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="medico" class="form-label">Médico:</label>
                                <asp:DropDownList runat="server" ID="ddl_medicos_modificar" CssClass="form-select" OnSelectedIndexChanged="ddl_medicos_modificar_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_especialidad_modificar" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>


                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="turno-fecha" class="form-label">Fecha:</label>
                                <asp:Calendar ID="calendarAgenda_modificar" runat="server" OnDayRender="calendarAgenda_modificar_DayRender" OnSelectionChanged="calendarAgenda_modificar_SelectionChanged" Visible="false"></asp:Calendar>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_medicos_modificar" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="turno-hora" class="form-label">Hora:</label>
                                <asp:DropDownList runat="server" ID="ddl_hora_modificar" CssClass="form-select" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="calendarAgenda_modificar" EventName="SelectionChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="mb-3">
                        <label for="turno-estado" class="form-label">Estado:</label>
                        <asp:DropDownList runat="server" ID="ddl_estado_modificar" CssClass="form-select">
                            <asp:ListItem Text="Nuevo" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Cancelado" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Atendido" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Reprogramado" Value="4"></asp:ListItem>
                            <asp:ListItem Text="No asistió" Value="5"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <!-- -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" ID="btn_aceptarModificarTurno" CssClass="btn btn-primary" OnClick="btn_aceptarModificarTurno_Click">Guardar cambios</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- modal eliminar -->
    <div class="modal fade" id="modalEliminarTurno" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnModalEliminarTurno" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnModalEliminarTurno">Eliminar turno</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de que desea borrar el turno?</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" class="btn btn-primary" Text="Eliminar" OnClick="eliminarTurno"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <% }
        else
        {
            Session.Add("Error", "Debés tener permisos de administrador, recepcionista o médico para ver esta sección.");
            Response.Redirect("Error.aspx", false);

        } %>
    <% }
        else
        {
            Session.Add("Error", "Debés estar logueado para ver esta sección.");
            Response.Redirect("Error.aspx", false);

        }%>
</asp:Content>
