using adoNetWebSQlServer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;
using GEstaR.classi;
using System.Data.SqlClient;
using System.Web.UI;

namespace GEstaR
{
    public partial class DatiBambini : System.Web.UI.Page
    {
        List<Bambino> bambini;
        int[] idTurni;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            else
            {
                adoNet adoWeb = new adoNet();

                try
                {
                    if (Request.Cookies["genitore1"].Value == null)
                    {
                        Response.Redirect("./DatiGenitori.aspx");
                    }
                    else if (!IsPostBack)
                    {
                        adoNet.impostaConnessione();

                        bambini = new List<Bambino>();
                        Genitore genitore1 = new Genitore(Request.Cookies["genitore1"].Value);
                        Genitore genitore2;
                        try
                        {
                            if (Request.Cookies["genitore2"].Value != null)
                            {
                                genitore2 = new Genitore(Request.Cookies["genitore2"].Value);
                                if (genitore1.indirizzo == genitore2.indirizzo &&
                                    genitore1.numeroCivico == genitore2.numeroCivico &&
                                    genitore1.citta == genitore2.citta &&
                                    genitore1.provincia == genitore2.provincia)
                                    indirizzoUguale.Visible = true;
                                else
                                    indirizzoUguale.Visible = false;
                            }
                            else
                            {
                                indirizzoUguale.Visible = false;
                            }
                        }
                        catch (Exception ex)
                        {
                            indirizzoUguale.Visible = false;
                        }
                        string sql = @"select * 
                        from Nazioni ORDER BY DescNazione";
                        DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                        nazionalitaBambino.DataSource = codice;
                        nazionalitaBambino.DataTextField = "DescNazione";
                        nazionalitaBambino.DataValueField = "IdNazione";
                        nazionalitaBambino.DataBind();

                        sql = @"select * 
                        from Province ORDER BY DescProvincia";
                        codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                        provinciaBambino.DataSource = codice;
                        provinciaBambino.DataTextField = "DescProvincia";
                        provinciaBambino.DataValueField = "CodProvincia";
                        provinciaBambino.DataBind();
                        provinciaBambino.SelectedIndex = -1;

                        sql = @"select *, descri + ' (' + prov + ')' AS text
                        from Citta ORDER BY descri"; 
                        codice = adoWeb.eseguiQuery(sql, CommandType.Text);
                        cittaNascitaBambino.DataSource = codice;
                        cittaNascitaBambino.DataTextField = "text";
                        cittaNascitaBambino.DataValueField = "IdCitta";
                        cittaNascitaBambino.DataBind();

                        sql = @"select * 
                        from Classi";
                        DataTable classi = adoWeb.eseguiQuery(sql, CommandType.Text);
                        foreach (DataRow dr in classi.Rows)
                        {
                            ListItem ls = new ListItem(dr.Field<int>("anno").ToString() + "° " + ((dr.Field<string>("ME") == "M") ? "Media" : "Elementare"), dr.Field<int>("id").ToString());
                            classeBambino.Items.Add(ls);
                        }
                    }
                    else
                    {

                        string sql = @"select * 
                        from Turni WHERE idCentro = " + Session["idCentro"];
                        DataTable turni = adoWeb.eseguiQuery(sql, CommandType.Text);
                        int y = 0;
                        idTurni = new int[turni.Rows.Count];
                        foreach (DataRow turno in turni.Rows)
                        {

                            TableRow tr = new TableRow();
                            TableCell tc = new TableCell();
                            CheckBox checkBox = new CheckBox();
                            checkBox.ID = turno["id"].ToString();
                            idTurni[y] = (int)(turno["id"]);
                            y++;
                            checkBox.CheckedChanged += turnoEvent;
                            checkBox.AutoPostBack = true;
                            tc.Controls.Add(checkBox);
                            tr.Cells.Add(tc);
                            tc = new TableCell();
                            tc.Text = (Convert.ToDateTime(turno["dataInizio"].ToString())).ToShortDateString();
                            tr.Cells.Add(tc);
                            tc = new TableCell();
                            tc.Text = (Convert.ToDateTime(turno["dataFine"].ToString())).ToShortDateString();
                            tr.Cells.Add(tc);
                            int colSpan = 2;
                            if (Convert.ToBoolean(turno["servizioMensa"].ToString()))
                            {
                                tc = new TableCell();
                                //tr.Cells.Add(tc);
                                //tc = new TableCell();
                                //tc.ColumnSpan = 2;
                                RadioButtonList radio = new RadioButtonList();
                                radio.ID = "mensa" + turno["id"].ToString();
                                radio.Enabled = false;
                                radio.CssClass = "table-borderless";
                                radio.Items.Add("Sì");
                                radio.Items.Add("No");
                                tc.Controls.Add(radio);
                                tr.Cells.Add(tc);
                                colSpan += 3;
                            }
                            tableTurni.Rows.Add(tr);
                            tr = new TableRow();
                            tr.Cells.Add(new TableCell());
                            tc = new TableCell();
                            tc.ColumnSpan = colSpan;
                            CheckBoxList checkBoxList = new CheckBoxList();
                            checkBoxList.ID = "settimane" + turno["id"].ToString();
                            checkBoxList.Enabled = false;
                            checkBoxList.Visible = false;

                            DateTime data = new DateTime();
                            data = Convert.ToDateTime(turno["dataInizio"]);
                            checkBoxList.CssClass = "table-borderless";

                            for (int i = 0; i < Convert.ToInt32(turno["numeroSettimane"].ToString()); i++)
                            {
                                checkBoxList.Items.Add("Settimana " + (i + 1) + ": " + data.ToShortDateString() + " - " + data.AddDays(7).ToShortDateString());
                                data = data.AddDays(7);
                            }
                            tc.Controls.Add(checkBoxList);
                            tr.Cells.Add(tc);
                            tableTurni.Rows.Add(tr);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("./DatiGenitori.aspx");
                }
                termineIscrizione.Enabled = false;

                for (int k = 0; k <= Request.Cookies.Count; k++)
                {
                    try
                    {
                        if (Request.Cookies["bambino" + k].Value != null)
                        {
                            Bambino newBambino = new Bambino();
                            newBambino.readCookie(Request.Cookies["bambino" + (k)].Value);
                            TableRow tr = new TableRow();
                            TableCell tc = new TableCell();
                            tc.Text = newBambino.nome;
                            tr.Cells.Add(tc);
                            tc = new TableCell();
                            tc.Text = newBambino.cognome;
                            tr.Cells.Add(tc);
                            tc = new TableCell();
                            tc.Text = newBambino.dataNascita.ToShortDateString();
                            tr.Cells.Add(tc);
                            tc = new TableCell();
                            for (int p = 0; p < newBambino.turni.GetLength(0); p++)
                            {
                                if (Convert.ToInt32(newBambino.turni[p, 0]) != 0)
                                {
                                    string sql = @"select * 
                        from Turni WHERE id = " + newBambino.turni[p, 0];
                                    DataTable dettaglioTurno = adoWeb.eseguiQuery(sql, CommandType.Text);
                                    tc.Text += " ♦ Turno " + dettaglioTurno.Rows[0].Field<int>("numero").ToString() + ": " + dettaglioTurno.Rows[0].Field<DateTime>("dataInizio").ToShortDateString() + " - " + dettaglioTurno.Rows[0].Field<DateTime>("dataFine").ToShortDateString() + " ";
                                    if (Convert.ToBoolean(dettaglioTurno.Rows[0].Field<bool>("servizioMensa")))
                                        tc.Text += "- Mensa: " + (Convert.ToInt32(newBambino.turni[p, 1]) == 1 ? "Sì" : "No");
                                    tc.Text += "<br/>";
                                }
                            }
                            tr.Cells.Add(tc);
                            tc = new TableCell();
                            Button btn = new Button();
                            btn.CssClass = "btn btn-circle btn-danger";
                            Label lbl = new Label();
                            lbl.CssClass = "fas fa-trash";
                            btn.Controls.Add(lbl);
                            btn.Click += EliminaBambino_click;
                            btn.ID = "bambino" + k;
                            tc.Controls.Add(btn);
                            tr.Cells.Add(tc);
                            tableDettagli.Rows.Add(tr);
                            termineIscrizione.Enabled = true;
                        }
                    }
                    catch (Exception ex) { }
                }
            }
        }


        protected void Unnamed_Click(object sender, EventArgs e)
        {
            datiBambino.Visible = true;
            nomeBambino.Text = "";
            cognomeBambino.Text = "";
            sessoBambino.SelectedIndex = -1;
            nazionalitaBambino.SelectedIndex = -1;
            dataNascitaBambino.Text = "";
            cittaNascitaBambino.SelectedIndex = -1;
            indirizzoBambino.Text = "";
            numeroCivicoBambino.Text = "";
            provinciaBambino.SelectedIndex = -1;
            cittaBambino.SelectedIndex = -1;
            termineIscrizione.Visible = false;
            foreach (Control ctrl in datiBambino.Controls)
            {
                try
                {
                    ((RequiredFieldValidator)ctrl).Enabled = true;
                }
                catch (Exception ex) { }
            }
        }

        protected void EliminaBambino_click(object sender, EventArgs e)
        {
            foreach (Control ctrl in datiBambino.Controls)
            {
                try
                {
                    ((RequiredFieldValidator)ctrl).Enabled = false;
                }
                catch (Exception ex) { }
            }
            Response.Cookies[((Button)sender).ID].Expires = DateTime.Now.AddDays(-1);
            Request.Cookies[((Button)sender).ID].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("./DatiBambini.aspx");
        }
        protected void salvaBambino_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                datiBambino.Visible = false;
                termineIscrizione.Visible = true;
                Bambino newBambino = new Bambino();
                newBambino.nome = nomeBambino.Text;
                newBambino.cognome = cognomeBambino.Text;
                newBambino.sesso = Convert.ToChar(sessoBambino.SelectedValue);
                newBambino.nazionalita = Convert.ToInt32(nazionalitaBambino.SelectedValue);
                newBambino.dataNascita = Convert.ToDateTime(dataNascitaBambino.Text);
                newBambino.cittaNascita = Convert.ToInt32(cittaNascitaBambino.SelectedValue);
                newBambino.CF = codiceFiscaleBambino.Text;
                newBambino.indirizzo = indirizzoBambino.Text;
                newBambino.numeroCivico = numeroCivicoBambino.Text;
                newBambino.provincia = provinciaBambino.SelectedValue;
                newBambino.citta = Convert.ToInt32(cittaBambino.SelectedValue);
                newBambino.classe = Convert.ToInt32(classeBambino.SelectedValue);
                newBambino.scuola = scuolaBambino.Text;


                newBambino.turni = new object[idTurni.Length, 17];
                int i = 0;
                foreach (int turno in idTurni)
                {
                    if (((CheckBox)tableTurni.FindControl(turno.ToString())).Checked)
                    {
                        newBambino.turni[i, 0] = turno;
                        try
                        {
                            newBambino.turni[i, 1] = ((RadioButtonList)tableTurni.FindControl("mensa" + turno.ToString())).SelectedValue == "No" ? 0 : 1;
                        }
                        catch (Exception ex)
                        {
                            newBambino.turni[i, 1] = 0;
                        }
                        for (int y = 0; y < ((CheckBoxList)tableTurni.FindControl("settimane" + turno.ToString())).Items.Count; y++)
                        {
                            newBambino.turni[i, y + 2] = Convert.ToInt32(((CheckBoxList)tableTurni.FindControl("settimane" + turno.ToString())).Items[y].Selected);
                        }
                        i++;
                    }
                }
                int n = 0;
                for (int k = 0; k <= Request.Cookies.Count; k++)
                {
                    try
                    {
                        if (Request.Cookies["bambino" + k].Value != null)
                            n++;
                    }
                    catch { }
                }
                Response.Cookies["bambino" + (n + 1)].Value += newBambino.writeCookie();
                Response.Cookies["bambino" + (n + 1)].Expires = DateTime.Now.AddMinutes(30);
                //bambini.Add(newBambino);
                TableRow tr = new TableRow();
                TableCell tc = new TableCell();
                tc.Text = newBambino.nome;
                tr.Cells.Add(tc);
                tc = new TableCell();
                tc.Text = newBambino.cognome;
                tr.Cells.Add(tc);
                tc = new TableCell();
                tc.Text = newBambino.dataNascita.ToShortDateString();
                tr.Cells.Add(tc);
                tc = new TableCell();
                for (int p = 0; p < newBambino.turni.GetLength(0); p++)
                {
                    if (Convert.ToInt32(newBambino.turni[p, 0]) != 0)
                    {
                        string sql = @"select * 
                        from Turni WHERE id = " + newBambino.turni[p, 0];
                        adoNet adoWeb = new adoNet();
                        DataTable dettaglioTurno = adoWeb.eseguiQuery(sql, CommandType.Text);
                        tc.Text += " ♦ Turno " + dettaglioTurno.Rows[0].Field<int>("numero").ToString() + ": " + dettaglioTurno.Rows[0].Field<DateTime>("dataInizio").ToShortDateString() + " - " + dettaglioTurno.Rows[0].Field<DateTime>("dataFine").ToShortDateString() + " ";
                        if (Convert.ToBoolean(dettaglioTurno.Rows[0].Field<bool>("servizioMensa")))
                            tc.Text += "- Mensa: " + (Convert.ToInt32(newBambino.turni[p, 1]) == 1 ? "Sì" : "No");
                        tc.Text += "<br/>";
                    }
                }
                tr.Cells.Add(tc);
                tableDettagli.Rows.Add(tr);
            }
        }

