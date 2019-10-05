using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SelfDrive.Transactions
{
    public partial class SDBooking : System.Web.UI.Page
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["companyid"] = "CMP00001";
            if (!IsPostBack)
            {
                hcompanyid.Value = Session["Companyid"].ToString();
                hbookingId.Value = "New";
                txtbookingdate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                txtFromDate.Text= DateTime.Now.ToString("dd-MMM-yyyy");
                txtToDate.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                txtfromtime.Text = DateTime.Now.ToString("H.m");
                txttotime.Text = DateTime.Now.ToString("H.m");

                txtFromDateL.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                txtToDateL.Text = DateTime.Now.ToString("dd-MMM-yyyy");
                hfromdateL.Value = DateTime.Now.ToString("dd-MMM-yyyy");
                htodateL.Value = DateTime.Now.ToString("dd-MMM-yyyy");


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

                LoadBookings();
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
                DateTime fromdate = Convert.ToDateTime(hfromdateL.Value);
                DateTime todate = Convert.ToDateTime(htodateL.Value);

                lblmessage.Text = "";
                DataTable dtdetails = ObjDBAccess1.GetAllBookings(Session["companyid"].ToString(),fromdate,todate);
                
                if (dtdetails != null && dtdetails.Rows.Count > 0)
                {
                    String UnreadText = "";
                    foreach (DataRow drverprof in dtdetails.Rows)
                    {
                        UnreadText += "<tr>";
                        //UnreadText += "<td style='display: none;'>" + drverprof["profileid"] + "</td>";
                        UnreadText += "<td>" + drverprof["bookingId"] + "</td>";
                        UnreadText += "<td>" + Convert.ToDateTime(drverprof["bookingdate"]).ToString("dd-MMM-yyyy") + "</td>";
                        UnreadText += "<td>" + drverprof["slname"] + "</td>";
                        UnreadText += "<td>" + drverprof["customername"] + "</td>";
                        UnreadText += "<td>" + Convert.ToDateTime(drverprof["Fromdate"]).ToString("dd-MMM-yyyy") + "</td>";
                        UnreadText += "<td>" + Convert.ToDateTime(drverprof["Todate"]).ToString("dd-MMM-yyyy") + "</td>";
                        UnreadText += "<td>" + drverprof["vehsegname"] + "</td>";
                        UnreadText += "<td>" + drverprof["bookingstatus"] + "</td>";
                        UnreadText += "<td>" + drverprof["dutyclosestatus"] + "</td>";

                        //bookingid, segid, slid,vehmakeid, status, customername, bookingdate, bookedby, BookedMobileno, BookedEmail, GuestMobile, GuestName, GuestEmail, FromDate, Todate, AdvAmt, discstatus, discount, SecDepStatus,SecDepAmt, companyid
                        UnreadText += "<td style='text-align:center;'><a data-toggle='modal' data-target='.bs-example-modal-lg' href='#'  onclick= \"FillDetails('"
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

                        UnreadText += "<a  href='#'  onclick= \"DeleteMe('" + drverprof["bookingId"] + "')\" > <i class='fas fa-trash-alt' aria-hidden='true'></i></a></td>";
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
                txtFromDateL.Text = hfromdateL.Value;
                txtToDateL.Text = htodateL.Value;
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
                string bookingid = hbookingId.Value;
                string CompanyId = Session["companyid"].ToString();
                ObjDBAccess1.DeleteBookingById(bookingid, CompanyId);
                LoadBookings();
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
                hbookingId.Value = "New";
                
                //ddlVehicleseg.SelectedIndex = 0;
                //ddlLocation.SelectedIndex = 0;
                //ddlVehicleMake.SelectedIndex = 0;
                //ddlDiscStatus.SelectedIndex = 0;
                //ddlSecDepStatus.SelectedIndex = 0;
                //ddlstatus.SelectedIndex = 0;

                //txtcustomer.Text = "";
                //txtbookedby.Text = "";
                
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
                string bookingid = hbookingId.Value.ToString();
                string customerid = txtcustomer.Text;
                DateTime bookingdate = Convert.ToDateTime(hbookingdate.Value);
                DateTime fromdate = Convert.ToDateTime(hfromdate.Value);
                DateTime todate = Convert.ToDateTime(htodate.Value);
                string Dfromtime = txtfromtime.Text;
                TimeSpan fromtime = TimeSpan.Parse(Dfromtime.Replace(".",":")); //DateTime.Now.TimeOfDay;//DateTime.Now.ToString("HH:mm:ss tt");
                string Dtotime = txttotime.Text;
                TimeSpan totime = TimeSpan.Parse(Dtotime.Replace(".", ":")); //DateTime.Now.TimeOfDay;
                string CompanyId = Session["companyid"].ToString();

                string vehSegid = ddlVehicleseg.SelectedValue;
                string SerLocid = ddlLocation.SelectedValue;
                string vehmakeid = hvehmakeid.Value;
                string secdepstatus = ddlSecDepStatus.SelectedValue;
                double SecDepAmt = 0;
                if (secdepstatus == "required")
                {
                    if (txtSecDepAmt.Text.Length > 0)
                    {
                        SecDepAmt = Convert.ToDouble(txtSecDepAmt.Text);
                    }
                }
                string discstatus = ddlDiscStatus.SelectedValue;
                string status = ddlstatus.SelectedValue;
                
                string bookedby = txtbookedby.Text;
                string bookedbymobile = txtBookedMobileno.Text;
                string bookedbyemail = txtBookedEmail.Text;
                string guest = txtGuest.Text;
                string guestmobile = txtGuestMobile.Text;
                string guestemail = txtGuestEmail.Text;
                double AdvanceAmt = 0;
                if (txtAdvAmt.Text.Length > 0)
                {
                    AdvanceAmt = Convert.ToDouble(txtAdvAmt.Text);
                }
                double discount = 0;
                if (txtdiscount.Text.Length > 0)
                {
                    discount = Convert.ToDouble(txtdiscount.Text);
                }

                string tariffid = hseltariffid.Value;
                string accessoriesStatus = ddlAccessoriesStatus.SelectedValue;
                string accids = haccids.Value;

                string Preparedby = "UP001";

                string Flag = string.Empty;
                if (bookingid != "New")
                {
                    Flag = "Edit";
                }
                else
                {
                    Flag = "Add";
                }

                //string Flag, string bookingid, DateTime bookingdate, string customerid, DateTime fromdate, DateTime Todate, TimeSpan fromtime, TimeSpan Totime, string vehsegid,string status,
            //string slid,string vehmakeid,string bookedby, string bookedbymobile,string bookedbyemail,string guest,string guestmobile,string guestEmail,
           // double AdvanceAmt,string discstatus, double discount, string SecDepStatus,double SecDepAmt, string preparedbyid, string CompanyId

                string id = ObjDBAccess1.InsertBookingData(Flag, bookingid, bookingdate, customerid,fromdate,todate,fromtime,totime, vehSegid, status, 
                    SerLocid, vehmakeid, bookedby, bookedbymobile,  bookedbyemail, guest, guestmobile, guestemail,
                    AdvanceAmt, discstatus, discount, secdepstatus, SecDepAmt, Preparedby, CompanyId,tariffid, accessoriesStatus, accids);

                hbookingId.Value = "New";
                if (id == "2")
                {
                    lblmessage.Text = "Sorry! Booking already exists.";
                }
                else
                {
                    lblmessage.Text = "";
                    LoadBookings();
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