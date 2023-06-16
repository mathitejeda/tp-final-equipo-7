<%@ Page Title="Pacientes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoPacientes.aspx.cs" Inherits="VistaWeb.ListadoPacientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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
                            <tr>
                                <td>1</td>
                                <td>Pedro El Escamoso</td>
                                <td>25/11/1997</td>
                                <td>40.545.555</td>
                                <td>
                                    <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modalVerDatos">
                                        <i class="bi bi-person-circle"></i>
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
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#modalModificarPaciente">Modificar</button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminarPaciente">Eliminar</button>
                                </td>
                            </tr>
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


    <!-- modal ver horarios x médico -->
    <div class="modal fade" id="modalVerDatos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerDatos" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerDatos">Datos de NOMBRE_PACIENTE</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
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
                                    NOMBRE Y APELLIDO PACIENTE
                                </div>
                                <div>
                                    <i class="bi bi-calendar-heart"></i>
                                    FECHA DE NACIMIENTO DD/MMM/AAAA
                                </div>
                                <div>
                                    <i class="bi bi-calendar-heart"></i>
                                    45.555.555
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
                                    La calle más larga que conocí alguna vez 2558, Los Polvorines
                                </div>
                                <div>
                                    <i class="bi bi-telephone-fill"></i>
                                    15-5555-6666
                                </div>
                                <div>
                                    <i class="bi bi-whatsapp"></i>
                                    +54 9 11-5555-6666
                                </div>
                                <div>
                                    <i class="bi bi-envelope-fill"></i>
                                    direccionemail@correoelectronico.com.ar
                                </div>
                            </div>
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

    <!-- modal ver turnos x paciente -->
    <div class="modal fade" id="modalVerTurnos" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerTurnos" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerTurnos">Ver turnos del paciente NOMBRE_PACIENTE</h3>
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
                                    <li><strong>Médico: </strong> NOMBRE Y APELLIDO DEL MÉDICO</li>
                                    <li><strong>Especialidad: </strong> NOMBRE DE LA ESPECIALIDAD</li>
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
                        <input type="text" style="background: #fff" class="form-control" id="paciente-nombre" name="nombre" placeholder="Ingresa el nombre..." required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-apellido" class="form-label">Apellido del paciente:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-apellido" name="apellido" placeholder="Ingresa el apellido" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-dni" class="form-label">DNI:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-dni" name="dni paciente" placeholder="Ingresa el DNI..." required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                        <input type="date" style="background: #fff" class="form-control" id="paciente-fechaNacimiento" name="fecha de nacimiento del paciente" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-direccion" class="form-label">Dirección completa:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-direccion" name="direccion del paciente" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-email" class="form-label">E-mail:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-email" name="telefono del paciente">
                    </div>
                    <div class="mb-3">
                        <label for="paciente-telefono" class="form-label">Telefono particular:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-telefono" name="telefono del paciente">
                    </div>
                    <div class="mb-3">
                        <label for="paciente-celular" class="form-label">Celular:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-celular" name="telefono del paciente">
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
    <div class="modal fade" id="modalModificarPaciente" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalModificarPaciente" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalModificarPaciente">Modificar paciente NOMBRE_PACIENTE</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="paciente-nombre" class="form-label">Nombre del paciente:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-nombre" name="nombre" placeholder="Ingresa el nombre..." value="NOMBRE_PACIENTE" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-apellido" class="form-label">Apellido del paciente:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-apellido" name="apellido" placeholder="Ingresa el apellido" value="APELLIDO_PACIENTE" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-dni" class="form-label">DNI:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-dni" name="dni paciente" placeholder="Ingresa el DNI..." value="DNI_PACIENTE" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                        <input type="date" style="background: #fff" class="form-control" id="paciente-fechaNacimiento" name="fecha de nacimiento del paciente" value="1997-11-25" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-direccion" class="form-label">Dirección completa:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-direccion" name="direccion del paciente" value="DIRECCION_PACIENTE" required>
                    </div>
                    <div class="mb-3">
                        <label for="paciente-email" class="form-label">E-mail:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-email" value="EMAIL_PACIENTE" name="telefono del paciente">
                    </div>
                    <div class="mb-3">
                        <label for="paciente-telefono" class="form-label">Telefono particular:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-telefono" value="TELEFONO_PACIENTE" name="telefono del paciente">
                    </div>
                    <div class="mb-3">
                        <label for="paciente-celular" class="form-label">Celular:</label>
                        <input type="text" style="background: #fff" class="form-control" id="paciente-celular" value="CELULAR_PACIENTE" name="telefono del paciente">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Modificar paciente</button>
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
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar al paciente (NOMBRE_PACIENTE)?</h4>
                    <h5>Todos los turnos pendientes serán dados de baja</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <button type="button" class="btn btn-primary">Eliminar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
