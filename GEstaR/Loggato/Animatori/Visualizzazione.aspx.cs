using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GEstaR.Loggato.Animatori
{
    public partial class Visualizzazione : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "UpdateMsg", "$(document).ready(function(){$('#MainContent_tableAnimatori').DataTable();});", true);
        }

        protected void btnAggiungi_Click(object sender, EventArgs e)
        {
            Response.Redirect("./Dettagli.aspx?type=0");
        }

        protected void btnCerca_Click(object sender, EventArgs e)
        {

        }
    }
}