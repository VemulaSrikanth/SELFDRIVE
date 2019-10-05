using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive.Masters
{
    public partial class CompanyMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hCmpflag.Value = "New";
                LoadCompanies();
            }
        }

        private void LoadCompanies()
        {
            try
            {
                string DeletePer = "Required";
                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllCompanies();

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {
                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["companyname"] + "</td>";
                        UnreadText += "<td>" + drverprof["address1"] + "</td>";
                        UnreadText += "<td>" + drverprof["city"] + "</td>";
                        UnreadText += "<td>" + drverprof["pincode"] + "</td>";
                        UnreadText += "<td>" + drverprof["panno"] + "</td>";
                        UnreadText += "<td>" + drverprof["status"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                             + drverprof["companyid"] + "','"
                            + drverprof["companyname"] + "','"
                            + drverprof["address1"] + "','"
                            + drverprof["address2"] + "','"
                            + drverprof["city"] + "','"
                            + drverprof["pincode"] + "','"
                            + drverprof["colorlogo"] + "','"
                            + drverprof["blacklogo"] + "','"
                            + drverprof["panno"] + "','"
                            + drverprof["gstno"] + "','"
                           + drverprof["status"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        if (DeletePer == "Required")
                        {
                            UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["companyid"] + "')\" > <i class='fas fa-trash-alt' style='color:red;' aria-hidden='true'></i></a></td>";
                        }
                        else
                        {
                            UnreadText += "		 <a  href='#'> <i class='fas fa-ban' aria-hidden='true'></i></a></td>";
                        }
                        //UnreadText += "<td></td>";
                        UnreadText += "		</tr>";
                    }
                    tlist.InnerHtml = UnreadText;
                    Panel1.Visible = true;
                }
                else
                {
                    Panel1.Visible = false;
                    lblmessage.Text = "No Records Found";
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }

        protected void BtnClose_Click(object sender, EventArgs e)
        {
            ClearInputValues();
        }
        private void ClearInputValues()
        {
            try
            {
                hCmpflag.Value = "New";
                txtcompany.Text = "";
                txtadd1.Text = "";
                txtadd2.Text = "";
                txtcity.Text = "";
                txtpincode.Text = "";
                txtcolorlogo.Text = "";
                txtblacklogo.Text = "";
                txtpanno.Text = "";
                ddlunitstatus.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }

        protected void btncmpdelete_Click(object sender, EventArgs e)
        {
            try
            {
                string CompanyId = hcompanyid.Value;
                ObjDBAccess1.DeleteCompanyById(CompanyId);
                LoadCompanies();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            try
            {
                string flag = hCmpflag.Value.ToString();
                string companyname = txtcompany.Text;
                
                string add1 = txtadd1.Text;
                string add2 = txtadd2.Text;
                string city = txtcity.Text;
                string pincode = txtpincode.Text;
                string colorlogo = txtcolorlogo.Text;
                string blacklogo = txtblacklogo.Text;
                string panno = txtpanno.Text;
                string gstno = txtGSTno.Text;
                string status = ddlunitstatus.SelectedItem.Text;
                                
                //string Loginid = Session["profileid"].ToString();
                                
                string id = ObjDBAccess1.InsertCompanyMasterData(flag, companyname, add1, add2,city, pincode, colorlogo, blacklogo, panno,
                        gstno, status );

                hCmpflag.Value = "New";
                LoadCompanies();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }

    }
}