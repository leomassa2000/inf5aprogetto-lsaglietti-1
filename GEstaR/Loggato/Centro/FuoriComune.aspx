<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FuoriComune.aspx.cs" Inherits="GEstaR.Loggato.Centro.FuoriComune" MasterPageFile="~/Loggato/Loggato.Master" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" ID="Panel1" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="Label1" CssClass="m-0 font-weight-bold text-primary">Fuori Comune</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="datiGenitore">
                <div class="row">
                    <h3>Città/Indirizzi comprese nelle quote pagate dal comune</h3>
                    <asp:Table runat="server" ID="datiFuoriComune">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell>Città</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Indirizzo</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Civico Iniziale</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Civico Finale</asp:TableHeaderCell>
                            <asp:TableHeaderCell><!--Azioni--></asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                    </asp:Table>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="Panel2" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="Label2" CssClass="m-0 font-weight-bold text-primary">Fuori Comune</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="datiGenitore">
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="provinciaBambino">Provincia:</label>
                        <asp:DropDownList Font-Size="Medium" ID="provinciaFuoriComune" CssClass="form-control" runat="server" OnSelectedIndexChanged="provinciaFuoriComune_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                    <div class="form-group col-6 col-lg-6">
                        <label for="cittaBambino">Città:</label>
                        <asp:DropDownList Font-Size="Medium" ID="cittaFuoriComune" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-12 col-lg-12">
                        <label for="cognomeAnimatore">Indirizzo:</label>
                        <asp:TextBox Font-Size="Medium" ID="indirizzoFuoriComune" MaxLength="150" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="cellulareAnimatore">Numero Civico Inziale:</label>
                        <asp:TextBox TextMode="Number" Font-Size="Medium" ID="numeroCivicoFuoriComuneI" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group col-6 col-lg-6">
                        <label for="cellulareAnimatore">Numero Civico Finale:</label>
                        <asp:TextBox TextMode="Number" Font-Size="Medium" ID="numeroCivicoFuoriComuneF" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
