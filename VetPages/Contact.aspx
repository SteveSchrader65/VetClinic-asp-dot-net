<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="DrDoolittleVetClinic.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div style="left: 110px; width: 1600px; position: absolute; top: 110px;">
        <asp:Panel runat="server" Style="float: left; padding-left: 0" Width="99%">
            <asp:Label ID="lblDetails" runat="server" Text="Details" Font-Bold="True"></asp:Label>
            <br />
            <asp:TextBox ID="tbxDetails" runat="server" Style="width: 95%; max-width: 50%" TextMode="MultiLine" Rows="7" Font-Size="15px" BackColor="LightGoldenrodYellow" ReadOnly="True"/>
            <br />
            <br />
          </asp:Panel>
    </div>

</asp:Content>
