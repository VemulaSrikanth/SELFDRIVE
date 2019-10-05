using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class SupplierMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {

                //hcompanyid.Value = Session["Companyid"].ToString();
                huserprofile.Value = "New";
                
                LoadSuppliers();
            }
        }
        private void LoadSuppliers()
        {
            try
            {

                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllSuppliers(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {

                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {


                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["suppname"] + "</td>";
                        UnreadText += "<td>" + drverprof["contactname"] + "</td>";
                        UnreadText += "<td>" + drverprof["address1"] + "</td>";
                        UnreadText += "<td>" + drverprof["city"] + "</td>";
                        UnreadText += "<td>" + drverprof["contactphone"] + "</td>";


                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                            + drverprof["suppid"] + "','"
                            + drverprof["suppname"] + "','"
                            + drverprof["address1"] + "','"
                            + drverprof["address2"] + "','"
                            + drverprof["city"] + "','"
                            + drverprof["contactname"] + "','"
                            + drverprof["contactemailid"] + "','"
                            + drverprof["contactphone"] + "','"
                            + drverprof["gstid"] + "','"
                            + drverprof["gstin"] + "','"
                            + drverprof["gststatus"] + "','"
                             + drverprof["tdsperc"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["suppid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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

                txtsuppliername.Text = "";
                txtAddress1.Text = "";
                txtAddress2.Text = "";
                txtCity.Text = "";
                txtcontactname.Text = "";
                txtEmail.Text = "";
                txtPhno.Text = "";



                ddlstatus.SelectedIndex = 0;

                txtgstid.Text = "";
                txtgstin.Text = "";

                txttdsPerc.Text = "";


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
                string supplierid = huserprofile.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteSupplierById(supplierid, CompanyId);
                LoadSuppliers();
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
                string supplierid = huserprofile.Value.ToString();
                string CompanyId = Session["companyid"].ToString();
                string suppliername = txtsuppliername.Text;
                string Address1 = txtAddress1.Text;
                string Address2 = txtAddress2.Text;

                string city = txtCity.Text;
                string gststatus = ddlstatus.SelectedValue;

                string contactname = txtcontactname.Text;
                string contactemail = txtEmail.Text;
                string Phonenum = txtPhno.Text;

                string gstid = txtgstid.Text;

                string gstin = txtgstin.Text;
                string tdsperc = txttdsPerc.Text;

                //Int32 IsCount = ObjDBAccess1.UserNameIsExist(ProfileId, CompanyId, LoginEmail);
                //if (IsCount == 0)
                //{
                //    string Id = ObjDBAccess1.InsertUserProfile(ProfileId, ProfileId, EmployeeName, EmployeeId, LoginEmail, PassWord,
                //        ConfirmPassword, ModifiedPrivilege, DeletePrivilege, UserType, Status, Masters, Transactions,
                //        Hr, Accounts, Reports, Admin, AdminActivity, CompanyId);
                //}

                string Flag = string.Empty;
                if (supplierid != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InsertSupplierMasterData(Flag, supplierid, suppliername, Address1, Address2, city, contactname, contactemail, Phonenum, gstid, gstin, gststatus, Convert.ToDouble(tdsperc), CompanyId);

                huserprofile.Value = "New";

                LoadSuppliers();
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}