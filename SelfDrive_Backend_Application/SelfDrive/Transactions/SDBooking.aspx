<%@ Page Language="C#" AutoEventWireup="true" enableEventValidation="false" MasterPageFile="~/Site1.Master" CodeBehind="SDBooking.aspx.cs" Inherits="SelfDrive.Transactions.SDBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../vendor/bootstrap-datepicker.css" rel="stylesheet" />
    <script src="../vendor/bootstrap-datepicker.js"></script>
    <script src="../js/select2.js"></script>
    <link href="../css/select2.css" rel="stylesheet" />
    <link href="../css/customstyles.css" rel="stylesheet" />
    <script type="text/javascript" class="init">
        $(document).ready(function () {
            getallCustomers();
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

            $(document).ready(function () {
                $('#datepicker_Bookingdate')
                    .datepicker({
                        autoclose: true,
                        //format: 'mm/dd/yyyy',
                        format: 'dd-M-yyyy',
                        todayHighlight: true,
                        //startDate: stdate,
                        
                        changeMonth: true,
                        changeYear: true,
                        yearRange: 'c-2:c+2',
                        //endDate: end,
                        autoclose: true
                        
                
                
                    })
            });

            $(document).ready(function () {
                $('#datepicker_Fromdate')
                    .datepicker({
                        autoclose: true,
                        //format: 'mm/dd/yyyy',
                        format: 'dd-M-yyyy',
                        todayHighlight: true,
                        startDate: today,
                        changeMonth: true,
                        changeYear: true,
                        yearRange: 'c-2:c+2',
                        //endDate: end,
                        autoclose: true
                    })
            });

            $(document).ready(function () {
                $('#datepicker_Todate')
                    .datepicker({
                        autoclose: true,
                        //format: 'mm/dd/yyyy',
                        format: 'dd-M-yyyy',
                        todayHighlight: true,
                        startDate: today,
                        changeMonth: true,
                        changeYear: true,
                        yearRange: 'c-2:c+2',
                        //endDate: end,
                        autoclose: true
                    })
            });


            var isPostBack = "<%Response.Write(Page.IsPostBack);%>";

            if (isPostBack == "False") {

                //alert(today);

                $('#<%= txtbookingdate.ClientID %>').datepicker({ format: 'dd-M-yyyy' });

                <%-- $('#<%= txtdob.ClientID %>').datepicker('setDate', today);

                $('#<%= txtjoindate.ClientID %>').datepicker({ format: 'dd-M-yyyy' });

                $('#<%= txtjoindate.ClientID %>').datepicker('setDate', today);

                $('#<%= txtredate.ClientID %>').datepicker({ format: 'dd-M-yyyy' });

                $('#<%= txtredate.ClientID %>').datepicker('setDate', today);--%>


            }

        });
    </script>
     <script lang="javascript" type="text/javascript">
         function OnlyNumeric(evt) {
             var keyCode = evt.keyCode || evt.which;
             if (keyCode) {
                 if ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 || keyCode == 9)
                     return true;
             };
             if (evt.preventDefault)
                 evt.preventDefault();
             else evt.returnValue = false;
             return false;
         }
         function OnlyFloat(sender, evt) {
             var txt = sender.value;
             var dotcontainer = txt.split('.');
             var keyCode = evt.keyCode || evt.which;
             if (keyCode) {
                 if ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 || (dotcontainer.length == 1 && keyCode == 46) || keyCode == 9)
                     return true;
             };

             if (evt.preventDefault)
                 evt.preventDefault();
             else evt.returnValue = false;

             return false;
         }
    </script>
    <script lang="javascript" type="text/javascript">
        function getAllVehMakes() {
            debugger;
            var CompanyId = $("#<%= hcompanyid.ClientID %>").val();

            var vehSegid = $("#<%= ddlVehicleseg.ClientID %>").val();
            //alert(vehSegid);
            //alert(CompanyId);
            if (vehSegid != "Select") {
                $("#<%= ddlVehicleMake.ClientID %>").empty();
                var option = document.createElement("option");
                option.text = "Select";
                option.value = "Select";
                document.getElementById("<%=ddlVehicleMake.ClientID %>").options.add(option);

                //alert('123');
                $.ajax
              ({

                  type: "GET",
                  url: "/api/VehMake/GetAllVehMakes?companyid=" + CompanyId + "&VehSegId=" + vehSegid,

                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  async: false,
                  success: function (result) {
                      //alert("success");
                      debugger;
                      for (var i = 0; i < result.length; i++) {
                          //alert(result.length);
                          var opt = new Option(result[i].branchName);
                          //alert(result[i].EmployeeId);
                          //alert(result[i].EmployeeName);
                          <%-- $("#<%= ddlemployee.ClientID %>").append(opt);--%>
                          $("#<%= ddlVehicleMake.ClientID %>").append($('<option>', {
                              value: result[i].VehMakeId,
                              text: result[i].VehMake
                          }));
                      }

                      $('#<%= ddlVehicleMake.ClientID %>').select2().val("Select").trigger('change');

                  },
                  error: function (r) {
                      //alert(r.error);
                  },
              });


            }
            LoadPackages();
            LoadAccessories();
        }

        function LoadPackages() {
            debugger;
            var CompanyId = $("#<%= hcompanyid.ClientID %>").val();
            var Locid = $("#<%= ddlLocation.ClientID %>").val();
            var vehSegid = $("#<%= ddlVehicleseg.ClientID %>").val();
            if (vehSegid != "Select") {
                $.ajax
               ({
                   type: "GET",
                   url: "/api/Package/GetAllPackages?companyid=" + CompanyId + "&SerLocid=" + Locid + "&VehSegId=" + vehSegid,

                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,
                   success: function (result) {
                       //alert("success");                  
                       debugger;
                       var datatableVariable = $('#tblPackage').DataTable({
                           "bDestroy": true,
                           "paging": false,
                           data: result,
                           columns: [
                               {
                                   'data': 'Tariffid', 'render': function (data, type, full, meta) {
                                       return '<input type="radio" class="call-checkbox" name="rdopackage" value="'
                                          + $('<div/>').text(data).html() + '">';
                                   }
                               },
                               { 'data': 'PackageName' },
                               { 'data': 'allowedKms' },
                               { 'data': 'allowedHrs' },
                               { 'data': 'basicrate' },
                               { 'data': 'SecurityDeposit' }]
                       });
                       // Handle click on "Select all" control
                       $('#example-select-all').on('click', function () {
                           // Check/uncheck all checkboxes in the table
                           var rows = datatableVariable.rows().nodes();
                           $('input[type="radio"]', rows).prop('checked', this.checked);
                       });
                       $('#divfooternext').show();

                   },
                   error: function (r) {
                       //alert(r.error);
                   },
               });
            }
        }

        function LoadAccessories() {
            debugger;
            var CompanyId = $("#<%= hcompanyid.ClientID %>").val();
            var vehSegid = $("#<%= ddlVehicleseg.ClientID %>").val();
            if (vehSegid != "Select") {
                $.ajax
               ({
                   type: "GET",
                   url: "/api/Accessories/GetAllAccessories?companyid=" + CompanyId + "&VehSegId=" + vehSegid,

                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   async: false,
                   success: function (result) {
                      //alert("success");
                       debugger;
                       $('#divchklist').html("");
                      var table = $('<table id="tbodyid"></table>');
                      var counter = 0;
                      $(result).each(function () {
                          table.append($('<tr></tr>').append($('<td></td>').append($('<input>').attr({
                              type: 'checkbox', name: 'chklistitem', value: this.Accsid, id: 'chklistitem' + counter
                          })).append(
                          $('<label>').attr({
                              for: 'chklistitem' + counter++
                          }).text(this.AccsName))));
                      });

                      $('#divchklist').append(table);
                      

                      

                  },
                  error: function (r) {
                      //alert(r.error);
                  },
               });
            }
            }
   </script>

    <script lang="javascript" type="text/javascript">
        function getallCustomers() {
            debugger;

           var CompanyId = $("#<%= hcompanyid.ClientID %>").val();
            var vehSegid = 'CMP00001/VC0001';


            $("#<%= ddlcustomer.ClientID %>").empty();

            //alert('Sub 1');
            $.ajax
          ({
              type: "GET",
              async: false,
              url: "/api/Accessories/GetAllAccessories?companyid=" + CompanyId + "&VehSegId=" + vehSegid,

              contentType: "application/json; charset=utf-8",
              dataType: "json",

              success: function (result) {
                  //alert("success");
                  debugger;
                  for (var i = 0; i < result.length; i++) {
                      //alert(result.length);
                      var opt = new Option(result[i].CompanyName);
                      //alert(result[i].EmployeeId);
                      //alert(result[i].EmployeeName);
                      <%-- $("#<%= ddlemployee.ClientID %>").append(opt);--%>
                      $("#<%= ddlcustomer.ClientID %>").append($('<option>', {
                          value: result[i].Accsid,
                          text: result[i].AccsName
                      }));


                  }
                  //if (CompanyType === 'New') {
                  var option = document.createElement("option");
                  option.text = "Select";
                  option.value = "Select";
                  document.getElementById("<%=ddlcustomer.ClientID %>").options.add(option);
                  $('#<%= ddlcustomer.ClientID %>').select2().val("Select").trigger('change');

                  //}
                  <%--else {
                      $('#<%= ddlcompany.ClientID %>').select2().val(CompanyId).trigger('change');
                  }--%>

              },
              error: function (r) {
                  //alert(r.error);
              },
          });

        }
    </script>

    <style type="text/css">
        .form-control {
            height: 30px !important;
            margin: 1px 0px;
        }
    </style>
     <script lang="javascript" type="text/javascript">
        function NewBooking() {
            $('#<%= btnsave.ClientID %>').show();
            document.getElementById("<%= btnsave.ClientID %>").disabled = false;
            document.getElementById("<%= hbookingId.ClientID %>").value = 'New';

            document.getElementById("<%= txtcustomer.ClientID %>").value = '';
            document.getElementById("<%= txtbookingdate.ClientID %>").value = '';
            var date1 = new Date();
            var today1 = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate());
            $('#<%= txtbookingdate.ClientID %>').datepicker('setDate', today1);
            $('#<%= txtFromDate.ClientID %>').datepicker('setDate', today1);
            $('#<%= txtToDate.ClientID %>').datepicker('setDate', today1);

            document.getElementById("<%= txtbookedby.ClientID %>").value = '';
            document.getElementById("<%= txtBookedMobileno.ClientID %>").value = '';
            document.getElementById("<%= txtBookedEmail.ClientID %>").value = '';
            document.getElementById("<%= txtGuestMobile.ClientID %>").value = '';
            document.getElementById("<%= txtGuest.ClientID %>").value = '';
            document.getElementById("<%= txtGuestEmail.ClientID %>").value = '';
            
            document.getElementById("<%= txtAdvAmt.ClientID %>").value = '';
            document.getElementById("<%= txtdiscount.ClientID %>").value = '';
            document.getElementById("<%= txtSecDepAmt.ClientID %>").value = '';

            document.getElementById("<%= ddlLocation.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlVehicleseg.ClientID %>").selectedIndex = 0;

            $("#<%= ddlVehicleMake.ClientID %>").empty();
                var option = document.createElement("option");
                option.text = "Select";
                option.value = "Select";
                document.getElementById("<%=ddlVehicleMake.ClientID %>").options.add(option);

            var table = $('#tblPackage').DataTable();
            $("#tblPackage").find("input,button,textarea,select").removeAttr("disabled");
            if (table.data().any()) {
                //alert("Hi");
                $('#tblPackage').empty();
            }
            $('#divchklist').html("");

            document.getElementById("<%= ddlDiscStatus.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlSecDepStatus.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlstatus.ClientID %>").selectedIndex = 0;
           
            document.getElementById("<%= ddlstatus.ClientID %>").disabled = true;

            var CompanyId = document.getElementById("<%=hcompanyid.ClientID %>").value;

            document.getElementById("<%= ddlLocation.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%=ddlVehicleseg.ClientID%>").style.borderColor = "#ccc";
            document.getElementById("<%=ddlVehicleMake.ClientID%>").style.borderColor = "#ccc";
            
            document.getElementById("<%= txtcustomer.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtbookedby.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtGuest.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtGuestMobile.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtFromDate.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtToDate.ClientID %>").style.borderColor = "#ccc";
        }

    </script>
    <script lang="javascript" type="text/javascript">
        function FillDetails(bookingid, segid, slid, vehmakeid, status, customername, bookingdate, bookedby, BookedMobileno, BookedEmail, GuestMobile, GuestName, GuestEmail, FromDate, Todate, AdvAmt, discstatus, discount, SecDepStatus, SecDepAmt, tariffid, accessoriesStatus, accsids,fromtime,totime, companyid) {

            document.getElementById("<%= hbookingId.ClientID %>").value = bookingid;

            var DDlVehseg = document.getElementById("<%=ddlVehicleseg.ClientID %>");
            for (var i = 0; i < DDlVehseg.options.length; i++) {
                if (DDlVehseg.options[i].value == segid) {
                    DDlVehseg.selectedIndex = i;
                    break;
                }
            }
            var Status1 = document.getElementById("<%=ddlstatus.ClientID %>");
            for (var i = 0; i < Status1.options.length; i++) {
                if (Status1.options[i].text == status) {
                    Status1.selectedIndex = i;
                    break;
                }
            }
            document.getElementById("<%= ddlstatus.ClientID %>").disabled = false;

            var DDlSerLoc = document.getElementById("<%=ddlLocation.ClientID %>");
            for (var i = 0; i < DDlSerLoc.options.length; i++) {
                if (DDlSerLoc.options[i].value == slid) {
                    DDlSerLoc.selectedIndex = i;
                    break;
                }
            }

            var dstatus = document.getElementById("<%=ddlDiscStatus.ClientID %>");
            for (var i = 0; i < dstatus.options.length; i++) {
                if (dstatus.options[i].text == discstatus) {
                    dstatus.selectedIndex = i;
                    break;
                }
            }
            var Secdstatus = document.getElementById("<%=ddlSecDepStatus.ClientID %>");
            for (var i = 0; i < Secdstatus.options.length; i++) {
                if (Secdstatus.options[i].text == SecDepStatus) {
                    Secdstatus.selectedIndex = i;
                    break;
                }
            }
            getAllVehMakes();
            var Dvehmake = document.getElementById("<%=ddlVehicleMake.ClientID %>");
            for (var i = 0; i < Dvehmake.options.length; i++) {
                if (Dvehmake.options[i].value == vehmakeid) {
                    Dvehmake.selectedIndex = i;
                    break;
                }
            }
            var DaccsStatus = document.getElementById("<%=ddlAccessoriesStatus.ClientID %>");
            for (var i = 0; i < DaccsStatus.options.length; i++) {
                if (DaccsStatus.options[i].text == accessoriesStatus) {
                    DaccsStatus.selectedIndex = i;
                    break;
                }
            }

           var accidlist = accsids.split(",");
            var checkBoxes = document.getElementsByName("chklistitem");
            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type == "checkbox") {
                    for (var k = 0; k < accidlist.length; k++) {
                        if (accidlist[k] == checkBoxes[i].value) {
                            checkBoxes[i].checked = true;
                            break;
                        }
                    }
                }
            }
            
            
            document.getElementById("<%= txtcustomer.ClientID %>").value = customername;
            document.getElementById("<%= txtbookingdate.ClientID %>").value = bookingdate;
            document.getElementById("<%= txtbookedby.ClientID %>").value = bookedby;
            document.getElementById("<%= txtBookedMobileno.ClientID %>").value = BookedMobileno;
            document.getElementById("<%= txtBookedEmail.ClientID %>").value = BookedEmail;
            document.getElementById("<%= txtGuestMobile.ClientID %>").value = GuestMobile;
            document.getElementById("<%= txtGuest.ClientID %>").value = GuestName;
            document.getElementById("<%= txtGuestEmail.ClientID %>").value = GuestEmail;
            document.getElementById("<%= txtFromDate.ClientID %>").value = FromDate;
            document.getElementById("<%= txtToDate.ClientID %>").value = Todate;
            document.getElementById("<%= txtAdvAmt.ClientID %>").value = AdvAmt;
            document.getElementById("<%= txtdiscount.ClientID %>").value = discount;
            document.getElementById("<%= txtSecDepAmt.ClientID %>").value = SecDepAmt;

            $('#tblPackage tbody>tr').each(function (a, b) {

                var Id = $('.call-checkbox', b).val();

                var emid = Id.split('-');//example-select-all
                //alert("test1");
                $('#tblPackage').DataTable().$('.call-checkbox', b).prop('disabled', false);
                if (emid[0] === tariffid) {
                    $('#tblPackage').DataTable().$('.call-checkbox', b).prop('checked', true);
                }

            });
        }
    </script>
    <script lang="javascript" type="text/javascript">
        function SaveValidation() {
           
            var flag = true;
            var errmsg = '';
                      

            //if (!isAnyCheckBoxChecked) {
            //    alert("No CheckBox is Checked.");
            //}
            document.getElementById("<%= hbookingdate.ClientID %>").value = document.getElementById("<%= txtbookingdate.ClientID %>").value;
            alert(document.getElementById("<%= hbookingdate.ClientID %>").value);

             if (document.getElementById("<%= txtcustomer.ClientID %>").value == "") {
                document.getElementById("<%= txtcustomer.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtcustomer.ClientID %>").style.borderColor = "#ccc";
             }

            var IndexValue = document.getElementById('<%=ddlLocation.ClientID %>').selectedIndex;
            var SelectedVal = document.getElementById('<%=ddlLocation.ClientID %>').options[IndexValue].text;
            if (SelectedVal == "Select") {
                document.getElementById("<%= ddlLocation.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= ddlLocation.ClientID %>").style.borderColor = "#ccc";
            }
            var IndexVehseg = document.getElementById('<%=ddlVehicleseg.ClientID%>').selectedIndex;
            var SelSegvel = document.getElementById('<%=ddlVehicleseg.ClientID%>').options[IndexVehseg].text;
            if (SelSegvel == 'Select') {
                document.getElementById("<%=ddlVehicleseg.ClientID%>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else { document.getElementById("<%=ddlVehicleseg.ClientID%>").style.borderColor = "#ccc"; }

            var Indexbranch = document.getElementById('<%=ddlVehicleMake.ClientID %>').selectedIndex;
            var SelectedBranch = document.getElementById('<%=ddlVehicleMake.ClientID %>').options[Indexbranch].text;
            if (SelectedBranch == "Select")
            {
                document.getElementById("<%= ddlVehicleMake.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else{
                document.getElementById("<%= ddlVehicleMake.ClientID %>").style.borderColor = "#ccc";
                document.getElementById("<%= hvehmakeid.ClientID%>").value= document.getElementById('<%=ddlVehicleMake.ClientID %>').options[Indexbranch].value;
            }

            //Collecting checkbox_value
            var tariffid = '';
            var oTable = $('#tblPackage').dataTable();
            //alert(oTable);
            var rowcollection = oTable.$(".call-checkbox:checked", { "page": "all" });
            //alert(rowcollection);
            rowcollection.each(function (index, elem) {
                var checkbox_value = $(elem).val().split('-');
                tariffid = checkbox_value[0];
            });
            //alert(tariffid);
            if (tariffid == '') {
                alert('Please select atleast one Tariff...!');
                return false;
            }

            document.getElementById("<%= hseltariffid.ClientID %>").value = tariffid;

             var accsids = '';
            var checkBoxes = document.getElementsByName("chklistitem");
           
            for (var i = 0; i < checkBoxes.length; i++) {
                if (checkBoxes[i].type == "checkbox") {
                    if (checkBoxes[i].checked) {
                        if (accsids == "") {
                            accsids = checkBoxes[i].value;
                        }
                        else {
                            accsids = accsids + "," + checkBoxes[i].value;
                        }
                        
                        
                    }
                }
            }
            alert(accsids);
            document.getElementById("<%= haccids.ClientID %>").value = accsids;

            
            
            if (document.getElementById("<%= txtbookedby.ClientID %>").value == "") {
                document.getElementById("<%= txtbookedby.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtbookedby.ClientID %>").style.borderColor = "#ccc";
            }

            var EmailPattern = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
            if (document.getElementById("<%= txtBookedEmail.ClientID %>").value == "") {
                document.getElementById("<%= txtBookedEmail.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                var strTAEmail = document.getElementById("<%= txtBookedEmail.ClientID %>").value;
                if (strTAEmail != "") {
                    if (!(EmailPattern.test(strTAEmail))) {
                        errmsg += "a valid Guest Email";
                        document.getElementById("<%= txtBookedEmail.ClientID %>").style.borderColor = "Red";
                        document.getElementById("<%= txtBookedEmail.ClientID %>").focus();
                        flag = false;
                    }
                    else {
                        document.getElementById("<%= txtBookedEmail.ClientID %>").style.borderColor = "#FFCC00";
                    }
                }
                document.getElementById("<%= txtBookedEmail.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtBookedMobileno.ClientID %>").value == "") {
                document.getElementById("<%= txtBookedMobileno.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtBookedMobileno.ClientID %>").style.borderColor = "#ccc";
            }

            if (document.getElementById("<%= txtGuest.ClientID %>").value == "") {
                document.getElementById("<%= txtGuest.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtGuest.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtGuestMobile.ClientID %>").value == "") {
                document.getElementById("<%= txtGuestMobile.ClientID %>").style.borderColor = "Red";
                 errmsg += "";
                 flag = false;
             }
             else {
                 document.getElementById("<%= txtGuestMobile.ClientID %>").style.borderColor = "#ccc";
            }
            
             if (document.getElementById("<%= txtGuestEmail.ClientID %>").value == "") {
                document.getElementById("<%= txtGuestEmail.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
             else {
                 
                var strTAEmail = document.getElementById("<%= txtGuestEmail.ClientID %>").value;
                if (strTAEmail != "") {
                    if (!(EmailPattern.test(strTAEmail))) {
                        errmsg += "a valid Guest Email";
                        document.getElementById("<%= txtGuestEmail.ClientID %>").style.borderColor = "Red";
                        document.getElementById("<%= txtGuestEmail.ClientID %>").focus();
                        flag = false;
                    }
                    else {
                        document.getElementById("<%= txtGuestEmail.ClientID %>").style.borderColor = "#FFCC00";
                    }
                }

                document.getElementById("<%= txtGuestEmail.ClientID %>").style.borderColor = "#ccc";
             }
             if (document.getElementById("<%= txtFromDate.ClientID %>").value == "") {
                document.getElementById("<%= txtFromDate.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                 document.getElementById("<%= txtFromDate.ClientID %>").style.borderColor = "#ccc";
                 document.getElementById("<%= hfromdate.ClientID %>").value = document.getElementById("<%= txtFromDate.ClientID %>").value;
             }
             if (document.getElementById("<%= txtToDate.ClientID %>").value == "") {
                document.getElementById("<%= txtToDate.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                 document.getElementById("<%= txtToDate.ClientID %>").style.borderColor = "#ccc";
                 document.getElementById("<%= htodate.ClientID %>").value = document.getElementById("<%= txtToDate.ClientID %>").value;
            }
            //alert(flag);
            if (flag) {
                return true;
            }
            else {
                return false;
            }

        }
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
    <asp:HiddenField runat="server" ID="hvehmakeid" />
    <asp:HiddenField runat="server" ID="hseltariffid" />
    <asp:HiddenField runat="server" ID="haccids" />
    <asp:HiddenField runat="server" ID="hbookingdate" />
     <asp:HiddenField runat="server" ID="hfromdate" />
     <asp:HiddenField runat="server" ID="htodate" />
    <asp:HiddenField runat="server" ID="hfromdateL" />
     <asp:HiddenField runat="server" ID="htodateL" />

    <asp:Button runat="server" ID="btnDelete" Style="display: none;" OnClick="btnDelete_Click" />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="row" style="padding: 0px 20px;">
            <div class="col-md-4 col-sm-12 col-xs-12" style="padding-top: 15px;">
                <h4>&nbsp;Bookings</h4>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 " style="padding-top: 15px;">
                <div class="form-group fa-pull-right ">
                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="NewBooking();">New Booking</a>
                </div>
            </div>
        </div>
    </div>
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
                <td >
                    <div class="input-group date" id="datepicker_TodateL">
                        <asp:TextBox runat="server" ID="txtToDateL" CssClass="form-control form-control1" autocomplete="off" Readonly="true"></asp:TextBox>
                        <span class="input-group-text input-group-addon add-on"><span class="fa fa-calendar-alt"></span></span>
                    </div>
                </td>
                 <td >
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
                                            <th>Booking Id</th>
                                            <th>Booking Date</th>
                                            <th>Service Location</th>
                                            <th>Customer Name</th>
                                            <th>From Date</th>
                                            <th>To Date</th>
                                            <th>Veh Segment</th>
                                            <th>Booking Status</th>
                                            <th>DutySlip Status</th>
                                            <th style="width: 60px;">Options</th>
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
    <!-- Large modal popup 1 start -->
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-content modal-heading">
                    <%-- <button type="button" class="close" data-dimiss="modal">
                        <span aria-hidden="true">x</span>
                    </button>--%>
                    <h4 class="modal-title" id="myModelLabel">&nbsp; Bookings Info</h4>
                </div>
                <div class="modal-body">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <h5 style="color: #2196f3; display: none;">Bookings Info</h5>

                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Customer Name</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtcustomer" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                                <asp:DropDownList runat="server" ID="ddlcustomer" Width="200" CssClass="drpwidth"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Booking Date</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="input-group date" id="datepicker_Bookingdate">
                                                    <asp:TextBox runat="server" ID="txtbookingdate" CssClass="form-control form-control1" autocomplete="off" ReadOnly="true"></asp:TextBox>
                                                    <span class="input-group-text input-group-addon add-on"><span class="fa fa-calendar-alt"></span></span>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Booked By</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtbookedby" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Mobile No.</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtBookedMobileno" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Email</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtBookedEmail" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Guest</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtGuest" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Guest Mobile</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtGuestMobile" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label>Guest Email</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtGuestEmail" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Service Location</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control form-control1">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Vehicle Segment</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlVehicleseg" CssClass="form-control form-control1" onchange="getAllVehMakes();" >
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Vehicle Make</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlVehicleMake" CssClass="form-control form-control1">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <div class="x_panel">
                                            <div class="x_content">
                                                <div class="" role="tabpanel" data-example-id="togglable-tabs">
                                                    <div>
                                                        <asp:Panel runat="server" ID="Panel" CssClass="ScrollStyle">
                                                            <div>
                                                                <table id="tblPackage" style="font: 12px verdana; width: 100%;" class="table table-bordered">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>
                                                                            </th>
                                                                            <th>Package Name</th>
                                                                            <th>Allowed Kms</th>
                                                                            <th>Allowed Hrs</th>
                                                                            <th>Basic Rate</th>
                                                                            <th>Sec. Deposit</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="Tbody1" runat="server">
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">From Date</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="input-group date" id="datepicker_Fromdate">
                                                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control form-control1" autocomplete="off" Readonly="true"></asp:TextBox>
                                                    <span class="input-group-text input-group-addon add-on"><span class="fa fa-calendar-alt"></span></span>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">From Time</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="input-group date">
                                                    <asp:TextBox runat="server" ID="txtfromtime" CssClass="form-control form-control1" autocomplete="off" MaxLength="8" onkeypress="return OnlyFloat(event)"></asp:TextBox>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">To Date</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="input-group date" id="datepicker_Todate">
                                                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control form-control1" autocomplete="off" Readonly="true"></asp:TextBox>
                                                    <span class="input-group-text input-group-addon add-on"><span class="fa fa-calendar-alt"></span></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">To Time</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <div class="input-group date">
                                                    <asp:TextBox runat="server" ID="txttotime" CssClass="form-control form-control1" autocomplete="off" MaxLength="8" onkeypress="return OnlyFloat(event)"></asp:TextBox>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Advance Amount</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtAdvAmt" CssClass="form-control form-control1" autocomplete="off" MaxLength="8" onkeypress="return OnlyFloat(event)"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Discount Status</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlDiscStatus" CssClass="form-control form-control1">
                                                    <asp:ListItem Text="Not Applicable" Value="no"></asp:ListItem>
                                                    <asp:ListItem Text="Percentage" Value="percentage"></asp:ListItem>
                                                    <asp:ListItem Text="Fixed Amount" Value="amount"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Discount </label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtdiscount" CssClass="form-control form-control1" autocomplete="off" MaxLength="8" onkeypress="return OnlyFloat(event)"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Security Deposit Status</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlSecDepStatus" CssClass="form-control form-control1">
                                                    <asp:ListItem Text="Not Required" Value="notrequired"></asp:ListItem>
                                                    <asp:ListItem Text="Required" Value="required"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Security Deposit Amount </label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtSecDepAmt" CssClass="form-control form-control1" autocomplete="off" MaxLength="8" onkeypress="return OnlyFloat(event)"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Accessories Status</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlAccessoriesStatus" CssClass="form-control form-control1">
                                                    <asp:ListItem Text="Not Required" Value="notrequired"></asp:ListItem>
                                                    <asp:ListItem Text="Required" Value="required"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Status</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlstatus" CssClass="form-control form-control1">
                                                    <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                    <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Accessories</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12" id="divchklist">
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnClose" Text="Close" class="btn btn-default" data-dismiss="modal" />
                    <asp:Button runat="server" ID="btnsave" Text="Save" class="btn btn-success" OnClientClick="return SaveValidation();" OnClick="btnsave_Click" />

                </div>
            </div>
        </div>
</asp:Content>
