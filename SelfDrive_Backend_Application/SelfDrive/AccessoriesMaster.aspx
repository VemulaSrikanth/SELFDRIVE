<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AccessoriesMaster.aspx.cs" Inherits="SelfDrive.AccessoriesMaster"  EnableEventValidation="false" %>
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
           

            if (document.getElementById("<%= txtaccessname.ClientID %>").value == "") {
                document.getElementById("<%= txtaccessname.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtaccessname.ClientID %>").style.borderColor = "#ccc";
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

            document.getElementById("<%= txtaccessname.ClientID %>").value = '';
            
            var CompanyId = document.getElementById("<%=hcompanyid.ClientID %>").value;
           
            document.getElementById("<%= txtaccessname.ClientID %>").style.borderColor = "#ccc";
            

        }
    </script>
    <script lang="javascript" type="text/javascript">

        function FillDetails(accsid, accsname, status, accsdescription, vehsegids, companyId) {
        
           
            document.getElementById("<%= huserprofile.ClientID %>").value = accsid;
            document.getElementById("<%= txtaccessname.ClientID %>").value = accsname;
            document.getElementById("<%= txtDescription.ClientID %>").value = accsdescription;

            //alert(tdsapplystatus);
            <%-- var EmployeeId1 = document.getElementById("<%=ddlemployee.ClientID %>");
            for (var i = 0; i < EmployeeId1.options.length; i++) {
                alert(EmployeeId1.options[i].value);
                alert(employeeid);
                if (EmployeeId1.options[i].value === employeeid) {
                    EmployeeId1.selectedIndex = i;
                    break;
                }
            }--%>

            var CHK = document.getElementById("<%=chkVehicles.ClientID%>");
           var checkbox = CHK.getElementsByTagName("input");
           var counter = 0;

           var ArrPaxVehSegs = vehsegids.split(",");
           if (ArrPaxVehSegs != null && ArrPaxVehSegs.length > 0) {
               for (var i = 0; i < checkbox.length; i++) {
                   for(var k=0; k < ArrPaxVehSegs.length; k++)
                   {
                       if(checkbox[i].value == ArrPaxVehSegs[k])
                       {
                           checkbox[i].checked = true;
                       }
                   }
                  
               }
           }

            var Status1 = document.getElementById("<%=ddlprofilestatus.ClientID %>");
            for (var i = 0; i < Status1.options.length; i++) {
                if (Status1.options[i].text === status) {
                    Status1.selectedIndex = i;
                    break;
                }
            }

          
            document.getElementById("<%= txtaccessname.ClientID %>").style.borderColor = "#ccc";
            

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
                justify-content: left !important;
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
                <h4>&nbsp;Accessories Master</h4>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 " style="padding-top: 15px;">
                <div class="form-group fa-pull-right ">
                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="NewUserProfile();">New Accessories</a>
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
                                            <th>Name</th>
                                            <th>Description</th>
                                            <th>Status</th>
                                            <th>Vehicle Segments </th>
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
                    <h4 class="modal-title" id="myModelLabel">&nbsp; Accessories Info</h4>
                </div>
                <div class="modal-body">
                    <div class="col-md-12 col-sm-12 col-xs-12 text-left">
                        <h5 style="color: #2196f3;display:none;">Accessories Info</h5>
                        <div class="row" style="margin-bottom:10px;">
                       
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="col-md-6 col-xs-12">
                                            <label>Accessories Name</label></div>
                                            <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtaccessname" CssClass="form-control form-control1" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                             <div class="col-md-6 col-xs-12">
                                            <label>Description</label>
                                                 </div>
                                             <div class="col-md-6 col-xs-12">
                                            <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control form-control1"  TextMode="MultiLine" autocomplete="off"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                 <div class="row">
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                             <div class="col-md-6 col-xs-12">
                                            <label >Vehicle Segments</label>
                                                 </div>
                                             <div class="col-md-6 col-xs-12">
                                            <asp:Checkboxlist ID="chkVehicles"  runat="server"></asp:Checkboxlist>
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
                                                    <asp:DropDownList runat="server" ID="ddlprofilestatus" CssClass="form-control form-control1">
                                                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                        <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                                    </asp:DropDownList>
                                                              </div>
                                                </div>
                                            </div>
                                        </div>

                            </div>
                           
                        
                    
                </div>
                <div class="modal-footer" style="margin-top: 160px !important;">
                    <asp:Button runat="server" ID="btnClose" Text="Close" class="btn btn-default" data-dismiss="modal" />
                    <asp:Button runat="server" ID="btnsave" Text="Save" class="btn btn-success" OnClientClick="return SaveValidation();" OnClick="btnsave_Click1" />

                </div>
            </div>
        </div>
    </div>
</asp:Content>