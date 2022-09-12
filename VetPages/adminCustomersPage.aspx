<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminCustomersPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.adminCustomersPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1600px; position: absolute; top: 110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Customers Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px" />
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="1%">
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="98%">
            <div>
                <asp:GridView ID=adminCustomersGridView runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black"
                    PageSize="8" ShowHeaderWhenEmpty="True" CurrentSortField="OwnerID" CurrentSortDirection="ASC" CellSpacing="2"
                    DataKeyNames="OwnerID" Width="1600px" ShowFooter="True"
                    OnPageIndexChanging="AdminCustomersGridView_PageIndexChanging"
                    OnRowDataBound="AdminCustomersGridView_RowDataBound"
                    OnRowUpdated="AdminCustomersGridView_RowUpdated" 
                    DataSourceID="sqlGetAllCustomers">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="LightCyan" />
                    <EmptyDataTemplate>
                        <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminCustomersGridView"
                            style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">Cust#</td>
                            <td "col">First Name</td>
                            <td "col">Last Name</td>
                            <td "col">Address1</td>
                            <td "col">Address2</td>
                            <td "col">State</td>
                            <td "col">Postcode</td>
                            <td "col">Phone#</td>
                            <td "col">E-mail</td>
                            <td "col">Proof Type</td>
                            <td "col">Proof Number</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                                <td colspan="10">There are no Customers to display</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:CommandField ButtonType="Button" ItemStyle-Width="90px" CausesValidation="True" ValidationGroup="EditCust" ShowEditButton="True">
                        </asp:CommandField>
                       <asp:TemplateField HeaderText="Cust#" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" InsertVisible="False" SortExpression="OwnerID">
                            <EditItemTemplate>
                                <asp:Label ID="lblCustID" runat="server" Text='<%# Bind("OwnerID") %>' Width="40px" ItemStyle-HorizontalAlign="Center" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustID2" runat="server" Text='<%# Bind("OwnerID") %>' Width="40px" ItemStyle-HorizontalAlign="Center"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnNewCustomer" runat="server" CausesValidation="True" ValidationGroup="NewCust" Text="Add" ButtonType="Button" Width="40px" OnClick="BtnNewCustomer_Clicked"></asp:Button>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="First Name" ItemStyle-Width="65px" SortExpression="FirstName">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustFirstName" runat="server" Text='<%# Bind("FirstName") %>' Width="60px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustFirstName" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustFirstName" ErrorMessage="First Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustFirstName" runat="server" Text='<%# Bind("FirstName") %>' Width="60px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustFirstName" runat="server" Width="60px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustFirstName" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustFirstName" ErrorMessage="First Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Last Name" ItemStyle-Width="65px" SortExpression="LastName">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustLastName" runat="server" Text='<%# Bind("LastName") %>' Width="60px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustLastName" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustLastName" ErrorMessage="Last Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustLastName" runat="server" Text='<%# Bind("LastName") %>' Width="60px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustLastName" runat="server" Width="60px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustLastName" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustLastName" ErrorMessage="Last Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pets" ItemStyle-Width="95px">
                             <EditItemTemplate>
                                <asp:Label ID="lblEditPetsOwned" runat="server" Text=" (Pets)           " Width="90px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:Label>
                            </EditItemTemplate>                           
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlPetsOwnedList" runat="server" AutoPostBack="true" DataTextField="petName" ToolTip="UPDATE button to save Pet details. CANCEL button to exit." Width="90px"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address" ItemStyle-Width="125px" SortExpression="Address2">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustAddress1" runat="server" Text='<%# Bind("Address1") %>' Width="120px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustAddress1" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustAddress1" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustAddress1" runat="server" Text='<%# Bind("Address1") %>' Width="120px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustAddress1" runat="server" Width="120px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustAddress1" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustAddress1" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="______________" HeaderStyle-ForeColor="Tan" ItemStyle-Width="75px" SortExpression="Address2">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustAddress2" runat="server" Text='<%# Bind("Address2") %>' Width="70px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustAddress2" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustAddress2" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblVCusAddress2" runat="server" Text='<%# Bind("Address2") %>' Width="70px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustAddress2" runat="server" Width="70px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustAddress2" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustAddress2" ErrorMessage="Both Address lines are required fields" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="State" ItemStyle-Width="35px" SortExpression="State">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustState" runat="server" Text='<%# Bind("State") %>' Width="30px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustState" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustState" ErrorMessage="State is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustState" runat="server" Text='<%# Bind("State") %>' Width="30px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustState" runat="server" Width="30px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustState" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustState" ErrorMessage="State is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Postcode" ItemStyle-Width="45px" SortExpression="PostCode">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustPostcode" runat="server" Text='<%# Bind("PostCode") %>' Width="40px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustPostcode" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustPostcode" ErrorMessage="Postcode is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustPostcode" runat="server" Text='<%# Bind("PostCode") %>' Width="40px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustPostcode" runat="server" Width="40px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustPostcode" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustPostcode" ErrorMessage="Postcode is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone#" ItemStyle-Width="105px" SortExpression="PhoneNumber">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' Width="100px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustPhoneNumber" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustPhoneNumber" ErrorMessage="Phone# is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' Width="100px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustPhoneNumber" runat="server" Width="100px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustPhoneNumber" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustPhoneNumber" ErrorMessage="Phone# is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="E-Mail" ItemStyle-Width="105px" SortExpression="EmailAddress">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustEmail" runat="server" Text='<%# Bind("EmailAddress") %>' Width="100px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustEmail" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustEmail" ErrorMessage="E-Mail Address is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustEmail" runat="server" Text='<%# Bind("EmailAddress") %>' Width="100px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustEmail" runat="server" Width="100px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustEmail" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustEmail" ErrorMessage="E-Mail Address is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Proof Type" ItemStyle-Width="125px" SortExpression="ProofType">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustProofType" runat="server" Text='<%# Bind("ProofType") %>' Width="120px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustProofType" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustProofType" ErrorMessage="Proof Type is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustProofType" runat="server" Text='<%# Bind("ProofType") %>' Width="120px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustProofType" runat="server" Width="125px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustProofType" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustProofType" ErrorMessage="Proof Type is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Proof Number" ItemStyle-Width="90px" SortExpression="ProofNumber">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCustProofNumber" runat="server" Text='<%# Bind("ProofNumber") %>' Width="90px" ToolTip="UPDATE button to save Customer details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCustProofNumber" ValidationGroup="EditCust" runat="server" ControlToValidate="txtEditCustProofNumber" ErrorMessage="Proof Number is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCustProofNumber" runat="server" Text='<%# Bind("ProofNumber") %>' Width="90px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCustProofNumber" runat="server" Width="90px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCustProofNumber" ValidationGroup="NewCust" runat="server" ControlToValidate="txtNewCustProofNumber" ErrorMessage="Proof Number is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                </div>
                </asp:Panel>
                <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="65%">
                <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="True" Text="Error Message" Visible="False"></asp:Label>
                <asp:ValidationSummary ID="vsEditCust" ValidationGroup="EditCust" ForeColor="Red" Font-Bold="True" runat="server"/>
                <asp:ValidationSummary ID="vsNewCust" ValidationGroup="NewCust" ForeColor="Red" Font-Bold="True" runat="server" />
                <br />
                <asp:Label ID="lblCustomerSearch" runat="server" Font-Bold="True" Text="Search Customer Name: "></asp:Label>
                <asp:TextBox ID="tbxCustomerSearch" runat="server" Width="236px" AutoPostBack="true" CausesValidation="true" ValidationGroup="CustSearch" OnTextChanged="TbxCustomerSearch_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCustSearch" runat="server" ValidationGroup="CustSearch" ControlToValidate="tbxCustomerSearch" ErrorMessage="Search field is required" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                <asp:Button ID="btnClearSearch" runat="server" CausesValidation="False" Text="Clear" Width="75px" BorderStyle="Solid" BackColor="LightGray" Font-Bold="True" OnClick="BtnClearSearch" Visible="False" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ValidationSummary ID="vsDrugSearch" runat="server" ValidationGroup="DrugSearch" ForeColor="Red" Font-Bold="True"/>
                    <asp:SqlDataSource ID="sqlGetAllCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                        InsertCommand="spNewOwner" InsertCommandType="StoredProcedure" 
                        OnInserted="SqlGetAllCustomers_Inserted" 
                        SelectCommand="SELECT [OwnerID], 
                                       [FirstName],
                                       [LastName],
                                       [Address1],
                                       [Address2],
                                       [State],
                                       [Postcode],
                                       [PhoneNumber],
                                       [EmailAddress],
                                       [ProofType],
                                       [ProofNumber]
                                       FROM [PetOwners]" 
                        UpdateCommand="UPDATE [PetOwners] SET [FirstName] = @FirstName, 
                                       [LastName] = @LastName, 
                                       [Address1] = @Address1, 
                                       [Address2] = @Address2, 
                                       [State] = @State, 
                                       [PostCode] = @PostCode, 
                                       [PhoneNumber] = @PhoneNumber, 
                                       [EmailAddress] = @EmailAddress, 
                                       [ProofType] = @ProofType, 
                                       [ProofNumber] = @ProofNumber 
                                       WHERE [OwnerID] = @OwnerID">
                        <UpdateParameters>
                            <asp:Parameter Name="FirstName" Type="String" />
                            <asp:Parameter Name="LastName" Type="String" />
                            <asp:Parameter Name="Address1" Type="String" />
                            <asp:Parameter Name="Address2" Type="String" />
                            <asp:Parameter Name="State" Type="String" />
                            <asp:Parameter Name="PostCode" Type="Int32" />
                            <asp:Parameter Name="PhoneNumber" Type="String" />
                            <asp:Parameter Name="EmailAddress" Type="String" />
                            <asp:Parameter Name="ProofType" Type="String" />
                            <asp:Parameter Name="ProofNumber" Type="String" />
                            <asp:Parameter Name="OwnerID" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="FirstName" Type="String" />
                            <asp:Parameter Name="LastName" Type="String" />
                            <asp:Parameter Name="Address1" Type="String" />
                            <asp:Parameter Name="Address2" Type="String" />
                            <asp:Parameter Name="State" Type="String" />
                            <asp:Parameter Name="PostCode" Type="Int32" />
                            <asp:Parameter Name="PhoneNumber" Type="String" />
                            <asp:Parameter Name="EmailAddress" Type="String" />
                            <asp:Parameter Name="ProofType" Type="String" />
                            <asp:Parameter Name="ProofNumber" Type="String" />
                            <asp:Parameter Name="newOwnerID" Type="Int32" Direction="Output" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlCustomerSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                        SelectCommand="SELECT [OwnerID], 
                                       [FirstName],
                                       [LastName],
                                       [Address1],
                                       [Address2],
                                       [State],
                                       [Postcode],
                                       [PhoneNumber],
                                       [EmailAddress],
                                       [ProofType],
                                       [ProofNumber]
                                       FROM [PetOwners]
                                       WHERE (([FirstName] LIKE @CustSearchText + '%')
                                       OR ([LastName] LIKE @CustSearchText + '%'))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="tbxCustomerSearch" Name="CustSearchText" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" ToolTip="Display Appointments Table" Width="130px" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnersTable_Clicked" Text="Customers" ToolTip="You are Here" Width="130px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" ToolTip="Display Pets Table" Width="130px" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnVetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnVetsTable_Clicked" Text="Vets" ToolTip="Display Vet staff Table" Width="130px" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" ToolTip="Display Medications Table" Width="130px" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnReportsPage" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnReportsPage_Clicked" Text="Reports" ToolTip="Display Reports Page" Width="130px" />
                    &nbsp;&nbsp;
       </asp:Panel>

    </div>
</asp:Content>
