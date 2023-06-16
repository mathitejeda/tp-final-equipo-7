<%@ Page Title="Médicos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoMedicos.aspx.cs" Inherits="VistaWeb.ListadoMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <h1 class="mb-4">Listado de Médicos</h1>


            <div class="col-md-12">

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Nombre y Apellido</th>
                                <th>Matrícula</th>
                                <th>Especialidades</th>
                                <th>Horarios</th>
                                <th>Turnos</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Juan Ramirez</td>
                                <td>Matrícula Nacional 999578</td>
                                <td>
                                    <span class="badge text-bg-info">Cardiología</span><br />
                                    <span class="badge text-bg-info">Medicina Clínica</span><br />
                                    <span class="badge text-bg-info">Ecografía de Tejidos Blandos</span><br />
                                    <span class="badge text-bg-info">Otra especialidad</span><br />
                                </td>
                                <td>
                                    <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modalVerHorarios">
                                        <i class="bi bi-clock"></i>
                                        Ver
                                    </button>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalVerTurnos">
                                        <i class="bi bi-calendar3"></i>
                                        Ver
                                    </button>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modalModificarMedico">Modificar</button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarMedico">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarMedico">Agregar nuevo médico</button>
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


    <!-- modal ver horarios x médico -->
    <div class="modal fade" id="modalVerHorarios" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerHorarios" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerHorarios">Ver horarios de NOMBRE_MÉDICO</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="card border-primary mb-3">
                        <div class="card-header text-primary">
                            <h5>CARDIOLOGÍA</h5>
                        </div>
                        <div class="card-body text-primary">
                            <h6 class="card-title">Horarios:</h6>
                            <p class="card-text">
                                <ul>
                                    <li>HORARIO 1 - FIN HORARIO 1</li>
                                    <li>HORARIO 2 - FIN HORARIO 2</li>
                                    <li>HORARIO 3 - FIN HORARIO 3</li>
                                </ul>
                            </p>
                        </div>
                    </div>

                    <div class="card border-primary mb-3">
                        <div class="card-header text-primary">
                            <h5>MEDICINA CLÍNICA</h5>
                        </div>
                        <div class="card-body text-primary">
                            <h6 class="card-title">Horarios:</h6>
                            <p class="card-text">
                                <ul>
                                    <li>HORARIO 1 - FIN HORARIO 1</li>
                                    <li>HORARIO 2 - FIN HORARIO 2</li>
                                    <li>HORARIO 3 - FIN HORARIO 3</li>
                                </ul>
                            </p>
                        </div>
                    </div>
                    <div class="card border-primary mb-3">
                        <div class="card-header text-primary">
                            <h5>ECOGRAFÍA DE TEJIDOS BLANDOS</h5>
                        </div>
                        <div class="card-body text-primary">
                            <h6 class="card-title">Horarios:</h6>
                            <p class="card-text">
                                <ul>
                                    <li>HORARIO 1 - FIN HORARIO 1</li>
                                    <li>HORARIO 2 - FIN HORARIO 2</li>
                                    <li>HORARIO 3 - FIN HORARIO 3</li>
                                </ul>
                            </p>
                        </div>
                    </div>
                    <div class="card border-primary mb-3">
                        <div class="card-header text-primary">
                            <h5>OTRA ESPECIALIDAD</h5>
                        </div>
                        <div class="card-body text-primary">
                            <h6 class="card-title">Horarios:</h6>
                            <p class="card-text">
                                <ul>
                                    <li>HORARIO 1 - FIN HORARIO 1</li>
                                    <li>HORARIO 2 - FIN HORARIO 2</li>
                                    <li>HORARIO 3 - FIN HORARIO 3</li>
                                </ul>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal ver -->

    <!-- modal ver turnos x médico -->
    <div class="modal fade" id="modalVerTurnos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerTurnos" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerTurnos">Ver turnos de NOMBRE_MÉDICO</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="card border-dark mb-3">
                        <div class="card-header text-dark">
                            <h5>Viernes 16 de Junio 2023 - 10:30hs</h5>
                        </div>
                        <div class="card-body text-dark">
                            <h6 class="card-title">Datos del turno:</h6>
                            <p class="card-text">
                                <ul>
                                    <li><strong>Paciente: </strong> NOMBRE y APELLIDO PACIENTE</li>
                                    <li><strong>Especialidad: </strong> NOMBRE DE LA ESPECIALIDAD</li>
                                
                                </ul>
                            </p>
                            <button type="button" class="btn btn-dark">
                                <i class="bi bi-eye"></i>
                                Ver turno
                            </button>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal ver -->
    <!-- modal agregar medico -->
    <div class="modal fade" id="modalAgregarMedico" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalAgregarMedico" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalAgregarMedico">Agregar un nuevo médico</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="medico-nombre" class="form-label">Nombre del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medico-nombre" name="nombre" placeholder="NOMBRE_MEDICO" required>
                    </div>
                    <div class="mb-3">
                        <label for="medico-apellido" class="form-label">Apellido del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medico-apellido" name="apellido" placeholder="APELLIDO_MEDICO" required>
                    </div>
                    <div class="mb-3">
                        <label for="medico-matricula" class="form-label">Matrícula/s del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medico-matricula" name="matricula" placeholder="MATRICULAS_MEDICO" required>
                    </div>
                    <div class="mb-3">
                        <label for="especialidades-medico" class="form-label">Especialidades que atiende el médico:</label>
                        <select id="especialidades-medico" class="form-select" multiple aria-label="Medicos de la especialidad">
                            <option>Seleccione una o varias especialidades...</option>
                            <option value="Cardiología">Cardiología</option>
                            <option value="Medicina Clínica">Medicina Clínica</option>
                            <option value="Ecografía de Tejidos Blandos">Ecografía de Tejidos Blandos</option>
                            <option value="Otra especialidad">Otra especialidad</option>
                            <option value="">Más especialidades...</option>
                            <option value="">Más especialidades...</option>
                            <option value="">Más especialidades...</option>
                            <option value="">Más especialidades...</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Agregar médico</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

    <!-- modal Modificar medico-->
    <div class="modal fade" id="modalModificarMedico" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalModificarMedico" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalModificarMedico">Modificar médico</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body w-100">

                    <div class="mb-3">
                        <label for="medico-nombre" class="form-label">Nombre del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medico-nombre" name="nombre" placeholder="NOMBRE_MEDICO" required>
                    </div>
                    <div class="mb-3">
                        <label for="medico-apellido" class="form-label">Apellido del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medico-apellido" name="apellido" placeholder="APELLIDO_MEDICO" required>
                    </div>
                    <div class="mb-3">
                        <label for="medico-matricula" class="form-label">Matrícula/s del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medico-matricula" name="matricula" placeholder="MATRICULAS_MEDICO" required>
                    </div>
                    <div class="mb-3">
                        <label for="especialidades-medico" class="form-label">Especialidades que atiende el médico:</label>
                        <select id="especialidades-medico" class="form-select" multiple aria-label="Medicos de la especialidad">
                            <option>Seleccione una o varias especialidades...</option>
                            <option value="Cardiología" selected>Cardiología</option>
                            <option value="Medicina Clínica" selected>Medicina Clínica</option>
                            <option value="Ecografía de Tejidos Blandos" selected>Ecografía de Tejidos Blandos</option>
                            <option value="Otra especialidad" selected>Otra especialidad</option>
                            <option value="">Más especialidades...</option>
                            <option value="">Más especialidades...</option>
                            <option value="">Más especialidades...</option>
                            <option value="">Más especialidades...</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Modificar médico</button>
                </div>
            </div>
        </div>
    </div>

    <!-- modal eliminar -->
    <div class="modal fade" id="modalEliminarMedico" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalEliminarMedico" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalEliminarMedico">Eliminar médico</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar al médico (NOMBRE_MÉDICO)?</h4>
                    <h5>Todos los turnos que debe atender serán cambiados a estado PENDIENTE</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
