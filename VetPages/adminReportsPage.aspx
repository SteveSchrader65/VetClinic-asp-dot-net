<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminReportsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.adminReportsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel runat="server" Style="padding-left: 0" Width="100%">
        <div style="left: 110px; width: 1300px; position: absolute; top: 110px;">
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="tbxTitle" Text="Reports Page" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
            <br />
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="25%">
                <asp:TextBox ID="tbxSpacer" runat="server" BorderStyle="None" Width="200px" />
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="70%">
                <br />
                <br />
                <asp:GridView ID="grdReportDisplay" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" 
                              ForeColor="Black" GridLines="None" OnRowDataBound="GrdReportDisplay_RowDataBound" ShowHeaderWhenEmpty="True"
                              PageSize="15" AllowPaging="True" OnPageIndexChanging="GrdReportDisplay_PageIndexChanging">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <FooterStyle BackColor="Tan" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                </asp:GridView>
                <br />
                <br />
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="10%">
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="40%">
                <br />
                <asp:Label ID="lblReportType" runat="server" Font-Bold="True" Font-Size="14pt" Font-Underline="True" Text="Select Report Type" />
                <br />
                <br />
                <asp:RadioButtonList ID="rblReportType" runat="server" Width="221px" ToolTip="SELECT type of Report to be displayed">
                    <asp:ListItem>Income - Preview</asp:ListItem>
                    <asp:ListItem Text="Income - Vet"></asp:ListItem>
                    <asp:ListItem Text="Income - Customer"></asp:ListItem>
                    <asp:ListItem Text="Sales - Medication"></asp:ListItem>
                </asp:RadioButtonList>
                <br />
                <br />
                <br />
                <br />
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="10%">
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="20%">
                <br />
                <asp:Label ID="lblReportLayout" runat="server" Text="Select Report Layout" Font-Bold="True" Font-Underline="True" Font-Size="14pt" />
                <br />
                <br />
                <asp:RadioButtonList ID="rblReportLayout" runat="server" ToolTip="SELECT break-down for this Report">
                    <asp:ListItem Text="Weekly"></asp:ListItem>
                    <asp:ListItem Text="Monthly"></asp:ListItem>
                    <asp:ListItem Text="Quarterly"></asp:ListItem>
                </asp:RadioButtonList>
                <br />
                <br />
                <asp:Button ID="btnCollate" runat="server" BackColor="LightGreen" Font-Bold="True" Font-Size="10pt" OnClick="BtnCollate_Click" Text="Collate Report" ToolTip="CLICK to Generate selected Report" />
                <br />
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
            </asp:Panel>
            <asp:Panel runat="server" Style="float: right; padding-left: 0" Width="20%">
                <br />
                <asp:Label ID="lblReportPeriod" runat="server" Text="Select Report Period" Font-Bold="True" Font-Underline="True" Font-Size="14pt" />
                <br />
                <br />
                <asp:Label ID="lblReportSearch1" runat="server" Font-Bold="True" Text="   From: "></asp:Label>
                <asp:TextBox ID="tbxReportDate1" runat="server" TextMode="Date" Width="145px" AutoPostBack="True" OnTextChanged="TbxReportDate1_TextChanged" ToolTip="SELECT starting date for Report from calendar"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                <asp:Label ID="lblReportSearch2" runat="server" Font-Bold="True" Text="   To  : "></asp:Label>
                &nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="tbxReportDate2" runat="server" TextMode="Date" Width="145px" AutoPostBack="True" OnTextChanged="TbxReportDate2_TextChanged" ToolTip="SELECT end date for Report from calendar"></asp:TextBox>
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnClearSearch" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnClearSearch" Text="Clear" ToolTip="Clear Search Fields" Width="75px" BorderStyle="Solid" CausesValidation="False" Visible="False" Font-Size="10pt" />
            </asp:Panel>
            <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="100%">
            <br />
            &nbsp;&nbsp;
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" ToolTip="Display Appointments Page" Width="130px" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnersTable_Clicked" Text="Customers" ToolTip="Display Customers Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" ToolTip="Display Pets Table" Width="130px" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnVetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnVetsTable_Clicked" Text="Vets" ToolTip="Display Vet staff Table" Width="130px" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" ToolTip="Display Medications Table" Width="130px" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnReportsPage" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnReportsPage_Clicked" Text="Reports" ToolTip="You are Here" Width="130px" />
            </asp:Panel>
        </div>
    </asp:Panel>

</asp:Content>
