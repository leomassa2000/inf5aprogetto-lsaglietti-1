using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GEstaR.classi
{
    public class Genitore
    {
        public string nome;
        public string cognome;
        public char sesso;
        public int nazionalita;
        public DateTime dataNascita;
        public int cittaNascita;
        public string indirizzo;
        public string numeroCivico;
        public string provincia;
        public int citta;
        public string cellulare;
        public string email;

        public Genitore() { }
        public Genitore(string cookie)
        {
            readCookie(cookie);
        }

        public string writeCookie()
        {
            return nome + "," +
                cognome + "," +
                sesso + "," +
                nazionalita + "," +
                dataNascita.ToShortDateString() + "," +
                cittaNascita + "," +
                indirizzo + "," +
                numeroCivico + "," +
                provincia + "," +
                citta + "," +
                cellulare + "," +
                email;
        }

        public void readCookie(string cookie)
        {
            string[] vDati = cookie.Split(',');
            nome = vDati[0];
            cognome = vDati[1];
            sesso = Convert.ToChar(vDati[2]);
            nazionalita = Convert.ToInt32(vDati[3]);
            dataNascita = Convert.ToDateTime(vDati[4]);
            cittaNascita = Convert.ToInt32(vDati[5]);
            indirizzo = vDati[6];
            numeroCivico = vDati[7];
            provincia = vDati[8];
            citta = Convert.ToInt32(vDati[9]);
            cellulare = vDati[10];
            email = vDati[11];
        }
    }
}