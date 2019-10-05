<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ServiceLocationMaster.aspx.cs" Inherits="SelfDrive.ServiceLocationMaster"   EnableEventValidation="false" %>

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
           

            if (document.getElementById("<%= txtlocationname.ClientID %>").value == "") {
                document.getElementById("<%= txtlocationname.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtlocationname.ClientID %>").style.borderColor = "#ccc";
            }

             var IndexValue = document.getElementById('<%=ddlState.ClientID %>').selectedIndex;
                var SelectedVal = document.getElementById('<%=ddlState.ClientID %>').options[IndexValue].text;

            if(SelectedVal == "Select")
            {
                document.getElementById("<%= ddlState.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else{
                document.getElementById("<%= ddlState.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtcode.ClientID %>").value == "") {
                document.getElementById("<%= txtcode.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtcode.ClientID %>").style.borderColor = "#ccc";
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

            document.getElementById("<%= txtlocationname.ClientID %>").value = '';
            
            var CompanyId = document.getElementById("<%=hcompanyid.ClientID %>").value;
           
            document.getElementById("<%= txtlocationname.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtcode.ClientID %>").value = '';

            

        }
    </script>
    <script lang="javascript" type="text/javascript">

        function FillDetails(slid, stateid, slname, slcode, status, companyId) {

          
            document.getElementById("<%= huserprofile.ClientID %>").value = slid;
            document.getElementById("<%= txtlocationname.ClientID %>").value = slname;
            document.getElementById("<%= txtcode.ClientID %>").value = slcode;


            var DDlState = document.getElementById("<%=ddlState.ClientID %>");
            for (var i = 0; i < DDlState.options.length; i++) {

                if (DDlState.options[i].value === stateid) {
                    DDlState.selectedIndex = i;
                    break;
                }
            }

                var Status1 = document.getElementById("<%=ddlstatus.ClientID %>");
                for (var i = 0; i < Status1.options.length; i++) {
                    if (Status1.options[i].text === status) {
                        Status1.selectedIndex = i;
                        break;
                    }
                }




                document.getElementById("<%= txtlocationname.ClientID %>").style.borderColor = "#ccc";


            
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField runat="server" ID="hstaffid" />
    <asp:HiddenField runat="server" ID="hcompanyid" />
    <asp:HiddenField runat="server" ID="huserprofile" />
    <asp:HiddenField runat="server" ID="hEmpId" />
    <asp:HiddenField runat="server" ID="hemployeeId" />
    <asp:HiddenField runat="server" ID="hemployeename" />
    <asp:Button runat="server" ID="btnUserProfile" Style="display: none;" OnClick="btnUserProfileDelete_Click" />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="row" style="padding: 0px 20px;">
            <div class="col-md-4 col-sm-12 col-xs-12" style="padding-top: 15px;">
                <h4>&nbsp;Location Master</h4>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 " style="padding-top: 15px;">
                <div class="form-group fa-pull-right ">
                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="NewUserProfile();">New Location</a>
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
                                            <th>Location Name</th>
                                            <th>State</th>
                                            <th>Location Code</th>
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
                    <h4 class="modal-title" id="myModelLabel">&nbsp; Location Master Info</h4>
                </div>
                <div class="modal-body">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <h5 style="color: #2196f3;display:none;">Location Master Info</h5>
                       
                                <div class="row" style="margin-bottom:10px;">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                                <div class="col-md-6 col-xs-12">

                                            <label >Location Name</label>
                                                    </div>
                                                <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtlocationname" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                                    </div>
                                            
                                        </div>
                                    </div>
                                </div>
                                 <div class="row" style="margin-bottom:10px;">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">State</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                    <asp:DropDownList runat="server" ID="ddlState" CssClass="form-control form-control1">
                                                        
                                                    </asp:DropDownList>
                                                            </div>
                                                </div>
                                            </div>
                                        </div>
                               <div class="row" style="margin-bottom:10px;">
                                       
                                            <div class="col-md-12 col-xs-12">
                                                <div class="form-group">
                                                        <div class="col-md-6 col-xs-12">
                                                    <label for="exampleInputEmail1">Location Code</label>
                                                            </div>
                                                        <div class="col-md-6 col-xs-12">
                                                    <asp:TextBox ID="txtcode" runat="server" CssClass="form-control form-control1" TabIndex="2"
                        MaxLength="3" onkeypress="OnlyNumeric(event);"></asp:TextBox>
                                                            </div>
                                                </div>
                                            </div>
                                        </div>
                                 <div class="row" style="margin-bottom:10px;">
                                       
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