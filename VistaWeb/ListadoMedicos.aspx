<%@ Page Title="Médicos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoMedicos.aspx.cs" Inherits="VistaWeb.ListadoMedicos" %>

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
            <h1 class="mb-4">Listado de Médicos</h1>


            <div class="col-md-12">

                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead class="table-primary">
                            <tr>
                                <th>ID</th>
                                <th>Nombre y Apellido</th>
                                <th>Especialidades</th>
                                <th>Horarios</th>
                                <th>Turnos</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                           <asp:Repeater runat="server" id="rowRepeater">
                               <ItemTemplate >
                                        
                                <tr>
                                    <td><%#Eval("Id")%> </td>
                                    <td><%#Eval("Nombre")+" "+Eval("Apellido")%></td>
                                    

                               
                                    <td>
                                    <asp:Repeater runat="server" id="especialidadesRepeater" DataSource='<%#Eval("Especialidades")%>'>
                                        <ItemTemplate>
                                                <span class="badge text-bg-info"><%#Eval("Nombre")%></span><br />
                                            </ItemTemplate>
                                    </asp:Repeater>
                                        
                                                                               
                                       
                                    </td>
                                    <td>
                                        <asp:LinkButton runat="server" type="button" class="btn btn-info" OnCommand="Modal_btn" CommandArgument='<%#Eval("Id")%>' CommandName="modalVerHorarios">
                                            <i class="bi bi-clock"></i>
                                            Ver
                                        </asp:LinkButton>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalVerTurnos">
                                            <i class="bi bi-calendar3"></i>
                                            Ver
                                        </button>
                                    </td>
                                    <td>
                                        <a href="DetalleMedico.aspx?id=<%#Eval("Id")%>" class="btn btn-success">Ver Detalle</a>
                                        <asp:LinkButton runat="server" OnCommand="Modal_btn" CommandArgument='<%#Eval("Id")%>' CommandName="modalModificarMedico" type="button" class="btn btn-warning" Text="Modificar"></asp:LinkButton>
                                        <asp:button runat="server" OnCommand="Modal_btn" CommandArgument='<%#Eval("Id")%>' CommandName="modalEliminarMedico" type="button" class="btn btn-danger" Text="Eliminar"></asp:button>
                                    </td>
                                </tr>
                            
                               </ItemTemplate>
                           </asp:Repeater>
                        </tbody>
                    </table>
                    <div class="d-flex justify-content-between">
                        <div>
                            <a href="AgregarMedico.aspx" class="btn btn-primary">Agregar nuevo médico</a>
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


    <!-- modal ver horarios x médico -->
    <div class="modal fade" id="modalVerHorarios" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalVerHorarios" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerHorarios">Ver horarios de <%:medicoActivo.Apellido+" "+medicoActivo.Nombre %></h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <asp:Repeater runat="server" ID="especialidadesRepeater" OnItemDataBound="especialidadesRepeater_ItemDataBound">
                        <ItemTemplate>
                            <div class="card border-primary mb-3">
                                <div class="card-header text-primary">
                                    <h5><%#Eval("Nombre") %></h5>
                                </div>
                                <div class="card-body text-primary">
                                    <h6 class="card-title">Horarios:</h6>
                                    <p class="card-text">
                                        <ul>
                                            <asp:Repeater runat="server" ID="horarios">
                                                <ItemTemplate>
                                                    <li><%# Eval("DiaSem")+": "+Eval("HsEntrada")+" - "+Eval("HsSalida")%></li>

                                                </ItemTemplate>
                                            </asp:Repeater>
                                    
                                        </ul>
                                    </p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
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
                    <h3 class="modal-title fs-5" id="labelBtnmodalVerTurnos">EN CONSTRUCCION</h3> <!--Ver turnos de NOMBRE_MÉDICO-->
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
    <!-- modal agregar medico 
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
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="medicoNombreAdd" name="nombre" >
                    </div>
                    <div class="mb-3">
                        <label for="medico-apellido" class="form-label">Apellido del médico:</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="medicoApellidoAdd" name="apellido" >
                    </div>
                    <div class="mb-3">
                        <label for="medico-matricula" class="form-label">Matrícula/s del médico:</label>
                        <input type="text" style="background: #fff" class="form-control" id="medicoMatricula" name="matricula" >
                    </div>
                    <div class="mb-3">
                        <label for="especialidades-medico" class="form-label">Especialidades que atiende el médico:</label>
                        <asp:CheckBoxList runat="server" DataTextField="Nombre" DataValueField="Id" id="especialidadesMedicoAdd" class="form-select" aria-label="Especialidades del médico:">
                        </asp:CheckBoxList>
                            
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Volver</button>
                    <asp:button runat="server" OnClick="btn_Agregar" type="button" class="btn btn-primary" Text="Agregar usuario"></asp:button>
                </div>
            </div>
        </div>
    </div>
        -->
    <!-- fin modal Agregar -->

    <!-- modal Modificar medico-->
    <div class="modal fade" id="modalModificarMedico" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="labelBtnmodalModificarMedico" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5" id="labelBtnmodalModificarMedico">Modificar médico</h3>
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body w-100">

                    <div class="mb-3">
                        <label for="medico-nombre" class="form-label">Nombre del médico:</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="medicoNombreMdf" name="nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="medico-apellido" class="form-label">Apellido del médico:</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="medicoApellidoMdf" name="apellido" required>
                    </div>
                    <div class="mb-3">
                        <label for="especialidades-medico" class="form-label">Especialidades que atiende el médico:</label>
                        <asp:CheckBoxList runat="server" DataTextField="Nombre" style="background-image:none" DataValueField="Id" id="especialidadesMedicoMdf" class="form-select" aria-label="Especialidades del médico:">
                        </asp:CheckBoxList>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <a href="ModificarMedico.aspx?id=<%:medicoActivo.Id%>" class="btn btn-primary">Más opciones</a>
                    <asp:button runat="server" OnClick="btn_Modificar" type="button" class="btn btn-primary" Text="Modificar médico"></asp:button>
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
                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <h4>¿Estás seguro de borrar al médico <%:medicoActivo.Apellido+", "+medicoActivo.Nombre%>?</h4>
                    <h5>Todos los turnos que debe atender serán cambiados a estado PENDIENTE</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Volver</button>
                    <asp:button runat="server" OnClick="btn_Eliminar" type="button" class="btn btn-primary" Text="Eliminar"></asp:button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
