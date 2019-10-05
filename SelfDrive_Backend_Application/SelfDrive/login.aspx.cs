using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class login : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnloging_Click(object sender, EventArgs e)
        {
            string id = txtid.Text;
            string pwd = txtpwd.Text;
            //DataTable dt = ObjDBAccess1.adminlogin(id, pwd);
            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    string loginstatus = dt.Rows[0]["loginstatus"].ToString();
            //    if (loginstatus != "Not Exists")
            //    {
            //        Session["A_LoginId"] = dt.Rows[0]["loginid"].ToString();
            //        Session["A_username"] = dt.Rows[0]["username"].ToString();
            //        Response.Redirect("CompanyMaster.aspx");
            //    }
            //    else
            //    {
            //        lblmsg.Text = "Invalid Logins...!";
            //        return;
            //    }
            //}
            //else
            //{

            //}
        }
    }
}