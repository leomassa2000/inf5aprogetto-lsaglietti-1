using adoNetWebSQlServer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GEstaR.Loggato.Animatori
{
    public partial class Dettagli : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Params["type"] == "0")
                {
                    //Aggiungi
                    Page.Title = "Aggiungi Animatore";
                    salvaAnimatore.Text = "Aggiungi";
                    annullaAnimatore.Visible = true;
                }
                else if (Request.Params["type"] == "1")
                {
                    //Modifica
                    Page.Title = "Modifica Animatore";
                    salvaAnimatore.Text = "Modifica";
                    annullaAnimatore.Visible = true;
                }
                else if (Request.Params["type"] == "2")
                {
                    //Visualizza
                    Page.Title = "Visualizza Animatore";
                    annullaAnimatore.Visible = false;
                    salvaAnimatore.Text = "Chiudi";
                }
                else
                {
                    //ERRORE: Redirect to pagina precedente
                    Response.Redirect(Request.UrlReferrer.ToString());
                }


                string sql = @"select * 
                        from Province ORDER BY DescProvincia";
                adoNet adoWeb = new adoNet();
                DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                provinciaAnimatore.DataSource = codice;
                provinciaAnimatore.DataTextField = "DescProvincia";
                provinciaAnimatore.DataValueField = "CodProvincia";
                provinciaAnimatore.DataBind();
                provinciaAnimatore.SelectedIndex = -1;

                sql = @"select * 
                        from Citta ORDER BY descri";
                adoWeb = new adoNet();
                codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                cittaNascitaAnimatore.DataSource = codice;
                cittaNascitaAnimatore.DataTextField = "descri";
                cittaNascitaAnimatore.DataValueField = "IdCitta";
                cittaNascitaAnimatore.DataBind();
                cittaNascitaAnimatore.SelectedIndex = -1;

                sql = @"select * 
                        from Nazioni ORDER BY DescNazione";
                adoWeb = new adoNet();
                codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                nazionalitaAnimatore.DataSource = codice;
                nazionalitaAnimatore.DataTextField = "DescNazione";
                nazionalitaAnimatore.DataValueField = "IdNazione";
                nazionalitaAnimatore.DataBind();
                nazionalitaAnimatore.SelectedIndex = -1;
            }
        }

        protected void salvaAnimatore_Click(object sender, EventArgs e)
        {
            adoNet ado = new adoNet();
            string sql = "";
            SqlCommand command = new SqlCommand();
            switch (((Button)sender).Text)
            {
                case "Aggiungi":
                    sql = "INSERT INTO Personale(nome, cognome, sesso, dataNascita, natoA, nazionalita, indirizzo, numeroCivico, idCitta, numeroTelefono, email) " +
                        "OUTPUT Inserted.id " +
                        "VALUES " +
                        "(@nome, @cognome, @sesso, @dataNascita, @natoA, @nazionalita, @indirizzo, @numeroCivico, @idCitta, @numeroTelefono, @email)";
                    command.CommandText = sql;
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nome", nomeAnimatore.Text);
                    command.Parameters.AddWithValue("@cognome", cognomeAnimatore.Text);
                    command.Parameters.AddWithValue("@sesso", sessoAnimatore.SelectedValue);
                    command.Parameters.AddWithValue("@dataNascita", dataNascitaAnimatore.Text);
                    command.Parameters.AddWithValue("@natoA", cittaNascitaAnimatore.SelectedValue);
                    command.Parameters.AddWithValue("@nazionalita", nazionalitaAnimatore.SelectedValue);
                    command.Parameters.AddWithValue("@indirizzo", indirizzoAnimatore.Text);
                    command.Parameters.AddWithValue("@numeroCivico", numeroCivicoAnimatore.Text);
                    command.Parameters.AddWithValue("@idCitta", cittaAnimatore.SelectedValue);
                    command.Parameters.AddWithValue("@numeroTelefono", cellulareAnimatore.Text);
                    command.Parameters.AddWithValue("@email", emailAnimatore.Text);
                    string idAnimatore = ado.eseguiScalar(command);
                    
                    sql = "INSERT INTO Genitori(nome, cognome, numeroTelefono) " +
                       "OUTPUT Inserted.id " +
                       "VALUES " +
                       "(@nome, @cognome, @numeroTelefono)";
                    command = new SqlCommand();
                    command.CommandText = sql;
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nome", nomeAnimatore.Text);
                    command.Parameters.AddWithValue("@cognome", cognomeAnimatore.Text);
                    command.Parameters.AddWithValue("@numeroTelefono", cellulareAnimatore.Text);
                    string idGenitore = ado.eseguiScalar(command);

                    sql = "INSERT INTO ParenteleAnimatori(idAnimatore, idGenitore) VALUES(" + idAnimatore + ", " + idGenitore + ")";
                    ado.eseguiNonQuery(sql, CommandType.Text);
                    Response.Redirect("./Visualizzazione.aspx");
                    break;
                case "Modifica":
                    break;
                case "Chiudi":
                    break;
            }
        }

        protected void annullaAnimatore_Click(object sender, EventArgs e)
        {

        }

        protected void provinciaAnimatore_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sql = @"select * 
                        from Citta where prov = '" + provinciaAnimatore.SelectedValue + "'";
            adoNet adoWeb = new adoNet();
            DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
            cittaAnimatore.DataSource = codice;
            cittaAnimatore.DataTextField = "descri";
            cittaAnimatore.DataValueField = "IdCitta";
            cittaAnimatore.DataBind();
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            adoNet adoNet = new adoNet();
            string sql = "SELECT COUNT(*) " +
                "FROM Genitori " +
                "WHERE email = '" + args.Value + "'";
            string ris = adoNet.eseguiScalar(sql, CommandType.Text);
            if (Convert.ToInt32(ris) == 0)
            {
                sql = "SELECT COUNT(*) " +
               "FROM Personale " +
               "WHERE email = '" + args.Value + "'";
                ris = adoNet.eseguiScalar(sql, CommandType.Text);
                if (Convert.ToInt32(ris) == 0)
                {
                    sql = "SELECT COUNT(*) " +
                    "FROM Centri " +
                    "WHERE email = '" + args.Value + "'";
                    ris = adoNet.eseguiScalar(sql, CommandType.Text);
                    if (Convert.ToInt32(ris) == 0)
                        args.IsValid = true; //ok
                    else
                        args.IsValid = false; //ko
                }

            }
            else
                args.IsValid = false; //ko
        }
    }
}