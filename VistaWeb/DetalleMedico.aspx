<%@ Page Title="MedicDetail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalleMedico.aspx.cs" Inherits="VistaWeb.DetalleMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Modificar Medico</h2>
    
        <div class="row align-text-center" style="margin-top:30px">
        <div class="col mb-3">
                        <label for="medico-nombre" class="form-label">Nombre</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="nombre" readonly>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-apellido" class="form-label">Apellido</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="apellido" readonly>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-matricula" class="form-label">Mail</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="mail" readonly>
                    </div>
            </div>
        <div class="row align-text-center" style="margin-top:20px">
            <div class="col mb-3">
                        <label for="medico-nombre" class="form-label">DNI</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="dni" readonly>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-apellido" class="form-label">Teléfono</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="telefono" readonly>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-matricula" class="form-label">Dirección</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="direccion" readonly>
                    </div>
            </div>
        <div class="row justify-content-center" style="margin-top:20px">
                <div class="col-4">
                            <label for="medico-nombre" class="form-label">Fecha Nacimiento</label>
                            <input runat="server" type="text" style="background: #fff" class="form-control" id="fechaNac" name="apellido" readonly>
                            
                        </div>
                <div class="col-4">
                        <label for="especialidades-medico" class="form-label">Especialidades que atiende el médico:</label>
                        <asp:ListBox runat="server" style="background-image:none; max-height:230px; min-height:230px; max-width:350px" id="especialidadesMedicoLista" class="form-select" aria-label="Especialidades del médico:">
                        </asp:ListBox>
                    </div>
                </div>
        <div class="row justify-content-end" style="margin-top:20px">
            <div class="col-4">
                <a href="ListadoMedicos.aspx" class="btn btn-outline-primary">Volver</a>
            </div>
         </div>
    
</asp:Content>
