<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pagamento.aspx.cs" Inherits="GEstaR.Pagamento" %>

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
    <form id="form1" runat="server" class="backgoundImage">
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
                                </asp:TableHeaderRow>
                            </asp:Table>
                        </div>

                        <div class="row">
                            <asp:Table CssClass="table table-bordered" runat="server" ID="tablePagamento">
                                <asp:TableHeaderRow>
                                    <asp:TableHeaderCell>Turno</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Bambini</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Settimane</asp:TableHeaderCell>
                                    <asp:TableHeaderCell>Totale</asp:TableHeaderCell>
                                </asp:TableHeaderRow>
                            </asp:Table>
                        </div>

                        <br />
                        <br />
                        <div class="row">
                            <div class="col-3"></div>
                            <asp:RadioButtonList runat="server" ID="tipoPagamento" CssClass="rounded col-6 text-center" Font-Size="Medium">
                                <asp:ListItem Value="satispay">&nbsp;&nbsp;Paga con Satispay<!--<img src="../img/satispay.jpeg" width="5%" height="5%" />--></asp:ListItem>
                                <asp:ListItem Value="cassa">&nbsp;&nbsp;Paga alla cassa</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="row d-flex flex-row align-items-center justify-content-center">
                            <asp:Button runat="server" OnClick="termineIscrizione_Click"  CssClass="btn btn-primary col-4" Text="Paga" />
                        </div>
                    </div>
                </div>
                <br />
            </div>
        </div>
    </form>
</body>
</html>
