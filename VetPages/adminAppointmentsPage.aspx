<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminAppointmentsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.adminAppointmentsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1600px; position: absolute; top: 110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Appointments Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px"/>
        <br />
        <br />
        <asp:Panel runat="server" Style="padding-left: 0" Width="100%">
            <div>
                <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="1%">
                </asp:Panel>
                <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="99%">
                    <asp:GridView ID="adminAppointmentsGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                    BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black"
                                    PageSize="11" ShowHeaderWhenEmpty="False" CurrentSortField="AppointID" CurrentSortDirection="ASC" CellSpacing="2"
                                    DataKeyNames="AppointID" Width="1400px" ShowFooter="True" DataSourceID="sqlGetAllAppointments"
                                    OnPageIndexChanging="AdminAppointmentsGridView_PageIndexChanging"
                                    OnRowDataBound="AdminAppointmentsGridView_RowDataBound"
                                    OnRowCommand="AdminAppointmentsGridView_RowCommand"
                                    OnRowUpdating="AdminAppointmentsGridView_RowUpdating"
                                    OnRowUpdated="AdminAppointmentsGridView_RowUpdated">
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                        <HeaderStyle BackColor="Tan" Font-Bold="True" />
                        <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="LightCyan" />
                        <EmptyDataTemplate>
                            <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminAppointmentsGridView" style="color: Black; 
                                    background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">Appoint#</td>
                            <td "col">Date</td>
                            <td "col">Time</td>
                            <td "col">Pet</td>
                            <td "col">Owner</td>
                            <td "col">Vet</td>
                            <td "col">Cost</td>
                            <td "col">Appointment Comment</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                                <td colspan="8">There are no Appointments to display
                                </td>
                            </tr>
                            </table>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField ShowHeader="False" ItemStyle-Width="140px">
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" CausesValidation="True" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>' Text="Edit" Visible="False" />
                                    <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Delete" CommandArgument='<%# Container.DataItemIndex %>' Text="Cancel" Visible="False"
                                                        OnClientClick="return confirm('WARNING: You are about to CANCEL this Appointment.\nAre you sure that you wish to proceed ??');" />
                                    <asp:Button ID="btnView" runat="server" CausesValidation="False" CommandName="View" CommandArgument='<%# Container.DataItemIndex %>' Text="View" Visible="False" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Button ID="btnUpdate" runat="server" CausesValidation="True" ValidationGroup="EditAppoint" CommandName="Update" CommandArgument='<%# Container.DataItemIndex %>' Text="Update"/>
                                    <asp:Button ID="btnExit" runat="server" CausesValidation="False" CommandName="Cancel" CommandArgument='<%# Container.DataItemIndex %>' Text="Exit" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Appoint#" InsertVisible="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px" SortExpression="AppointID">
                                <EditItemTemplate>
                                    <asp:Label ID="lblAppointID" runat="server" Text='<%# Bind("AppointID") %>' Width="50px"></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAppointID2" runat="server" Text='<%# Bind("AppointID") %>' Width="50px"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ID="btnNewAppoint" runat="server" ButtonType="Button" CausesValidation="True" OnClick="BtnNewAppointment_Clicked" Text="Book" ValidationGroup="NewAppoint" Width="50px" />
                                </FooterTemplate>
                            </asp:TemplateField>                                                        
                            <asp:TemplateField HeaderText="Date" ItemStyle-Width="165px" SortExpression="Date">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxEditAppointDate" runat="server" Text='<%# Bind("Date") %>' TextMode="Date" OnTextChanged="TbxEditAppointDate_TextChanged" AutoPostBack="True" Width="135px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEditAppointDate" runat="server" ControlToValidate="tbxEditAppointDate" ErrorMessage="Appointment Date is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditAppoint"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="custEditAppointDate" runat="server" ControlToValidate="tbxEditAppointDate" OnServerValidate="EditAppointDate_ServerValidate" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditAppoint"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAppointDate" runat="server" Text='<%# Bind("Date2") %>' Width="135px"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate> 
                                    <asp:TextBox ID="tbxNewAppointDate" runat="server" TextMode="Date" OnTextChanged="TbxNewAppointDate_TextChanged" AutoPostBack="True" Width="135px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvNewAppointDate" runat="server" ControlToValidate="tbxNewAppointDate" ErrorMessage="Appointment Date is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewAppoint"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="cvNewAppointDate" runat="server" ControlToValidate="tbxNewAppointDate" Type="Date" Operator="GreaterThanEqual" ValueToCompare="<%# DateTime.Today.ToShortDateString() %>" ErrorMessage="Appointment Date cannot be earlier than today" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewAppoint"></asp:CompareValidator>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Time" ItemStyle-Width="150px" SortExpression="Time">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxEditAppointTime" runat="server" Text='<%# Bind("Time") %>' AutoPostBack="True" OnTextChanged="TbxEditAppointTime_TextChanged" Width="135px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEditAppointTime" ValidationGroup="EditAppoint" runat="server" ControlToValidate="tbxEditAppointTime" ErrorMessage="Appointment Time is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAppointTime" runat="server" Text='<%# Bind("Time") %>' Width="135px"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbxNewAppointTime" runat="server" TextMode="Time" OnTextChanged="TbxNewAppointTime_TextChanged" AutoPostBack="True" Width="135px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvNewAppointTime" ValidationGroup="NewAppoint" runat="server" ControlToValidate="tbxNewAppointTime" ErrorMessage="Appointment Time is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>              
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PetID" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPetID" runat="server" Text='<%# Bind("PetID") %>' CausesValidation="True" ValidationGroup="EditAppoint"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEditPet" runat="server" ControlToValidate="txtPetID" ErrorMessage="Pet is a required field" InitialValue="0" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditAppoint"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPetID" runat="server" Text='<%# Bind("PetID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>              
                            <asp:TemplateField HeaderText="Pet" ItemStyle-Width="140px" SortExpression="Pet">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditPetName" runat="server" DataValueField="petNumber" DataTextField="petName" CausesValidation="True" ValidationGroup="EditAppoint" Width="120px" ToolTip="UPDATE button to save Pet details. CANCEL button to exit." />
                                    <asp:RequiredFieldValidator ID="rfvEditPetName" ValidationGroup="EditAppoint" runat="server" ControlToValidate="ddlEditPetName" InitialValue="0" ErrorMessage="Pet Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPetName" runat="server" Text='<%# Bind("Pet") %>' Width="140px"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewPetName" runat="server" DataTextField="petName" CausesValidation="True" ValidationGroup="NewAppoint" Width="120px" />
                                    <asp:RequiredFieldValidator ID="rfvNewPetName" ValidationGroup="NewAppoint" runat="server" ControlToValidate="ddlNewPetName" InitialValue="(Select Pet)" ErrorMessage="Pet Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>                                                        
                            <asp:TemplateField HeaderText="Owner" ItemStyle-Width="140px" SortExpression="Owner">
                                <EditItemTemplate>
                                    <asp:Label ID="lblEditOwnerName" runat="server" Text='<%# Bind("Owner") %>' Width="140px"></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblOwnerName" runat="server" Text='<%# Bind("Owner") %>' Width="140px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fee" ItemStyle-Width="115px" SortExpression="Fee">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxEditAppointFee" runat="server" Text='<%# Bind("Fee", "{0:F2}") %>' AutoPostBack="True" Width="85px" CausesValidation="True" ValidationGroup="EditFee"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEditAppointFee" runat="server" ControlToValidate="tbxEditAppointFee" ErrorMessage="Appoint Fee is a required field" ForeColor="Red" Font-Bold="True" Text="*" ValidationGroup="EditFee"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="custEditAppointFee" runat="server" ControlToValidate="tbxEditAppointFee" OnServerValidate="EditAppointFee_ServerValidate" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditFee"></asp:CustomValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAppointFee" runat="server" Text='<%# Bind("Fee", "{0:C2}") %>' Width="85px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="VetID" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtVetID" runat="server" Text='<%# Bind("VetID") %>' CausesValidation="True" ValidationGroup="EditAppoint"></asp:TextBox>                            
                                    <asp:RequiredFieldValidator ID="rfvEditVetID" runat="server" ControlToValidate="txtVetID" ErrorMessage="Treating Vet is a required field" InitialValue="0" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditAppoint"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblVetID" runat="server" Text='<%# Bind("VetID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Assigned Vet" ItemStyle-Width="180px" SortExpression="Vet">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlEditVet" runat="server" AutoPostBack="True" DataValueField="vetNumber" DataTextField="vetName" CausesValidation="True" ValidationGroup="EditAppoint" Width="160px">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvEditVet" ValidationGroup="EditAppoint" runat="server" ControlToValidate="ddlEditVet" InitialValue="0" ErrorMessage="Treating Vet is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblVetName" runat="server" Text='<%# Bind("Vet") %>' Width="160px"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlNewVet" runat="server" DataValueField="vetNumber" DataTextField="vetName" CausesValidation="True" ValidationGroup="NewAppoint" Width="160px">
                                    </asp:DropDownList>                                    
                                    <asp:RequiredFieldValidator ID="rfvNewAppointVet" ValidationGroup="NewAppoint" runat="server" ControlToValidate="ddlNewVet" InitialValue="0" ErrorMessage="Treating Vet is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Appointment Comment">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbxEditAppointComment" runat="server" Text='<%# Bind("AppointComment") %>' ValidationGroup="EditAppoint" Width="240px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEditAppointComment" ValidationGroup="EditAppoint" runat="server" ControlToValidate="tbxEditAppointComment" ErrorMessage="Booking notes are a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAppointComment" runat="server" Text='<%# Bind("AppointComment") %>' Width="240px"></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbxNewAppointComment" runat="server" Width="240px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvNewAppointComment" ValidationGroup="NewAppoint" runat="server" ControlToValidate="tbxNewAppointComment" ErrorMessage="Booking notes are a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="65%">
            <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="True" Text="Error Message" Visible="False"></asp:Label>
            <asp:ValidationSummary ID="vsEditAppoint" ValidationGroup="EditAppoint" ForeColor="Red" Font-Bold="True" runat="server" />
            <asp:ValidationSummary ID="vsNewAppoint" ValidationGroup="NewAppoint" ForeColor="Red" Font-Bold="True" runat="server" />
            <asp:ValidationSummary ID="vsEditFee" ValidationGroup="EditFee" ForeColor="Red" Font-Bold="True" runat="server" />
            <br />
            <asp:Label ID="lblAppointSearch3" runat="server" Font-Bold="True" Text="Search Pets:"></asp:Label>
            <asp:TextBox ID="tbxSearch3" runat="server" AutoPostBack="true" OnTextChanged="TbxSearch3_TextChanged" Width="145px"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblAppointSearch" runat="server" Font-Bold="True" Text="Search From: "></asp:Label>
            <asp:TextBox ID="tbxDateSearch1" runat="server" TextMode="Date" Width="145px"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblAppointSearch2" runat="server" Font-Bold="True" Text="To: "></asp:Label>
            <asp:TextBox ID="tbxDateSearch2" runat="server" TextMode="Date" AutoPostBack="true" Width="145px" OnTextChanged="TbxDateSearch2_TextChanged"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearSearch" runat="server" BackColor="LightGray" BorderStyle="Solid" CausesValidation="False" Font-Bold="True" OnClick="BtnClearSearch" Text="Clear" Visible="False" Width="75px" />
            <br />
            <br />
            <asp:SqlDataSource ID="sqlGetAllAppointments" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>"
                SelectCommand="SELECT * FROM (
                               SELECT TOP (500) table1.[AppointID],
                               CONVERT(varchar(10), table1.[AppointDate]) AS 'Date',
                               CONVERT(varchar(10), table1.[AppointDate], 103) AS 'Date2',
                               FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time',
                               table2.[PetID],
                               table2.[PetName] AS 'Pet',
                               table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner',
                               CAST(ROUND(table1.[AppointPrice], 2) AS DECIMAL (6, 2)) AS 'Fee',          
                               table4.[VetID],                
                               table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet', 
                               table1.[AppointComment]
                               FROM [DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN
                               [DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN
                               [DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN
                               [DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID]       
							   WHERE table1.[AppointDate] = CAST(GETDATE() AS DATE)
							   ORDER BY 'Time' ASC
							   ) AS tbl1
	                    	   UNION ALL
	                           SELECT * FROM (
                        	   SELECT TOP (500) table1.[AppointID],
                               CONVERT(varchar(10), table1.[AppointDate]) AS 'Date',
                               CONVERT(varchar(10), table1.[AppointDate], 103) AS 'Date2',
                               FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time',
                               table2.[PetID],
                               table2.[PetName] AS 'Pet',
                               table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner',
                               CAST(ROUND(table1.[AppointPrice], 2) AS DECIMAL (6, 2)) AS 'Fee',          
                               table4.[VetID],                
                               table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet', 
                               table1.[AppointComment]
                               FROM [DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN
                               [DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN
                               [DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN
                               [DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID]
							   WHERE table1.[AppointDate] != CAST(GETDATE() AS DATE)
                               ORDER BY 'Date' DESC, 'Time' ASC
                        	   ) AS tbl2"
                UpdateCommand="UPDATE [Appointments] SET [PetID] = @PetID,
                               [VetID] = @VetID, 
                               [AppointDate] = @Date, 
                               [AppointTime] = @Time,
                               [AppointPrice] = @Fee,
                               [AppointComment] = @AppointComment
                               WHERE [AppointID] = @AppointID"
                InsertCommand="spNewAppointment" InsertCommandType="StoredProcedure" OnInserted="SqlGetAllAppointments_Inserted"
                DeleteCommand="DELETE FROM [Appointments] 
                               WHERE [AppointID] = @AppointID">
                <UpdateParameters>
                    <asp:Parameter Name="PetID" Type="Int32" />
                    <asp:Parameter Name="VetID" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="AppointDate" />
                    <asp:Parameter DbType="Time" Name="AppointTime" />
                    <asp:Parameter Name="AppointPrice" Type="Decimal" />
                    <asp:Parameter Name="AppointComment" Type="String" />
                    <asp:Parameter Name="AppointID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="PetID" Type="Int32" />
                    <asp:Parameter Name="VetID" Type="Int32" />
                    <asp:Parameter DbType="Date" Name="AppointDate" />
                    <asp:Parameter DbType="Time" Name="AppointTime" />
                    <asp:Parameter Name="AppointPrice" Type="Decimal" />
                    <asp:Parameter Name="AppointComment" Type="String" />
                    <asp:Parameter Direction="Output" Name="newAppointID" Type="Int32" />
                </InsertParameters>
                <DeleteParameters>
                    <asp:Parameter Name="AppointID" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlAppointSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>"
                SelectCommand="SELECT table1.[AppointID],
                               CONVERT(varchar(10), table1.[AppointDate]) AS 'Date',
                               CONVERT(varchar(10), table1.[AppointDate], 103) AS 'Date2',
                               FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time',
                               table2.[PetID],
                               table2.[PetName] AS 'Pet',
                               table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner',
                               CAST(ROUND(table1.[AppointPrice], 2) AS DECIMAL (6, 2)) AS 'Fee',
                               table4.[VetID],
                               table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet',                            
                               table1.[AppointComment] 
                               FROM [DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN
                               [DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN
                               [DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN
                               [DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID]
                               WHERE table1.[AppointDate] BETWEEN @DateSearch1 AND @DateSearch2
                               ORDER BY 'Date' DESC, 'Time' ASC">
                <SelectParameters>
                    <asp:ControlParameter ControlID="tbxDateSearch1" Name="DateSearch1" PropertyName="Text" />
                    <asp:ControlParameter ControlID="tbxDateSearch2" Name="DateSearch2" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlPetSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                SelectCommand="SELECT table1.[AppointID],
                               CONVERT(varchar(10), table1.[AppointDate]) AS 'Date',
                               CONVERT(varchar(10), table1.[AppointDate], 103) AS 'Date2',
                               FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time',
                               table2.[PetID],
                               table2.[PetName] AS 'Pet',
                               table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner',
                               CAST(ROUND(table1.[AppointPrice], 2) AS DECIMAL (6, 2)) AS 'Fee',
                               table4.[VetID],
                               table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet',                            
                               table1.[AppointComment] 
                               FROM [DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN
                               [DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN
                               [DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN
                               [DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID]
                               WHERE table2.[PetName] LIKE @PetSearch + '%'
                               ORDER BY 'Date' DESC, 'Time' ASC">
                <SelectParameters>
                    <asp:ControlParameter Name="PetSearch" ControlID="tbxSearch3" PropertyName="Text"/>
                </SelectParameters>
            </asp:SqlDataSource>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" ToolTip="You are Here" Width="130px" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnersTable_Clicked" Text="Customers" ToolTip="Display Customers Table" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" ToolTip="Display Pets Table" Width="130px" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnVetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnVetsTable_Clicked" Text="Vets" ToolTip="Display Vet staff Table" Width="130px" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" ToolTip="Display Medications Table" Width="130px" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnReportsPage" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnReportsPage_Clicked" Text="Reports" ToolTip="Display Reports Page" Width="130px" />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="30%">
            <br />
            <asp:Label ID="lblCompletedAppointDetails" runat="server" Text="Completed Appointment Details" BorderStyle="None" Font-Bold="True" Font-Size="13pt" Font-Underline="True" Visible="False" />
            <asp:TextBox ID="tbxCompletedAppointDetails" runat="server" Style="max-width: 70%" MaxLength="200" TextMode="MultiLine" BackColor="LightGoldenrodYellow" BorderStyle="Solid" Font-Size="12pt" ReadOnly="True" Visible="False" Height="194px" Width="418px" />
        </asp:Panel>
    </div>

</asp:Content>
