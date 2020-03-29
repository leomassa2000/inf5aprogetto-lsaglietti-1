<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dettagli.aspx.cs" Inherits="GEstaR.Loggato.Animatori.Dettagli" MasterPageFile="~/Loggato/Loggato.Master" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" ID="datiAnimatore" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="typeNew" CssClass="m-0 font-weight-bold text-primary">Dati Animatore</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="datiAnimatore">
                <div class="row">
                    <div class="form-group col-lg-6">
                        <label for="nomeAnimatore">Nome:</label>
                        <asp:TextBox Font-Size="Medium" ID="nomeAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="nomeAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-lg-6">
                        <label for="cognomeAnimatore">Cognome:</label>
                        <asp:TextBox Font-Size="Medium" ID="cognomeAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cognomeAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="sessoAnimatore">Sesso:</label>
                        <asp:DropDownList Font-Size="Medium" runat="server" ID="sessoAnimatore" CssClass="form-control">
                            <asp:ListItem Value="M">Maschio</asp:ListItem>
                            <asp:ListItem Value="F">Femmina</asp:ListItem>
                            <asp:ListItem Value="A">Altro</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="cittaNascitaAnimatore">Città di Nascita:</label>
                        <asp:DropDownList Font-Size="Medium" ID="cittaNascitaAnimatore" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                    <div class="form-group col-6 col-lg-6">
                        <label for="dataNascitaAnimatore">Data di Nascita:</label>
                        <asp:TextBox Font-Size="Medium" TextMode="Date" ID="dataNascitaAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="dataNascitaAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-12 col-lg-12">
                        <label for="sessoAnimatore">Nazionalità:</label>
                        <asp:DropDownList Font-Size="Medium" runat="server" ID="nazionalitaAnimatore" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-8 col-lg-8">
                        <label for="indirizzoAnimatore">Indirizzo di residenza:</label>
                        <asp:TextBox Font-Size="Medium" ID="indirizzoAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="indirizzoAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-4 col-lg-4">
                        <label for="numeroCivicoAnimatore">Numero Civico:</label>
                        <asp:TextBox Font-Size="Medium" ID="numeroCivicoAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="numeroCivicoAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="provinciaAnimatore">Provincia:</label>
                        <asp:DropDownList Font-Size="Medium" ID="provinciaAnimatore" CssClass="form-control" runat="server" OnSelectedIndexChanged="provinciaAnimatore_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                    <div class="form-group col-6 col-lg-6">
                        <label for="cittaAnimatore">Città:</label>
                        <asp:DropDownList Font-Size="Medium" ID="cittaAnimatore" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="cellulareAnimatore">Cellulare:</label>
                        <asp:TextBox Font-Size="Medium" ID="cellulareAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cellulareAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-6 col-lg-6">
                        <label for="emailAnimatore">Email:</label>
                        <asp:TextBox Font-Size="Medium" ID="emailAnimatore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Email già inserita" Font-Size="Small" ForeColor="Red" ControlToValidate="emailAnimatore" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="emailAnimatore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <h3>Iscrizione Turni</h3>
                <div class="row form-row">
                    <asp:Table runat="server" ID="tableTurni" CssClass="col-12 table table-bordered">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell></asp:TableHeaderCell>
                            <asp:TableHeaderCell>Data Inizio</asp:TableHeaderCell>
                            <asp:TableHeaderCell>Data Fine</asp:TableHeaderCell>
                        </asp:TableHeaderRow>
                    </asp:Table>
                </div>

            </div>
        </div>
    </asp:Panel>

    <asp:Panel runat="server" ID="Genitore" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="Label1" CssClass="m-0 font-weight-bold text-primary">Dati Genitore</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="datiGenitore">
                <div class="row">
                    <div class="form-group col-lg-6">
                        <label for="nomeAnimatore">Nome:</label>
                        <asp:TextBox Font-Size="Medium" ID="nomeGenitore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="nomeGenitore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-lg-6">
                        <label for="cognomeAnimatore">Cognome:</label>
                        <asp:TextBox Font-Size="Medium" ID="cognomeGenitore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cognomeGenitore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div><div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="cellulareAnimatore">Cellulare:</label>
                        <asp:TextBox Font-Size="Medium" ID="cellulareGenitore" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="cellulareGenitore" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
    <div class="row d-flex flex-row align-items-center justify-content-center">
        <asp:Button runat="server" OnClick="annullaAnimatore_Click" ID="annullaAnimatore" CssClass="btn btn-secondary col-4" Text="Annulla" />
        <asp:Button runat="server" OnClick="salvaAnimatore_Click" ID="salvaAnimatore" CssClass="btn btn-primary col-4" Text="Salva!" />
    </div>
</asp:Content>
