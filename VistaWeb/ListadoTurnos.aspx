<%@ Page Title="Turnos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoTurnos.aspx.cs" Inherits="VistaWeb.ListadoTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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
                        <tbody>
                            <tr>
                                <td>Martes 13 de Junio 2023</td>
                                <td>10:00</td>
                                <td>Dentista</td>
                                <td>Dr. Pérez</td>
                                <td>Juan González</td>
                                <td>
                                    <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#modalVerTurno">
                                      <i class="bi bi-eye"></i>
                                       Ver
                                    </button>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modalModificarTurno">Modificar</button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarTurno">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Jueves 15 de Junio 2023</td>
                                <td>11:30</td>
                                <td>Cardiología</td>
                                <td>Dr. Ramírez</td>
                                <td>María López</td>
                                <td>
                                    <button type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#modalVerTurno">
                                      <i class="bi bi-eye"></i>
                                       Ver
                                    </button>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modalModificarTurno">Modificar</button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarTurno">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarTurno">Agregar un turno</button>
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
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnModalVerTurno">Turno para (ESPECIALIDAD)</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Paciente: </strong>(NOMBRE PACIENTE)</p>
                    <p><strong>Fecha: </strong>Martes 13 de Junio 2023</p>
                    <p><strong>Horario: </strong>10:00hs</p>
                    <p><strong>Médico asignado: </strong>(NOMBRE_MÉDICO) ((ESPECIALIDAD))</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <!-- Inicio Form Datos Turno -->
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
                        <label for="turno-especialidad" class="form-label">Especialidad:</label>
                        <select class="form-select" id="turno-especialidad" name="especialidad" required>
                            <option value="">Seleccionar...</option>
                            <option value="cardiología">Cardiología</option>
                            <option value="clínica">Clínica</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="turno-medico" class="form-label">Médico:</label>
                        <select class="form-select" id="turno-medico" name="medico" required>
                            <option value="">Seleccionar...</option>
                            <option value="Dr. Pérez">Dr. Pérez</option>
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
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
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
                        <label for="especialidad" class="form-label">Especialidad:</label>
                        <select class="form-select" id="especialidad" name="especialidad" required>
                            <option value="">Seleccionar...</option>
                            <option value="cardiología">Cardiología</option>
                            <option value="clínica">Clínica</option>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar el turno del (NOMBRE_PACIENTE)?</h4>
                    <h5>Fecha: dd/mm/aaaa a las HH:ss</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
