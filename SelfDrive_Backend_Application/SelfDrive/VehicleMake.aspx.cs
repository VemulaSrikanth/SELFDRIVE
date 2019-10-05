using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SelfDrive
{
    public partial class VehicleMake : System.Web.UI.Page
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
                    ddlVehicles.DataSource = dtdetails;
                    ddlVehicles.DataTextField = "vehsegname";
                    ddlVehicles.DataValueField = "vehsegid";
                    ddlVehicles.DataBind();
                    ddlVehicles.Items.Insert(0, new ListItem("Select", "Select"));
                }
                LoadVehicleMake();
            }
        }
        private void LoadVehicleMake()
        {
            try
            {

                lblmessage.Text = "";
                //string DeletePer = Session["delete_login"].ToString();
                string DeletePer = "Required";
                DataTable dtdetails = ObjDBAccess1.GetAllVehicleMakeMaster(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {

                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehmake"] + "</td>";
                        UnreadText += "<td>" + drverprof["acnonac"] + "</td>";
                        UnreadText += "<td>" + drverprof["status"] + "</td>";
                        UnreadText += "<td>" + drverprof["VehicleNames"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                            + drverprof["vehmakeid"] + "','"
                            + drverprof["vehmake"] + "','"
                            + drverprof["status"] + "','"
                            + drverprof["acnonac"] + "','"
                            + drverprof["vehsegid"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        //if (DeletePer == "Required")
                        //{
                        //    UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["vehmakeid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a>";
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

                txtvehmakename.Text = "";
                ddlAcNonAc.SelectedIndex = 0;
                ddlVehicles.SelectedIndex = 0;

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
                string vehmakeid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeletevehicleMakeMasterById(vehmakeid, CompanyId);
                LoadVehicleMake();
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
                string vehmakename = txtvehmakename.Text;

                string AcNonAc = ddlAcNonAc.SelectedItem.Text;
                string Status = ddlprofilestatus.SelectedItem.Text;

                string VehicleSegID = string.Empty;
                VehicleSegID = ddlVehicles.SelectedValue;

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
                string id = ObjDBAccess1.InsertVehMakeMasterData(Flag, ProfileId, vehmakename, AcNonAc, Status, VehicleSegID, CompanyId);

                huserprofile.Value = "New";

                LoadVehicleMake();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}