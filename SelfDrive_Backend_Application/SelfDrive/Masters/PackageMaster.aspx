<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PackageMaster.aspx.cs" MasterPageFile="~/Site1.Master" Inherits="SelfDrive.Masters.PackageMaster" %>

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
            document.getElementById("<%= htariffid.ClientID %>").value = IdToBeDeleted;
            document.getElementById("<%=btnDelete.ClientID%>").click();
        }
    </script>
    <script lang="javascript" type="text/javascript">
        function SaveValidation() {
           
            var flag = true;
            var errmsg = '';
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


            if (document.getElementById("<%= txtpackagename.ClientID %>").value == "") {
                document.getElementById("<%= txtpackagename.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtpackagename.ClientID %>").style.borderColor = "#ccc";
            }

            if (document.getElementById("<%= txtBasicRate.ClientID %>").value == "") {
                document.getElementById("<%= txtBasicRate.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtBasicRate.ClientID %>").style.borderColor = "#ccc";
            }

            if (document.getElementById("<%= txtalwhrs.ClientID %>").value == "") {
                document.getElementById("<%= txtalwhrs.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtalwhrs.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtalwkms.ClientID %>").value == "") {
                document.getElementById("<%= txtalwkms.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtalwkms.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtExtraKmRate.ClientID %>").value == "") {
                document.getElementById("<%= txtExtraKmRate.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtExtraKmRate.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtgracehrRate.ClientID %>").value == "") {
                document.getElementById("<%= txtgracehrRate.ClientID %>").style.borderColor = "Red";
                 errmsg += "";
                 flag = false;
             }
             else {
                 document.getElementById("<%= txtgracehrRate.ClientID %>").style.borderColor = "#ccc";
             }
             if (document.getElementById("<%= txtgracehrs.ClientID %>").value == "") {
                document.getElementById("<%= txtgracehrs.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {
                document.getElementById("<%= txtgracehrs.ClientID %>").style.borderColor = "#ccc";
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
        function NewPackage() {
            $('#<%= btnsave.ClientID %>').show();
            document.getElementById("<%= btnsave.ClientID %>").disabled = false;
            document.getElementById("<%= htariffid.ClientID %>").value = 'New';

            document.getElementById("<%= txtpackagename.ClientID %>").value = '';
            document.getElementById("<%= txtBasicRate.ClientID %>").value = '';
            document.getElementById("<%= txtSecDeposit.ClientID %>").value = '';
            document.getElementById("<%= txtalwkms.ClientID %>").value = '';
            document.getElementById("<%= txtalwhrs.ClientID %>").value = '';
            document.getElementById("<%= txtgracehrs.ClientID %>").value = '';
            document.getElementById("<%= txtgracehrRate.ClientID %>").value = '';
            document.getElementById("<%= txtExtraKmRate.ClientID %>").value = '';

            document.getElementById("<%= ddlLocation.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlVehicleseg.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlfuelstatus.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlRatetype.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlstatus.ClientID %>").selectedIndex = 0;
           
            document.getElementById("<%= ddlstatus.ClientID %>").disabled = true;

            var CompanyId = document.getElementById("<%=hcompanyid.ClientID %>").value;

            document.getElementById("<%= ddlLocation.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%=ddlVehicleseg.ClientID%>").style.borderColor = "#ccc";
            document.getElementById("<%= txtpackagename.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtBasicRate.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtSecDeposit.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtalwkms.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtalwhrs.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtgracehrs.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtgracehrRate.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtExtraKmRate.ClientID %>").style.borderColor = "#ccc";

        }

    </script>
    <script lang="javascript" type="text/javascript">

        function FillDetails(tariffid, segid, packagename, basicrate, ratetype, securitydeposit, fuelcoststatus, slid, tariffstatus, allowedkms, allowedhrs, gracehrs, gracehrrate, extrakmrate, companyid) {

            document.getElementById("<%= htariffid.ClientID %>").value = tariffid;

            var DDlVehseg = document.getElementById("<%=ddlVehicleseg.ClientID %>");
            for (var i = 0; i < DDlVehseg.options.length; i++) {
                if (DDlVehseg.options[i].value == segid) {
                    DDlVehseg.selectedIndex = i;
                    break;
                }
            }
            var Status1 = document.getElementById("<%=ddlstatus.ClientID %>");
            for (var i = 0; i < Status1.options.length; i++) {
                if (Status1.options[i].text == tariffstatus) {
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
            var Ratetype1 = document.getElementById("<%=ddlRatetype.ClientID %>");
            for (var i = 0; i < Ratetype1.options.length; i++) {
                if (Ratetype1.options[i].text == ratetype) {
                    Ratetype1.selectedIndex = i;
                    break;
                }
            }
            var Fuel1 = document.getElementById("<%=ddlfuelstatus.ClientID %>");
            for (var i = 0; i < Fuel1.options.length; i++) {
                if (Fuel1.options[i].text == fuelcoststatus) {
                    Fuel1.selectedIndex = i;
                    break;
                }
            }

            document.getElementById("<%= txtpackagename.ClientID %>").value = packagename;
            document.getElementById("<%= txtBasicRate.ClientID %>").value = basicrate;
            document.getElementById("<%= txtSecDeposit.ClientID %>").value = securitydeposit;
            document.getElementById("<%= txtalwkms.ClientID %>").value = allowedkms;
            document.getElementById("<%= txtalwhrs.ClientID %>").value = allowedhrs;
            document.getElementById("<%= txtgracehrs.ClientID %>").value = gracehrs;
            document.getElementById("<%= txtgracehrRate.ClientID %>").value = gracehrrate;
            document.getElementById("<%= txtExtraKmRate.ClientID %>").value = extrakmrate;

            document.getElementById("<%= txtpackagename.ClientID %>").style.borderColor = "#ccc";

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
                max-width: 700px !important;
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
        .form-control1
        {
            width:130px !important;
        }
        .row{
                margin-top: 6px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:HiddenField runat="server" ID="hstaffid" />
    <asp:HiddenField runat="server" ID="hcompanyid" />
    <asp:HiddenField runat="server" ID="htariffid" />
    <asp:HiddenField runat="server" ID="hEmpId" />
    <asp:HiddenField runat="server" ID="hemployeeId" />
    <asp:HiddenField runat="server" ID="hbrid" />
    <asp:Button runat="server" ID="btnDelete" Style="display: none;" OnClick="btnDelete_Click" />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="row" style="padding: 0px 20px;">
            <div class="col-md-4 col-sm-12 col-xs-12" style="padding-top: 15px;">
                <h4>&nbsp;Package Master</h4>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 " style="padding-top: 15px;">
                <div class="form-group fa-pull-right ">
                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="NewPackage();">New Package</a>
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
                                            <th>Package Name</th>
                                            <th>Vehicle Segment</th>
                                            <th>Service Location</th>
                                            <th>Allowed Kms</th>
                                            <th>Allowed Hrs</th>
                                            <th>Basic Rate</th>
                                            <th>Rate Type</th>
                                            <th>Security Deposit</th>
                                            <th>Fuel Cost Status </th>
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
                    <h4 class="modal-title" id="myModelLabel">&nbsp; Package Master Info</h4>
                </div>
                <div class="modal-body">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <h5 style="color: #2196f3; display: none;">Package Master Info</h5>

                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="row">

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Service Location</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control form-control1" onchange="getallBranches();">
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
                                                <asp:DropDownList runat="server" ID="ddlVehicleseg" CssClass="form-control form-control1">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">

                                                <label>Package Name</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtpackagename" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Allowed Kms</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtalwkms" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Allowed hrs</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtalwhrs" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Grace hrs</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtgracehrs" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                                <label for="exampleInputEmail1">Grace hr Rate</label>
                                            </div>
                                            <div class="col-md-6 col-xs-12">
                                                <asp:TextBox runat="server" ID="txtgracehrRate" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
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
                                            <label for="exampleInputEmail1">Extra Km Rate</label>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtExtraKmRate" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-6 col-xs-12">
                                            <label for="exampleInputEmail1">Basic Rate</label>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtBasicRate" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-6 col-xs-12">
                                            <label for="exampleInputEmail1">Rate Type</label>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <asp:DropDownList runat="server" ID="ddlRatetype" CssClass="form-control form-control1">
                                                <asp:ListItem Text="Per Hour" Value="PerHour"></asp:ListItem>
                                                <asp:ListItem Text="Per Day" Value="PerDay"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-6 col-xs-12">
                                            <label for="exampleInputEmail1">Fuel Cost Status</label>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <asp:DropDownList runat="server" ID="ddlfuelstatus" CssClass="form-control form-control1">
                                                <asp:ListItem Text="N" Value="N"></asp:ListItem>
                                                <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="col-md-6 col-xs-12">
                                            <label for="exampleInputEmail1">Security Deposit</label>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtSecDeposit" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
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








                </div>


            </div>
            <div class="modal-footer">
                <asp:Button runat="server" ID="btnClose" Text="Close" class="btn btn-default" data-dismiss="modal" />
                <asp:Button runat="server" ID="btnsave" Text="Save" class="btn btn-success" OnClientClick="return SaveValidation();" OnClick="btnsave_Click" />

            </div>
        </div>
    </div>
       
</asp:Content>
