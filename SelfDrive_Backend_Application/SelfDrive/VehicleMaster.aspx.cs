using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class VehicleMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {

                hcompanyid.Value = Session["Companyid"].ToString();
                huserprofile.Value = "New";

                DataTable dtsuppliers = ObjDBAccess1.GetAllSuppliers(Session["companyid"].ToString());
                if (dtsuppliers != null && dtsuppliers.Rows.Count > 0)
                {
                    ddlSupplier.DataSource = dtsuppliers;
                    ddlSupplier.DataTextField = "suppname";
                    ddlSupplier.DataValueField = "suppid";
                    ddlSupplier.DataBind();
                    ddlSupplier.Items.Insert(0, new ListItem("Select", "Select"));
                }
                DataTable dtvehiclemake = ObjDBAccess1.GetAllActiveVehicleMakeMaster(Session["companyid"].ToString());
                if (dtvehiclemake != null && dtvehiclemake.Rows.Count > 0)
                {
                    ddlVehicleMake.DataSource = dtvehiclemake;
                    ddlVehicleMake.DataTextField = "vehmake";
                    ddlVehicleMake.DataValueField = "vehmakeid";
                    ddlVehicleMake.DataBind();
                    ddlVehicleMake.Items.Insert(0, new ListItem("Select", "Select"));
                }

                DataTable dtdetails = ObjDBAccess1.GetAllActiveLocations(Session["companyid"].ToString());
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    ddlLocation.DataSource = dtdetails;
                    ddlLocation.DataTextField = "slname";
                    ddlLocation.DataValueField = "slid";
                    ddlLocation.DataBind();
                    ddlLocation.Items.Insert(0, new ListItem("Select", "Select"));
                }
                ddlbranch.Items.Insert(0, new ListItem("Select", "Select"));
                LoadVehicleMaster();
            }
        }
        private void LoadVehicleMaster()
        {
            try
            {
                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllVehicleMasterWithVehiclemake(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {
                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["suppname"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehmake"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehicleregno"] + "</td>";
                        UnreadText += "<td>" + drverprof["avgmileage"] + "</td>";
                        UnreadText += "<td>" + drverprof["engineno"] + "</td>";
                        UnreadText += "<td>" + drverprof["chasisno"] + "</td>";
                        UnreadText += "<td>" + drverprof["slname"] + "</td>";
                        UnreadText += "<td>" + drverprof["brname"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehstatus"] + "</td>";
                        
                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                           + drverprof["vrid"] + "','"
                            + drverprof["supplied"] + "','"
                            + drverprof["vehmakeid"] + "','"
                            + drverprof["vehicleregno"] + "','"
                            + drverprof["avgmileage"] + "','"
                            + drverprof["engineno"] + "','"
                            + drverprof["chasisno"] + "','"
                            + drverprof["slid"] + "','"
                            + drverprof["brid"] + "','"
                             + drverprof["vehstatus"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["vrid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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

        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            string slid = ddlLocation.SelectedItem.Value;
            string vehno = txtvehno.Text;
            if (slid != "Select")
            {
                DataTable dt = ObjDBAccess1.GetAllActiveBranches(Session["companyid"].ToString(), slid);
                if (dt != null && dt.Rows.Count > 0)
                {
                    ddlbranch.Items.Clear();
                    ddlbranch.DataSource = dt;
                    ddlbranch.DataTextField = "brname";
                    ddlbranch.DataValueField = "brid";
                    ddlbranch.DataBind();
                    ddlbranch.Items.Insert(0, new ListItem("Select", "Select"));
                }
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

                ddlSupplier.SelectedIndex = 0;
                ddlVehicleMake.SelectedIndex = 0;
                ddlLocation.SelectedIndex = 0;
                ddlbranch.SelectedIndex = 0;

                txtvehno.Text = "";
                txtavgmilage.Text = "";
                txtchasisno.Text = "";
                txtengineno.Text = "";
                
                ddlstatus.SelectedIndex = 0;
                

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
                string vrid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteVehMasterById(vrid, CompanyId);
                LoadVehicleMaster();
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
                string vrid = huserprofile.Value.ToString();
                string CompanyId = Session["companyid"].ToString();

                string supplier = ddlSupplier.SelectedValue;
                string vehmake = ddlVehicleMake.SelectedValue;
                string SerLocid = ddlLocation.SelectedValue;
                //string Branchid = ddlbranch.SelectedValue;
                string Branchid = hbrid.Value;

                string vehno = txtvehno.Text;
                string avgmilage = txtavgmilage.Text;
                string chasisno = txtchasisno.Text;

                string engineno = txtengineno.Text;

                string status = ddlstatus.SelectedValue;
                
                //Int32 IsCount = ObjDBAccess1.UserNameIsExist(ProfileId, CompanyId, LoginEmail);
                //if (IsCount == 0)
                //{
                //    string Id = ObjDBAccess1.InsertUserProfile(ProfileId, ProfileId, EmployeeName, EmployeeId, LoginEmail, PassWord,
                //        ConfirmPassword, ModifiedPrivilege, DeletePrivilege, UserType, Status, Masters, Transactions,
                //        Hr, Accounts, Reports, Admin, AdminActivity, CompanyId);
                //}

                string Flag = string.Empty;
                if (vrid != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InsertVehMasterData(Flag, vrid, supplier, vehmake, vehno, Convert.ToDouble(avgmilage), chasisno, engineno,status, CompanyId,SerLocid,Branchid);

                huserprofile.Value = "New";

                LoadVehicleMaster();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}