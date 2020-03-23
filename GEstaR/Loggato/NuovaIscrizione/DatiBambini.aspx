<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatiBambini.aspx.cs" Inherits="GEstaR.DatiBambini" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Nuova Iscrizione - GEstaR</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script type="text/javascript" src="../../js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="~/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="~/css/sb-admin-2.min.css" />
    <script type="text/javascript" src="../../js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="~/css/common.css" />

    <!-- icon -->
    <link rel="shortcut icon" type="image/x-icon" href="~/css/images/ER_logo.jpg" />

</head>
<body>
    <form id="form1" runat="server" class="backgoundImage" style="font-size:medium; height:100vh">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see https://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Name="bootstrap" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>
        <h1 class="text-center">Estate Ragazzi - <% adoNetWebSQlServer.adoNet.impostaConnessione();
                                                     adoNetWebSQlServer.adoNet ado = new adoNetWebSQlServer.adoNet();
                                                     string nomeCentro = ado.eseguiScalar("SELECT nome FROM Centri WHERE id = " + Session["idCentro"], System.Data.CommandType.Text);
                                                     Response.Write(nomeCentro + " - " + DateTime.Now.Year); %></h1>
        <h3 class="text-center">Nuova Iscrizione</h3>
        <div class="row">
            <div class="col-1"></div>
            <div class="col-10 col-lg-10">
                <!-- Dati Bambini -->
                <div class="card shadow mb-4">
                    <!-- Card Header - Dropdown -->
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Bambini</h6>
                    </div>
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="row">
                            <asp:Table CssClass="table table-bordered" runat="server" ID="tableDettagli">
                                <asp:TableHeaderRow>
                                    <asp:TableHeaderCell>Nome</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Cognome</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Data di Nascita</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Turni</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Elimina<br />Iscrizione</asp:TableHeaderCell>
                                </asp:TableHeaderRow>
                            </asp:Table>
                        </div>
                        <div class="row d-flex flex-row align-items-center justify-content-center">
                            <asp:Button runat="server" OnClick="Unnamed_Click" CssClass="btn btn-primary col-4" Text="Aggiungi Bambino" />
                        </div>
                    </div>
                </div>
                <asp:Panel runat="server" Visible="false" ID="datiBambino" class="card shadow mb-4">
                    <!-- Card Header - Dropdown -->
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Bambino</h6>
                    </div>
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="datiBambino">
                            <div class="row">
                                <div class="form-group col-lg-6">
                                    <label for="nomeBambino">Nome:</label>
                                    <asp:TextBox Font-Size="Medium"  ID="nomeBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="nomeBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="cognomeBambino">Cognome:</label>
                                    <asp:TextBox Font-Size="Medium"  ID="cognomeBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="cognomeBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="sessoBambino">Sesso:</label>
                                    <asp:DropDownList Font-Size="Medium" runat="server" ID="sessoBambino" CssClass="form-control">
                                        <asp:ListItem Value="M">Maschio</asp:ListItem>
                                        <asp:ListItem Value="F">Femmina</asp:ListItem>
                                        <asp:ListItem Value="A">Altro</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="nazionalitaBambino">Nazionalità:</label>
                                    <asp:DropDownList Font-Size="Medium" runat="server" ID="nazionalitaBambino" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="dataNascitaBambino">Data di Nascita:</label>
                                    <asp:TextBox Font-Size="Medium"  TextMode="Date" ID="dataNascitaBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="dataNascitaBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cittaNascitaBambino">Città di Nascita:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="cittaNascitaBambino" CssClass="form-control" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-lg-12">
                                    <label for="codiceFiscaleBambino">Codice Fiscale:</label>
                                    <asp:TextBox Font-Size="Medium"  ID="codiceFiscaleBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="codiceFiscaleBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <asp:Panel runat="server" class="row form-group form-check-inline hide" ID="indirizzoUguale">
                                <asp:CheckBox runat="server" ID="sameIndirizzoGenitori" CssClass="form-check-input" OnCheckedChanged="sameIndirizzoGenitori_CheckedChanged" />
                                <label class="form-check-input" for="sameIndirizzoGenitori">Stesso indirizzo di residenza dei genitori</label>
                            </asp:Panel>
                            <div class="row">
                                <div class="form-group col-8 col-lg-8">
                                    <label for="indirizzoBambino">Indirizzo di residenza:</label>
                                    <asp:TextBox Font-Size="Medium"  ID="indirizzoBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="indirizzoBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-4 col-lg-4">
                                    <label for="numeroCivicoBambino">Numero Civico:</label>
                                    <asp:TextBox Font-Size="Medium"  ID="numeroCivicoBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="numeroCivicoBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="provinciaBambino">Provincia:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="provinciaBambino" CssClass="form-control" runat="server" OnSelectedIndexChanged="provinciaBambino_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cittaBambino">Città:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="cittaBambino" CssClass="form-control" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="provinciaBambino">Scuola:</label>
                                    <asp:TextBox Font-Size="Medium"  ID="scuolaBambino" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="scuolaBambino" ForeColor="Red" Font-Size="Small">Campo obbligatorio</asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cittaBambino">Classe:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="classeBambino" CssClass="form-control" runat="server"></asp:DropDownList>
                                </div>
                            </div>
                            <h3>Iscrizione Turni</h3>
                            <div class="row form-row">
                                <asp:Table runat="server" ID="tableTurni" CssClass="col-12 table table-bordered">
                                    <asp:TableHeaderRow>
                                        <asp:TableHeaderCell></asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Data Inizio</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Data Fine</asp:TableHeaderCell>
                                        <asp:TableHeaderCell>Servizio Mensa</asp:TableHeaderCell>
                                    </asp:TableHeaderRow>
                                </asp:Table>
                            </div>
                            <div class="row d-flex flex-row align-items-center justify-content-center">
                                <asp:Button runat="server" OnClick="salvaBambino_Click" ID="salvaBambino" CssClass="btn btn-primary col-4" Text="Salva!" />
                                <asp:Button runat="server" OnClick="annullaBambino_Click" ID="annullaBambino" CssClass="btn btn-secondary col-4" Text="Annulla" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <br />
                <div class="row d-flex flex-row align-items-center justify-content-center">
                    <asp:Button runat="server" OnClick="termineIscrizione_Click" ID="termineIscrizione" CssClass="btn btn-primary" Text="Iscrizione Terminata" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
