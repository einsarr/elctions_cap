<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="EspaceVote.aspx.vb" Inherits="elections_EspaceVote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_SYNDICAT" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_SYNDICAT" />
            <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="CODE_SYNDICAT" SortExpression="CODE_SYNDICAT" />
            <asp:BoundField DataField="PRENOM_NOM_SG" HeaderText="PRENOM_NOM_SG" SortExpression="PRENOM_NOM_SG" />
            <asp:BoundField DataField="PHOTO_SG" HeaderText="PHOTO_SG" SortExpression="PHOTO_SG" />
        </Columns>
    </asp:GridView>
    
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ID_SYNDICAT, CODE_SYNDICAT, PRENOM_NOM_SG, PHOTO_SG FROM ELECTION_CAP_SYNDICAT"></asp:SqlDataSource>
</asp:Content>

