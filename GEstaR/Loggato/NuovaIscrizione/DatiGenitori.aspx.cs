using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using adoNetWebSQlServer;
using System.Data;
using System.Net;
using GEstaR.classi;

namespace GEstaR
{
    public partial class DatiGenitori : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            else
            {
                emailGenitore1C.SetFocusOnError = true;
                emailGenitore1C.ValidateEmptyText = false; //esegue il controllo anche se campo vuoto
                emailGenitore1C.EnableClientScript = false;
                emailGenitore1C.ForeColor = System.Drawing.Color.Red;
                if (!Page.IsPostBack)
                {
                    datiGenitore2_CheckedChanged(new object(), new EventArgs());
                    //adoNet.impostaConnessione();


                    string sql = @"select * 
                        from Province";
                    adoNet adoWeb = new adoNet();
                    DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                    provinciaGenitore1.DataSource = codice;
                    provinciaGenitore1.DataTextField = "DescProvincia";
                    provinciaGenitore1.DataValueField = "CodProvincia";
                    provinciaGenitore1.DataBind();
                    provinciaGenitore1.SelectedIndex = -1;

                    provinciaGenitore2.DataSource = codice;
                    provinciaGenitore2.DataTextField = "DescProvincia";
                    provinciaGenitore2.DataValueField = "CodProvincia";
                    provinciaGenitore2.DataBind();
                    provinciaGenitore2.SelectedIndex = -1;
                }
            }
        }

        protected void salvaDatiGenitore_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (Page.IsValid)
            {
                Genitore genitore1 = new Genitore();
                genitore1.nome = nomeGenitore1.Text;
                genitore1.cognome = cognomeGenitore1.Text;
                genitore1.sesso = Convert.ToChar(sessoGenitore1.SelectedValue);
                genitore1.indirizzo = indirizzoGenitore1.Text;
                genitore1.numeroCivico = numeroCivicoGenitore1.Text;
                genitore1.provincia = provinciaGenitore1.SelectedValue;
                genitore1.citta = Convert.ToInt32(cittaGenitore1.SelectedValue);
                genitore1.cellulare[0, 0] = cellulare1Genitore1.Text;
                genitore1.cellulare[0, 1] = DescrCellulare1Genitore1.Text;
                if (cellulare2Genitore1.Text != String.Empty)
                {
                    genitore1.cellulare[1, 0] = cellulare2Genitore1.Text;
                    genitore1.cellulare[1, 1] = DescrCellulare2Genitore1.Text;
                }
                if (cellulare3Genitore1.Text != String.Empty)
                {
                    genitore1.cellulare[2, 0] = cellulare3Genitore1.Text;
                    genitore1.cellulare[2, 1] = DescrCellulare3Genitore1.Text;
                }
                genitore1.email = emailGenitore1.Text;
                Response.Cookies["genitore1"].Value = genitore1.writeCookie();
                Response.Cookies["genitore1"].Expires = DateTime.Now.AddMinutes(30);

                if (datiGenitore2.Checked)
                {
                    Genitore genitore2 = new Genitore();
                    genitore2.nome = nomeGenitore2.Text;
                    genitore2.cognome = cognomeGenitore2.Text;
                    genitore2.sesso = Convert.ToChar(sessoGenitore2.SelectedValue);
                    genitore2.indirizzo = indirizzoGenitore2.Text;
                    genitore2.numeroCivico = numeroCivicoGenitore2.Text;
                    genitore2.provincia = provinciaGenitore2.SelectedValue;
                    genitore2.citta = Convert.ToInt32(cittaGenitore2.SelectedValue);
                    genitore2.cellulare[0, 0] = cellulare1Genitore2.Text;
                    genitore2.cellulare[0, 1] = DescrCellulare1Genitore2.Text;
                    if (cellulare2Genitore2.Text != String.Empty)
                    {
                        genitore2.cellulare[1, 0] = cellulare2Genitore2.Text;
                        genitore2.cellulare[1, 1] = DescrCellulare2Genitore2.Text;
                    }
                    if (cellulare3Genitore2.Text != String.Empty)
                    {
                        genitore2.cellulare[2, 0] = cellulare3Genitore2.Text;
                        genitore2.cellulare[2, 1] = DescrCellulare3Genitore2.Text;
                    }
                    genitore2.email = emailGenitore2.Text;
                    Response.Cookies["genitore2"].Value = genitore2.writeCookie();
                    Response.Cookies["genitore2"].Expires = DateTime.Now.AddMinutes(30);
                }
                Response.Redirect("./DatiBambini.aspx");
            }
        }

        protected void emailGenitoreC_ServerValidate(object source, ServerValidateEventArgs args)
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

        protected void sameIndirizzoGenitori_CheckedChanged(object sender, EventArgs e)
        {
            if (sameIndirizzoGenitori.Checked)
            {
                indirizzoGenitore2.Text = indirizzoGenitore1.Text;
                numeroCivicoGenitore2.Text = numeroCivicoGenitore1.Text;
                provinciaGenitore2.SelectedValue = provinciaGenitore1.SelectedValue;
                //TODO: controllare perchè non worka 
                provinciaGenitore2_SelectedIndexChanged(new object(), new EventArgs());
                cittaGenitore2.SelectedValue = cittaGenitore2.SelectedValue;
            }
            else
            {
                indirizzoGenitore2.Text = "";
                numeroCivicoGenitore2.Text = "";
                provinciaGenitore2.SelectedIndex = -1;
                cittaGenitore2.SelectedIndex = -1;
            }
        }

        protected void provinciaGenitore1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sql = @"select * 
                        from Citta where prov = '" + provinciaGenitore1.SelectedValue + "'";
            adoNet adoWeb = new adoNet();
            DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
            cittaGenitore1.DataSource = codice;
            cittaGenitore1.DataTextField = "descri";
            cittaGenitore1.DataValueField = "IdCitta";
            cittaGenitore1.DataBind();
        }

        protected void provinciaGenitore2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sql = @"select * 
                        from Citta where prov = '" + provinciaGenitore2.SelectedValue + "'";
            adoNet adoWeb = new adoNet();
            DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
            cittaGenitore2.DataSource = codice;
            cittaGenitore2.DataTextField = "descri";
            cittaGenitore2.DataValueField = "IdCitta";
            cittaGenitore2.DataBind();
        }

        protected void datiGenitore2_CheckedChanged(object sender, EventArgs e)
        {
            datiGenitore2div.Enabled = datiGenitore2.Checked;

            nomeGenitore2R.Enabled = datiGenitore2.Checked;
            cognomeGenitore2R.Enabled = datiGenitore2.Checked;
            indirizzoGenitore2R.Enabled = datiGenitore2.Checked;
            numeroCivicoGenitore2R.Enabled = datiGenitore2.Checked;
            cittaGenitore2R.Enabled = datiGenitore2.Checked;
            cellulare1Genitore2R.Enabled = datiGenitore2.Checked;
            DescrCellulare1Genitore2.Enabled = datiGenitore2.Checked;
            emailGenitore2E.Enabled = datiGenitore2.Checked;

        }

        protected void cellulare1Genitore2_TextChanged(object sender, EventArgs e)
        {
            if (cellulare1Genitore2.Text.Trim().Length != 0)
            {
                cellulare2Genitore2.Enabled = true;
                DescrCellulare2Genitore2.Enabled = true;
            }
            else
            {
                cellulare2Genitore2.Enabled = false;
                DescrCellulare2Genitore2.Enabled = false;
            }
        }

        protected void cellulare2Genitore2_TextChanged(object sender, EventArgs e)
        {
            if (cellulare2Genitore2.Text.Trim().Length != 0)
            {
                cellulare3Genitore2.Enabled = true;
                DescrCellulare3Genitore2.Enabled = true;
            }
            else
            {
                cellulare3Genitore2.Enabled = false;
                DescrCellulare3Genitore2.Enabled = false;
            }
        }

    }
}