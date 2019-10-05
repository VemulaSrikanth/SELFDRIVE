<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="CompanyMaster.aspx.cs" Inherits="SelfDrive.Masters.CompanyMaster" %>
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
            document.getElementById("<%= hcompanyid.ClientID %>").value = IdToBeDeleted;
            document.getElementById("<%=btncmpdelete.ClientID%>").click();
        }
    </script>
    <script lang="javascript" type="text/javascript">
        function SaveValidation() {
            var flag = true;
            var errmsg = '';


            if (document.getElementById("<%= txtcompany.ClientID %>").value == "") {
                document.getElementById("<%= txtcompany.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtcompany.ClientID %>").style.borderColor = "#ccc";
            }

            if (document.getElementById("<%= txtadd1.ClientID %>").value == "") {
                document.getElementById("<%= txtadd1.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtadd1.ClientID %>").style.borderColor = "#ccc";
            }

            if (document.getElementById("<%= txtcity.ClientID %>").value == "") {
                document.getElementById("<%= txtcity.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtcity.ClientID %>").style.borderColor = "#ccc";
            }
            if (document.getElementById("<%= txtpincode.ClientID %>").value == "") {
                document.getElementById("<%= txtpincode.ClientID %>").style.borderColor = "Red";
                errmsg += "";
                flag = false;
            }
            else {

                document.getElementById("<%= txtpincode.ClientID %>").style.borderColor = "#ccc";
            }
             
            var gstno = document.getElementById("<%= txtGSTno.ClientID %>");
            if (gstno != null && gstno.value.length > 0) {
                if (gstno.value.length != 16) {
                    document.getElementById("<%= txtGSTno.ClientID %>").style.borderColor = "Red";
                    errmsg += "";
                    flag = false;
                }
                else {

                        document.getElementById("<%= txtGSTno.ClientID %>").style.borderColor = "#ccc";
                    }
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
        function Newcompany() {
           $('#<%= btnsave.ClientID %>').show();
            document.getElementById("<%= btnsave.ClientID %>").disabled = false;
            document.getElementById("<%= hCmpflag.ClientID %>").value = 'New';

            document.getElementById("<%= txtcompany.ClientID %>").value = '';
            document.getElementById("<%= txtadd1.ClientID %>").value = '';
            document.getElementById("<%= txtadd2.ClientID %>").value = '';
            document.getElementById("<%= txtcity.ClientID %>").value = '';
            document.getElementById("<%= txtpincode.ClientID %>").value = '';
            document.getElementById("<%= txtpanno.ClientID %>").value = '';
            document.getElementById("<%= txtGSTno.ClientID %>").value = '';
            document.getElementById("<%= txtcolorlogo.ClientID %>").value = '';
            document.getElementById("<%= txtblacklogo.ClientID %>").value = '';
            var CompanyId = document.getElementById("<%=hcompanyid.ClientID %>").value;

            var UnitStatus = document.getElementById("<%=ddlunitstatus.ClientID %>");

            UnitStatus.selectedIndex = 0;
            document.getElementById("<%= ddlunitstatus.ClientID %>").disabled = true;
            
            document.getElementById("<%= txtcompany.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtadd1.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtcity.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtpincode.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtcolorlogo.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtblacklogo.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtpanno.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtGSTno.ClientID %>").style.borderColor = "#ccc";
        }
    </script>
    <script lang="javascript" type="text/javascript">

        function FillDetails(companyid, companyname, address1, address2, city, pincode, colorlogo, blacklogo, panno,
            gstno,unitstatus) {
            
            document.getElementById("<%= hCmpflag.ClientID %>").value = companyid;
                document.getElementById("<%= txtcompany.ClientID %>").value = companyname;

            document.getElementById("<%= txtadd1.ClientID %>").value = address1;
            document.getElementById("<%= txtadd2.ClientID %>").value = address2;
            document.getElementById("<%= txtcity.ClientID %>").value = city;
            document.getElementById("<%= txtpincode.ClientID %>").value = pincode;
            document.getElementById("<%= txtcolorlogo.ClientID %>").value = colorlogo;
            document.getElementById("<%= txtblacklogo.ClientID %>").value = blacklogo;
            document.getElementById("<%= txtpanno.ClientID %>").value = panno;
            document.getElementById("<%= txtGSTno.ClientID %>").value = gstno;

            var Unitstatus1 = document.getElementById("<%=ddlunitstatus.ClientID %>");
            for (var i = 0; i < Unitstatus1.options.length; i++) {
                if (Unitstatus1.options[i].text === unitstatus) {
                    Unitstatus1.selectedIndex = i;
                    break;
                }
            }
             document.getElementById("<%= ddlunitstatus.ClientID %>").disabled = false;
            
            document.getElementById("<%= txtcompany.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtadd1.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtcity.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtpincode.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtcolorlogo.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtblacklogo.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtpanno.ClientID %>").style.borderColor = "#ccc";
            document.getElementById("<%= txtGSTno.ClientID %>").style.borderColor = "#ccc";

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
                max-width: 500px !important;
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
    <asp:HiddenField runat="server" ID="hcompanyid" />
    <asp:HiddenField runat="server" ID="hCmpflag" />
    <asp:HiddenField runat="server" ID="hEmpId" />
    <asp:HiddenField runat="server" ID="hemployeeId" />
    <asp:HiddenField runat="server" ID="hemployeename" />
    <asp:Button runat="server" ID="btncmpdelete" Style="display: none;" OnClick="btncmpdelete_Click" />
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="row" style="padding: 0px 20px;">
            <div class="col-md-4 col-sm-12 col-xs-12" style="padding-top: 15px;">
                <h4>&nbsp;Company Master</h4>
            </div>
            <div class="col-md-6 col-sm-12 col-xs-12">
                <asp:Label runat="server" ID="lblmessage" CssClass="alert-info"></asp:Label>
            </div>
            <div class="col-md-2 col-sm-12 col-xs-12 " style="padding-top: 15px;">
                <div class="form-group fa-pull-right ">
                    <a class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="Newcompany();">New Company</a>
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
                                            <th>Company Name</th>
                                            <th>Address</th>
                                            <th>City</th>
                                            <th>Pin Code</th>
                                            <th>Pan No.</th>
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
                    <h4>&nbsp; Company Information</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="row">
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    
                                    <div class="col-md-8 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label style="color: red;">Company Name</label>
                                            <div id="divtxcompany">
                                                <asp:TextBox runat="server" ID="txtcompany" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-10 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label style="color: red;">Address1</label>
                                            <asp:TextBox runat="server" ID="txtadd1" CssClass="form-control form-control1"   TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label>Address2</label>
                                            <asp:TextBox runat="server" ID="txtadd2" CssClass="form-control form-control1"   TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label style="color: red;">City</label>
                                                    <asp:TextBox runat="server" ID="txtcity" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-10 col-sm-12 col-xs-12">
                                        <div class="form-group">
                                            <label style="color: red;">Pin Code</label>
                                                    <asp:TextBox runat="server" ID="txtpincode" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="col-md-6 col-sm-6 col-xs-12">
                                    <div class="col-md-10 col-sm-12 col-xs-12">
                                        <div class="row">
                                            <div class="col-md-8 col-xs-12">
                                                <div class="form-group">
                                                    <label style="color: red;">Color Logo</label>
                                                    <asp:TextBox runat="server" ID="txtcolorlogo" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-8 col-sm-12 col-xs-12">
                                                <div class="form-group">
                                                    <label style="color: red;">Black Logo</label>
                                                    <asp:TextBox runat="server" ID="txtblacklogo" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="col-md-10 col-sm-12 col-xs-12">
                                        <div class="row">
                                            <div class="col-md-8 col-xs-12">
                                                <div class="form-group">
                                                    <label>PAN No.</label>
                                                    <asp:TextBox runat="server" ID="txtpanno" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-8 col-xs-12">
                                                <div class="form-group">
                                                    <label>GST No.</label>
                                                    <asp:TextBox runat="server" ID="txtGSTno" MaxLength="16" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-8 col-sm-12 col-xs-12">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <asp:DropDownList runat="server" ID="ddlunitstatus" CssClass="form-control">
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
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnClose" Text="Close" class="btn btn-default" data-dismiss="modal" />
                    <asp:Button runat="server" ID="btnsave" Text="Save" class="btn btn-success" OnClientClick="return SaveValidation();" OnClick="btnsave_Click" />

                </div>
            </div>
        </div>
    </div>

</asp:Content>