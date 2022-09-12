<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminVetsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.adminVetsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1580px; position: absolute; top: 110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle1" Text="Vets Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px"  Width="250px"/>
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="1%">
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="98%">
            <div>
                <asp:GridView ID=adminVetsGridView runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black"
                    PageSize="4" ShowHeaderWhenEmpty="False" CurrentSortField="VetID" CurrentSortDirection="ASC" CellSpacing="2"
                    DataKeyNames="VetID" Width="1600px" ShowFooter="True" DataSourceID="sqlGetAllVets"
                    OnPageIndexChanging="AdminVetsGridView_PageIndexChanging"
                    OnRowUpdated="AdminVetsGridView_RowUpdated" 
                    OnRowDataBound="AdminVetsGridView_RowDataBound"
                    OnRowCommand="AdminVetsGridView_RowCommand">                    
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="LightCyan" />
                    <EmptyDataTemplate>
                        <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminVetsGridView"
                            style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">Vet#</td>
                            <td "col">Title</td>
                            <td "col">First Name</td>
                            <td "col">Last Name</td>
                            <td "col">Address1</td>
                            <td "col">Address2</td>
                            <td "col">State</td>
                            <td "col">Postcode</td>
                            <td "col">Phone#</td>
                            <td "col">Qualification</td>
                            <td "col">E-mail</td>
                            <td "col">Password</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                                <td colspan="10">There are no Vets to display</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <Columns>
                         <asp:CommandField ButtonType="Button" ItemStyle-Width="110px" ShowEditButton="True" ValidationGroup="EditVet" CausesValidation="True" />                      
                        <asp:TemplateField ItemStyle-Width="60px" ShowHeader="False">
                             <ItemTemplate>
                                 <asp:Button ID="btnVetRoster" runat="server" CausesValidation="False" CommandArgument="<%# Container.DataItemIndex %>" CommandName="Roster" ItemStyle-Width="60px" Text="Roster" Visible="False" />
                             </ItemTemplate>                         
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="VetID" InsertVisible="False" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="40px" SortExpression="VetID">
                             <EditItemTemplate>
                                 <asp:Label ID="lblVetID" runat="server" ItemStyle-HorizontalAlign="Center" Text='<%# Bind("VetID") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="40px"></asp:Label>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetID2" runat="server" ItemStyle-HorizontalAlign="Center" Text='<%# Bind("VetID") %>' Width="40px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:Button ID="btnNewVet" runat="server" ButtonType="Button" CausesValidation="True" OnClick="BtnNewVet_Clicked" Text="Add" ValidationGroup="NewVet" Width="40px" />
                             </FooterTemplate>
                         </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Title" ItemStyle-Width="59px" SortExpression="Title">
                             <EditItemTemplate>
                                 <asp:DropDownList ID="ddlEditVetTitle" runat="server" SelectedValue='<%# Bind("Title") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." CausesValidation="True" Width="59px">
                                     <asp:ListItem>(Title)</asp:ListItem>
                                     <asp:ListItem>Dr</asp:ListItem>
                                     <asp:ListItem>Prof</asp:ListItem>
                                     <asp:ListItem>Sir</asp:ListItem>
                                     <asp:ListItem>Dame</asp:ListItem>
                                     <asp:ListItem>Mr</asp:ListItem>
                                     <asp:ListItem>Mrs</asp:ListItem>
                                     <asp:ListItem>Ms</asp:ListItem>
                                 </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="rfvEditVetTitle" ValidationGroup="EditVet" runat="server" ControlToValidate="ddlEditVetTitle" ErrorMessage="Title is a required field" Font-Bold="True" ForeColor="Red" InitialValue="(Title)" Text="*"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetTitle" runat="server" Text='<%# Bind("Title") %>' CausesValidation="True" Width="30px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:DropDownList ID="ddlNewVetTitle" runat="server" ToolTip="ADD button to create new Vet record." Width="59px">
                                     <asp:ListItem>(Title)</asp:ListItem>
                                     <asp:ListItem>Dr</asp:ListItem>
                                     <asp:ListItem>Prof</asp:ListItem>
                                     <asp:ListItem>Sir</asp:ListItem>
                                     <asp:ListItem>Dame</asp:ListItem>
                                     <asp:ListItem>Mr</asp:ListItem>
                                     <asp:ListItem>Mrs</asp:ListItem>
                                     <asp:ListItem>Ms</asp:ListItem>
                                 </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="rfvNewVetTitle" ValidationGroup="NewVet" runat="server" ControlToValidate="ddlNewVetTitle" ErrorMessage="Title is a required field" Font-Bold="True" ForeColor="Red" InitialValue="(Title)" Text="*"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                        </asp:TemplateField>                  
                        <asp:TemplateField HeaderText="First Name" ItemStyle-Width="80px" SortExpression="FirstName">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetFirstName" runat="server" Text='<%# Bind("FirstName") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="80px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetFirstName" runat="server" ControlToValidate="txtEditVetFirstName" ErrorMessage="First Name is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetFirstName" runat="server" Text='<%# Bind("FirstName") %>' Width="80px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetFirstName" runat="server" Width="80px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetFirstName" runat="server" ControlToValidate="txtNewVetFirstName" ErrorMessage="First Name is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Last Name" ItemStyle-Width="80px" SortExpression="LastName">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetLastName" runat="server" Text='<%# Bind("LastName") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="80px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetLastName" runat="server" ControlToValidate="txtEditVetLastName" ErrorMessage="Last Name is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetLastName" runat="server" Text='<%# Bind("LastName") %>' Width="80px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetLastName" runat="server" Width="80px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetLastName" runat="server" ControlToValidate="txtNewVetLastName" ErrorMessage="Last Name is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Address" ItemStyle-Width="130px" SortExpression="Address2">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetAddress1" runat="server" Text='<%# Bind("Address1") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="130px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetAddress1" runat="server" ControlToValidate="txtEditVetAddress1" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetAddress1" runat="server" Text='<%# Bind("Address1") %>' Width="130px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetAddress1" runat="server" Width="130px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetAddress1" runat="server" ControlToValidate="txtNewVetAddress1" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderStyle-ForeColor="Tan" HeaderText="______________" ItemStyle-Width="85px" SortExpression="Address2">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetAddress2" runat="server" Text='<%# Bind("Address2") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="85px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetAddress2" runat="server" ControlToValidate="txtEditVetAddress2" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetAddress2" runat="server" Text='<%# Bind("Address2") %>' Width="85px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetAddress2" runat="server" Width="85px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetAddress2" runat="server" ControlToValidate="txtNewVetAddress2" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                             <HeaderStyle ForeColor="Tan" />
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="State" ItemStyle-Width="45px" SortExpression="State">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetState" runat="server" Text='<%# Bind("State") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="45px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetState" runat="server" ControlToValidate="txtEditVetState" ErrorMessage="State is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetState" runat="server" Text='<%# Bind("State") %>' Width="45px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetState" runat="server" Width="45px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetState" runat="server" ControlToValidate="txtNewVetState" ErrorMessage="State is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Postcode" ItemStyle-Width="40px" SortExpression="PostCode">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetPostcode" runat="server" Text='<%# Bind("PostCode") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="40px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetPostcode" runat="server" ControlToValidate="txtEditVetPostcode" ErrorMessage="Postcode is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetPostcode" runat="server" Text='<%# Bind("PostCode") %>' Width="40px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetPostcode" runat="server" Width="40px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetPostcode" runat="server" ControlToValidate="txtNewVetPostcode" ErrorMessage="Postcode is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Phone#" ItemStyle-Width="100px" SortExpression="PhoneNumber">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="100px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetPhoneNumber" runat="server" ControlToValidate="txtEditVetPhoneNumber" ErrorMessage="Phone# is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' Width="100px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetPhoneNumber" runat="server" Width="100px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetPhoneNumber" runat="server" ControlToValidate="txtNewVetPhoneNumber" ErrorMessage="Phone# is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Qualification" ItemStyle-Width="160px" SortExpression="Qualification">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetQualification" runat="server" Text='<%# Bind("Qualification") %>' TextMode="MultiLine" Rows="2" ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="160px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetQualification" runat="server" ControlToValidate="txtEditVetQualification" ErrorMessage="Qualification is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:TextBox ID="txtVetQualification" runat="server" Text='<%# Bind("Qualification") %>' TextMode="MultiLine" Rows="2" BorderStyle="None" BackColor="Transparent" Width="160px"></asp:TextBox>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetQualification" runat="server"  TextMode="MultiLine" Rows="1" Width="160px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetQualification" runat="server" ControlToValidate="txtNewVetQualification" ErrorMessage="Qualification is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="E-Mail" ItemStyle-Width="160px" SortExpression="EmailAddress">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetEmail" runat="server" Text='<%# Bind("EmailAddress") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="160px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetEmail" runat="server" ControlToValidate="txtEditVetEmail" ErrorMessage="E-Mail Address is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetEmail" runat="server" Text='<%# Bind("EmailAddress") %>' Width="160px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetEmail" runat="server" Width="160px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetEmail" runat="server" ControlToValidate="txtNewVetEmail" ErrorMessage="E-Mail Address is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Password" ItemStyle-Width="70px" SortExpression="Password">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txtEditVetPassword" runat="server" Text='<%# Bind("Password") %>' ToolTip="UPDATE button to save Vet details. CANCEL button to exit." Width="70px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvEditVetPassword" runat="server" ControlToValidate="txtEditVetPassword" ErrorMessage="Password is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditVet"></asp:RequiredFieldValidator>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="lblVetPassword" runat="server" Text='<%# Bind("Password") %>' Width="70px"></asp:Label>
                             </ItemTemplate>
                             <FooterTemplate>
                                 <asp:TextBox ID="txtNewVetPassword" runat="server" Width="70px"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="rfvNewVetPassword" runat="server" ControlToValidate="txtNewVetPassword" ErrorMessage="Password is a required field" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="NewVet"></asp:RequiredFieldValidator>
                             </FooterTemplate>
                         </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="True" Text="Error Message" Visible="False"></asp:Label>
                <asp:ValidationSummary ID="vsEditVet" ValidationGroup="EditVet" ForeColor="Red" Font-Bold="True" runat="server" />
                <asp:ValidationSummary ID="vsNewVet" ValidationGroup="NewVet" ForeColor="Red" Font-Bold="True" runat="server" />
                <br />
                <asp:Label ID="lblVetSearch" runat="server" Font-Bold="True" Text="Search Vet Name: "></asp:Label>
                <asp:TextBox ID="tbxVetSearch" runat="server" Width="236px" AutoPostBack="True" CausesValidation="True" ValidationGroup="VetSearch" OnTextChanged="TbxVetSearch_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvVetSearch" runat="server" ValidationGroup="VetSearch" ControlToValidate="tbxVetSearch" ErrorMessage="Search field is required" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnClearSearch" runat="server" CausesValidation="False" Text="Clear" Width="75px" BorderStyle="Solid" BackColor="LightGray" Font-Bold="True" OnClick="BtnClearSearch" Visible="False" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                
                <asp:ValidationSummary ID="vsVetSearch" runat="server" ValidationGroup="VetSearch" ForeColor="Red" Font-Bold="True"/>
                <asp:SqlDataSource ID="sqlGetAllVets" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                    SelectCommand="SELECT [VetID], 
                                   [Title],
                                   [FirstName],
                                   [LastName],
                                   [Address1],
                                   [Address2],
                                   [State],
                                   [Postcode],
                                   [PhoneNumber],
                                   [Qualification],
                                   [EmailAddress],
                                   [Password]
                                   FROM [Vets]" 
                    UpdateCommand="UPDATE [Vets] SET [Title] = @Title, 
                                   [FirstName] = @FirstName, 
                                   [LastName] = @LastName, 
                                   [Address1] = @Address1, 
                                   [Address2] = @Address2, 
                                   [State] = @State, 
                                   [PostCode] = @PostCode, 
                                   [PhoneNumber] = @PhoneNumber, 
                                   [Qualification] = @Qualification, 
                                   [EmailAddress] = @EmailAddress, 
                                   [Password] = @Password 
                                   WHERE [VetID] = @VetID"
                    InsertCommand="spNewVet" InsertCommandType="StoredProcedure" 
                    OnInserted="SqlGetAllVets_Inserted">
                    <UpdateParameters>
                        <asp:Parameter Name="Title" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="Address1" Type="String" />
                        <asp:Parameter Name="Address2" Type="String" />
                        <asp:Parameter Name="State" Type="String" />
                        <asp:Parameter Name="PostCode" Type="Int32" />
                        <asp:Parameter Name="PhoneNumber" Type="String" />
                        <asp:Parameter Name="Qualification" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="Password" Type="String" />
                        <asp:Parameter Name="VetID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Title" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="Address1" Type="String" />
                        <asp:Parameter Name="Address2" Type="String" />
                        <asp:Parameter Name="State" Type="String" />
                        <asp:Parameter Name="PostCode" Type="Int32" />
                        <asp:Parameter Name="PhoneNumber" Type="String" />
                        <asp:Parameter Name="Qualification" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="Password" Type="String" />
                        <asp:Parameter Name="newVetID" Type="Int32" Direction="Output" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlVetSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                    SelectCommand="SELECT [VetID], 
                                   [Title],
                                   [FirstName],
                                   [LastName],
                                   [Address1],
                                   [Address2],
                                   [State],
                                   [Postcode],
                                   [PhoneNumber],
                                   [Qualification],
                                   [EmailAddress],
                                   [Password]
                                   FROM [Vets]
                                   WHERE [Title] LIKE @VetSearchText + '%' 
                                   OR [FirstName] LIKE @VetSearchText + '%'
                                   OR [LastName] LIKE @VetSearchText + '%'">
                    <SelectParameters>
                        <asp:ControlParameter Name="VetSearchText" ControlID="tbxVetSearch" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="tbxTitle2" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Text="Vet Roster" Width="142px" />
                <br />
            </div>
            <asp:GridView ID="grdRosterDisplay" runat="server" AllowPaging="True" BackColor="LightGoldenrodYellow" 
                    BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" PageSize="6" 
                    ShowHeaderWhenEmpty="True" Width="1045px">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <FooterStyle BackColor="Tan" />
                <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
            </asp:GridView>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" Width="130px" ToolTip="Display Appointments Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnersTable_Clicked" Text="Customers" Width="130px" ToolTip="Display Pet-Owners Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" Width="130px" ToolTip="Display Pets Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnVetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnVetsTable_Clicked" Text="Vets" Width="130px" ToolTip="You are Here" CausesValidation="False" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" Width="130px" ToolTip="Display Medications Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnReportsPage" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnReportsPage_Clicked" Text="Reports" ToolTip="Display Reports Page" Width="130px" />
            <br />
            <br />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="1%">
        </asp:Panel>
    </div>

</asp:Content>
