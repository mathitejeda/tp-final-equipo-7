<%@ Page Title="Turnos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoTurnos.aspx.cs" Inherits="VistaWeb.ListadoTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <div class="container">
        <div class="row">
            <h1>Listado de Turnos</h1>

            <!-- VISTA DEL RECEPCIONISTA -->
            <div class="col-md-12">
                <div class="alert alert-secondary">
                    <div class="d-flex">

                        <div class="p-1">
                            <label for="filtro-dia" class="form-label">Día:</label>
                            <select class="form-select" id="filtro-dia" name="filtro-dia">
                                <option value="">Todos los días</option>
                                <option value="lunes">Lunes</option>
                                <option value="martes">Martes</option>
                                <option value="miercoles">Miércoles</option>
                                <option value="jueves">Jueves</option>
                                <option value="viernes">Viernes</option>
                                <option value="sabado">Sábado</option>
                                <option value="domingo">Domingo</option>
                            </select>
                        </div>
                        <div class="p-1">
                            <label for="filtro-especialidad" class="form-label">Especialidad:</label>
                            <select class="form-select" id="filtro-especialidad" name="filtro-especialidad">
                                <option value="">Todas las especialidades</option>
                                <option value="cardiologia">Cardiología</option>
                                <option value="clínica">Clínica</option>
                            </select>
                        </div>
                        <div class="p-1">
                            <label for="filtro-medico" class="form-label">Médico:</label>
                            <select class="form-select" id="filtro-medico" name="filtro-medico">
                                <option value="">Todos los médicos</option>
                                <option value="Dr. Pérez">Dr. Pérez</option>
                            </select>
                        </div>
                        <div class="my-auto pt-4 ml-3">

                            <button type="submit" class="btn btn-outline-primary px-4">Filtrar</button>
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
                        <%if (turnos != null && turnos.Count() > 0)
                            {%>
                        <asp:Repeater runat="server" ID="repeaterTurnos" OnItemCommand="repeaterTurnos_ItemCommand">
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td>Martes 13 de Junio 2023</td>
                                        <td>10:00</td>
                                        <td>Dentista</td>
                                        <td>Dr. Pérez</td>
                                        <td>Juan González</td>
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
                            <asp:LinkButton runat="server" ID="btn_agregarTurno" CssClass="btn btn-primary" Text="Agregar un turno" OnClick="btn_agregarTurno_Click" ></asp:LinkButton>
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
                                <asp:DropDownList runat="server" ID="ddl_medicos" CssClass="form-select"></asp:DropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddl_especialidad" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <div class="mb-3">
                        <label for="turno-fecha" class="form-label">Fecha:</label>
                        <input type="date" class="form-control" id="turno-fecha" name="fecha" required>
                    </div>
                    <div class="mb-3">
                        <label for="turno-horario" class="form-label">Horario:</label>
                        <select class="form-select" id="turno-horario" name="horario" required>
                            <option value="">Seleccionar...</option>
                            <option value="10:30">10:30</option>
                            <option value="11:00">11:00</option>
                            <option value="12:00">12:00</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="turno-paciente" class="form-label">Paciente:</label>
                        <select class="form-select" id="turno-paciente" name="paciente" required>
                            <option value="">Seleccionar...</option>
                            <option value="Juan Topo">Juan Topo</option>
                            <option value="Elvis Cocho">Elvis Cocho</option>
                        </select>
                    </div>
                    <!-- -->

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Agregar turno</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

    <!-- modal modificar -->
    <div class="modal fade" id="modalModificarTurno" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnModalModificarTurno" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnModalModificarTurno">Modificar turno</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <!-- Inicio Form Datos Turno -->
                    <div class="mb-3">
                        <label for="fecha" class="form-label">Fecha:</label>
                        <input type="date" class="form-control" id="fecha" name="fecha" required>
                    </div>
                    <div class="mb-3">
                        <label for="horario" class="form-label">Horario:</label>
                        <select class="form-select" id="horario" name="horario" required>
                            <option value="">Seleccionar...</option>
                            <option value="10:30">10:30</option>
                            <option value="11:00">11:00</option>
                            <option value="12:00">12:00</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="medico" class="form-label">Médico:</label>
                        <select class="form-select" id="medico" name="medico" required>
                            <option value="">Seleccionar...</option>
                            <option value="Dr. Pérez">Dr. Pérez</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="especialidad" class="form-label">Especialidad:</label>
                        <select class="form-select" id="especialidad" name="especialidad" required>
                            <option value="">Seleccionar...</option>
                            <option value="cardiología">Cardiología</option>
                            <option value="clínica">Clínica</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="paciente" class="form-label">Paciente:</label>
                        <select class="form-select" id="paciente" name="paciente" required>
                            <option value="">Seleccionar...</option>
                            <option value="Juan Topo">Juan Topo</option>
                            <option value="Elvis Cocho">Elvis Cocho</option>
                        </select>
                    </div>
                    <!-- -->

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Guardar cambios</button>
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
                    <h4>¿Estás seguro de borrar el turno?</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:LinkButton runat="server" class="btn btn-primary" Text="Eliminar" OnClick="eliminarTurno"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
