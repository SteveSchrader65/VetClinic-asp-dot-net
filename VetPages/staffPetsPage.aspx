<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="staffPetsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.staffPetsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left:110px; width:1300px; position:absolute; top:110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Pets Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px"/>
        <br />
        <br />
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="2%">
        </asp:Panel>
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="26%">
            <div>
                <asp:TextBox ID="tbxTitle1" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="12pt" Font-Underline="True" Text="" Width="69px"/>
                <asp:DetailsView ID="staffPetDetailsView" runat="server" Height="40px" Width="297px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Left"> 
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
                <asp:TextBox ID="tbxTitle2" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="12pt" Font-Underline="True" Text="" Width="130px"/>
                <br />
                <asp:TextBox ID="tbxMedicalHistory" runat="server" Height="155px" TextMode="MultiLine" Width="340px" ReadOnly="True" BorderStyle="Double" MaxLength="4000" Visible="false"/>
            </div>
        </asp:Panel> 
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="2%">
        </asp:Panel>
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="56%">
             <div>
                 <asp:GridView ID="staffPetsGridView" runat="server" Width="690px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" 
                     CellPadding="2" ForeColor="Black" PageSize="6" ShowHeaderWhenEmpty="False" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                     CurrentSortField="PetID" CurrentSortDirection="ASC"
                     OnSelectedIndexChanged="StaffPetsGridView_SelectedIndexChanged"
                     OnPageIndexChanging="StaffPetsGridView_PageIndexChanging" 
                     OnSorting="StaffPetsGridView_Sorting" 
                     OnRowDataBound="StaffPetsGridView_RowDataBound">
                     <AlternatingRowStyle BackColor="PaleGoldenrod" />
                     <HeaderStyle BackColor="Tan" Font-Bold="True" />
                     <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                     <SelectedRowStyle BackColor="LightCyan"/>
                     <EmptyDataTemplate>
                         <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminPetsGridView"
                             style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                             <tr style="background-color: Tan; font-weight: bold;" />
                             <td "col">Name</td>
                             <td "col">Breed</td>
                             <td "col">Gender</td>
                             <td "col">Birth Date</td>
                             <tr style="color: black; background-color: PaleGoldenrod">
                                 <td colspan="6">There are no Pets to display
                                 </td>
                             </tr>
                         </table>
                     </EmptyDataTemplate>
                     <SortedAscendingCellStyle BackColor="#FAFAE7" />
                     <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                     <SortedDescendingCellStyle BackColor="#E1DB9C" />
                     <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                     <Columns>
				         <asp:CommandField ButtonType="Button" CausesValidation="False" ItemStyle-Width="65px" ShowCancelButton="False" ShowSelectButton="True" />
                         <asp:BoundField DataField="PetID" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="Owner" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" ReadOnly="True" />
                         <asp:BoundField DataField="Pet Name" HeaderText="Pet Name" ItemStyle-Width="100px" SortExpression="Pet Name" ReadOnly="True" />
                         <asp:BoundField DataField="Breed" HeaderText="Breed" ItemStyle-Width="200px" SortExpression="Breed" ReadOnly="True" />
                         <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-Width="50px" SortExpression="Gender" ReadOnly="True" />
                         <asp:BoundField DataField="Birth Date" HeaderText="Birth Date" ItemStyle-Width="100px" SortExpression="Birth Date" ReadOnly="True" />
                         <asp:BoundField DataField="PetMedicalHistory" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" />
                     </Columns>
                 </asp:GridView>
             </div>
             <br />
             <asp:Label ID="lblPetSearch" runat="server" Font-Bold="True" Text="Search Pet Name: "></asp:Label>
             <asp:TextBox ID="tbxPetSearch" runat="server" Width="236px"></asp:TextBox>
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
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnerTable_Clicked" Text="Customers" ToolTip="Display Pet-Owners Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" ToolTip="You are Here" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" ToolTip="Display Medications Table" Width="130px" />
         </asp:Panel>
    </div>

</asp:Content>
