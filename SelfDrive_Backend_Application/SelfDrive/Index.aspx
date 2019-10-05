<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SelfDrive.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <link href="../vendor/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="../vendor/bootstrap-datepicker.js"></script>
    <script type="text/javascript" class="init">
        $(document).ready(function () {

            $.fn.textWidth = function () {
                var html_org = $(this).html();
                var html_calc = '<span>' + html_org + '</span>';
                $(this).html(html_calc);
                var width = $(this).find('span:first').width();
                $(this).html(html_org);
                return width;
            };

            $('#tblbookings').on('draw.dt', function (e) {
                $('#tblbookings thead tr th').each(function (idx, ele) {
                    var xPos = parseInt((($(ele).textWidth())) + 15);
                    if ($(ele).text() == '') {
                        $(ele).css('display', 'none')
                    }
                    else {
                        $(ele).css('background-position-x', xPos + 'px')
                    }
                })
            });

            var table = $('#tblbookings').DataTable({
                "bPaginate": $('#tblbookings tbody tr').length > 10
            });
            $('#min, #max').keyup(function () {
                table.draw();
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            var date = new Date();
            var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());
            var stdate = new Date((date.getFullYear() - 1), date.getMonth(), date.getDate());
            
            $(document).ready(function () {
                $('#datepicker_FromdateL')
                    .datepicker({
                        autoclose: true,
                        //format: 'mm/dd/yyyy',
                        format: 'dd-M-yyyy',
                        todayHighlight: true,
                        //startDate: today,
                        changeMonth: true,
                        changeYear: true,
                        yearRange: 'c-2:c+2',
                        //endDate: end,
                        autoclose: true
                    })
            });

            $(document).ready(function () {
                $('#datepicker_TodateL')
                    .datepicker({
                        autoclose: true,
                        //format: 'mm/dd/yyyy',
                        format: 'dd-M-yyyy',
                        todayHighlight: true,
                        //startDate: today,
                        changeMonth: true,
                        changeYear: true,
                        yearRange: 'c-2:c+2',
                        //endDate: end,
                        autoclose: true
                    })
            });


            
        });
    </script>
     <script lang="javascript" type="text/javascript">
         function LoadValidation() {
             var flag = true;
             var errmsg = '';
             if (document.getElementById("<%= txtFromDateL.ClientID %>").value == "") {
                document.getElementById("<%= txtFromDateL.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                 document.getElementById("<%= txtFromDateL.ClientID %>").style.borderColor = "#ccc";
                 document.getElementById("<%= hfromdateL.ClientID %>").value = document.getElementById("<%= txtFromDateL.ClientID %>").value;
             }
             if (document.getElementById("<%= txtToDateL.ClientID %>").value == "") {
                document.getElementById("<%= txtToDateL.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                 document.getElementById("<%= txtToDateL.ClientID %>").style.borderColor = "#ccc";
                 document.getElementById("<%= htodateL.ClientID %>").value = document.getElementById("<%= txtToDateL.ClientID %>").value;
             }

             if (flag) {
                 return true;
             }
             else {
                 return false;
             }
         }
     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField runat="server" ID="hcompanyid" />
    <asp:HiddenField runat="server" ID="hbookingId" />
     <asp:HiddenField runat="server" ID="hfromdateL" />
     <asp:HiddenField runat="server" ID="htodateL" />
    <!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
				<div class="page-title">
				<h4><i class="icon-arrow-left52" style="transform: rotate(180deg);"></i> Welcome To Self Drive</h4>
			</div>
		</div> 
	</div>
    <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
	<!-- /page header -->

    <table align="center">
            <tr>
                <td>
                    <asp:Label ID="lblfdate" Text="From Date" runat="server" CssClass="commanlabels"></asp:Label>
                </td>
                <td>
                    <div class="input-group date" id="datepicker_FromdateL">
                        <asp:TextBox runat="server" ID="txtFromDateL" CssClass="form-control form-control1" autocomplete="off" Readonly="true"></asp:TextBox>
                        <span class="input-group-text input-group-addon add-on"><span class="fa fa-calendar-alt"></span></span>
                    </div>
                </td>
                <td>
                    <asp:Label ID="lbltdate" Text="To Date" runat="server" CssClass="commanlabels"></asp:Label>
                </td>
                <td colspan="2">
                    <div class="input-group date" id="datepicker_TodateL">
                        <asp:TextBox runat="server" ID="txtToDateL" CssClass="form-control form-control1" autocomplete="off" Readonly="true"></asp:TextBox>
                        <span class="input-group-text input-group-addon add-on"><span class="fa fa-calendar-alt"></span></span>
                    </div>
                </td>
                
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblbookingStatus" runat="server" Text="Booking Status" CssClass="commanlabels"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlBookingStatus" runat="server" CssClass="form-control form-control1">
                        <asp:ListItem Text="Pending Booking" Value="N" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Dispatched" Value="P" ></asp:ListItem>
                        <asp:ListItem Text="Both" Value="B"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <label for="exampleInputEmail1">Service Location</label>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control form-control1">
                                                </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btnload" Text="Load" runat="server" class="btn btn-success" OnClientClick="return LoadValidation();" OnClick="btnload_Click">
                    </asp:Button>
                </td>
            </tr>
        </table>
    <br />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_content">
                <div class="" role="tabpanel" data-example-id="togglable-tabs">
                    <div>
                        <asp:Panel runat="server" ID="Panel1">
                            <div>
                                <table id="tblbookings" class="table table-bordered">
                                    <thead>
                                        <tr class="bg-primary">
                                            <th style="width: 60px;">Options</th>
                                            <th>Report Date</th>
                                            <th>Report Time</th>
                                            <th>Customer Name</th>
                                            <th>Veh Segment</th>
                                            <th>DS No.</th>
                                            <th>Veh. No.</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tlist" runat="server">
                                    </tbody>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </div>
     
</asp:Content>