        protected void sameIndirizzoGenitori_CheckedChanged(object sender, EventArgs e)
        {
            if (sameIndirizzoGenitori.Checked)
            {
                Genitore genitore = new Genitore(Request.Cookies["genitore1"].Value);

                indirizzoBambino.Text = genitore.indirizzo;
                numeroCivicoBambino.Text = genitore.numeroCivico;
                provinciaBambino.SelectedValue = genitore.provincia;
                cittaBambino.SelectedValue = genitore.citta.ToString();
            }
        }

        protected void turnoEvent(object sender, EventArgs e)
        {
            CheckBoxList content = (CheckBoxList)tableTurni.FindControl("settimane" + ((CheckBox)sender).ID);
            content.Visible = ((CheckBox)sender).Checked;
            content.Enabled = ((CheckBox)sender).Checked;
            try
            {
                RadioButtonList radio = (RadioButtonList)tableTurni.FindControl("mensa" + ((CheckBox)sender).ID);
                radio.Enabled = ((CheckBox)sender).Checked;
                ((CheckBox)sender).Focus();
            }
            catch (Exception ex) { }
        }

        protected void provinciaBambino_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sql = @"select * 
                        from Citta where prov = '" + provinciaBambino.SelectedValue + "'";
            adoNet adoWeb = new adoNet();
            DataTable codice = adoWeb.eseguiQuery(sql, CommandType.Text);
            cittaBambino.DataSource = codice;
            cittaBambino.DataTextField = "descri";
            cittaBambino.DataValueField = "IdCitta";
            cittaBambino.DataBind();
        }

        protected void termineIscrizione_Click(object sender, EventArgs e)
        {
            Response.Redirect("./Pagamento.aspx");
        }

        private string getStringTurno(object[,] turni, int j)
        {
            string s = "";
            for (int i = 2; i < turni.GetLength(1); i++)
            {
                s += turni[j, i];
            }
            return s;
        }

        protected void annullaBambino_Click(object sender, EventArgs e)
        {
            foreach (Control ctrl in datiBambino.Controls)
            {
                try
                {
                    ((RequiredFieldValidator)ctrl).Enabled = false;
                }
                catch (Exception ex) { }
            }
            //TODO: verifica annulla inserimento
            if (Page.IsValid || !Page.IsValid)
            {
                datiBambino.Visible = false;

                termineIscrizione.Visible = true;
            }
        }
    }


}