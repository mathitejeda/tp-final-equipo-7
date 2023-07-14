<%@ Page Title="Error" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="VistaWeb.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


<div class="container my-5">
   <div class="row">
      <div class="p-5 bg-body-tertiary rounded-3">
        <h1 class="text-body-emphasis">Ha ocurrido un error.</h1>
        <p class="fs-5">
         <asp:Label ID="lbl_ErrorMsj" runat="server" Text="Detalle error"></asp:Label>
        </p>

          <div class="mt-2 w-50">
        <% if(!EstaLogueado()) { %>
             <a class="nav-link btn btn-primary" href="Cuenta.aspx">Loguearse</a>
        <% } %>
          </div>
      </div>
    </div>
</div>

</asp:Content>
