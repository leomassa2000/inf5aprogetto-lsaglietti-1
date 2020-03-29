using adoNetWebSQlServer;
using System;
using System.Collections.Generic;
using System.Data;
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
                Response.Redirect("~/Login.aspx");
            }
            else if ((string)Session["ruolo"] == "G")
            {
                adoNet.impostaConnessione();
                adoNet ado = new adoNet();
                string sql = "SELECT nome + ' ' + cognome AS NomeCognome FROM Genitori WHERE id = " + Session["id"];
                nomeCognome = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                sceltaBambino.Visible = true;
                sql = @"select Turni.id, Turni.numero 
                        from Turni
                        inner join FreqBambini on idTurno = Turni.id
                        inner join ParenteleBambini on FreqBambini.idBambino = ParenteleBambini.idBambino
                        inner join Genitori on Genitori.id = ParenteleBambini.idGenitore
                        where Genitori.id = " + Session["id"] + " AND Turni.anno = " + DateTime.Now.Year;
                DataTable dt = ado.eseguiQuery(sql, System.Data.CommandType.Text);
                foreach (DataRow dr in dt.Rows)
                {
                    sceltaTurno.Items.Add(new ListItem(dr.ItemArray[1] + "° turno", dr.ItemArray[0].ToString()));
                }
            }
            else
            {
                adoNet.impostaConnessione();
                adoNet ado = new adoNet();
                string sql = "SELECT nome + ' ' + cognome AS NomeCognome FROM Personale WHERE id = " + Session["id"];
                nomeCognome = ado.eseguiScalar(sql, System.Data.CommandType.Text);
                sceltaBambino.Visible = false;
                sql = @"select Turni.id, Turni.numero
                        from FreqPersonale
                        inner join Personale on idPersonale = Personale.id
                        inner join Turni on idTurno = Turni.id
                        where Personale.id = " + Session["id"];
                DataTable dt = ado.eseguiQuery(sql, System.Data.CommandType.Text);
                foreach (DataRow dr in dt.Rows)
                {
                    sceltaTurno.Items.Add(new ListItem(dr.ItemArray[1] + "° turno", dr.ItemArray[0].ToString()));
                }
            }

        }
    }
}