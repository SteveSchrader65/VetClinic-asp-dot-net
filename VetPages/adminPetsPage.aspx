<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="adminPetsPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.adminPetsPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1300px; position: absolute; top: 110px;">
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Pets Table" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="210px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" Width="250px"/>
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="90%">
            <div>
                <asp:GridView ID="adminPetsGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black"
                    PageSize="8" ShowHeaderWhenEmpty="True" CurrentSortField="PetID" CurrentSortDirection="ASC" CellSpacing="2"
                    DataKeyNames="PetID" Width="1250px" ShowFooter="True" DataSourceID="sqlGetAllPets"
                    OnSelectedIndexChanged="AdminPetsGridView_SelectedIndexChanged"
                    OnPageIndexChanging="AdminPetsGridView_PageIndexChanging"
                    OnRowDataBound="AdminPetsGridView_RowDataBound" 
                    OnRowCommand="AdminPetsGridView_RowCommand"
                    OnRowUpdating="AdminPetsGridView_RowUpdating"      
                    OnRowUpdated="AdminPetsGridView_RowUpdated">
                    <AlternatingRowStyle BackColor="PaleGoldenrod" />
                    <HeaderStyle BackColor="Tan" Font-Bold="True" />
                    <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="LightCyan" />
                    <EmptyDataTemplate>
                        <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminPetsGridView"
                            style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">Pet#</td>
                            <td "col">Name</td>
                            <td "col">Owner</td>
                            <td "col">Breed</td>
                            <td "col">Gender</td>
                            <td "col">Birth Date</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                                <td colspan="6">There are no Pets to display
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:CommandField ButtonType="Button" ItemStyle-Width="100px" CausesValidation="True" ValidationGroup="EditPet" ShowSelectButton="True" ShowEditButton="True">
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="Pet#" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" InsertVisible="False" SortExpression="PetID">
                            <EditItemTemplate>
                                <asp:Label ID="lblPetID" runat="server" Text='<%# Bind("PetID") %>' Width="40px" ItemStyle-HorizontalAlign="Center" ToolTip="UPDATE button to save Pet details. CANCEL button to exit."></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPetID2" runat="server" Text='<%# Bind("PetID") %>' Width="40px" ItemStyle-HorizontalAlign="Center"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Button ID="btnNewPet" runat="server" CausesValidation="True" ValidationGroup="NewPet" Text="Add" ButtonType="Button" Width="40px" OnClick="BtnNewPet_Clicked"></asp:Button>
                            </FooterTemplate>
                        </asp:TemplateField>                       
                        <asp:TemplateField HeaderText="Owner#" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtOwnerID" runat="server" Text='<%# Bind("OwnerID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditOwnerID" runat="server" ControlToValidate="txtOwnerID" ErrorMessage="Owner Name is a required field" InitialValue="0" Font-Bold="True" ForeColor="Red" Text="*" ValidationGroup="EditPet"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblOwnerID" runat="server" Text='<%# Bind("OwnerID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="130px" SortExpression="PetName">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPetName" runat="server" Text='<%# Bind("PetName") %>' Width="130px" ToolTip="UPDATE button to save Pet details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditPetName" ValidationGroup="EditPet" runat="server" ControlToValidate="txtEditPetName" ErrorMessage="Pet Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPetName" runat="server" Text='<%# Bind("PetName") %>' BackColor="Transparent" Width="130px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewPetName" runat="server" Width="130px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewPetName" ValidationGroup="NewPet" SetFocusOnError="True" runat="server" ControlToValidate="txtNewPetName" ErrorMessage="Pet Name is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Owner" ItemStyle-Width="130px" SortExpression="Owner">
                            <EditItemTemplate>                              
                                <asp:DropDownList ID="ddlEditOwnerName" runat="server" AutoPostBack="True" DataValueField="ownerNumber" DataTextField="ownerName" CausesValidation="True" Width="130px" ToolTip="UPDATE button to save Pet details. CANCEL button to exit."></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvEditPetOwner" ValidationGroup="EditPet" runat="server" ControlToValidate="ddlEditOwnerName" ErrorMessage="Owner Name is a required field" InitialValue="0" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblOwnerName" runat="server" Text='<%# Bind("Owner") %>' Width="130px" ></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>                                
                                <asp:DropDownList ID="ddlNewOwnerName" runat="server" AutoPostBack="True" DataValueField="ownerNumber" DataTextField="ownerName" CausesValidation="True" Width="130px" ToolTip="ADD button to create new Pet record."></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvNewPetOwner" ValidationGroup="NewPet" runat="server" ControlToValidate="ddlNewOwnerName" ErrorMessage="Owner Name is a required field" InitialValue="0" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Breed" ItemStyle-Width="120px" SortExpression="PetBreed">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditPetBreed" runat="server" Text='<%# Bind("PetBreed") %>' ItemStyle-Width="115px" ToolTip="UPDATE button to save Pet details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditPetBreed" ValidationGroup="EditPet" runat="server" ControlToValidate="txtEditPetBreed" ErrorMessage="Pet Breed is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPetBreed" runat="server" Text='<%# Bind("PetBreed") %>' ItemStyle-Width="115px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewPetBreed" runat="server" ItemStyle-Width="115px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewPetBreed" ValidationGroup="NewPet" runat="server" ControlToValidate="txtNewPetBreed" ErrorMessage="Pet Breed is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Gender" SortExpression="PetGender" ItemStyle-Width="115px">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEditPetGender" runat="server" SelectedValue='<%# Bind("PetGender") %>' ToolTip="UPDATE button to save Pet details. CANCEL button to exit." Width="105px">
                                    <asp:ListItem>(Pet Gender)</asp:ListItem>
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvEditPetGender" ValidationGroup="EditPet" runat="server" ControlToValidate="ddlEditPetGender" ErrorMessage="Gender is a required field" Font-Bold="True" ForeColor="Red" Text="*" InitialValue="(Pet Gender)"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPetGender" runat="server" Text='<%# Bind("PetGender") %>' Width="105px"></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:DropDownList ID="ddlNewPetGender" runat="server" ToolTip="ADD button to create new Pet record." Width="105px">
                                    <asp:ListItem>(Pet Gender)</asp:ListItem>
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvNewPetGender" ValidationGroup="NewPet" runat="server" ControlToValidate="ddlNewPetGender" ErrorMessage="Gender is a required field" Font-Bold="True" ForeColor="Red" Text="*" InitialValue="(Pet Gender)"></asp:RequiredFieldValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Birth Date" ItemStyle-Width="100px" SortExpression="PetBirthDate">
                            <EditItemTemplate> 
                                <asp:TextBox ID="txtEditPetBirthDate" runat="server" Text='<%# Bind("PetBirthDate") %>' TextMode="Date" ToolTip="UPDATE button to save Pet details. CANCEL button to exit."></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEditPetBirthDate" ValidationGroup="EditPet" runat="server" ControlToValidate="txtEditPetBirthDate" ErrorMessage="Birth Date is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvEditPetBirthDate" runat="server" ValidationGroup="EditPet" ControlToValidate="txtEditPetBirthDate" ErrorMessage="Birth Date cannot be later than Today" Operator="LessThanEqual" Type="Date" ValueToCompare="<%# DateTime.Today.ToShortDateString() %>" Font-Bold="True" ForeColor="Red" Text="*"></asp:CompareValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPetBirthDate" runat="server" Text='<%# Bind("PetBirthDate") %>'></asp:Label>                            
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:TextBox ID="txtNewPetBirthDate" runat="server" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewPetBirthDate" ValidationGroup="NewPet" runat="server" ControlToValidate="txtNewPetBirthDate" ErrorMessage="Birth Date is a required field" Font-Bold="True" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvNewPetBirthDate" runat="server" ValidationGroup="NewPet" ControlToValidate="txtNewPetBirthDate" ErrorMessage="Birth Date cannot be later than Today" Operator="LessThanEqual" Type="Date" ValueToCompare="<%# DateTime.Today.ToShortDateString() %>" Font-Bold="True" ForeColor="Red" Text="*"></asp:CompareValidator>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PetMedicalHistory" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="True" Text="Error Message" Visible="False"></asp:Label>
                <asp:ValidationSummary ID="vsEditPet" ValidationGroup="EditPet" ForeColor="Red" Font-Bold="True" runat="server" />
                <asp:ValidationSummary ID="vsNewPet" ValidationGroup="NewPet" ForeColor="Red" Font-Bold="True" runat="server" />
                <br />
                <asp:Label ID="lblPetSearch" runat="server" Font-Bold="True" Text="Search Pet Name: "></asp:Label>
                <asp:TextBox ID="tbxPetSearch" runat="server" Width="236px" AutoPostBack="True" CausesValidation="True" ValidationGroup="PetSearch" OnTextChanged="TbxPetSearch_TextChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPetSearch" runat="server" ValidationGroup="PetSearch" ControlToValidate="tbxPetSearch" ErrorMessage="Search field is required" ForeColor="Red" Font-Bold="True" Text="*"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnClearSearch" runat="server" CausesValidation="False" Text="Clear" Width="75px" BorderStyle="Solid" BackColor="LightGray" Font-Bold="True" OnClick="BtnClearSearch" Visible="False" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ValidationSummary ID="vsPetSearch" runat="server" ValidationGroup="PetSearch" ForeColor="Red" Font-Bold="True"/>
                <asp:SqlDataSource ID="sqlGetAllPets" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>"
                    SelectCommand="SELECT [PetID],
                                   [PetName], 
                                   PetsTable.[OwnerID],
                                   PetOwnersTable.[FirstName] + ' ' + PetOwnersTable.[LastName] AS 'Owner',                 
                                   [PetBreed], 
                                   [PetGender],                    
                                   CONVERT(varchar(10), [PetBirthDate]) AS 'PetBirthDate',
                                   [PetMedicalHistory] FROM [Pets] PetsTable
                                   LEFT JOIN [PetOwners] PetOwnersTable 
                                   ON PetsTable.OwnerID = PetOwnersTable.OwnerID"
                    UpdateCommand="UPDATE [Pets] SET [OwnerID] = @OwnerID,
                                   [PetName] = @PetName,
                                   [PetBreed] = @PetBreed, 
                                   [PetGender] = @PetGender, 
                                   [PetBirthDate] = @PetBirthDate
                                   WHERE [PetID] = @PetID"
                    InsertCommand="spNewPet" InsertCommandType="StoredProcedure" 
                    OnInserted="SqlGetAllPets_Inserted">                     
                    <UpdateParameters>
                        <asp:Parameter Name="OwnerID" Type="Int32" />
                        <asp:Parameter Name="PetName" Type="String" />
                        <asp:Parameter Name="PetBreed" Type="String" />
                        <asp:Parameter Name="PetGender" Type="String" />
                        <asp:Parameter Name="PetBirthDate" DbType="Date" />
                        <asp:Parameter Name="PetID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="OwnerID" Type="Int32" />
                        <asp:Parameter Name="PetName" Type="String" />
                        <asp:Parameter Name="PetBreed" Type="String" />
                        <asp:Parameter Name="PetGender" Type="String" />
                        <asp:Parameter Name="PetBirthDate" DbType="Date" />
                        <asp:Parameter Name="PetMedicalHistory" Type="String" />
                        <asp:Parameter Name="newPetID" Type="Int32" Direction="Output" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlPetSearch" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>" 
                    SelectCommand="SELECT [PetID],
                                   [PetName], 
                                   PetsTable.[OwnerID],
                                   PetOwnersTable.[FirstName] + ' ' + PetOwnersTable.[LastName] AS 'Owner',                 
                                   [PetBreed], 
                                   [PetGender],                    
                                   CONVERT(varchar(10), [PetBirthDate]) AS 'PetBirthDate',
                                   [PetMedicalHistory] FROM [Pets] PetsTable
                                   LEFT JOIN [PetOwners] PetOwnersTable 
                                   ON PetsTable.OwnerID = PetOwnersTable.OwnerID
                                   WHERE [PetName] LIKE @PetSearchText + '%'">
                    <SelectParameters>
                        <asp:ControlParameter Name="PetSearchText" ControlID="tbxPetSearch" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            <br />
            <br />
            <asp:Label ID="lblMedicalHistory" runat="server" Font-Bold="True" Text="Pet Medical History:" Visible="False"></asp:Label>
            <br />
            <asp:TextBox ID="tbxMedicalHistory" runat="server" BorderStyle="Double" Height="135px" Style="max-width: 95%" MaxLength="4000" ReadOnly="True" TextMode="MultiLine" Visible="false" Width="1140px" BackColor="LightGoldenrodYellow" />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnAppointmentsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnAppointmentsTable_Clicked" Text="Appointments" Width="130px" ToolTip="Display Apppintments Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnOwnersTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnOwnersTable_Clicked" Text="Customers" Width="130px" ToolTip="Display Pet-Owners Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
             <asp:Button ID="btnPetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnPetsTable_Clicked" Text="Pets" Width="130px" ToolTip="Tou are Here" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnVetsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnVetsTable_Clicked" Text="Vets" Width="130px" ToolTip="Display Vet staff Table" CausesValidation="False" />
            &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="btnMedicationsTable" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnMedicationsTable_Clicked" Text="Medications" Width="130px" ToolTip="Display Medications Table" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnReportsPage" runat="server" BackColor="LightGray" Font-Bold="True" OnClick="BtnReportsPage_Clicked" Text="Reports" ToolTip="Display Reports Page" Width="130px" />
            <br />
            <br />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
        </asp:Panel>
    </div>

</asp:Content>
