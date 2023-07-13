<%@ Page Title="Mi Cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cuenta.aspx.cs" Inherits="VistaWeb.Cuenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <% if (((Modelo.Usuario)Session["UsuarioLogueado"]) == null)
        { %>

<div class="container my-5">
  <div class="p-5 bg-body-tertiary rounded-3">
    <h1 class="text-body-emphasis">Iniciar Sesión</h1>
    <p class="fs-5">
      Accede al sistema de nuestra clínica para gestionar tus tareas.
    </p>

    <div class="d-flex flex-row">
      <div class="form-group mb-2">
        <label for="MainContent_tbxUsernameLogin" class="sr-only">Usuario:</label>
        <asp:TextBox runat="server" type="text" ID="tbxUsernameLogin" class="form-control" name="login-usuario" placeholder="Ingresa tu usuario..."></asp:TextBox>
        <asp:RequiredFieldValidator ControlToValidate="tbxUsernameLogin" ID="RequiredUser" runat="server" ErrorMessage="* usuario requerido." ForeColor="red" ValidationGroup="input-login" Display="Dynamic"></asp:RequiredFieldValidator>
    </div>
      <div class="form-group mx-sm-3 mb-2">
        <label for="MainContent_tbxPasswordLogin" class="sr-only">Contraseña:</label>
        <asp:TextBox runat="server" type="password" ID="tbxPasswordLogin" class="form-control" name="login-password" placeholder="Ingresa tu contraseña..."></asp:TextBox>
        <asp:RequiredFieldValidator ControlToValidate="tbxPasswordLogin" ID="RequiredPassword" runat="server" ErrorMessage="* contraseña requerida." ForeColor="red" ValidationGroup="input-login" Display="Dynamic"></asp:RequiredFieldValidator>
   
      </div>
    </div>
      <div class="form-group mb-2">
        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="remember" name="remember">
          <label class="form-check-label" for="remember">Recordar sesión</label>
        </div>
      </div>
      <div class="mt-3">
        <asp:Button Text="Iniciar sesión" class="btn btn-primary" ID="btnIniciarSesionSubmit" runat="server" ValidationGroup="input-login" OnClick="btnIniciarSesionSubmit_Click"/>
        <a href="#" class="ml-3">¿Olvidaste tu contraseña?</a>
      </div>
  </div>
</div>
        <% } %>



 <% if (((Modelo.Usuario)Session["UsuarioLogueado"]) != null)
    { %>

    <div class="container mt-3">

        <h3 class="mb-3 text-center">  <asp:Label ID="lbl_BienvenidaUser" runat="server">¡Hola <% Response.Write(((Modelo.Usuario)Session["UsuarioLogueado"]).User); %> !</asp:Label> </h3>
       
        <div class="row">
            <h4 class="mb-3">Mi Cuenta</h4>
            <div class="col-4">
                <div class="list-group" id="list-tab-acciones-user" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-home-list" data-bs-toggle="list" href="#list-turnos" role="tab" aria-controls="list-turnos">Mis turnos</a>
                    <a class="list-group-item list-group-item-action" id="list-profile-list" data-bs-toggle="list" href="#list-profile" role="tab" aria-controls="list-profile">Historia Clínica</a>
                    <a class="list-group-item list-group-item-action" id="list-messages-list" data-bs-toggle="list" href="#list-messages" role="tab" aria-controls="list-messages">Datos Personales</a>
                    <a class="list-group-item list-group-item-action" id="list-settings-list" data-bs-toggle="list" href="#list-settings" role="tab" aria-controls="list-settings">Datos de Contacto</a>
                    <a class="list-group-item list-group-item-action" id="list-settings-list" data-bs-toggle="list" href="#list-settings" role="tab" aria-controls="list-settings">Modificar contraseña</a>
                    <a class="list-group-item list-group-item-action" id="list-settings-list" data-bs-toggle="list" href="#list-settings" role="tab" aria-controls="list-settings">Cerrar sesión</a>
                </div>
            </div>
            <div class="col-8">
                <div class="tab-content" id="nav-list-tab-acciones-user">
                    <div class="tab-pane fade show active" id="list-turnos" role="tabpanel" aria-labelledby="list-turnos">
                        <div class="card border-primary mb-3">
                      <div class="card-header text-primary d-flex justify-content-md-between">
                          <h5>Turno # - (NOMBRE_ESPECIALIDAD)</h5>
                          <span class="badge text-bg-primary my-auto">13/06/2023</span>
                      </div>
                      <div class="card-body text-primary">
                          <div class="card-text">
                            <p><strong>Paciente: </strong>(NOMBRE PACIENTE)</p>
                            <p><strong>Fecha: </strong>Martes 13 de Junio 2023</p>
                            <p><strong>Horario: </strong>10:00hs</p>
                            <p><strong>Médico asignado: </strong>(NOMBRE_MÉDICO) ((ESPECIALIDAD))</p>
                            <p><strong>Observaciones: </strong>(OBSERVACIONES_DEL_TURNO)</p>
                          </div>
                      </div>
                    </div>
                    </div>
                    <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">...</div>
                    <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">...</div>
                    <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">...</div>
                </div>
            </div>
        </div>
    </div>
 <% } %>
</asp:Content>
