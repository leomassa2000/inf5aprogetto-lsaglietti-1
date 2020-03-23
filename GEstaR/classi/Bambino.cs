using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GEstaR.classi
{
    public class Bambino
    {
        public string nome;
        public string cognome;
        public char sesso;
        public int nazionalita;
        public DateTime dataNascita;
        public int cittaNascita;
        public string CF;
        public string indirizzo;
        public string numeroCivico;
        public string provincia;
        public int citta;
        public string scuola;
        public int classe;
        public object[,] turni;

        public string writeCookie()
        {
            string s = nome + "," +
                cognome + "," +
                sesso + "," +
                nazionalita + "," +
                dataNascita.ToShortDateString() + "," +
                cittaNascita + "," +
                CF + "," +
                indirizzo + "," +
                numeroCivico + "," +
                provincia + "," +
                citta + "," +
                classe + "," +
                scuola;

            for (int i = 0; i < turni.GetLength(0); i++)
            {
                for (int y = 0; y < turni.GetLength(1); y++)
                    if (y > 0)
                        s += Convert.ToInt32(turni[i, y]) == 1 ? 1 : 0;
                    else
                        s += turni[i, y];
                s += ",";
            }

            return s;
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
            CF = vDati[6];
            indirizzo = vDati[7];
            numeroCivico = vDati[8];
            provincia = vDati[9];
            citta = Convert.ToInt32(vDati[10]);
            classe = Convert.ToInt32(vDati[11]);
            scuola = vDati[12];
            turni = new object[vDati.Length - 14, 17];
            for (int i = 0; i < vDati.Length - 14; i++)
                for (int y = 0; y < 16; y++)
                    turni[i, y] = vDati[i + 13].Substring(y, 1);
        }
    }
}