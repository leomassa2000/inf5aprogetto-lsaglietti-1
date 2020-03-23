<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="GEstaR.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css" />
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../css/common.css" />

    <!-- icon -->
    <link rel="shortcut icon" type="image/x-icon" href="./css/images/ER_logo.jpg" />
</head>
<body style="background-color: #e9ffb0; background-image: url(./css/images/KidsPattern.jpg); background-repeat: repeat;"> 
    <form id="form1" runat="server" class="container" >
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
        <!-- Outer Row -->
        <div class="row justify-content-center" >

            <div class="col-xl-10 col-lg-12 col-md-11">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <asp:Panel runat="server" ID="divForg" class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Recupera la tua Password!</h1>
                                    </div>
                                    <div class="form-group">
                                        <asp:TextBox runat="server" TextMode="Email" CssClass="form-control" placeholder="Inserire l'email..." ID="txtEmailUser"></asp:TextBox>
                                    </div>
                                    <asp:Button runat="server" CssClass="btn btn-primary btn-user btn-block" Text="Recupera Password" ID="btnRecupera" OnClick="btnRecupera_Click" />
                                    <br />
                                    <br />
                                    <asp:Label ID="lblErrore" runat="server" ForeColor="Red"></asp:Label>
                                    <br />
                                    <hr>
                                    <div class="text-center">
                                        <asp:HyperLink runat="server" NavigateUrl="~/Login.aspx">Ti ricordi la Password?</asp:HyperLink>
                                    </div>
                                </asp:Panel>
                                <asp:Panel runat="server" ID="divSucc" Visible="false">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Recupera la tua Password!</h1>
                                        <br />
                                        <h3 class="h6 text-gray-900 mb-4">Controlla la tua casella di posta elettronica!</h3>
                                    </div>

                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </form>
</body>
</html>
