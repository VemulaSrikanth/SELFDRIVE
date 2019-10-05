using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class AccessoriesMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {

                //hcompanyid.Value = Session["Companyid"].ToString();
                huserprofile.Value = "New";
                DataTable dtdetails = ObjDBAccess1.GetAllVehicleMaster(Session["companyid"].ToString());
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    chkVehicles.DataSource = dtdetails;
                    chkVehicles.DataTextField = "vehsegname";
                    chkVehicles.DataValueField = "vehsegid";
                    chkVehicles.DataBind();
                }
                LoadAccessories();
            }
        }
        private void LoadAccessories()
        {
            try
            {
                lblmessage.Text = "";

                //string DeletePer = Session["delete_login"].ToString();
                string DeletePer = "Required";
                DataTable dtdetails = ObjDBAccess1.GetAllAccessoriesMaster(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {

                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["accsname"] + "</td>";
                        UnreadText += "<td>" + drverprof["accsdescription"] + "</td>";
                        UnreadText += "<td>" + drverprof["status"] + "</td>";
                        UnreadText += "<td>" + drverprof["VehicleNames"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                            + drverprof["accsid"] + "','"
                            + drverprof["accsname"] + "','"
                            + drverprof["status"] + "','"
                            + drverprof["accsdescription"] + "','"
                            + drverprof["vehsegids"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        //if (DeletePer == "Required")
                        //{
                        //    UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["accsid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a>";
                        //}
                        //else
                        //{
                        //    UnreadText += "		 <a  href='#'> <i class='fas fa-ban' aria-hidden='true'></i></a>";
                        //}
                        //UnreadText += "<td></td>";
                        UnreadText += "		</td></tr>";
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

                txtaccessname.Text = "";
                txtDescription.Text = "";
                for (int i = 0; i < chkVehicles.Items.Count; i++)
                {
                   chkVehicles.Items[i].Selected = false;
                    
                }

                ddlprofilestatus.SelectedIndex = 0;

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
                string accid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteAccessoriesMasterById(accid, CompanyId);
                LoadAccessories();
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
                string ProfileId = huserprofile.Value.ToString();
                string CompanyId = Session["companyid"].ToString();
                string Accessname = txtaccessname.Text;

                string AccessDesc = txtDescription.Text;
                string Status = ddlprofilestatus.SelectedItem.Text;

                string items = string.Empty;
                foreach (ListItem i in chkVehicles.Items)
                {
                    if (i.Selected == true)
                    {
                        items += i.Value + ",";
                    }
                }
                if(items.Length > 0)
                {
                    items = items.Remove(items.Length - 1);
                }

                //Int32 IsCount = ObjDBAccess1.UserNameIsExist(ProfileId, CompanyId, LoginEmail);
                //if (IsCount == 0)
                //{
                //    string Id = ObjDBAccess1.InsertUserProfile(ProfileId, ProfileId, EmployeeName, EmployeeId, LoginEmail, PassWord,
                //        ConfirmPassword, ModifiedPrivilege, DeletePrivilege, UserType, Status, Masters, Transactions,
                //        Hr, Accounts, Reports, Admin, AdminActivity, CompanyId);
                //}

                string Flag = string.Empty;
                if (ProfileId != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InsertAccessoriesMasterData(Flag, ProfileId, Accessname, AccessDesc, Status, items, CompanyId);

                huserprofile.Value = "New";

                LoadAccessories();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}