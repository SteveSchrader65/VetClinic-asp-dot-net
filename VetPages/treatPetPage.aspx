<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="treatPetPage.aspx.cs" Inherits="DrDoolittleVetClinic.VetPages.treatPetPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="../StyleSheets/DoolittleStyles.css" rel="stylesheet" />
    <div style="left: 110px; width: 1500px; position: absolute; top: 110px;">
        <asp:HiddenField ID="hdnPetID" runat="server" />
        <asp:TextBox ID="tbxWelcome" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxTitle" Text="Appointment Consultation" runat="server" BorderStyle="None" Font-Bold="True" Font-Size="16pt" Font-Underline="True" Width="280px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="tbxCurrentDate" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        <br />
        <br />
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
            <asp:TextBox ID="tbxSpacer1" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="22%">
            <asp:Label ID="lblAppointmentDetails" runat="server" Text="Appointment Details" Font-Size="13pt" Font-Bold="true" Font-Underline="true"></asp:Label>
            <asp:DetailsView ID="dvAppointmentDetails" runat="server" Height="40px" BackColor="LightGoldenrodYellow" BorderStyle="Solid" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="Horizontal" HorizontalAlign="Left" Width="301px">
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
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="lblConsult" runat="server" Font-Bold="True" Font-Underline="True" Font-Size="13pt" Text="Consultation Type"></asp:Label>
            <br />
            <asp:DropDownList ID="ddlConsultationList" runat="server" Font-Bold="True">
                <asp:ListItem>Standard Consultation</asp:ListItem>
                <asp:ListItem>Extended Consultation</asp:ListItem>
                <asp:ListItem>Surgery</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <br />
            <asp:Label ID="lblProcedureList" runat="server" Font-Bold="True" Font-Underline="True" Font-Size="13pt" Text="Procedure List"></asp:Label>
            <br />
            <asp:RadioButtonList ID="rdoProceduresList" runat="server" Font-Bold="True">
                <asp:ListItem>Check-Up</asp:ListItem>
                <asp:ListItem>Treat Wound</asp:ListItem>
                <asp:ListItem>Vaccination</asp:ListItem>
                <asp:ListItem>Heartworm Test</asp:ListItem>
                <asp:ListItem>Dew-claw Removal</asp:ListItem>
                <asp:ListItem>Spaying/De-sexing</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
            <asp:TextBox ID="tbxSpacer2" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="40%">
            <asp:Label ID="lblMedicalHistory" runat="server" Text="" Font-Size="13pt" Font-Bold="True" Font-Underline="true"></asp:Label>
            <br />
            <asp:TextBox ID="tbxMedicalHistory" runat="server" Style="max-width: 95%" TextMode="MultiLine" Font-Size="13px" BackColor="LightGoldenrodYellow" Height="168px" Width="561px" ReadOnly="True" />
            <br />
            <br />
            <asp:Label ID="lblConsultationNotes" runat="server" Font-Bold="True" Font-Size="13pt" Font-Underline="True" Text="Consultation Notes"></asp:Label>
            <br />
            <asp:TextBox ID="tbxConsultationNotes" runat="server" Height="38px" Style="max-width: 95%" TextMode="MultiLine" Rows="2" Width="561px" BackColor="LightGoldenrodYellow"></asp:TextBox>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnUpdateMedicalHistory" runat="server" Font-Bold="True" OnClick="BtnUpdateMedicalHistory_Click" Text="Update Medical History" Width="195px" BackColor="LightGray" />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="5%">
            <asp:TextBox ID="tbxSpacer3" runat="server" Font-Bold="True" BorderStyle="None" Height="18px" />
        </asp:Panel>
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="23%">
            <asp:Label ID="lblMedications" runat="server" Text="Prescribe Medications" Font-Bold="True" Font-Underline="True" Font-Size="13pt"></asp:Label>
            <asp:GridView ID="prescriptionsGridView" runat="server" PageSize="15" AutoGenerateColumns="False" AllowPaging="True" BorderStyle="Solid"
                BorderWidth="1px" CellPadding="2" BackColor="LightGoldenrodYellow" BorderColor="Tan" ForeColor="Black"
                GridLines="Horizontal" HorizontalAlign="Left" DataKeyNames="DrugID" DataSourceID="sqlMedicationsList"
                OnPageIndexChanging="PrescriptionsGridView_PageIndexChanging"
                OnRowDataBound="PrescriptionsGridView_RowDataBound">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="Tan" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        <table cellspacing:2; cellpadding:2; rules="all" id="MainContent_adminCustomersGridView"
                            style="color: Black; background-color: LightGoldenrodYellow; border-color: Tan; border-width: 1px; border-style: solid; width: 1159px;">
                            <tr style="background-color: Tan; font-weight: bold;" />
                            <td "col">Drug Name</td>
                            <tr style="color: black; background-color: PaleGoldenrod">
                            <td colspan="1">There are no Medications to prescribe</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField ItemStyle-Width="40px">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkPrescribed" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField InsertVisible="False" HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                        <ItemTemplate>
                            <asp:Label ID="lblDrugID" runat="server" Text='<%# Bind("DrugID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Drug Name" ItemStyle-Width="150px" SortExpression="DrugName">
                        <ItemTemplate>
                            <asp:Label ID="lblDrugName" runat="server" Text='<%# Bind("DrugName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                        <ItemTemplate>
                            <asp:Label ID="lblDrugSalePrice" runat="server" Text='<%# Bind("DrugSalePrice") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-CssClass="HideMe" ItemStyle-CssClass="HideMe" FooterStyle-CssClass="HideMe">
                        <ItemTemplate>
                            <asp:Label ID="lblDrugQuantity" runat="server" Text='<%# Bind("DrugQuantity") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:SqlDataSource ID="sqlMedicationsList" runat="server" ConnectionString="<%$ ConnectionStrings:DrDoolittleConnectionString %>"
                SelectCommand="SELECT [DrugID],
                                      [DrugName],
                                      CAST(ROUND([DrugSalePrice], 2) AS DECIMAL (6, 2)) AS 'DrugSalePrice',
                                      [DrugQuantity]
                                      FROM [Medications] WHERE ([DrugQuantity] &gt; @DrugQuantity)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="DrugQuantity" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
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
