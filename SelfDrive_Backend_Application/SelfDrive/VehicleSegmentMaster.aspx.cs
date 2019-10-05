using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class VehicleSegmentMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {
               
                //hcompanyid.Value = Session["Companyid"].ToString();
                huserprofile.Value = "New";
                LoadVehSegments();
            }
        }
        private void LoadVehSegments()
        {
            try
            {

                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllVehicleMaster(Session["companyid"].ToString());
               
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {
                        
                        int AccVehCount = Convert.ToInt32(drverprof["AccVehSegCount"]);
                        int MakeVehCount = Convert.ToInt32(drverprof["MakeVehSegCount"]);
                        
                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehsegname"] + "</td>";
                   
                        UnreadText += "<td>" + drverprof["status"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                            + drverprof["vehsegid"] + "','"
                            + drverprof["vehsegname"] + "','"
                            + drverprof["status"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        if (AccVehCount == 0 && MakeVehCount == 0)
                        {
                            UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["vehsegid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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
                huserprofile.Value = "New";
                
                txtvehiclesegname.Text = "";
                
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
                string Vehsegid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteVehicleSegById(Vehsegid, CompanyId);
                LoadVehSegments();
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
                string VehicleSegname = txtvehiclesegname.Text;
                
               
                string Status = ddlprofilestatus.SelectedItem.Text;



                //Int32 IsCount = ObjDBAccess1.UserNameIsExist(ProfileId, CompanyId, LoginEmail);
                //if (IsCount == 0)
                //{
                //    string Id = ObjDBAccess1.InsertUserProfile(ProfileId, ProfileId, EmployeeName, EmployeeId, LoginEmail, PassWord,
                //        ConfirmPassword, ModifiedPrivilege, DeletePrivilege, UserType, Status, Masters, Transactions,
                //        Hr, Accounts, Reports, Admin, AdminActivity, CompanyId);
                //}

                string Flag = string.Empty;
                if(ProfileId != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InsertVehicleSegMasterData(Flag, ProfileId, VehicleSegname, Status, CompanyId);

                huserprofile.Value = "New";

                LoadVehSegments();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}