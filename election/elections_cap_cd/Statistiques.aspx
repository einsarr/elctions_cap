<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Statistiques.aspx.vb" Inherits="elections_cap_cd_Statistiques" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <br />

    <br /> TAUX DE PARTICIPATION : <h2 class="btn btn-primary"><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></h2>
    <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
            <asp:BoundField DataField="INSCRITS" HeaderText="INSCRITS" ReadOnly="True" SortExpression="INSCRITS" />
            <asp:BoundField DataField="VOTANT" HeaderText="VOTANT" ReadOnly="True" SortExpression="VOTANT" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT CG.LIBELLE_CORPS_GROUPE,
    COUNT (CASE WHEN E.A_VOTE=0 OR E.A_VOTE=1 THEN 1 ELSE NULL END )AS INSCRITS ,
    COUNT (CASE WHEN E.A_VOTE=1 THEN 1 ELSE NULL END ) AS VOTANT
FROM ELECTION_CAP_ELECTEUR E
JOIN ELECTION_CAP_CLASSE CL ON CL.ID_CLASSE=E.ID_CLASSE
JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS = E.ID_CORPS 
JOIN ELECTION_CAP_CORPS_GROUPE CG ON CG.ID_CORPS_GROUPE=C.ID_CORPS_GROUPE
GROUP BY CG.LIBELLE_CORPS_GROUPE
ORDER BY CG.LIBELLE_CORPS_GROUPE"></asp:SqlDataSource>
</asp:Content>

