using adoNetWebSQlServer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GEstaR
{
    public partial class LoggatoMaster : MasterPage
    {
        public string nomeCognome = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            else if ((string)Session["ruolo"] == "G")
            {
                adoNet.impostaConnessione();
                adoNet ado = new adoNet();
                string sql = "SELECT nome + ' ' + cognome AS NomeCognome FROM Genitori WHERE id = " + Session["id"];
                nomeCognome = ado.eseguiScalar(sql, System.Data.CommandType.Text);
            }
            else
            {
                adoNet.impostaConnessione();
                adoNet ado = new adoNet();
                string sql = "SELECT nome + ' ' + cognome AS NomeCognome FROM Personale WHERE id = " + Session["id"];
                nomeCognome = ado.eseguiScalar(sql, System.Data.CommandType.Text);
            }
        }
    }
}