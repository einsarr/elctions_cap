<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ListeElecteurs.aspx.vb" Inherits="elections_cap_cd_ListeElecteurs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <br />
    <br />
    <asp:GridView ID="GridView1" PagerStyle-CssClass="pagination-ys" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowSorting="True"
                                BackColor="White" BorderColor="#3366CC" BorderStyle="None">
        <Columns>
            <asp:BoundField DataField="MATRICULE_ELECTEUR" HeaderText="MATRICULE_ELECTEUR" SortExpression="MATRICULE_ELECTEUR" />
            <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM_ELECTEUR" SortExpression="PRENOM_ELECTEUR" />
            <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM_ELECTEUR" SortExpression="NOM_ELECTEUR" />
            <asp:BoundField DataField="NIN_ELECTEUR" HeaderText="NIN_ELECTEUR" SortExpression="NIN_ELECTEUR" />
            <asp:BoundField DataField="AVOTE" HeaderText="AVOTE" ReadOnly="True" SortExpression="AVOTE" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT MATRICULE_ELECTEUR, PRENOM_ELECTEUR, NOM_ELECTEUR, NIN_ELECTEUR, CASE A_VOTE WHEN 1 THEN 'A VOTE' ELSE '' END AS AVOTE FROM ELECTION_CAP_ELECTEUR"></asp:SqlDataSource>

</asp:Content>

