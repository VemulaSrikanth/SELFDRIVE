using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnklogout_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["profileid"] != null)
                {
                    Session.Abandon();
                }
                Response.Redirect("~/Default.aspx");
            }
            catch (Exception ex)
            {
               
            }
            finally { }
        }
    }
}