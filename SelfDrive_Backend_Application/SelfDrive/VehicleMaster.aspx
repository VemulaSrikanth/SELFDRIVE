<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="VehicleMaster.aspx.cs" Inherits="SelfDrive.VehicleMaster" EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
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

            $('#tblUserProfile').on('draw.dt', function (e) {
                $('#tblUserProfile thead tr th').each(function (idx, ele) {
                    var xPos = parseInt((($(ele).textWidth())) + 15);
                    if ($(ele).text() == '') {
                        $(ele).css('display', 'none')
                    }
                    else {
                        $(ele).css('background-position-x', xPos + 'px')
                    }
                })
            });

            var table = $('#tblUserProfile').DataTable({
                "bPaginate": $('#tblUserProfile tbody tr').length > 10
            });
            $('#min, #max').keyup(function () {
                table.draw();
            });
        });
    </script>


   

    <script lang="javascript" type="text/javascript">
        function DeleteMe(IdToBeDeleted) {
            if (window.confirm('Are you sure to delete this row?') == false) return;
            document.getElementById("<%= huserprofile.ClientID %>").value = IdToBeDeleted;
            document.getElementById("<%=btnUserProfile.ClientID%>").click();
        }
    </script>
    <script lang="javascript" type="text/javascript">
        function SaveValidation() {
            var flag = true;
            var errmsg = '';
           
            var IndexValue = document.getElementById('<%=ddlSupplier.ClientID %>').selectedIndex;
                var SelectedVal = document.getElementById('<%=ddlSupplier.ClientID %>').options[IndexValue].text;

            if(SelectedVal == "Select")
            {
                document.getElementById("<%= ddlSupplier.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else{
                document.getElementById("<%= ddlSupplier.ClientID %>").style.borderColor = "#ccc";
            }

             var Indexvehmake = document.getElementById('<%=ddlVehicleMake.ClientID %>').selectedIndex;
            var SelectedValVehmake = document.getElementById('<%=ddlVehicleMake.ClientID %>').options[Indexvehmake].text;

            if (SelectedValVehmake == "Select")
            {
                document.getElementById("<%= ddlVehicleMake.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else{
                document.getElementById("<%= ddlVehicleMake.ClientID %>").style.borderColor = "#ccc";
            }

            if (document.getElementById("<%= txtvehno.ClientID %>").value == "") {
                document.getElementById("<%= txtvehno.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtvehno.ClientID %>").style.borderColor = "#ccc";
            }

             
            if (document.getElementById("<%= txtavgmilage.ClientID %>").value == "") {
                document.getElementById("<%= txtavgmilage.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtavgmilage.ClientID %>").style.borderColor = "#ccc";
            }
            
             if (document.getElementById("<%= txtengineno.ClientID %>").value == "") {
                document.getElementById("<%= txtengineno.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtengineno.ClientID %>").style.borderColor = "#ccc";
            }
            
             if (document.getElementById("<%= txtchasisno.ClientID %>").value == "") {
                document.getElementById("<%= txtchasisno.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtchasisno.ClientID %>").style.borderColor = "#ccc";
            }
            
            var Indexloc = document.getElementById('<%=ddlLocation.ClientID %>').selectedIndex;
            var SelectedLoc = document.getElementById('<%=ddlLocation.ClientID %>').options[Indexloc].text;
            if (SelectedLoc == "Select")
            {
                document.getElementById("<%= ddlLocation.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else{
                document.getElementById("<%= ddlLocation.ClientID %>").style.borderColor = "#ccc";
            }

            var Indexbranch = document.getElementById('<%=ddlbranch.ClientID %>').selectedIndex;
            var SelectedBranch = document.getElementById('<%=ddlbranch.ClientID %>').options[Indexbranch].text;
            if (SelectedBranch == "Select")
            {
                document.getElementById("<%= ddlbranch.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else{
                document.getElementById("<%= ddlbranch.ClientID %>").style.borderColor = "#ccc";
                document.getElementById("<%= hbrid.ClientID%>").value= document.getElementById('<%=ddlbranch.ClientID %>').options[Indexbranch].value;
            }
            
            if (flag) {

                return true;
            }
            else {

                return false;
            }

        }
    </script>


    <script lang="javascript" type="text/javascript">
        function NewUserProfile() {
            $('#<%= btnsave.ClientID %>').show();
            document.getElementById("<%= btnsave.ClientID %>").disabled = false;
            document.getElementById("<%= huserprofile.ClientID %>").value = 'New';

            document.getElementById("<%= txtvehno.ClientID %>").value = '';
            document.getElementById("<%= txtavgmilage.ClientID %>").value = '';
            document.getElementById("<%= txtengineno.ClientID %>").value = '';
            document.getElementById("<%= txtchasisno.ClientID %>").value = '';
            document.getElementById("<%= ddlLocation.ClientID %>").selectedIndex = 0;
             $("#<%= ddlbranch.ClientID %>").empty();
                var option = document.createElement("option");
                option.text = "Select";
                option.value = "Select";
                document.getElementById("<%=ddlbranch.ClientID %>").options.add(option);
            
            var CompanyId = document.getElementById("<%=hcompanyid.ClientID %>").value;
           
        }
    </script>
    <script lang="javascript" type="text/javascript">

        function FillDetails(vrid, supplied, vehmakeid, vehicleregno, avgmileage, engineno, chasisno, slid,brid,vehstatus, companyid) {
                      
            document.getElementById("<%= huserprofile.ClientID %>").value = vrid;
            
            var DDlSupp = document.getElementById("<%=ddlSupplier.ClientID %>");
            for (var i = 0; i < DDlSupp.options.length; i++) {

                if (DDlSupp.options[i].value == supplied) {
                    DDlSupp.selectedIndex = i;
                    break;
                }
            }

            var DDlVehmake = document.getElementById("<%=ddlVehicleMake.ClientID %>");
            for (var i = 0; i < DDlVehmake.options.length; i++) {

                if (DDlVehmake.options[i].value == vehmakeid) {
                    DDlVehmake.selectedIndex = i;
                    break;
                }
            }
                var Status1 = document.getElementById("<%=ddlstatus.ClientID %>");
                for (var i = 0; i < Status1.options.length; i++) {
                    if (Status1.options[i].text == vehstatus) {
                        Status1.selectedIndex = i;
                        break;
                    }
                }
            var DDlSerLoc = document.getElementById("<%=ddlLocation.ClientID %>");
            for (var i = 0; i < DDlSerLoc.options.length; i++) {

                if (DDlSerLoc.options[i].value == slid) {
                    DDlSerLoc.selectedIndex = i;
                    break;
                }
            }

            getallBranches();

            var DDlbranch = document.getElementById("<%=ddlbranch.ClientID %>");
            for (var i = 0; i < DDlbranch.options.length; i++) {

                if (DDlbranch.options[i].value == brid) {
                    DDlbranch.selectedIndex = i;
                    break;
                }
            }
            
            document.getElementById("<%= txtvehno.ClientID %>").value = vehicleregno;
            document.getElementById("<%= txtavgmilage.ClientID %>").value = avgmileage;
            document.getElementById("<%= txtengineno.ClientID %>").value = engineno;
            document.getElementById("<%= txtchasisno.ClientID %>").value = chasisno;
            document.getElementById("<%= txtvehno.ClientID %>").style.borderColor = "#ccc";

        }
    </script>
    <script type="text/javascript">
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
        };
    </script>
    
   <script lang="javascript" type="text/javascript">
        function getallBranches() {
            debugger;
            var cmpid = "New";
            var CompanyId = $("#<%= hcompanyid.ClientID %>").val();

            var slid = $("#<%= ddlLocation.ClientID %>").val();
            //alert(slid);
            //alert(CompanyId);
            if (slid != "Select") {
                $("#<%= ddlbranch.ClientID %>").empty();
                var option = document.createElement("option");
                option.text = "Select";
                option.value = "Select";
                document.getElementById("<%=ddlbranch.ClientID %>").options.add(option);

                //alert('123');
                $.ajax
              ({

                  type: "GET",
                  url: "/api/Masters/GetAllBranchNames?companyid=" + CompanyId + "&slid=" + slid,

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
                          $("#<%= ddlbranch.ClientID %>").append($('<option>', {
                              value: result[i].brId,
                              text: result[i].branchName
                          }));
                      }

                      $('#<%= ddlbranch.ClientID %>').select2().val("Select").trigger('change');

                  },
                  error: function (r) {
                      //alert(r.error);
                  },
              });
            }

        }
   </script>
    <style>
        .form-control1 {
            height: 30px;
            border-radius: 4px;
            font-size: 13px;
        }

        .dataTables_filter input {
            height: 30px;
            border-radius: 4px;
            border: 1px #cecece solid;
        }

        .dataTables_length select {
            height: 30px;
            border-radius: 4px;
            border: 1px #cecece solid;
        }

        @media (min-width: 250px) {
            .modal-lg {
                max-width: 400px !important;
            }
        }

        .form-control {
            padding: 0px 5px;
        }
          @media (min-width: 576px) {
            .form-inline label {
                justify-content: left;
            }
        }
         .row
         {
             margin-bottom:10px;
         }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField runat="server" ID="hstaffid" />
    <asp:HiddenField runat="server" ID="hcompanyid" />
    <asp:HiddenField runat="server" ID="huserprofile" />
    <asp:HiddenField runat="server" ID="hEmpId" />
    <asp:HiddenField runat="server" ID="hemployeeId" />
    <asp:HiddenField runat="server" ID="hbrid" />
    <asp:Button runat="server" ID="btnUserProfile" Style="display: none;" OnClick="btnUserProfileDelete_Click" />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="row" style="padding: 0px 20px;">
            <div class="col-md-4 col-sm-12 col-xs-12" style="padding-top: 15px;">
                <h4>&nbsp;Vehicle Master</h4>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 " style="padding-top: 15px;">
                <div class="form-group fa-pull-right ">
                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="NewUserProfile();">New Vehicle</a>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_content">
                <div class="" role="tabpanel" data-example-id="togglable-tabs">
                    <div>
                        <asp:Panel runat="server" ID="Panel1">
                            <div>
                                <table id="tblUserProfile" class="table table-bordered">
                                    <thead>
                                        <tr class="bg-primary">
                                            <th>Supplier Name</th>
                                            <th>Vehicle Make</th>
                                            <th>Vehicle Reg No.</th>
                                            <th>Avg Mileage</th>
                                            <th>Engine No.</th>
                                            <th>Chasis No.</th>
                                            <th>Service Loc</th>
                                            <th>Branch</th>
                                             <th>Status</th>
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
                    <h4 class="modal-title" id="myModelLabel">&nbsp; Vehicle Master Info</h4>
                </div>
                <div class="modal-body">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <h5 style="color: #2196f3;display:none;">Vehicle Master Info</h5>
                      
                               <div class="row">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">Supplier</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                    <asp:DropDownList runat="server" ID="ddlSupplier" CssClass="form-control form-control1">
                                                        
                                                    </asp:DropDownList>
                                                            </div>
                                                </div>
                                            </div>
                                        </div>
                                     <div class="row" >
                                       
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
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                                <div class="col-md-6 col-xs-12">

                                            <label >Vehicle Reg No.</label>
                                                    </div>
                                                <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtvehno" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                                    </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                 <div class="row">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">Average Mileage</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                     <asp:TextBox runat="server" ID="txtavgmilage" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                                            </div>
                                                </div>
                                            </div>
                                        </div>
                               <div class="row">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">Engine No.</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                     <asp:TextBox runat="server" ID="txtengineno" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                                            </div>
                                                </div>
                                            </div>
                                        </div>
                                  <div class="row">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">Chasis No.</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                     <asp:TextBox runat="server" ID="txtchasisno" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
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
                                                    <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control form-control1" onchange="getallBranches();" >
                                                        
                                                    </asp:DropDownList>
                                                            </div>
                                                </div>
                                            </div>
                                        </div>
                                <div class="row">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">Branch</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                    <asp:DropDownList runat="server" ID="ddlbranch" CssClass="form-control form-control1">
                                                        
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

                            </div>
                       
                    
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnClose" Text="Close" class="btn btn-default" data-dismiss="modal" />
                    <asp:Button runat="server" ID="btnsave" Text="Save" class="btn btn-success" OnClientClick="return SaveValidation();" OnClick="btnsave_Click1" />

                </div>
            </div>
        </div>
    </div>
</asp:Content>