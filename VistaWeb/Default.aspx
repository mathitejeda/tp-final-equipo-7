<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VistaWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
       <% if (EstaLogueado())
          { %> 

    <div class="container my-5">
        <div class="row">
          <div class="p-5 bg-body-tertiary rounded-3">
            <h1 class="text-body-emphasis my-5">Bienvenido al sistema de gestión de clínica.</h1>

              <div class="d-flex flex-wrap ">
                <% if (EsTipoUsuario("admin"))
                    { %> 
                <div class="flex-fill"> 
                    <a href="ListadoUsuarios.aspx" type="button" class="btn btn-warning btn-lg fs-3 p-5 m-2 fw-bold">USUARIOS</a>
                </div>
                  <%} %>
                <% if (EsTipoUsuario("admin") || EsTipoUsuario("recepcionista"))
                    { %> 
               <div class="flex-fill">
                  <a href="ListadoTurnos.aspx" type="button" class="btn btn-primary btn-lg fs-3 p-5 m-2 fw-bold">TURNOS</a>
               </div>
               <div class="flex-fill">
                 <a href="ListadoMedicos.aspx" type="button" class="btn btn-secondary btn-lg fs-3 p-5 m-2 fw-bold">MÉDICOS</a>
               </div>
               <div class="flex-fill"> 
                   <a href="ListadoHorarios.aspx" type="button" class="btn btn-dark btn-lg fs-3 p-5 m-2 fw-bold">HORARIOS</a>
               </div>
                <div class="flex-grow-1">  
                   <a href="ListadoEspecialidades.aspx" type="button" class="btn btn-info btn-lg fs-3 p-5 m-2 fw-bold">ESPECIALIDADES</a>
                </div>
                  <%} %>
                  <% if (EsTipoUsuario("admin") || EsTipoUsuario("recepcionista") || EsTipoUsuario("medico") )
                    { %> 
               <div class="flex-grow-1"> 
                <a href="ListadoPacientes.aspx" type="button" class="btn btn-success btn-lg fs-3 p-5 m-2 fw-bold">PACIENTES</a>
               </div>

                   <%} %>

              </div>
          </div>
        </div>
    </div>
<% } else
        { 
        Response.Redirect("Cuenta.aspx", false);

    }%>

</asp:Content>
