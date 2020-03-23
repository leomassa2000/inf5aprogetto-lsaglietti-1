using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GEstaR
{
    public partial class NuovaIscrizione : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
                Response.Redirect("../../Login.aspx");
        }

        protected void btnInizia_Click(object sender, EventArgs e)
        {
            Response.Redirect("./DatiGenitori.aspx");
        }
    }
}