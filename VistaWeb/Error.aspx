<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="VistaWeb.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Ha ocurrido un error.</h1><br />
    <asp:Label ID="lbl_ErrorMsj" runat="server" Text="Detalle error"></asp:Label>
</asp:Content>
