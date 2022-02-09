<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="DetailVote.aspx.vb" Inherits="elections_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <br />
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_CANDIDAT_LISTE" DataSourceID="SqlDataSource2">
        <Columns>
            <asp:BoundField DataField="ID_CANDIDAT_LISTE" HeaderText="ID_CANDIDAT_LISTE" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT_LISTE" />
            <asp:BoundField DataField="ID_ELECTEUR" HeaderText="ID_ELECTEUR" SortExpression="ID_ELECTEUR" />
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" SortExpression="ID_CANDIDAT" />
            <asp:BoundField DataField="RANG" HeaderText="RANG" SortExpression="RANG" />
            <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM_ELECTEUR" SortExpression="PRENOM_ELECTEUR" />
            <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM_ELECTEUR" SortExpression="NOM_ELECTEUR" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT EC.ID_CANDIDAT_LISTE, EC.ID_ELECTEUR, EC.ID_CANDIDAT, EC.RANG, E.PRENOM_ELECTEUR, E.NOM_ELECTEUR FROM ELECTION_CAP_CANDIDAT_LISTE AS EC INNER JOIN ELECTION_CAP_ELECTEUR AS E ON E.IDENTIFIANT_ELECTEUR = EC.ID_ELECTEUR INNER JOIN ELECTION_CAP_CANDIDAT AS C ON C.ID_CANDIDAT = EC.ID_CANDIDAT WHERE (C.ID_CANDIDAT = @ID_CANDIDAT) ORDER BY EC.RANG">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID_CANDIDAT" QueryStringField="confirm" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1">
        <Fields>
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT" />
            <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" SortExpression="ID_SYNDICAT" />
            <asp:BoundField DataField="ID_CORPS_GROUPE" HeaderText="ID_CORPS_GROUPE" SortExpression="ID_CORPS_GROUPE" />
            <asp:BoundField DataField="ID_CLASSE" HeaderText="ID_CLASSE" SortExpression="ID_CLASSE" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_CANDIDAT] WHERE ([ID_CANDIDAT] = @ID_CANDIDAT)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID_CANDIDAT" QueryStringField="confirm" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT" />
            <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" SortExpression="ID_SYNDICAT" />
            <asp:BoundField DataField="ID_CORPS_GROUPE" HeaderText="ID_CORPS_GROUPE" SortExpression="ID_CORPS_GROUPE" />
            <asp:BoundField DataField="ID_CLASSE" HeaderText="ID_CLASSE" SortExpression="ID_CLASSE" />
        </Columns>
    </asp:GridView>
    <br />

    <asp:Button ID="BtnConfirmVote" runat="server" Text="Valider mon choix" />



</asp:Content>

