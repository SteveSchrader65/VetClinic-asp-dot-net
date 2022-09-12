<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DrDoolittleVetClinic._default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="25%">
    </asp:Panel>
    <asp:Panel runat="server" Style="float: right;" Width="70%">
        <br />
        <br />
        <table background-color:"LightGoldenrodYellow" order-color:"Black" border-style:"Solid" borderwidth:"1px" cellpadding:1 cellspacing:0 font-names="Verdana" font-size="10pt" height="235px" style="border-collapse:collapse;" width="427px">
            <tr>
                <td>
                    <table cellpadding:0="" style="height:246px; width:427px; background-color:lightgoldenrodyellow">
                        <tr>
                            <td align:"center"="" colspan="2" style="color:Black;background-color:Tan;font-weight:bold;font-size:large;height:30px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DrDoolittle Vet Clinic Log-In</td>
                        </tr>
                        <tr>
                            <td align:"right"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lblEMail" runat="server" Font-Bold="True" Text="Enter E-Mail: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tbxEMailAddress" runat="server" Width="220px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEMailAddress" runat="server" ValidationGroup="Login" ControlToValidate="tbxEMailAddress" ErrorMessage="E-Mail Address is a required field" Text="*" ForeColor="Red" Font-Bold="True"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align:"right"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lblPassword" runat="server" Font-Bold="True" Text="Enter Password: "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tbxPasswordEntry" runat="server" Width="220px" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPasswordEntry" runat="server" ValidationGroup="Login" ControlToValidate="tbxPasswordEntry" ErrorMessage="Password is a required field" Text="*" ForeColor="Red" Font-Bold="True"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align:"right"="" style="height: 35px">
                            </td>
                            <td align:"right"="">
                            <asp:ValidationSummary ID="vsLoginSummary" runat="server" ValidationGroup="Login" Text="*" ForeColor="Red" Font-Bold="True" />
                            </td>
                        </tr>
                        <tr>
                            <td align:"right"="" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnLogIn" runat="server" BorderStyle="Double" Font-Bold="True" OnClick="BtnLogin_Click" Text="Log-In" ValidationGroup="Login" CausesValidation="True"/>
                            </td>
                        </tr>
                        <tr>
                             <td align:"right"="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>

</asp:Content>