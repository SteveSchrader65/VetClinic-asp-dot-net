<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminMedicationsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.adminMedicationsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1300px; position: absolute; top: 110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Medications Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px" />
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="90%">
            <div>
                <asp:GridView ID=adminMedicationsGridView runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black"
                    PageSize="8" ShowHeaderWhenEmpty="False" CurrentSortField="DrugID" CurrentSortDirection="ASC" CellSpacing="2" 
                    DataKeyNames="DrugID" Width="1159px" ShowFooter="True" DataSourceID="sqlGetAllDrugs"
                    OnPageIndexChanging="AdminMedicationsGridView_PageIndexChanging"
                    OnRowDataBound="AdminMedicationsGridView_RowDataBound"
                    OnRowUpdated="AdminMedicationsGridView_RowUpdated">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="LightCyan" />
                    <EmptyDataTemplate>
                        <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminMedicationsGridView"
                            style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">Drug ID</td>
                            <td "col">Drug Name</td>
                            <td "col">Supplier</td>
                            <td "col">Cost Price</td>
                            <td "col">Sale Price</td>
                            <td "col">Stock</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                                <td colspan="6">There are no Medications to display
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:CommandField ButtonType="Button" ItemStyle-Width="75px" CausesValidation="True" ValidationGroup="EditDrug" ShowEditButton="True">
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="Drug ID" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" InsertVisible="False" SortExpression="DrugID">
                            <EditItemTemplate>
                                <asp:Label ID="lblDrugID_EDIT" runat="server" Text='<%# Bind("DrugID") %>' Width="40px" ItemStyle-HorizontalAlign="Center" ToolTip="UPDATE button to save Medication details.\n CANCEL button to exit."></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDrugID_VIEW" runat="server" Text='<%# Bind("DrugID") %>' Width="40px" ItemStyle-HorizontalAlign="Center"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnNewMedication" runat="server" CausesValidation="True" ValidationGroup="NewDrug" Text="Add" ButtonType="Button" Width="40px" OnClick="BtnNewMedication_Clicked"></asp:Button>
                            </FooterTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Drug Name" ItemStyle-Width="130px" SortExpression="DrugName">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDrugName" runat="server" Text='<%# Bind("DrugName") %>' Width="130px" ToolTip="UPDATE button to save Medication details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditDrugName" ValidationGroup="EditDrug" runat="server" ControlToValidate="txtEditDrugName" ErrorMessage="Drug Name is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>' Width="130px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewDrugName" runat="server" Width="130px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewDrugName" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewDrugName" ErrorMessage="Drug Name is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Supplier" ItemStyle-Width="150px" SortExpression="DrugSupplier">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditSupplier" runat="server" Text='<%# Bind("DrugSupplier") %>' Width="150px" ToolTip="UPDATE button to save Medication details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditSupplier" ValidationGroup="EditDrug" runat="server" ControlToValidate="txtEditSupplier" ErrorMessage="Supplier Name is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSupplier" runat="server" Text='<%# Bind("DrugSupplier") %>' Width="150px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewSupplier" runat="server" Width="150px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewSupplier" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewSupplier" ErrorMessage="Supplier Name is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Cost Price" ItemStyle-Width="60px" SortExpression="DrugCostPrice">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditCostPrice" runat="server" Text='<%# Bind("DrugCostPrice") %>' Width="50px" ToolTip="UPDATE button to save Medication details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditCostPrice" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditCostPrice" ErrorMessage="Cost Price is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvEditCostPrice" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditCostPrice" ErrorMessage="Cost Price must be numeric" Operator="DataTypeCheck" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvEditCostPrice" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditCostPrice" ErrorMessage="Cost Price must be between $0.10 and $500.00" MinimumValue="0.10" MaximumValue="500.00" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCostPrice" runat="server" Text='<%# Bind("DrugCostPrice", "{0:C2}") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewCostPrice" runat="server" Width="50px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewCostPrice" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewCostPrice" ErrorMessage="Cost Price is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvNewCostPrice" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewCostPrice" ErrorMessage="Cost Price must be numeric" Operator="DataTypeCheck" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvNewCostPrice" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewCostPrice" ErrorMessage="Cost Price must be between $0.10 and $500.00" MinimumValue="0.10" MaximumValue="500.00" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:RangeValidator>
                            </FooterTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Sale Price" ItemStyle-Width="60px" SortExpression="DrugSalePrice">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditSalePrice" runat="server" Text='<%# Bind("DrugSalePrice") %>' Width="50px" ToolTip="UPDATE button to save Medication details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditSalePrice" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditSalePrice" ErrorMessage="Sale Price is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvEditSalePrice" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditSalePrice" ErrorMessage="Sale Price must be numeric" Operator="DataTypeCheck" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:CompareValidator ID="cvEditSalePrice2" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditSalePrice" ErrorMessage="Sale Price must be greater than Cost Price" Operator="GreaterThan" ControlToCompare="txtEditCostPrice" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvEditSalePrice" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditSalePrice" ErrorMessage="Sale Price must be between $0.20 and $500.00" MinimumValue="0.20" MaximumValue="500.00" Type="Double" ForeColor="Red" Font-Bold="True" Text="*" ></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSalePrice" runat="server" Text='<%# Bind("DrugSalePrice", "{0:C2}") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewSalePrice" runat="server"  Width="50px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewSalePrice" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewSalePrice" ErrorMessage="Sale Price is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvNewSalePrice" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewSalePrice" ErrorMessage="Sale Price must be numeric" Operator="DataTypeCheck" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:CompareValidator ID="cvNewSalePrice2" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewSalePrice" ErrorMessage="Sale Price must be greater than Cost Price" Operator="GreaterThan" ControlToCompare="txtNewCostPrice" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvNewSalePrice" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewSalePrice" ErrorMessage="Sale Price must be between $0.20 and $500.00" MinimumValue="0.20" MaximumValue="500.00" Type="Double" ForeColor="Red" Font-Bold="True" Text="*"></asp:RangeValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stock" ItemStyle-Width="60px" SortExpression="DrugQuantity">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditQuantity" runat="server" Text='<%# Bind("DrugQuantity") %>' Width="50px" ToolTip="UPDATE button to save Medication details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditQuantity" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditQuantity" ErrorMessage="Quantity is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvEditQuantity" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditQuantity" ErrorMessage="Quantity must be an integer" Operator="DataTypeCheck" Type="Integer" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvEditQuantity" runat="server" ValidationGroup="EditDrug" ControlToValidate="txtEditQuantity" ErrorMessage="Quantity must be between 0 and 1000" ForeColor="Red" Font-Bold="True" Text="*" MinimumValue="0" MaximumValue="1000" Type="Integer"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStockQuantity" runat="server" Text='<%# Bind("DrugQuantity") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewQuantity" runat="server"  Width="50px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewQuantity" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewQuantity" ErrorMessage="Quantity is a required field" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvNewQuantity" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewQuantity" ErrorMessage="Quantity must be an integer" Operator="DataTypeCheck" Type="Integer" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:CompareValidator ID="cvNewQuantity2" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewQuantity" ErrorMessage="Quantity cannot be negative" Operator="GreaterThan" ValueToCompare="0" Type="Integer" ForeColor="Red" Font-Bold="True" Text="*"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvNewQuantity" runat="server" ValidationGroup="NewDrug" ControlToValidate="txtNewQuantity" ErrorMessage="Quantity must be between 0 and 1000" ForeColor="Red" Font-Bold="True" Text="*" MinimumValue="0" MaximumValue="1000" Type="Integer"></asp:RangeValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="True" Text="Error Message" Visible="False"></asp:Label>
                <asp:ValidationSummary ID="vsEditDrug" runat="server" ValidationGroup="EditDrug" ForeColor="Red" Font-Bold="True"/>
                <asp:ValidationSummary ID="vsNewDrug" runat="server" ValidationGroup="NewDrug" ForeColor="Red" Font-Bold="True"/>
                <br />
                <asp:Label ID="lblDrugSearch" runat="server" Font-Bold="True" Text="Search Drug Name: "></asp:Label>
                <asp:TextBox ID="tbxDrugSearch" runat="server" Width="236px" AutoPostBack="True" CausesValidation="True" ValidationGroup="DrugSearch" OnTextChanged="TbxDrugSearch_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDrugSearch" runat="server" ValidationGroup="DrugSearch" ControlToValidate="tbxDrugSearch" ErrorMessage="Search field is required" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnClearSearch" runat="server" CausesValidation="False" Text="Clear" Width="75px" BorderStyle="Solid" BackColor="LightGray" Font-Bold="True" OnClick="BtnClearSearch" Visible="False" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                
                <asp:ValidationSummary ID="vsDrugSearch" runat="server" ValidationGroup="DrugSearch" ForeColor="Red" Font-Bold="True"/>
                <asp:SqlDataSource ID="sqlGetAllDrugs" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                    SelectCommand="SELECT [DrugID],
                                   [DrugName],
                                   [DrugSupplier],
                                   CONVERT(DECIMAL(10,2), [DrugCostPrice]) AS 'DrugCostPrice',
                                   CONVERT(DECIMAL(10,2), [DrugSalePrice]) AS 'DrugSalePrice',
                                   [DrugQuantity]
                                   FROM [Medications]" 
                    UpdateCommand="UPDATE [Medications] SET [DrugName] = @DrugName,
                                   [DrugSupplier] = @DrugSupplier, 
                                   [DrugCostPrice] = @DrugCostPrice, 
                                   [DrugSalePrice] = @DrugSalePrice, 
                                   [DrugQuantity] = @DrugQuantity 
                                   WHERE [DrugID] = @DrugID"                     
                    InsertCommand="spNewMedication" InsertCommandType="StoredProcedure" 
                    OnInserted="SqlGetAllDrugs_Inserted"> 
                    <UpdateParameters>
                        <asp:Parameter Name="DrugName" Type="String" />
                        <asp:Parameter Name="DrugSupplier" Type="String" />
                        <asp:Parameter Name="DrugCostPrice" Type="Decimal" />
                        <asp:Parameter Name="DrugSalePrice" Type="Decimal" />
                        <asp:Parameter Name="DrugQuantity" Type="Int32" />
                        <asp:Parameter Name="DrugID" Type="Int32" />
                    </UpdateParameters>                    
                    <InsertParameters>
                        <asp:Parameter Name="DrugName" Type="String" />
                        <asp:Parameter Name="DrugSupplier" Type="String" />
                        <asp:Parameter Name="DrugCostPrice" Type="Decimal" />
                        <asp:Parameter Name="DrugSalePrice" Type="Decimal" />
                        <asp:Parameter Name="DrugQuantity" Type="Int32" />
                        <asp:Parameter Name="newDrugID" Type="Int32" Direction="Output" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlDrugSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                    SelectCommand ="SELECT [DrugID],
                                   [DrugName],
                                   [DrugSupplier],
                                   CONVERT(DECIMAL(10,2), [DrugCostPrice]) AS 'DrugCostPrice',
                                   CONVERT(DECIMAL(10,2), [DrugSalePrice]) AS 'DrugSalePrice',
                                   [DrugQuantity]
                                   FROM [Medications]
                                   WHERE [DrugName] LIKE @DrugSearchText + '%'">
                    <SelectParameters>
                        <asp:ControlParameter Name="DrugSearchText" ControlID="tbxDrugSearch" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
            </div>
            <br />
            <br />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" Width="130px" ToolTip="Display Apppointments Table" CausesValidation="False"/>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnersTable_Clicked" Text="Customers" Width="130px" ToolTip="Display Pet-Owners Table" CausesValidation="False"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" Width="130px" ToolTip="Display Pets Table" CausesValidation="False"/>
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnVetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnVetsTable_Clicked" Text="Vets" Width="130px" ToolTip="Display Vet staff Table" CausesValidation="False" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" Width="130px" ToolTip="You are Here" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnReportsPage" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnReportsPage_Clicked" style="margin-bottom: 0" Text="Reports" ToolTip="Display Reports Page" Width="130px" />
            <br />
            <br />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
        </asp:Panel>
    </div>
  
</asp:Content>
