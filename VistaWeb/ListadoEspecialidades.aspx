<%@ Page Title="Especialidades" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoEspecialidades.aspx.cs" Inherits="VistaWeb.ListadoEspecialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <h1 class="mb-4">Listado de Especialidades</h1>

            
            <div class="col-md-12">

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Descripción</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Odontología</td>
                                <td>
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalVerMedicos">
                                        <i class="bi bi-person-fill-add"></i>
                                        Médicos
                                    </button>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modalModificarEspecialidad">Modificar</button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarEspecialidad">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Cardiología</td>
                                <td>
                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalVerMedicos">
                                        <i class="bi bi-person-fill-add"></i>
                                        Médicos
                                    </button>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modalModificarEspecialidad">Modificar</button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarEspecialidad">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAgregarEspecialidad">Agregar nueva especialidad</button>
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


        <!-- modal ver medicos -->
    <div class="modal fade" id="modalVerMedicos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerMedicos" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerMedicos">Médicos para (ESPECIALIDAD)</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <div class="card border-primary mb-3">
                      <div class="card-header text-primary">
                          <h5>NOMBRE DEL MÉDICO</h5>
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
    <!-- modal agregar esp -->
    <div class="modal fade" id="modalAgregarEspecialidad" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalAgregarEspecialidad" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalAgregarEspecialidad">Agregar una nueva especialidad</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body w-100">

                    <div class="mb-3">
                        <label for="especialidad-nombre" class="form-label">Nombre de la especialidad:</label>
                        <input type="text" style="background: #fff" class="form-control" id="especialidad-nombre" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="especialidad-medicos" class="form-label">Médicos asignados a esta especialidad:</label>
                        <select id="especialidad-medicos" class="form-select" multiple aria-label="Medicos de la especialidad">
                          <option>Seleccione el/los médico/s...</option>
                            <option value="Dr. Pérez">Dr. Pérez</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Agregar especialidad</button>
                </div>
            </div>
        </div>
    </div>
    <!-- fin modal Agregar -->

    <!-- modal Modificar esp-->
    <div class="modal fade" id="modalModificarEspecialidad" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalModificarEspecialidad" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalModificarEspecialidad">Modificar especialidad</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body w-100">

                    <div class="mb-3">
                        <label for="especialidad-nombre" class="form-label">Nombre de la especialidad:</label>
                        <input type="text" style="background: #fff" class="form-control" id="especialidad-nombre" name="nombre" placeholder="NOMBRE_ESPECIALIDAD" required>
                    </div>
                    <div class="mb-3">
                        <label for="especialidad-medicos" class="form-label">Médicos asignados a esta especialidad:</label>
                        <select id="especialidad-medicos" class="form-select" multiple aria-label="Medicos de la especialidad">
                          <option>Seleccione el/los médico/s...</option>
                            <option value="Dr. Pérez" selected>Dr. Pérez</option>
                        </select>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Agregar especialidad</button>
                </div>
            </div>
        </div>
    </div>

    <!-- modal eliminar -->
    <div class="modal fade" id="modalEliminarEspecialidad" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalEliminarEspecialidad" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalEliminarEspecialidad">Eliminar especialidad</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar la especialidad (NOMBRE_ESPECIALIDAD)?</h4>
                    <h5>Todos los médicos asociados perderán la especialidad</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
