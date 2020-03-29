<%@ Page Language="C#" AutoEventWireup="true" Title="Elenco Animatori" CodeBehind="Visualizzazione.aspx.cs" Inherits="GEstaR.Loggato.Animatori.Visualizzazione" MasterPageFile="~/Loggato/Loggato.Master" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" ID="azioni" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="typeNew" CssClass="m-0 font-weight-bold text-primary">Azioni</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="row">
                <div class="col-4">
                    <asp:LinkButton runat="server" CssClass="btn btn-primary" ID="btnAggiungi" OnClick="btnAggiungi_Click">
                        <i class="fa fa-plus"></i> Aggiungi
                    </asp:LinkButton>
                </div>
                <div class="col-4">
                    <!--Cerca-->
                    <asp:LinkButton runat="server" CssClass="btn btn-primary" ID="btnCerca" OnClick="btnCerca_Click">
                        <i class="fa fa-eye"></i> Cerca
                    </asp:LinkButton>
                </div>
                <div class="col-4">
                    <!--Assegna-->
                </div>
                <div class="col-4">
                    <!--?????-->
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel runat="server" Visible="false" ID="ricerca" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="Label1" CssClass="m-0 font-weight-bold text-primary">Cerca Animatore</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
        </div>
    </asp:Panel>
    <asp:Panel runat="server" ID="elencoAnimatori" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="Label2" CssClass="m-0 font-weight-bold text-primary">Cerca Animatore</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="table-responsive">
                <asp:Table runat="server" ID="tableAnimatori" CssClass="table table-hover table-bordered">
                    <asp:TableHeaderRow>
                        <asp:TableHeaderCell>Cognome</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Nome</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Data di Nascita</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Cellulare</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Email</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Ultimo Accesso</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Azioni</asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow>
                        <asp:TableCell>Saglietti</asp:TableCell>
                        <asp:TableCell>Luca</asp:TableCell>
                        <asp:TableCell>28/07/2001</asp:TableCell>
                        <asp:TableCell>3664314934</asp:TableCell>
                        <asp:TableCell>saglietti.luca@gmail.com</asp:TableCell>
                        <asp:TableCell>29/03/2020 15:43</asp:TableCell>
                        <asp:TableCell>
                            <asp:LinkButton runat="server" CssClass="btn btn-circle btn-primary"><i class="fa fa-eye"></i></asp:LinkButton>&nbsp;
                            <asp:LinkButton runat="server" CssClass="btn btn-circle btn-primary"><i class="fa fa-pencil-ruler"></i></asp:LinkButton>&nbsp;
                            <asp:LinkButton runat="server" CssClass="btn btn-circle btn-danger"><i class="fa fa-trash"></i></asp:LinkButton>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableFooterRow>
                        <asp:TableHeaderCell>Cognome</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Nome</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Data di Nascita</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Cellulare</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Email</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Ultimo Accesso</asp:TableHeaderCell>
                        <asp:TableHeaderCell>Azioni</asp:TableHeaderCell>
                    </asp:TableFooterRow>
                </asp:Table>
            </div>
        </div>
    </asp:Panel>
    
  
    <script>
        $(document).ready(function() {
  $('#MainContent_tableAnimatori').DataTable();
});
    </script>
</asp:Content>
