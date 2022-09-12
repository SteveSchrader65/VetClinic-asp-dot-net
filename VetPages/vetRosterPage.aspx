<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="vetRosterPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.UpdateRoster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1325px; position: absolute; top: 110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Staff Roster" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="15%">
            <asp:TextBox ID="TextBox1" runat="server" BorderStyle="None" Style="width: 20%; max-width: 20%"></asp:TextBox>
        </asp:Panel> 
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="80%">    
        </asp:Panel>
        <br />
        <br />
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="20%">
            <asp:TextBox ID="aFiller" runat="server" BorderStyle="None" Style="width: 20%; max-width: 20%"></asp:TextBox>
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="35%">
            <div style="height: 319px; width: 384px">
                <asp:Label ID="lblVetRoster" runat="server" Text="Vet Details" Font-Bold="True" Font-Size="12pt" Font-Underline="True"></asp:Label>
                <br />
                <asp:DetailsView ID="vetDetailsView" runat="server" Height="40px" Width="297px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Left">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                </asp:DetailsView>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="3%">
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="40%">
            <br />
            <br />
            <asp:Label ID="lblAvailable" runat="server" Text="Availability" Font-Bold="True" Font-Size="12pt" Font-Underline="True"></asp:Label>
            <br />
            <asp:CheckBox ID="chkDay1" runat="server" Text="Sunday" Font-Size="13pt"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:CheckBox ID="chkDay5" runat="server" Text="Thursday" Font-Size="13pt"/>
            <br />
            <asp:CheckBox ID="chkDay2" runat="server" Text="Monday" Font-Size="13pt"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkDay6" runat="server" Text="Friday" Font-Size="13pt"/>
            <br />
            <asp:CheckBox ID="chkDay3" runat="server" Text="Tuesday" Font-Size="13pt"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:CheckBox ID="chkDay7" runat="server" Text="Saturday" Font-Size="13pt"/>
            <br />
            <asp:CheckBox ID="chkDay4" runat="server" Text="Wednesday" Font-Size="13pt"/>
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnUpdateRoster" runat="server" Font-Bold="True" OnClick="BtnUpdateRoster_Click" Text="Update Roster" BackColor="LightGray" />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="3%">
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnExit" runat="server" Font-Bold="True" Text="Exit" BackColor="LightGray" OnClick="BtnExit_Click" />
        </asp:Panel>
    </div>

</asp:Content>
