<%@ Page Title="Mi Cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cuenta.aspx.cs" Inherits="VistaWeb.Cuenta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <div class="container my-5">
  <div class="p-5 bg-body-tertiary rounded-3">
    <h1 class="text-body-emphasis">Iniciar Sesión</h1>
    <p class="col-lg-8 fs-5">
      Accede al sistema de nuestra clínica para gestionar tus tareas.
    </p>

    <div class="form-inline">
      <div class="form-group mb-2">
        <label for="username" class="sr-only">Usuario:</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="Usuario" required>
      </div>
      <div class="form-group mx-sm-3 mb-2">
        <label for="password" class="sr-only">Contraseña:</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
      </div>
      <div class="form-group mb-2">
        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="remember" name="remember">
          <label class="form-check-label" for="remember">Recordar sesión</label>
        </div>
      </div>
    </div>
      <button type="submit" class="btn btn-primary mb-2">Iniciar Sesión</button>
      <div class="mt-3">
        <a href="#">¿Olvidaste tu contraseña?</a>
      </div>
  </div>
</div>
   <div class="container">
       <div class="row">

        <h1>Iniciar Sesión</h1>
           <div class="col-md-6">

              <div class="mb-3">
                <label for="usuario" class="form-label">Usuario:</label>
                <input type="text" style="background: #fff" class="form-control" id="usuario" name="nombre de usuario" required>
              </div>
              <div class="mb-3">
                <label for="pass" class="form-label">Contraseña:</label>
                <input type="password" style="background: #fff" class="form-control" id="pass" name="contraseña del usuario" required>
              </div>
              <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="recordar-sesion" name="mantener sesión">
                <label class="form-check-label" for="recordar-sesion">Recordar sesión</label>
              </div>
              <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
              <div class="mt-3">
                <a href="#">¿Olvidaste tu contraseña?</a>
              </div>
           </div>
       </div>

  </div>

    <br />
    <br />
    <div class="container">
        <h3 class="mb-3 text-center">¡Hola Pepín!</h3>
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
</asp:Content>
