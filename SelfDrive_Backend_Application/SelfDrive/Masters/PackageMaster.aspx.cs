using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive.Masters
{
    public partial class PackageMaster : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {
                hcompanyid.Value = Session["Companyid"].ToString();
                htariffid.Value = "New";
                DataTable dtvehiclemake = ObjDBAccess1.GetAllActiveVehicleSegments(Session["companyid"].ToString());
                if (dtvehiclemake != null && dtvehiclemake.Rows.Count > 0)
                {
                    ddlVehicleseg.DataSource = dtvehiclemake;
                    ddlVehicleseg.DataTextField = "vehsegname";
                    ddlVehicleseg.DataValueField = "vehsegid";
                    ddlVehicleseg.DataBind();
                    ddlVehicleseg.Items.Insert(0, new ListItem("Select", "Select"));
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

                LoadPackages();
            }
        }

        private void LoadPackages()
        {
            try
            {
                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllPackages(Session["companyid"].ToString());

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {
                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["packagename"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehsegname"] + "</td>";
                        UnreadText += "<td>" + drverprof["slname"] + "</td>";
                        UnreadText += "<td>" + drverprof["allowedkms"] + "</td>";
                        UnreadText += "<td>" + drverprof["allowedhrs"] + "</td>";
                        UnreadText += "<td>" + drverprof["basicrate"] + "</td>";
                        UnreadText += "<td>" + drverprof["ratetype"] + "</td>";
                        UnreadText += "<td>" + drverprof["securitydeposit"] + "</td>";
                        UnreadText += "<td>" + drverprof["fuelcoststatus"] + "</td>";
                        UnreadText += "<td>" + drverprof["tariffstatus"] + "</td>";

                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
                           + drverprof["tariffid"] + "','"
                            + drverprof["segid"] + "','"
                            + drverprof["packagename"] + "','"
                            + drverprof["basicrate"] + "','"
                            + drverprof["ratetype"] + "','"
                            + drverprof["securitydeposit"] + "','"
                            + drverprof["fuelcoststatus"] + "','"
                            + drverprof["slid"] + "','"
                            + drverprof["tariffstatus"] + "','"
                             + drverprof["allowedkms"] + "','"
                             + drverprof["allowedhrs"] + "','"
                             + drverprof["gracehrs"] + "','"
                             + drverprof["gracehrrate"] + "','"
                             + drverprof["extrakmrate"] + "','"
                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["tariffid"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string tariffid = htariffid.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeletePackageById(tariffid, CompanyId);
                LoadPackages();
                ClearInputValues();
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
                htariffid.Value = "New";

                ddlRatetype.SelectedIndex = 0;
                ddlVehicleseg.SelectedIndex = 0;
                ddlLocation.SelectedIndex = 0;
                ddlfuelstatus.SelectedIndex = 0;
                ddlstatus.SelectedIndex = 0;
                
                txtpackagename.Text = "";
                txtBasicRate.Text = "";
                txtalwhrs.Text = "";
                txtalwkms.Text = "";
                txtExtraKmRate.Text = "";
                txtgracehrRate.Text = "";
                txtgracehrs.Text = "";
                txtSecDeposit.Text = "";
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
                string tariffid = htariffid.Value.ToString();
                string CompanyId = Session["companyid"].ToString();
                
                string vehSegid = ddlVehicleseg.SelectedValue;
                string SerLocid = ddlLocation.SelectedValue;
                string ratetype = ddlRatetype.SelectedValue;
                string fuelstatus = ddlfuelstatus.SelectedValue;
                string status = ddlstatus.SelectedValue;

                string packagename = txtpackagename.Text;
                string basicrate = txtBasicRate.Text;
                string alwhrs = txtalwhrs.Text;
                string alwkms = txtalwkms.Text;
                string ExtraKmRate = txtExtraKmRate.Text;
                string gracehrRate = txtgracehrRate.Text;
                string gracehrs = txtgracehrs.Text;
                string SecDeposit = txtSecDeposit.Text;
                string Preparedby = "UP001";
                                
                string Flag = string.Empty;
                if (tariffid != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }
                string id = ObjDBAccess1.InserPackageMasterData(Flag, tariffid, packagename, status, SerLocid, vehSegid, Preparedby,Convert.ToInt16(alwkms), Convert.ToDouble(alwhrs), Convert.ToDouble(gracehrs), Convert.ToDouble(gracehrRate), Convert.ToDouble(ExtraKmRate), Convert.ToDouble(basicrate),ratetype, fuelstatus, Convert.ToDouble(SecDeposit), CompanyId);

                htariffid.Value = "New";
                if (id == "2")
                {
                    lblmessage.Text = "Sorry! Package already exists.";
                }
                else
                {
                    lblmessage.Text = "";
                    LoadPackages();
                }
                ClearInputValues();
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}