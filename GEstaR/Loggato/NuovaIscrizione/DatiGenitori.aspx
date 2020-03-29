<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatiGenitori.aspx.cs" Inherits="GEstaR.DatiGenitori" %>

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
    <form id="form1" runat="server" class="backgoundImage" style="font-size: medium">
        <script type="text/javascript" src="../js/jquery.js"></script>
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
            <div class="col-xl-10 col-lg-10">
                <!-- Dati Genitore 1 -->
                <div class="card shadow mb-4">
                    <!-- Card Header - Dropdown -->
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Genitore 1</h6>
                    </div>
                    <!-- Card Body -->
                    <div class="card-body">
                        <div class="datiGenitore1">
                            <div class="row">
                                <div class="form-group col-lg-6">
                                    <label for="nomeGenitore1">Nome:</label>
                                    <asp:TextBox ID="nomeGenitore1" CssClass="form-control" Font-Size="Medium" runat="server" ValidateRequestMode="Enabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="nomeGenitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="nomeGenitore1"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="cognomeGenitore1">Cognome:</label>
                                    <asp:TextBox Font-Size="Medium" ID="cognomeGenitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="cognomeGenitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="cognomeGenitore1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="sessoGenitore1">Sesso:</label>
                                    <asp:DropDownList Font-Size="Medium" runat="server" ID="sessoGenitore1" CssClass="form-control">
                                        <asp:ListItem Value="M">Maschio</asp:ListItem>
                                        <asp:ListItem Value="F">Femmina</asp:ListItem>
                                        <asp:ListItem Value="A">Altro</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="form-group col-8 col-lg-8">
                                    <label for="indirizzoGenitore1">Indirizzo di residenza:</label>
                                    <asp:TextBox Font-Size="Medium" ID="indirizzoGenitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="indirizzoGenitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="indirizzoGenitore1"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-4 col-lg-4">
                                    <label for="numeroCivicoGenitore1">Numero Civico:</label>
                                    <asp:TextBox Font-Size="Medium" ID="numeroCivicoGenitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="numeroCivicoGenitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="numeroCivicoGenitore1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="provinciaGenitore1">Provincia:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="provinciaGenitore1" CssClass="form-control" runat="server" OnSelectedIndexChanged="provinciaGenitore1_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="provinciaGenitore1E" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="provinciaGenitore1"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cittaGenitore1">Città:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="cittaGenitore1" CssClass="form-control" runat="server"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="cittaGenitore1E" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="cittaGenitore1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cellulare1Genitore1">Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="cellulare1Genitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="cellulare1Genitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="cellulare1Genitore1"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="DescrCellulare1Genitore1">Descrizione Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="DescrCellulare1Genitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="DescrCellulare1Genitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="DescrCellulare1Genitore1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cellulare2Genitore1">Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="cellulare2Genitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="DescrCellulare2Genitore1">Descrizione Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="DescrCellulare2Genitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cellulare3Genitore1">Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="cellulare3Genitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="DescrCellulare3Genitore1">Descrizione Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="DescrCellulare3Genitore1" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-12 col-lg-12">
                                    <label for="emailGenitore1">Email:</label>
                                    <asp:TextBox Font-Size="Medium" TextMode="Email" ID="emailGenitore1" CssClass="form-control" runat="server" AutoPostBack="true"></asp:TextBox>
                                    <asp:CustomValidator ForeColor="Red" ControlToValidate="emailGenitore1" ID="emailGenitore1C" OnServerValidate="emailGenitoreC_ServerValidate" runat="server" ErrorMessage="Email già inserita"></asp:CustomValidator>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="emailGenitore1R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="emailGenitore1"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Dati Genitore 2 -->
                <div class="card shadow mb-4">
                    <!-- Card Header - Dropdown -->
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <asp:CheckBox ID="datiGenitore2" Checked="false" runat="server" AutoPostBack="true" OnCheckedChanged="datiGenitore2_CheckedChanged" />

                        <h6 class="m-0 font-weight-bold text-primary">Genitore 2</h6>
                    </div>
                    <!-- Card Body -->
                    <asp:Panel runat="server" ID="datiGenitore2div" Enabled="false" CssClass="card-body">
                        <div class="datiGenitore2">
                            <div class="row">
                                <div class="form-group col-lg-6">
                                    <label for="nomeGenitore2">Nome:</label>
                                    <asp:TextBox ID="nomeGenitore2" CssClass="form-control" Font-Size="Medium" runat="server" ValidateRequestMode="Enabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="nomeGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="nomeGenitore2"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="cognomeGenitore2">Cognome:</label>
                                    <asp:TextBox Font-Size="Medium" ID="cognomeGenitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="cognomeGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="cognomeGenitore2"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="sessoGenitore2">Sesso:</label>
                                    <asp:DropDownList Font-Size="Medium" runat="server" ID="sessoGenitore2" CssClass="form-control">
                                        <asp:ListItem Value="M">Maschio</asp:ListItem>
                                        <asp:ListItem Value="F">Femmina</asp:ListItem>
                                        <asp:ListItem Value="A">Altro</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row form-group form-check-inline">
                                <asp:CheckBox runat="server" ID="sameIndirizzoGenitori" CssClass="form-check-input" AutoPostBack="true" OnCheckedChanged="sameIndirizzoGenitori_CheckedChanged" />
                                <label class="form-check-input" for="sameIndirizzoGenitori">Stesso indirizzo di residenza dell'altro genitore</label>
                            </div>
                            <div class="row">
                                <div class="form-group col-8 col-lg-8">
                                    <label for="indirizzoGenitore2">Indirizzo di residenza:</label>
                                    <asp:TextBox Font-Size="Medium" ID="indirizzoGenitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="indirizzoGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="indirizzoGenitore2"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-4 col-lg-4">
                                    <label for="numeroCivicoGenitore2">Numero Civico:</label>
                                    <asp:TextBox Font-Size="Medium" ID="numeroCivicoGenitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="numeroCivicoGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="numeroCivicoGenitore2"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="provinciaGenitore2">Provincia:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="provinciaGenitore2" CssClass="form-control" runat="server" OnSelectedIndexChanged="provinciaGenitore2_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="provinciaGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="provinciaGenitore2"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cittaGenitore2">Città:</label>
                                    <asp:DropDownList Font-Size="Medium" ID="cittaGenitore2" CssClass="form-control" runat="server"></asp:DropDownList>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="cittaGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="cittaGenitore2"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cellulare1Genitore2">Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" OnTextChanged="cellulare1Genitore2_TextChanged" AutoPostBack="true" ID="cellulare1Genitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="cellulare1Genitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="cellulare1Genitore2"></asp:RequiredFieldValidator>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="DescrCellulare1Genitore2">Descrizione Cellulare:</label>
                                    <asp:TextBox Font-Size="Medium" ID="DescrCellulare1Genitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="DescrCellulare1Genitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="DescrCellulare1Genitore2"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cellulare2Genitore2">Cellulare:</label>
                                    <asp:TextBox Enabled="false" Font-Size="Medium" OnTextChanged="cellulare2Genitore2_TextChanged" AutoPostBack="true" ID="cellulare2Genitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="DescrCellulare2Genitore2">Descrizione Cellulare:</label>
                                    <asp:TextBox Enabled="false" Font-Size="Medium" ID="DescrCellulare2Genitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-6 col-lg-6">
                                    <label for="cellulare3Genitore2">Cellulare:</label>
                                    <asp:TextBox Enabled="false" Font-Size="Medium" ID="cellulare3Genitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group col-6 col-lg-6">
                                    <label for="DescrCellulare3Genitore2">Descrizione Cellulare:</label>
                                    <asp:TextBox Enabled="false" Font-Size="Medium" ID="DescrCellulare3Genitore2" CssClass="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-12 col-lg-12">
                                    <label for="emailGenitore2">Email:</label>
                                    <asp:TextBox Font-Size="Medium" TextMode="Email" ID="emailGenitore2" CssClass="form-control" runat="server" AutoPostBack="true"></asp:TextBox>
                                    <asp:CustomValidator ForeColor="Red" ControlToValidate="emailGenitore2" ID="emailGenitore2E" OnServerValidate="emailGenitoreC_ServerValidate" runat="server" ErrorMessage="Email già inserita"></asp:CustomValidator>
                                    <asp:RequiredFieldValidator ForeColor="Red" ID="emailGenitore2R" runat="server" ErrorMessage="Campo Obbligatorio" ControlToValidate="emailGenitore2"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="row d-flex flex-row align-items-center justify-content-center">
                    <asp:Button runat="server" ID="salvaDatiGenitore" Font-Size="Medium" OnClick="salvaDatiGenitore_Click" CssClass="btn btn-primary" Text="Salva Dati" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>
