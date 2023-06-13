<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListadoTurnos.aspx.cs" Inherits="VistaWeb.ListadoTurnos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="container">
    <h1>Listado de Turnos</h1>
    
    <div class="table-responsive">
      <table class="table table-striped">
        <thead class="table-secondary">
          <tr>
            <th>Fecha</th>
            <th>Horario</th>
            <th>Especialidad</th>
            <th>Médico</th>
            <th>Paciente</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Martes 13 de Junio 2023</td>
            <td>10:00</td>
            <td>Dentista</td>
            <td>Dr. Pérez</td>
            <td>Juan González</td>
            <td>
              <button type="button" class="btn btn-warning">Modificar</button>
              <button type="button" class="btn btn-danger">Eliminar</button>
            </td>
          </tr>
          <tr>
            <td>Jueves 15 de Junio 2023</td>
            <td>11:30</td>
            <td>Cardiología</td>
            <td>Dr. Ramírez</td>
            <td>María López</td>
            <td>
              <button type="button" class="btn btn-warning">Modificar</button>
              <button type="button" class="btn btn-danger">Eliminar</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <nav aria-label="Menu de navegación del listado">
      <ul class="pagination justify-content-center">
        <li class="page-item"><a class="page-link" href="#">Anterior</a></li>
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item"><a class="page-link" href="#">Siguiente</a></li>
      </ul>
    </nav>

    <a class="btn btn-primary" href="#">Agregar Turno</a>

  </div>
</asp:Content>
