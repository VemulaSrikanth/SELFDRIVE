using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class ServiceLocationMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {

                //hcompanyid.Value = Session["Companyid"].ToString();
                huserprofile.Value = "New";

                DataTable dtdetails = ObjDBAccess1.GetAllStates(Session["companyid"].ToString());
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    ddlState.DataSource = dtdetails;
                    ddlState.DataTextField = "statename";
                    ddlState.DataValueField = "stateid";
                    ddlState.DataBind();
                    ddlState.Items.Insert(0, new ListItem("Select", "Select"));
                }

               
                LoadLocations();
            }
        }
        private void LoadLocations()
        {
            try
            {

                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllLocationsMaster(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {


                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["slname"] + "</td>";
                        UnreadText += "<td>" + drverprof["statename"] + "</td>";
                        UnreadText += "<td>" + drverprof["slcode"] + "</td>";
                        UnreadText += "<td>" + drverprof["slstatus"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                            + drverprof["slid"] + "','"
                            + drverprof["stateid"] + "','"
                            + drverprof["slname"] + "','"
                            + drverprof["slcode"] + "','"
                            + drverprof["slstatus"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["slid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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

                txtlocationname.Text = "";

                txtcode.Text = "";
                ddlState.SelectedIndex = 0;
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
                string locationid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteLocationById(locationid, CompanyId);
                LoadLocations();
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
                string LocationID = huserprofile.Value.ToString();
                string CompanyId = Session["companyid"].ToString();
                string LocationName = txtlocationname.Text;
                string stateid = ddlState.SelectedValue;

                string locationcode = txtcode.Text;
                string status = ddlstatus.SelectedValue;



                //Int32 IsCount = ObjDBAccess1.UserNameIsExist(ProfileId, CompanyId, LoginEmail);
                //if (IsCount == 0)
                //{
                //    string Id = ObjDBAccess1.InsertUserProfile(ProfileId, ProfileId, EmployeeName, EmployeeId, LoginEmail, PassWord,
                //        ConfirmPassword, ModifiedPrivilege, DeletePrivilege, UserType, Status, Masters, Transactions,
                //        Hr, Accounts, Reports, Admin, AdminActivity, CompanyId);
                //}

                string Flag = string.Empty;
                if (LocationID != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InsertLocationMasterData(Flag, LocationID, LocationName, stateid , locationcode, status, CompanyId);

                huserprofile.Value = "New";

                LoadLocations();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}