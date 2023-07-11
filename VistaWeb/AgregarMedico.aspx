<%@ Page Title="AddMedic" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgregarMedico.aspx.cs" Inherits="VistaWeb.AgregarMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<h2>Agregar Medico</h2>
    
        <div class="row align-text-center" style="margin-top:30px">
        <div class="col mb-3">
                        <label for="medico-nombre" class="form-label">Nombre</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="nombre" required>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-apellido" class="form-label">Apellido</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="apellido" required>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-matricula" class="form-label">Mail</label>
                        <input runat="server" type="email" style="background: #fff" class="form-control" id="mail">
                    </div>
            </div>
        <div class="row align-text-center" style="margin-top:20px">
            <div class="col mb-3">
                        <label for="medico-nombre" class="form-label">DNI (sin puntos)</label>
                        <input runat="server" type="number" style="background: #fff" class="form-control" id="dni" required>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-apellido" class="form-label">Teléfono</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="telefono" required>
                    </div>
                    <div class="col mb-3">
                        <label for="medico-matricula" class="form-label">Dirección</label>
                        <input runat="server" type="text" style="background: #fff" class="form-control" id="direccion" required>
                    </div>
            </div>
        <div class="row justify-content-center" style="margin-top:20px">
                <div class="col-4">
                            <label for="medico-nombre" class="form-label">Fecha Nacimiento</label>
                            <input runat="server" id="fechaNac" type="date" style="background: #fff" class="form-control" required>
                        </div>
                <div class="col-4">
                        <label for="especialidades-medico" class="form-label">Especialidades que atiende el médico:</label>
                        <asp:CheckBoxList runat="server" DataTextField="Nombre" DataValueField="Id" style="background-image:none; max-height:230px; min-height:230px; max-width:350px" id="especialidadesMedicoAdd" class="form-select" aria-label="Especialidades del médico:">
                        </asp:CheckBoxList>
                            
                            
                    </div>
                </div>
        <div class="row justify-content-end" style="margin-top:20px">
            <div class="col-4">
                <a href="ListadoMedicos.aspx" class="btn btn-outline-primary">Volver</a>
                <asp:button runat="server" type="button" class="btn btn-primary" Text="Agregar médico" OnClick="btn_agregar"></asp:button>
            </div>
         </div>
    
</asp:Content>
