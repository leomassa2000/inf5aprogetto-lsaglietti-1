<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dettagli.aspx.cs" Inherits="GEstaR.Loggato.Centro.Dettagli" MasterPageFile="~/Loggato/Loggato.Master" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" ID="DettagliCentro" class="card shadow mb-4">
        <!-- Card Header - Dropdown -->
        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
            <asp:Label runat="server" ID="Label1" CssClass="m-0 font-weight-bold text-primary">Dati Centro</asp:Label>
        </div>
        <!-- Card Body -->
        <div class="card-body">
            <div class="datiGenitore">
                <div class="row">
                    <div class="form-group col-12 col-lg-12">
                        <label for="nomeAnimatore">Nome Centro:</label>
                        <asp:TextBox Font-Size="Medium" MaxLength="100" ID="nomeCentro" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="nomeCentro" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-8 col-lg-8">
                        <label for="cognomeAnimatore">Indirizzo:</label>
                        <asp:TextBox Font-Size="Medium" ID="indirizzoCentro" MaxLength="150" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="indirizzoCentro" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group col-4 col-lg-4">
                        <label for="cellulareAnimatore">Numero Civico:</label>
                        <asp:TextBox Font-Size="Medium" ID="numeroCivicoCentro" MaxLength="10" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="numeroCivicoCentro" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-6 col-lg-6">
                        <label for="provinciaBambino">Provincia:</label>
                        <asp:DropDownList Font-Size="Medium" ID="provinciaCentro" CssClass="form-control" runat="server" OnSelectedIndexChanged="provinciaCentro_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                    </div>
                    <div class="form-group col-6 col-lg-6">
                        <label for="cittaBambino">Città:</label>
                        <asp:DropDownList Font-Size="Medium" ID="cittaCentro" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-8 col-lg-8">
                        <label for="cognomeAnimatore">Numero di Telefono:</label>
                        <asp:TextBox Font-Size="Medium" ID="numeroCentro" MaxLength="15" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="numeroCentro" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group col-4 col-lg-4">
                        <label for="cellulareAnimatore">Email:</label>
                        <asp:TextBox Font-Size="Medium" TextMode="Email" ID="emailCentro" MaxLength="50" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="emailCentro" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="row">
                    <asp:CheckBoxList runat="server" ID="informazioniAggiuntive">
                        <asp:ListItem Value="circolo">Partecipazione a un Circolo</asp:ListItem>
                        <asp:ListItem Value="fuoriComune">Quote differenziate da residenza (fuori comune)</asp:ListItem>
                    </asp:CheckBoxList>
                </div>
            </div>
        </div>
        <div class="row d-flex flex-row align-items-center justify-content-center">
            <asp:Button runat="server" OnClick="inserisciCentro_Click" ID="inserisciCentro" CssClass="btn btn-primary" Text="Inserisci Centro" />
        </div>
    </asp:Panel>
</asp:Content>
