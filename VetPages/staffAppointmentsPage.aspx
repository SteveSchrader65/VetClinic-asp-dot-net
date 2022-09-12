<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="staffAppointmentsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.staffAppointmentsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left:110px; width:1300px; position:absolute; top:110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Appointments Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px"/>
        <br />
        <br />
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="2%">
        </asp:Panel>
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="26%">
            <asp:TextBox ID="tbxTitle1" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="12pt" Font-Underline="True" Text="" Width="69px"/>
                <asp:DetailsView ID="staffAppointmentDetailsView" runat="server" Height="40px" Width="297px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Left" Visible="False"> 
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
                <asp:TextBox ID="tbxTitle2" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="12pt" Font-Underline="True" Text="" Width="200px"/>
                <br />
                <asp:TextBox ID="tbxAppointComment" runat="server" Height="155px" TextMode="MultiLine" Width="315px" ReadOnly="True" BorderStyle="Double" MaxLength="200" Visible="false"/>
        </asp:Panel> 
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="2%">
        </asp:Panel>
        <asp:Panel runat="server" style="float:left; padding-left: 0" Width="56%">
            <div>
                 <asp:GridView ID="staffAppointmentsGridView" runat="server" Width="1000px" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" 
                     CellPadding="2" ForeColor="Black" PageSize="11" ShowHeaderWhenEmpty="False" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                     CurrentSortField="AppointID" CurrentSortDirection="ASC"
                     OnSelectedIndexChanged="StaffAppointmentsGridView_SelectedIndexChanged"
                     OnPageIndexChanging="StaffAppointmentsGridView_PageIndexChanging"
                     OnSorting="StaffAppointmentsGridView_Sorting"
                     OnRowDataBound="StaffAppointmentsGridView_RowDataBound" 
                     OnRowCommand="StaffAppointmentsGridView_RowCommand">
                     <AlternatingRowStyle BackColor="PaleGoldenrod" />
                     <HeaderStyle BackColor="Tan" Font-Bold="True" />
                     <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                     <FooterStyle BackColor="Tan" />
                     <SelectedRowStyle BackColor="LightCyan"/>
                     <SortedAscendingCellStyle BackColor="#FAFAE7" />
                     <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                     <SortedDescendingCellStyle BackColor="#E1DB9C" />
                     <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                     <Columns>
                         <asp:TemplateField ShowHeader="False" ItemStyle-Width="115px">
                            <ItemTemplate>
                                <asp:Button ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select" Text="Details" />
                                <asp:Button ID="btnTreatPet" runat="server" CausesValidation="False" CommandName="TreatPet" CommandArgument='<%# Container.DataItemIndex %>' Text="Treat Pet" Visible="False"/>
                            </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="AppointID" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                             <ItemTemplate>
                                 <asp:Label ID="lblAppointID" runat="server" Text='<%# Bind("AppointID") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>                         
                         <asp:BoundField DataField="Date" HeaderText="Date" ItemStyle-Width="120px" ReadOnly="True" SortExpression="Date">
                         </asp:BoundField>
                         <asp:BoundField DataField="Time" HeaderText="Time" ItemStyle-Width="100px" ReadOnly="True" SortExpression="Time">
                         </asp:BoundField>
                         <asp:TemplateField HeaderText="Pet" ItemStyle-Width="150px" SortExpression="Pet">
                             <ItemTemplate>
                                 <asp:Label ID="lblPetName" runat="server" Text='<%# Bind("Pet") %>' Width="130px"></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Owner" ItemStyle-Width="150px" SortExpression="Owner">
                             <ItemTemplate>
                                 <asp:Label ID="lblOwnerName" runat="server" Text='<%# Bind("Owner") %>' Width="130px"></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Assigned Vet" ItemStyle-Width="150px" SortExpression="Vet">
                             <ItemTemplate>
                                 <asp:Label ID="lblVetName" runat="server" Text='<%# Bind("Vet") %>' Width="130px"></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="AppointCost" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                             <ItemTemplate>
                                 <asp:Label ID="lblAppointCost" runat="server" Text='<%# Bind("AppointPrice") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="AppointComment" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                             <ItemTemplate>
                                 <asp:Label ID="lblAppointComment" runat="server" Text='<%# Bind("AppointComment") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
             </div>
             <br />
             <asp:Label ID="lblAppointSearch" runat="server" Font-Bold="True" Text="Search From: "></asp:Label>
             <asp:TextBox ID="tbxDateSearch1" TextMode="Date" runat="server" Width="145px"></asp:TextBox>
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblAppointSearch2" runat="server" Font-Bold="True" Text="To: "></asp:Label>
            <asp:TextBox ID="tbxDateSearch2" runat="server" TextMode="Date" Width="145px"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnSearch" runat="server" Font-Bold="True" Text="Search" BackColor="LightGray" OnClick="BtnSearch_Click" />
            <br />
            <br />
            <br />
            <br />
            <br />             
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" ToolTip="You are Here" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnerTable_Clicked" Text="Customers" ToolTip="Display Pet-Owners Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" ToolTip="Display Pets Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" ToolTip="Display Medications Table" Width="130px" />
        </asp:Panel>
    </div>

</asp:Content>
