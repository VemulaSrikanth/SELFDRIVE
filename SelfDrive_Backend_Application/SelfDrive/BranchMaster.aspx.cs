using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace SelfDrive
{
    public partial class BranchMaster : System.Web.UI.Page
    {
        
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {

                //hcompanyid.Value = Session["Companyid"].ToString();
                huserprofile.Value = "New";

                DataTable dtdetails = ObjDBAccess1.GetAllActiveLocations(Session["companyid"].ToString());
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    ddlLocation.DataSource = dtdetails;
                    ddlLocation.DataTextField = "slname";
                    ddlLocation.DataValueField = "slid";
                    ddlLocation.DataBind();
                    ddlLocation.Items.Insert(0, new ListItem("Select", "Select"));
                }


                LoadBranches();
            }
        }
        private void LoadBranches()
        {
            try
            {

                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllBranches(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {


                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["brname"] + "</td>";
                        UnreadText += "<td>" + drverprof["brcode"] + "</td>";
                        UnreadText += "<td>" + drverprof["slname"] + "</td>";
                        UnreadText += "<td>" + drverprof["address1"] + "</td>";
                        UnreadText += "<td>" + drverprof["phoneno"] + "</td>";

                        UnreadText += "<td>" + drverprof["brstatus"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                            + drverprof["brid"] + "','"
                            + drverprof["brname"] + "','"
                            + drverprof["slid"] + "','"
                            + drverprof["brcode"] + "','"
                            + drverprof["address1"] + "','"
                            + drverprof["address2"] + "','"
                            + drverprof["pincode"] + "','"
                            + drverprof["phoneno"] + "','"
                            + drverprof["longitude"] + "','"
                            + drverprof["latitude"] + "','"
                            + drverprof["brstatus"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["brid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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
                huserprofile.Value = "New";

                txtbranchname.Text = "";

                txtcode.Text = "";
                ddlLocation.SelectedIndex = 0;
                ddlstatus.SelectedIndex = 0;
                txtAddress1.Text = "";
                txtAddress2.Text = "";
                txtlatitude.Text = "";
                txtlongitude.Text = "";
                txtPhno.Text = "";
                txtpincode.Text = "";


            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }



        protected void btnUserProfileDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string branchid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteBranchById(branchid, CompanyId);
                LoadBranches();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }

        protected void btnsave_Click1(object sender, EventArgs e)
        {
            try
            {
                string branchid = huserprofile.Value.ToString();
                string CompanyId = Session["companyid"].ToString();
                string branchname = txtbranchname.Text;
                string slid = ddlLocation.SelectedValue;

                string brcode = txtcode.Text;
                string status = ddlstatus.SelectedValue;

                string Address1 = txtAddress1.Text;
                string Address2 = txtAddress2.Text;

                string PinCode = txtpincode.Text;
                string Phonenum = txtPhno.Text;

                double longitude = 0;
                double latitude = 0;
                 if(txtlongitude.Text.Length > 0)
                {
                    longitude = Convert.ToDouble(txtlongitude.Text);
                }
                if (txtlatitude.Text.Length > 0)
                {
                    latitude = Convert.ToDouble(txtlatitude.Text);
                }

                
                string Flag = string.Empty;
                if (branchid != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InsertBranchMasterData(Flag, branchid, branchname, slid, brcode, Address1, Address2, PinCode, Phonenum, longitude, latitude, status, CompanyId);

                huserprofile.Value = "New";

                LoadBranches();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}