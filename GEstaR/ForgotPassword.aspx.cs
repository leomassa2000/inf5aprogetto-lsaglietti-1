using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using adoNetWebSQlServer;

namespace GEstaR
{
    public partial class ForgotPassword : System.Web.UI.Page
    {

        private static Random random = new Random();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRecupera_Click(object sender, EventArgs e)
        {
            adoNet.impostaConnessione();
            adoNet ado = new adoNet();
            string sql = "SELECT id FROM Personale WHERE email = '" + txtEmailUser.Text + "'";
            string codice = ado.eseguiScalar(sql, System.Data.CommandType.Text);
            if (codice != "")
            {
                string rand = "";
                bool newURL = false;
                do
                {
                    rand = RandomString(49);
                    sql = "SELECT COUNT(*) FROM LinkPasswordPersonale WHERE url = '" + rand + "'";
                    if (Convert.ToInt32(ado.eseguiScalar(sql, System.Data.CommandType.Text)) == 0)
                        newURL = true;
                } while (!newURL);
                sql = "INSERT INTO LinkPasswordPersonale (idPersonale, url) VALUES(" + codice + ", '" + rand + "')";
                ado.eseguiNonQuery(sql, System.Data.CommandType.Text);
                inviaEmail(txtEmailUser.Text, rand);
                divSucc.Visible = true;
                divForg.Visible = false;
            }
            else
            {
                sql = "SELECT id FROM Genitori WHERE email = '" + txtEmailUser.Text + "'";
                codice = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                if (codice != "")
                {
                    string rand = "";
                    bool newURL = false;
                    do
                    {
                        rand = RandomString(49);
                        sql = "SELECT COUNT(*) FROM LinkPasswordGenitori WHERE url = '" + rand + "'";
                        if (Convert.ToInt32(ado.eseguiScalar(sql, System.Data.CommandType.Text)) == 0)
                            newURL = true;
                    } while (!newURL);
                    sql = "INSERT INTO LinkPasswordGenitori (idGenitore, url) VALUES(" + codice + ", '" + rand + "')";
                    ado.eseguiNonQuery(sql, System.Data.CommandType.Text);
                    inviaEmail(txtEmailUser.Text, rand);
                    divSucc.Visible = true;
                    divForg.Visible = false;
                }
                else
                {
                    lblErrore.Text = "Email non trovata";
                    lblErrore.Visible = true;
                }
            }
        }

        private void inviaEmail(string text, string rand)
        {
            throw new NotImplementedException();
        }

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvz";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}