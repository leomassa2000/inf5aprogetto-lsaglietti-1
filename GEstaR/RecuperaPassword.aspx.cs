using adoNetWebSQlServer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GEstaR
{
    public partial class RecuperaPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string value = Request.QueryString["url"];
                if (value != null)
                {
                    adoNet ado = new adoNet();
                    string sql = "SELECT idPersonale FROM LinkPasswordPersonale WHERE url = '" + value + "' AND DATEDIFF(hour, dataRichiesta, GETDATE()) <= 24 AND modifica = 0";
                    string res = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                    if (res != "")
                    {
                        sql = "SELECT nome + ' ' + cognome AS NomeCognome FROM Personale WHERE id = " + res;
                        res = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                        NomeCognome.Text = res;
                    }
                    else
                    {
                        sql = "SELECT idGenitore FROM LinkPasswordGenitori WHERE url = '" + value + "' AND DATEDIFF(hour, dataRichiesta, GETDATE()) <= 24 AND modifica = 0";
                        res = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                        if (res != "")
                        {
                            sql = "SELECT nome + ' ' + cognome AS NomeCognome FROM Genitori WHERE id = " + res;
                            res = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                            NomeCognome.Text = res;
                        }
                        else
                        {
                            Response.Redirect("./Login.aspx");
                        }
                    }
                }
                else
                {
                    Response.Redirect("./Login.aspx");
                }
            }
        }

        protected void btnModifica_Click(object sender, EventArgs e)
        {
            if (txtPassword.Text == "" || txtPasswordR.Text == "")
                lblErrore.Text = "Password non valida";
            else if (txtPasswordR.Text != txtPassword.Text)
                lblErrore.Text = "Password non corrispondenti";
            else
            {
                // Controllo campi di Input
                if (txtPassword.Text.Contains("'") || txtPassword.Text.Contains("\"")
                || txtPasswordR.Text.Contains("'") || txtPasswordR.Text.Contains("\""))
                {
                    lblErrore.Text = "Caratteri non validi.";
                    return;
                }

                string value = Request.QueryString["url"];
                if (value != null)
                {
                    adoNet ado = new adoNet();
                    string sql = "SELECT idPersonale FROM LinkPasswordPersonale WHERE url = '" + value + "' AND DATEDIFF(hour, dataRichiesta, GETDATE()) <= 24";
                    string res = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                    if (res != "")
                    {
                        sql = "UPDATE Personale SET pwd = '" + SHA.GenerateSHA512String(txtPassword.Text) + "' WHERE id = " + res;
                        ado.eseguiNonQuery(sql, System.Data.CommandType.Text);
                        sql = "UPDATE LinkPasswordPersonale SET modifica = 1 WHERE idPersonale = " + res + " AND url = '" + value + "'";
                        ado.eseguiNonQuery(sql, System.Data.CommandType.Text);
                        Response.Redirect("./Login.aspx");
                    }
                    else
                    {
                        sql = "SELECT idGenitore FROM LinkPasswordGenitori WHERE url = '" + value + "' AND DATEDIFF(hour, dataRichiesta, GETDATE()) <= 24";
                        res = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                        if (res != "")
                        {
                            sql = "UPDATE Genitori SET pwd = '" + SHA.GenerateSHA512String(txtPassword.Text) + "' WHERE id = " + res;
                            ado.eseguiNonQuery(sql, System.Data.CommandType.Text);
                            sql = "UPDATE LinkPasswordGenitori SET modifica = 1 WHERE idGenitore = " + res + " AND url = '" + value + "'";
                            ado.eseguiNonQuery(sql, System.Data.CommandType.Text);
                            Response.Redirect("./Login.aspx");
                        }
                        else
                        {
                            Response.Redirect("./Login.aspx");
                        }
                    }
                }
                else
                {
                    Response.Redirect("./Login.aspx");
                }
            }
        }

        protected void txtPassword_TextChanged(object sender, EventArgs e)
        {
            lblErrore.Text = "";
        }
    }
}