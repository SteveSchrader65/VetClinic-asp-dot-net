<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="DrDoolittleVetClinic.About" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="left: 110px; width: 1600px; position: absolute; top: 110px;">
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="99%">
            <asp:Label ID="lblOverview" runat="server" Text="Overview" Font-Bold="True"></asp:Label>
            <br />
            <asp:TextBox ID="tbxOverview" runat="server" Style="width: 95%; max-width: 95%" TextMode="MultiLine" Rows="3" Font-Size="15px" BackColor="LightGoldenrodYellow" ReadOnly="True"/>
            <br />
            <br />
            <asp:Label ID="lblAdminPages" runat="server" Text="Admin Pages" Font-Bold="True"></asp:Label>
            <br />
            <asp:TextBox ID="tbxAdminPages" runat="server" Style="width: 95%; max-width: 95%" TextMode="MultiLine" Rows="35" Font-Size="15px" BackColor="LightGoldenrodYellow" ReadOnly="True"/>
            <br />
            <br />
            <asp:Label ID="lblStaffPages" runat="server" Text="Staff Pages" Font-Bold="True"></asp:Label>
            <br />
            <asp:TextBox ID="tbxStaffPages" runat="server" Style="width: 95%; max-width: 95%" TextMode="MultiLine" Rows="21" Font-Size="15px" BackColor="LightGoldenrodYellow" ReadOnly="True"/>
            <br />
            <br />
            <asp:Label ID="lblCommonControls" runat="server" Text="Common Controls" Font-Bold="True"></asp:Label>
            <br />
            <asp:TextBox ID="tbxCommonControls" runat="server" Style="width: 95%; max-width: 95%" TextMode="MultiLine" Rows="7" Font-Size="15px" BackColor="LightGoldenrodYellow" ReadOnly="True"/>
            <br />
            <br />
            <asp:Label ID="lblCredits" runat="server" Text="Credits" Font-Bold="True"></asp:Label>
            <br />
            <asp:TextBox ID="tbxCredits" runat="server" Style="width: 95%; max-width: 95%" TextMode="MultiLine" Rows="3" Font-Size="15px" BackColor="LightGoldenrodYellow" ReadOnly="True"/>
            <br />
            <br />
        </asp:Panel>
    </div>
    
</asp:Content>
