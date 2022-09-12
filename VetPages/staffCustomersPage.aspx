<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="staffCustomersPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.staffCustomersPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left:110px; width:1300px; position:absolute; top:110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
        <asp:TextBox ID="tbxTitle" Text="Customers Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px"/>
        <br />
        <br />
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="2%">
        </asp:Panel>
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="26%">
            <div>
                <asp:TextBox ID="tbxTitle1" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="12pt" Font-Underline="True" Text="" Width="69px"/>
                <asp:DetailsView ID="staffCustomersDetailsView" runat="server" Height="40px" Width="297px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Left">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                </asp:DetailsView>
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <asp:TextBox ID="tbxTitle2" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="12pt" Font-Underline="True" Text="" Width="69px"/>
                <br />
                <asp:ListBox ID="lstOwnedPets" runat="server" Height="59px" Rows="3" Visible="False" Width="134px" Font-Bold="True"></asp:ListBox>
            </div>
        </asp:Panel> 
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="2%">
        </asp:Panel>
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="56%">
             <div>
                 <asp:GridView ID="staffCustomersGridView" runat="server" Width="690px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" 
                     CellPadding="2" ForeColor="Black" PageSize="6" ShowHeaderWhenEmpty="False" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                     CurrentSortField="OwnerID" CurrentSortDirection="ASC"
                     OnSelectedIndexChanged="StaffCustomersGridView_SelectedIndexChanged"
                     OnPageIndexChanging="StaffCustomersGridView_PageIndexChanging"
                     OnSorting="StaffCustomersGridView_Sorting"
                     OnRowDataBound="StaffCustomersGridView_RowDataBound">
                     <AlternatingRowStyle BackColor="PaleGoldenrod" />
                     <HeaderStyle BackColor="Tan" Font-Bold="True" />
                     <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                     <FooterStyle BackColor="Tan" />
                     <SelectedRowStyle BackColor="LightCyan"/>
                    <EmptyDataTemplate>
                        <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminCustomersGridView"
                            style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">First Name</td>
                            <td "col">Last Name</td>
                            <td "col">State</td>
                            <td "col">Postcode</td>
                            <td "col">Phone#</td>
                            <td "col">E-mail</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                                <td colspan="10">There are no Customers to display</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                     <SortedAscendingCellStyle BackColor="#FAFAE7" />
                     <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                     <SortedDescendingCellStyle BackColor="#E1DB9C" />
                     <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                     <Columns>
				         <asp:CommandField ButtonType="Button" CausesValidation="False" ItemStyle-Width="65px" ShowCancelButton="False" ShowSelectButton="True" />
                         <asp:BoundField DataField="OwnerID" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="FirstName" HeaderText="First Name" ItemStyle-Width="100px" SortExpression="FirstName" ReadOnly="True" />
                         <asp:BoundField DataField="LastName" HeaderText="Last Name" ItemStyle-Width="100px" SortExpression="LastName" ReadOnly="True" />
                         <asp:BoundField DataField="Address1" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="Address2" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="State" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="PostCode" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="PhoneNumber" HeaderText="Phone No." ItemStyle-Width="100px" SortExpression="PhoneNumber" ReadOnly="True" />
                         <asp:BoundField DataField="EmailAddress" HeaderText="E-Mail" ItemStyle-Width="200px" SortExpression="EmailAddress" ReadOnly="True" />
                     </Columns>
                 </asp:GridView>
             </div>
             <br />
             <asp:Label ID="lblPetSearch" runat="server" Font-Bold="True" Text="Search Customer Name: "></asp:Label>
             <asp:TextBox ID="tbxCustomerSearch" runat="server" Width="236px"></asp:TextBox>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnSearch" runat="server" Font-Bold="True" Text="Search" BackColor="LightGray" OnClick="BtnSearch_Click" />
            <br />
            <br />
            <br />             
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" ToolTip="Display Appointments Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnerTable_Clicked" Text="Customers" ToolTip="You are Here" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" ToolTip="Display Pets Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" ToolTip="Display Medications Table" Width="130px" />
         </asp:Panel>
    </div>

</asp:Content>
