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
    public partial class Pagamento : System.Web.UI.Page
    {
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
                    else
                    if (!IsPostBack)
                    {
                        adoNet.impostaConnessione();

                        TableRow tr = new TableRow();
                        TableCell tc = new TableCell();

                        // 0 - idTurno; 1 - nBambini; 2 - settimane; 3 - fuoriComune
                        int[,] v = new int[20, 3];

                        for (int k = 0; k <= Request.Cookies.Count; k++)
                        {
                            try
                            {
                                if (Request.Cookies["bambino" + k].Value != null)
                                {
                                    Bambino newBambino = new Bambino();
                                    newBambino.readCookie(Request.Cookies["bambino" + k].Value);
                                    tr = new TableRow();
                                    tc = new TableCell();
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
                                    tableDettagli.Rows.Add(tr);

                                    for (int p = 0; p < newBambino.turni.GetLength(0); p++)
                                    {
                                        if (Convert.ToInt32(newBambino.turni[p, 0]) != 0)
                                        {
                                            for (int o = 0; o < v.GetLength(0); o++)
                                            {
                                                if (v[o, 0] == Convert.ToInt32(newBambino.turni[p, 0]) &&
                                                    v[o, 2] == calcoloSettimane(newBambino.turni, p) &&
                                                    v[o, 3] == verificaComune(newBambino, p))
                                                {
                                                    v[o, 1]++;
                                                    break;
                                                }
                                                else
                                                {
                                                    for (int t = 0; t < v.GetLength(0); t++)
                                                    {
                                                        if (v[t, 0] == 0)
                                                        {
                                                            v[t, 0] = Convert.ToInt32(newBambino.turni[p, 0]);
                                                            v[t, 1] = 1;
                                                            v[t, 2] = calcoloSettimane(newBambino.turni, p);
                                                            v[t, 3] = verificaComune(newBambino, p);
                                                            break;
                                                        }
                                                    }
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            catch (Exception ex) { }
                        }

                        
                        decimal totale = 0;

                        for (int o = 0; o < v.GetLength(0); o++)
                        {
                            if (v[o, 0] != 0)
                            {
                                tr = new TableRow();
                                tc = new TableCell();
                                string sql = @"select * 
                        from Turni WHERE id = " + v[o, 0];
                                DataTable dettaglioTurno = adoWeb.eseguiQuery(sql, CommandType.Text);
                                tc.Text += dettaglioTurno.Rows[0].Field<int>("numero").ToString() + "° Turno: " + dettaglioTurno.Rows[0].Field<DateTime>("dataInizio").ToShortDateString() + " - " + dettaglioTurno.Rows[0].Field<DateTime>("dataFine").ToShortDateString() + " ";
                                tr.Cells.Add(tc);
                                tc = new TableCell();
                                tc.Text = v[o, 1].ToString();
                                tr.Cells.Add(tc);
                                tc = new TableCell();
                                tc.Text = v[o, 2].ToString();
                                tr.Cells.Add(tc);
                                tc = new TableCell();
                                if (v[o, 2] <= dettaglioTurno.Rows[0].Field<int>("p1"))
                                {
                                    if (v[o, 1] < 3)
                                    {
                                        tc.Text = dettaglioTurno.Rows[0].Field<decimal>("p1quotaBamb" + v[o, 1]).ToString("F") + " €";
                                        totale += dettaglioTurno.Rows[0].Field<decimal>("p1quotaBamb" + v[o, 1]);
                                    }
                                    else
                                    {
                                        decimal calc = dettaglioTurno.Rows[0].Field<decimal>("p1quotaBamb3");
                                        for (int y = 3; y <= v[o, 1]; y++)
                                        {
                                            calc += dettaglioTurno.Rows[0].Field<decimal>("p1quotaBamb1");
                                        }
                                        tc.Text = calc.ToString("F") + " €";
                                        totale += calc;
                                    }
                                }
                                else
                                {
                                    if (v[o, 1] < 3)
                                    {
                                        tc.Text = dettaglioTurno.Rows[0].Field<decimal>("p2quotaBamb" + v[o, 1]).ToString("F") + " €";
                                        totale += dettaglioTurno.Rows[0].Field<decimal>("p2quotaBamb" + v[o, 1]);
                                    }
                                    else
                                    {
                                        decimal calc = dettaglioTurno.Rows[0].Field<decimal>("p2quotaBamb3");
                                        for (int y = 3; y <= v[o, 1]; y++)
                                        {
                                            calc += dettaglioTurno.Rows[0].Field<decimal>("p2quotaBamb1");
                                        }
                                        tc.Text = calc.ToString("F") + " €";
                                        totale += calc;
                                    }
                                }
                                if (v[o, 3] == 1)
                                {
                                    tc.Text += "<br/>   + " + (dettaglioTurno.Rows[0].Field<decimal>("quotaFuoriComune") * v[o, 1]).ToString("F") + " €";
                                    totale += dettaglioTurno.Rows[0].Field<decimal>("quotaFuoriComune") * v[o, 1];
                                }
                                tr.Cells.Add(tc);
                                tablePagamento.Rows.Add(tr);
                            }
                        }
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.ColumnSpan = 3;
                        tc.Text = "TOTALE:";
                        tc.Font.Bold = true;
                        tc.HorizontalAlign = HorizontalAlign.Right;
                        tr.Cells.Add(tc);
                        tc = new TableCell();
                        tc.Font.Bold = true;
                        tc.ID = "totDaPagare";
                        tc.Text = totale.ToString("F") + " €";
                        tr.Cells.Add(tc);
                        Response.Cookies["totDaPagare"].Value = totale.ToString("F");
                        Response.Cookies["totDaPagare"].Expires = DateTime.Now.AddMinutes(30);
                        tablePagamento.Rows.Add(tr);
                    }
                    else
                    {

                    }
                }
                catch (Exception ex)
                {
                      Response.Redirect("./DatiGenitori.aspx");
                }
            }
        }

        private int verificaComune(Bambino newBambino, int p)
        {
            int ris = 0;

            string sql = "SELECT idCitta FROM Turni INNER JOIN Centri ON idCentro = Centri.id WHERE Turni.id = " + newBambino.turni[p, 0];
            adoNet ado = new adoNet();
            string txt = ado.eseguiScalar(sql, CommandType.Text);
            if (newBambino.citta == Convert.ToInt32(txt))
            {
                ris = 1;
            }
            else
            {
                sql = "SELECT COUNT(*) FROM FuoriComune INNER JOIN  Centri ON idCentro =Centri.id INNER JOIN Turni ON Turni.idCentro = Centri.id WHERE Turni.id = " + newBambino.turni[p, 0] + "" +
                    " AND idCitta = " + newBambino.citta;
                string countCitta = ado.eseguiScalar(sql, CommandType.Text);
                if (Convert.ToInt32(countCitta) > 1)
                {
                    sql = "SELECT COUNT(*) FROM FuoriComune INNER JOIN  Centri ON idCentro =Centri.id INNER JOIN Turni ON Turni.idCentro = Centri.id WHERE Turni.id = " + newBambino.turni[p, 0] + "" +
                    " AND idCitta = " + newBambino.citta + "" +
                    " AND indirizzo = '" + newBambino.indirizzo + "'";
                    string countIndirizzo = ado.eseguiScalar(sql, CommandType.Text);
                    if (Convert.ToInt32(countIndirizzo) == 1)
                        ris = 1;
                }
                else if (Convert.ToInt32(countCitta) == 1)
                    ris = 1;
            }

            return ris;
        }

        private int calcoloSettimane(object[,] turni, int p)
        {
            int ris = 0;
            for (int i = 2; i < turni.GetLength(1); i++)
            {
                if (Convert.ToInt32(turni[p, i]) == 1)
                    ris++;
            }
            return ris;
        }

        protected void termineIscrizione_Click(object sender, EventArgs e)
        {
            string[] idGenitori = new string[2];

            Genitore genitore1 = new Genitore(Request.Cookies["genitore1"].Value);

            string sql = "INSERT INTO Genitori(nome, cognome, sesso, dataNascita, natoA, nazionalita, indirizzo, numeroCivico, idCitta, numeroTelefono, sosNumber, email) " +
                "OUTPUT Inserted.id " +
                "VALUES (@nome, @cognome, @sesso, @dataNascita, @natoA, @nazionalita, @indirizzo, @numeroCivico, @idCitta, @numeroTelefono, @sosNumber, @email);";
            SqlCommand command = new SqlCommand();
            command.CommandText = sql;
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@nome", genitore1.nome);
            command.Parameters.AddWithValue("@cognome", genitore1.cognome);
            command.Parameters.AddWithValue("@sesso", genitore1.sesso);
            command.Parameters.AddWithValue("@dataNascita", genitore1.dataNascita);
            command.Parameters.AddWithValue("@natoA", genitore1.cittaNascita);
            command.Parameters.AddWithValue("@nazionalita", genitore1.nazionalita);
            command.Parameters.AddWithValue("@indirizzo", genitore1.indirizzo);
            command.Parameters.AddWithValue("@numeroCivico", genitore1.numeroCivico);
            command.Parameters.AddWithValue("@idCitta", genitore1.citta);
            command.Parameters.AddWithValue("@numeroTelefono", genitore1.cellulare);
            command.Parameters.AddWithValue("@sosNumber", true);
            command.Parameters.AddWithValue("@email", genitore1.email);
            adoNet adoNet = new adoNet();
            idGenitori[0] = adoNet.eseguiScalar(command);
            Request.Cookies.Remove("genitore1");

            Genitore genitore2;
            try
            {
                if (Request.Cookies["genitore2"].Value != null)
                {
                    genitore2 = new Genitore(Request.Cookies["genitore2"].Value);
                    sql = "INSERT INTO Genitori(nome, cognome, sesso, dataNascita, natoA, nazionalita, indirizzo, numeroCivico, idCitta, numeroTelefono, sosNumber, email) " +
                     "OUTPUT Inserted.id " +
                     "VALUES (@nome, @cognome, @sesso, @dataNascita, @natoA, @nazionalita, @indirizzo, @numeroCivico, @idCitta, @numeroTelefono, @sosNumber, @email);";
                    command = new SqlCommand();
                    command.CommandText = sql;
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nome", genitore2.nome);
                    command.Parameters.AddWithValue("@cognome", genitore2.cognome);
                    command.Parameters.AddWithValue("@sesso", genitore2.sesso);
                    command.Parameters.AddWithValue("@dataNascita", genitore2.dataNascita);
                    command.Parameters.AddWithValue("@natoA", genitore2.cittaNascita);
                    command.Parameters.AddWithValue("@nazionalita", genitore2.nazionalita);
                    command.Parameters.AddWithValue("@indirizzo", genitore2.indirizzo);
                    command.Parameters.AddWithValue("@numeroCivico", genitore2.numeroCivico);
                    command.Parameters.AddWithValue("@idCitta", genitore2.citta);
                    command.Parameters.AddWithValue("@numeroTelefono", genitore2.cellulare);
                    command.Parameters.AddWithValue("@sosNumber", true);
                    command.Parameters.AddWithValue("@email", genitore2.email);
                    adoNet = new adoNet();
                    idGenitori[1] = adoNet.eseguiScalar(command);
                    Request.Cookies.Remove("genitore2");
                }
            }
            catch (Exception ex) { }
            int n = 0;
            for (int k = 0; k <= Request.Cookies.Count; k++)
            {
                try
                {
                    if (Request.Cookies["bambino" + k].Value != null)
                        n++;
                }
                catch (Exception ex) { }
            }

            string idBambini = "";
            for (int i = 0; i < n; i++)
            {
                Bambino newBambino = new Bambino();
                newBambino.readCookie(Request.Cookies["bambino" + (i + 1)].Value);
                sql = "INSERT INTO Bambini(nome, cognome, sesso, dataNascita, natoA, CF, nazionalita, indirizzo, numeroCivico, idCitta) " +
                "OUTPUT Inserted.id " +
                "VALUES (@nome, @cognome, @sesso, @dataNascita, @natoA, @CF, @nazionalita, @indirizzo, @numeroCivico, @idCitta);";
                command = new SqlCommand();
                command.CommandText = sql;
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@nome", newBambino.nome);
                command.Parameters.AddWithValue("@cognome", newBambino.cognome);
                command.Parameters.AddWithValue("@sesso", newBambino.sesso);
                command.Parameters.AddWithValue("@dataNascita", newBambino.dataNascita);
                command.Parameters.AddWithValue("@natoA", newBambino.cittaNascita);
                command.Parameters.AddWithValue("@CF", newBambino.CF);
                command.Parameters.AddWithValue("@nazionalita", newBambino.nazionalita);
                command.Parameters.AddWithValue("@indirizzo", newBambino.indirizzo);
                command.Parameters.AddWithValue("@numeroCivico", newBambino.numeroCivico);
                command.Parameters.AddWithValue("@idCitta", newBambino.citta);
                adoNet = new adoNet();
                string idBambino = adoNet.eseguiScalar(command);

                for (int j = 0; j < newBambino.turni.GetLength(0); j++)
                {
                    if (Convert.ToInt32(newBambino.turni[j, 0]) != 0)
                    {
                        sql = "INSERT INTO FreqBambini(idTurno, idBambino, settimane, dataIscrizione, servizioMensa, scuola, idClasse, pagato) " +
                            "OUTPUT Inserted.id" +
                        "VALUES(@idTurno, @idBambino, @settimane, @dataIscrizione, @servizioMensa, @scuola, @idClasse, 0);";
                        command = new SqlCommand();
                        command.CommandText = sql;
                        command.CommandType = CommandType.Text;
                        command.Parameters.AddWithValue("@idTurno", newBambino.turni[j, 0]);
                        command.Parameters.AddWithValue("@idBambino", idBambino);
                        command.Parameters.AddWithValue("@settimane", getStringTurno(newBambino.turni, j));
                        command.Parameters.AddWithValue("@dataIscrizione", DateTime.Now);
                        command.Parameters.AddWithValue("@servizioMensa", newBambino.turni[j, 1]);
                        command.Parameters.AddWithValue("@scuola", newBambino.scuola);
                        command.Parameters.AddWithValue("@idClasse", newBambino.classe);
                        string idIscrizione = adoNet.eseguiScalar(command);
                        idBambini += idIscrizione + ",";
                    }
                }
                if (idGenitori[1] != null)
                    sql = "INSERT INTO Parentele(idBambino, idGen1, idGen2) " +
                       "VALUES(@idBambino, @idGen1, @idGen2);";
                else
                    sql = "INSERT INTO Parentele(idBambino, idGen1) " +
                   "VALUES(@idBambino, @idGen1);";
                command = new SqlCommand();
                command.CommandText = sql;
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@idBambino", idBambino);
                command.Parameters.AddWithValue("@idGen1", idGenitori[0]);
                if (idGenitori[1] != null)
                    command.Parameters.AddWithValue("@idGen2", idGenitori[1]);
                adoNet.eseguiNonQuery(command);

                Request.Cookies.Remove("bambino" + (i + 1));
            }
            sql = "INSERT INTO pagamentiQuote(totale, pagato, metodo, idIscrizioni) " +
                        "VALUES(@totale, @pagato, @metodo, @idIscrizioni);";
            command = new SqlCommand();
            command.Parameters.AddWithValue("@totale", ((TableCell)tablePagamento.FindControl("totDaPagare")).Text.Split(' ')[0]);
            command.Parameters.AddWithValue("@pagato", false);
            command.Parameters.AddWithValue("@metodo", (tipoPagamento.SelectedValue == "cassa") ? "C" : "S");
            command.Parameters.AddWithValue("@idIscrizioni", idBambini);
            adoNet.eseguiNonQuery(command);
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

    }


}