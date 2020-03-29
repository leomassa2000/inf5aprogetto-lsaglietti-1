using Microsoft.SqlServer.Server;
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
        public string indirizzo;
        public string numeroCivico;
        public string provincia;
        public int citta;
        public string[,] cellulare = new string[3,2];
        public string email;

        public Genitore() { }
        public Genitore(string cookie)
        {
            readCookie(cookie);
        }

        public string writeCookie()
        {
            string s = nome + "," +
                cognome + "," +
                sesso + "," +
                indirizzo + "," +
                numeroCivico + "," +
                provincia + "," +
                citta + "," +
                email + ",";
            for (int i = 0; i < cellulare.GetLength(0); i++)
            {
                s += "[" + cellulare[i, 0] + ":" + cellulare[i, 1] + "],";
            }

            return s;
        }

        public void readCookie(string cookie)
        {
            string[] vDati = cookie.Split(',');
            nome = vDati[0];
            cognome = vDati[1];
            sesso = Convert.ToChar(vDati[2]);
            indirizzo = vDati[3];
            numeroCivico = vDati[4];
            provincia = vDati[5];
            citta = Convert.ToInt32(vDati[6]);
            email = vDati[7];
            for (int i = 0; i < vDati.Length - 7; i++)
            {
                cellulare[i, 0] = vDati[8 + i].Split(':')[0].Trim('[', ']');
                cellulare[i, 1] = vDati[8 + i].Split(':')[1].Trim('[', ']');
            }
        }
    }
}