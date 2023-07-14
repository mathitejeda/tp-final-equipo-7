<%@ Page Title="Mi Cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cuenta.aspx.cs" Inherits="VistaWeb.Cuenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <% if (!EstaLogueado())
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



 <% if (EstaLogueado())
    { %>
    <div id="loginExitoso" class="alert alert-primary alert-dismissible fade show" role="alert" style="display:none;">
        <strong>Login exitoso.</strong> Ingresaste correctamente a tu cuenta.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    
    <div id="modificarUser" class="alert alert-secondary alert-dismissible fade show" role="alert" style="display:none;">
        <strong>Modificación exitosa.</strong> Se ha modificado la contraseña.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <div class="container mt-3">

        <h3 class="mb-3 text-center">  <asp:Label ID="lbl_BienvenidaUser" runat="server">¡Hola <% imprimirDatos("user"); %>!</asp:Label> </h3>
       
        <div class="row">
            <h4 class="mb-3">Mi Cuenta</h4>
            <div class="col-4">
                <div class="list-group" id="list-tab-acciones-user" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-home-list" data-bs-toggle="list" href="#list-turnos" role="tab" aria-controls="list-turnos">Mis turnos</a>
                    <a class="list-group-item list-group-item-action" id="list-datos-list" data-bs-toggle="list" href="#list-datos" role="tab" aria-controls="list-datos">Datos Personales</a>
                    <a class="list-group-item list-group-item-action" id="list-contacto-list" data-bs-toggle="list" href="#list-contacto" role="tab" aria-controls="list-contacto">Datos de Contacto</a>
                    <a class="list-group-item list-group-item-action" id="list-cambiar-password-list" data-bs-toggle="list" href="#list-password" role="tab" aria-controls="list-password">Modificar contraseña</a>
                    <a class="list-group-item list-group-item-action" id="list-logout-list" data-bs-toggle="list" href="#list-logout" role="tab" aria-controls="list-logout">Cerrar sesión</a>
                </div>
            </div>
            <div class="col-8">
                <div class="tab-content" id="nav-list-tab-acciones-user">
                    <!-- acá hacer un if para mostrarlo solamente a pacientes. --> <!-- tambien hacer un else para dejar active el otro -->
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
                    <!-- /////////////////// -->
                    <div class="tab-pane fade" id="list-datos" role="tabpanel" aria-labelledby="list-datos-list">
                        <h5 class="fs-5">Datos personales</h5>
                            <p><strong>Nombre y apellido: </strong> <span><% imprimirDatos("nombre"); %></span> <span><% imprimirDatos("apellido"); %></span> </p>
                            <p><strong>DNI: </strong> <% imprimirDatos("dni"); %></p>
                            <p><strong>Fecha de nacimiento: </strong> <% imprimirDatos("fechaNac"); %> </p>
                    </div>
                    <div class="tab-pane fade" id="list-contacto" role="tabpanel" aria-labelledby="list-contacto-list">
                         <h5 class="fs-5">Datos de contacto</h5>
                            <p><strong>E-mail: </strong> <span><% imprimirDatos("email"); %></span> </p>
                            <p><strong>Celular: </strong> <% imprimirDatos("telefono"); %></p>
                            <p><strong>Celular: </strong> <% imprimirDatos("celular"); %></p>
                            <p><strong>Domicilio: </strong> <% imprimirDatos("direccion"); %> </p>
                    </div>
                    <div class="tab-pane fade" id="list-password" role="tabpanel" aria-labelledby="list-cambiar-password-list">
                        <h5 class="fs-5">Vas a modificar tu contraseña. Escribí la nueva a continuación: </h5>
                        <div class="mb-3">
                            <label for="MainContent_tbx_CambiarPass" class="form-label">Tu contraseña:</label>
                            <asp:TextBox runat="server" type="password" ID="tbx_CambiarPass" Style="background: #fff" class="form-control" name="contraseña"></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="tbx_CambiarPass" ID="RequiredFieldValidator1" runat="server" ErrorMessage="* contraseña requerida." ForeColor="red" ValidationGroup="input-cambiar-password" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:LinkButton runat="server" ID="btnCambiarPasswordSubmit" OnClick="btnCambiarPasswordSubmit_Click" type="button" class="btn btn-primary mt-3" Text="Cambiar password" ValidationGroup="input-cambiar-password"></asp:LinkButton>
                        </div>

                    </div>
                    <div class="tab-pane fade" id="list-logout" role="tabpanel" aria-labelledby="list-logout-list">
                        <h5 class="fs-5">¿Estás seguro de cerrar sesión?</h5>
                        <asp:Button ID="btnLogoutCuentaSubmit" OnClick="btnLogoutCuentaSubmit_Click" cssclass="btn btn-primary mt-3" runat="server" Text="Cerrar sesión" />
                    </div>
                </div>
            </div>
        </div>
    </div>
 <% } %>
</asp:Content>
