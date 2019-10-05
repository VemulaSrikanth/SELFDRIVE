using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive
{
    public partial class Index : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {
                hcompanyid.Value = Session["Companyid"].ToString();
                hbookingId.Value = "New";
                
                txtFromDateL.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                txtToDateL.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                hfromdateL.Value = DateTime.Now.ToString("dd-MMM-yyyy");
                htodateL.Value = DateTime.Now.ToString("dd-MMM-yyyy");
                DataTable dtdetails = ObjDBAccess1.GetAllActiveLocations(Session["companyid"].ToString());
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    ddlLocation.DataSource = dtdetails;
                    ddlLocation.DataTextField = "slname";
                    ddlLocation.DataValueField = "slid";
                    ddlLocation.DataBind();
                    ddlLocation.Items.Insert(0, new ListItem("All", "All"));
                }

            }
         }

        protected void btnload_Click(object sender, EventArgs e)
        {
            LoadBookings();
        }

        private void LoadBookings()
        {
            try
            {
                //string DeletePer = Session["delete_login"].ToString();
                lblmessage.Text = "";
                DateTime fromdate = Convert.ToDateTime(hfromdateL.Value);
                DateTime todate = Convert.ToDateTime(htodateL.Value);

                DataTable dtdetails = ObjDBAccess1.GetSelBookings(Session["companyid"].ToString(), fromdate, todate,ddlBookingStatus.SelectedValue,ddlLocation.SelectedValue);

                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {

                        UnreadText += "<tr>";
                        //bookingid, segid, slid,vehmakeid, status, customername, bookingdate, bookedby, BookedMobileno, BookedEmail, GuestMobile, GuestName, GuestEmail, FromDate, Todate, AdvAmt, discstatus, discount, SecDepStatus,SecDepAmt, companyid
                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#' title='Edit' onclick= \"FillDetails('"
                           + drverprof["bookingId"] + "','"
                            + drverprof["vehsegid"] + "','"
                            + drverprof["slid"] + "','"
                            + drverprof["vehmakeid"] + "','"
                            + drverprof["bookingstatus"] + "','"
                            + drverprof["customername"] + "','"
                            + Convert.ToDateTime(drverprof["bookingdate"]).ToString("dd-MMM-yyyy") + "','"
                            + drverprof["bookedby"] + "','"
                            + drverprof["BookedbyMobile"] + "','"
                             + drverprof["bookedbyemail"] + "','"
                             + drverprof["GuestMobile"] + "','"
                             + drverprof["guest"] + "','"
                             + drverprof["GuestEmail"] + "','"
                             + Convert.ToDateTime(drverprof["Fromdate"]).ToString("dd-MMM-yyyy") + "','"

                             + Convert.ToDateTime(drverprof["Todate"]).ToString("dd-MMM-yyyy") + "','"
                             + drverprof["AdvanceAmt"] + "','"
                             + drverprof["discstatus"] + "','"
                             + drverprof["discount"] + "','"
                             + drverprof["SecDepStatus"] + "','"
                             + drverprof["SecDepAmt"] + "','"
                              + drverprof["tariffid"] + "','"
                               + drverprof["accessoriesStatus"] + "','"
                               + drverprof["accsids"] + "','"
                               + drverprof["fromtime1"] + "','"
                               + drverprof["totime1"] + "','"

                            + drverprof["companyid"] + "')\" > <i style='padding-right:20px;' class='fas fa-edit' aria-hidden='true'></i></a>";

                        UnreadText += "<a  href='#' title='Delete' onclick= \"DeleteMe('" + drverprof["bookingId"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
                        //UnreadText += "<td></td>";
                        
                        UnreadText += "<td>" + Convert.ToDateTime(drverprof["Fromdate"]).ToString("dd-MMM-yyyy") + "</td>";
                        UnreadText += "<td>" + drverprof["fromtime1"] + "</td>";
                        UnreadText += "<td>" + drverprof["customerid"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehsegname"] + "</td>";
                        UnreadText += "<td>" + drverprof["dsno"] + "</td>";
                        UnreadText += "<td>" + drverprof["vehno"] + "</td>";
                        
                        
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
                txtFromDateL.Text = hfromdateL.Value;
                txtToDateL.Text = htodateL.Value;
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
        }
    }
}