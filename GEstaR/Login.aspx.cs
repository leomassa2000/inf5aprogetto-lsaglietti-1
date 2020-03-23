using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using adoNetWebSQlServer;

namespace GEstaR
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {   //adoNet.impostaConnessione("App_Data/estateragazziProvaDb.mdf");
                adoNet.impostaConnessione();
                Session.RemoveAll();
            }

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtEmailUser.Text == "")
                lblErrore.Text = "Utente non valido";
            else if (txtPasswordUser.Text == "")
                lblErrore.Text = "Password non valida";
            else
            {
                // Controllo campi di Input
                if (txtEmailUser.Text.Contains("'") || txtEmailUser.Text.Contains("\"")
                || txtPasswordUser.Text.Contains("'") || txtPasswordUser.Text.Contains("\""))
                {
                    lblErrore.Text = "Caratteri non validi.";
                    return;
                }

                // Crea stringa SQL per verificare validità Utente/password
                string sql = @"select ruolo, Personale.id, idCentro
                        from FreqPersonale
                        inner join Personale on idPersonale = Personale.id 
                        inner join Turni on idTurno = Turni.id
                        where email = '" + txtEmailUser.Text + "' " +
                            "and pwd = '" + txtPasswordUser.Text + "' " +
                            "and anno = " + DateTime.Now.Year;

                adoNet adoWeb = new adoNet();
                DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);

                if (codice.Rows.Count == 0)
                {
                    sql = @"select id
                        from Genitori
                        where email = '" + txtEmailUser.Text + "' " +
                            "and pwd = '" + SHA.GenerateSHA512String(txtPasswordUser.Text) + "' ";
                    string codiceG = adoWeb.eseguiScalar(sql, CommandType.Text);

                    if (codiceG != string.Empty)
                    {
                        Session["ruolo"] = "G";
                        Session["id"] = codiceG;
                        sql = @"select idCentro
                        from Turni
inner join FreqBambini on idTurno = Turni.id
inner join Parentele on FreqBambini.idBambino = Parentele.idBambino
inner join Genitori on Genitori.id = Parentele.idGen1 OR Genitori.id = Parentele.idGen2
                        where Genitori.id = " + codiceG + " AND Turni.anno = " + DateTime.Now.Year;
                        codiceG = adoWeb.eseguiScalar(sql, CommandType.Text);
                        Session["idCentro"] = codiceG;
                        Session.Timeout = 180;
                        Response.Redirect("./Loggato/Index.aspx");
                    }
                    else
                        lblErrore.Text = "ATTENZIONE!!! Utente e password non validi";
                }
                else
                {
                    // creazione session
                    Session["ruolo"] = codice.Rows[0]["ruolo"];
                    Session["id"] = codice.Rows[0]["Personale.id"];
                    Session["idCentro"] = codice.Rows[0]["idCentro"];
                    Session.Timeout = 180;
                    Response.Redirect("./Loggato/Index.aspx");
                }
            }
        }

    }
}