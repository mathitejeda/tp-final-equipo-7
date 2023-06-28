<%@ Page Title="Especialidades" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoEspecialidades.aspx.cs" Inherits="VistaWeb.ListadoEspecialidades" %>

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
                            <asp:Repeater runat="server" ID="rowRepeater">
                                <ItemTemplate>  
                                    <tr>
                                        <td><%#Eval("Id")%></td>
                                        <td><%#Eval("Nombre") %></td>
                                        <td>
                                            <asp:LinkButton runat="server" CommandName="modalVerMedicos" CommandArgument='<%#Eval("Id")%>' OnCommand="Modal_btn" type="button" class="btn btn-success" Text="Médicos">
                                                   <i class="bi bi-person-fill-add"></i> Médicos
                                            </asp:LinkButton>
                                            <asp:LinkButton runat="server" CommandName="modalModificarEspecialidad" CommandArgument='<%#Eval("Id")%>' OnCommand="Modal_btn" type="button" class="btn btn-warning">Modificar</asp:LinkButton>
                                            <asp:LinkButton runat="server" CommandName="modalEliminarEspecialidad" CommandArgument='<%#Eval("Id")%>' OnCommand="Modal_btn" type="button" class="btn btn-danger">Eliminar</asp:LinkButton>
                                            
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                                
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
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerMedicos">Médicos para <%:EspecialidadActiva.Nombre%></h3>
                    <button type="button"  class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">

                    <div class="card border-primary mb-3">
                      <asp:UpdatePanel runat="server">
                          <ContentTemplate>
                              <asp:Repeater runat="server" ID="medicRepeater">
                                  <ItemTemplate>

                                  <div class="card-header text-primary">
                                      <a href="./ListadoTurnos.aspx?id=<%#Eval("id") %>"> <%#Eval("Apellido")+", "+Eval("Nombre")%></a>
                                  </div>

                                  </ItemTemplate>
                              </asp:Repeater>
                          </ContentTemplate>
                      </asp:UpdatePanel>
                       

                        <!--
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
                        -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
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
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="especialidadNombreAdd" name="nombre">
                    </div>
                    <!--
                    <div class="mb-3">
                        <label for="especialidad-medicos" class="form-label">Médicos asignados a esta especialidad:</label>
                        <select id="especialidad-medicos" class="form-select" multiple aria-label="Medicos de la especialidad">
                          <option>Seleccione el/los médico/s...</option>
                            <option value="Dr. Pérez">Dr. Pérez</option>
                        </select>
                    </div>
                    -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <asp:button runat="server" type="button" class="btn btn-primary" Text="Agregar especialidad" OnClick="btn_Agregar"></asp:button>
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
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body w-100">

                    <div class="mb-3">
                        <label for="especialidad-nombre" class="form-label">Nombre de la especialidad:</label>
                        <asp:UpdatePanel ID="modValue" runat="server">
                            <ContentTemplate>
                                <input runat="server" type="text" style="background: #fff" class="form-control" id="especialidadNombreMdf" name="nombre">
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <!--
                    <div class="mb-3">
                        <label for="especialidad-medicos" class="form-label">Médicos asignados a esta especialidad:</label>
                        <select id="especialidad-medicos2" class="form-select" multiple aria-label="Medicos de la especialidad">
                          <option>Seleccione el/los médico/s...</option>
                            <option value="Dr. Pérez" selected>Dr. Pérez</option>
                        </select>
                    </div>
                    -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:button runat="server" type="button" class="btn btn-primary" OnClick="btn_Modificar" Text="Modificar especialidad"></asp:button>
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
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar la especialidad <%:EspecialidadActiva.Nombre%>?</h4>
                    <h5>Todos los médicos asociados perderán la especialidad</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:button runat="server" OnClick="btn_Eliminar" type="button" class="btn btn-primary" Text="Eliminar"></asp:button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
