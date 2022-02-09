<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Vote.aspx.vb" Inherits="elections_Vote" %>

<asp:Content ID="Contenu1" ContentPlaceHolderID="MainContent" Runat="Server">
    <br />
    <br />
    <br />
    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataKeyNames="IDENTIFIANT_ELECTEUR" DataSourceID="SqlDataSource2">
        <Fields>
            <asp:BoundField DataField="IDENTIFIANT_ELECTEUR" HeaderText="IDENTIFIANT_ELECTEUR" InsertVisible="False" ReadOnly="True" SortExpression="IDENTIFIANT_ELECTEUR" />
            <asp:BoundField DataField="MATRICULE_ELECTEUR" HeaderText="MATRICULE_ELECTEUR" SortExpression="MATRICULE_ELECTEUR" />
            <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM_ELECTEUR" SortExpression="PRENOM_ELECTEUR" />
            <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM_ELECTEUR" SortExpression="NOM_ELECTEUR" />
            <asp:BoundField DataField="NIN_ELECTEUR" HeaderText="NIN_ELECTEUR" SortExpression="NIN_ELECTEUR" />
            <asp:BoundField DataField="CODE_CORPS" HeaderText="CODE_CORPS" SortExpression="CODE_CORPS" />
            <asp:BoundField DataField="CODE_GRADE" HeaderText="CODE_GRADE" SortExpression="CODE_GRADE" />
            <asp:BoundField DataField="CODE_CLASSE" HeaderText="CODE_CLASSE" SortExpression="CODE_CLASSE" />
            <asp:BoundField DataField="EMAIL_ELECTEUR" HeaderText="EMAIL_ELECTEUR" SortExpression="EMAIL_ELECTEUR" />
            <asp:BoundField DataField="SEXE_ELECTEUR" HeaderText="SEXE_ELECTEUR" SortExpression="SEXE_ELECTEUR" />
            <asp:BoundField DataField="TELEPHONE_ELECTEUR" HeaderText="TELEPHONE_ELECTEUR" SortExpression="TELEPHONE_ELECTEUR" />
            <asp:BoundField DataField="PASSWORD_ELECTEUR" HeaderText="PASSWORD_ELECTEUR" SortExpression="PASSWORD_ELECTEUR" />
            <asp:BoundField DataField="PASSWORD_VALIDE" HeaderText="PASSWORD_VALIDE" SortExpression="PASSWORD_VALIDE" />
            <asp:BoundField DataField="A_VOTER" HeaderText="A_VOTER" SortExpression="A_VOTER" />
            <asp:BoundField DataField="TENTATIVE" HeaderText="TENTATIVE" SortExpression="TENTATIVE" />
            <asp:BoundField DataField="CODE_CORPS_GROUPE" HeaderText="CODE_CORPS_GROUPE" SortExpression="CODE_CORPS_GROUPE" />
            <asp:BoundField DataField="CODE_CORPS_GROUPE1" HeaderText="CODE_CORPS_GROUPE1" SortExpression="CODE_CORPS_GROUPE1" />
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
            <asp:BoundField DataField="IDENTIFIANT_ELECTEUR" HeaderText="IDENTIFIANT_ELECTEUR" InsertVisible="False" ReadOnly="True" SortExpression="IDENTIFIANT_ELECTEUR" />
            <asp:BoundField DataField="MATRICULE_ELECTEUR" HeaderText="MATRICULE_ELECTEUR" SortExpression="MATRICULE_ELECTEUR" />
            <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM_ELECTEUR" SortExpression="PRENOM_ELECTEUR" />
            <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM_ELECTEUR" SortExpression="NOM_ELECTEUR" />
            <asp:BoundField DataField="NIN_ELECTEUR" HeaderText="NIN_ELECTEUR" SortExpression="NIN_ELECTEUR" />
            <asp:BoundField DataField="CODE_CORPS" HeaderText="CODE_CORPS" SortExpression="CODE_CORPS" />
            <asp:BoundField DataField="CODE_GRADE" HeaderText="CODE_GRADE" SortExpression="CODE_GRADE" />
            <asp:BoundField DataField="CODE_CLASSE" HeaderText="CODE_CLASSE" SortExpression="CODE_CLASSE" />
            <asp:BoundField DataField="EMAIL_ELECTEUR" HeaderText="EMAIL_ELECTEUR" SortExpression="EMAIL_ELECTEUR" />
            <asp:BoundField DataField="SEXE_ELECTEUR" HeaderText="SEXE_ELECTEUR" SortExpression="SEXE_ELECTEUR" />
            <asp:BoundField DataField="TELEPHONE_ELECTEUR" HeaderText="TELEPHONE_ELECTEUR" SortExpression="TELEPHONE_ELECTEUR" />
            <asp:BoundField DataField="PASSWORD_ELECTEUR" HeaderText="PASSWORD_ELECTEUR" SortExpression="PASSWORD_ELECTEUR" />
            <asp:BoundField DataField="PASSWORD_VALIDE" HeaderText="PASSWORD_VALIDE" SortExpression="PASSWORD_VALIDE" />
            <asp:BoundField DataField="A_VOTER" HeaderText="A_VOTER" SortExpression="A_VOTER" />
            <asp:BoundField DataField="TENTATIVE" HeaderText="TENTATIVE" SortExpression="TENTATIVE" />
            <asp:BoundField DataField="CODE_CORPS_GROUPE" HeaderText="CODE_CORPS_GROUPE" SortExpression="CODE_CORPS_GROUPE" />
            <asp:BoundField DataField="LIBELLE_CORPS" HeaderText="LIBELLE_CORPS" SortExpression="LIBELLE_CORPS" />
            <asp:BoundField DataField="CODE_CORPS_GROUPE1" HeaderText="CODE_CORPS_GROUPE1" SortExpression="CODE_CORPS_GROUPE1" />
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
        </Fields>
    </asp:DetailsView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT E.*,C.LIBELLE_CORPS,CG.CODE_CORPS_GROUPE,CG.LIBELLE_CORPS_GROUPE FROM ELECTION_CAP_ELECTEUR E 
JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS =E.CODE_CORPS 
JOIN ELECTION_CAP_CORPS_GROUPE CG ON CG.ID_CORPS_GROUPE=C.ID_CORPS_GROUPE
WHERE E.IDENTIFIANT_ELECTEUR=@IDENTIFIANT_ELECTEUR">
        <SelectParameters>
            <asp:SessionParameter Name="IDENTIFIANT_ELECTEUR" SessionField="id_elect" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />
    <asp:DetailsView ID="DetailsView2" runat="server" Height="50px" Width="125px"></asp:DetailsView>
    
    <br />
    <br />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button2" runat="server" Text="Button" />
    <br />
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <br />
    
    <asp:DataList ID="DataList1" CssClass="table table-bordered table-striped" runat="server" DataSourceID="SqlDataSource1" Height="109px" RepeatDirection="Horizontal" Width="144px" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Justify" RepeatColumns="4">
        <ItemTemplate>
            <table>
                <tr>
                    <td class="btn btn-danger">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("CODE_SYNDICAT") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="btn btn-primary">
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("PRENOM_NOM_SG") %>'></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("PHOTO_SG", "~/elections/images/{0}") %>' Width="100%" />
                    </td>
                </tr>
                <tr>
                    <td class="btn btn-warning">
                        <asp:Button ID="BtAnnulerCloture" CssClass="btn btn-primary" runat="server" Text="Voter" />
                        <asp:Panel ID="PaneAnnulationCloture" runat="server">
                        <asp:Button ID="Button1" runat="server" Font-Bold="True" ForeColor="#FF3300" Text="Confirmer" CommandName="bnt_voter" CommandArgument='<%# Eval("ID_SYNDICAT") & " " & Eval("ID_CORPS_GROUPE") %>'/>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList>
                        

    <%--<asp:Button ID="BtAnnulerCloture" CssClass="btn btn-primary" runat="server" Text="Voter" />
    <asp:Panel ID="PaneAnnulationCloture" runat="server">
    <asp:Button ID="Button1" runat="server" Font-Bold="True" ForeColor="#FF3300" Text="Confirmer" CommandName="bnt_voter" CommandArgument='<%# Eval("ID_SYNDICAT") & " " & Eval("ID_CORPS_GROUPES") %>'/>
    </asp:Panel>--%>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT c.*,s.* FROM ELECTION_CAP_CANDIDAT c 
JOIN ELECTION_CAP_SYNDICAT s on S.ID_SYNDICAT=c.ID_SYNDICAT
WHERE C.ID_CORPS_GROUPE =
(SELECT cg.ID_CORPS_GROUPE FROM ELECTION_CAP_CORPS CO
	JOIN ELECTION_CAP_CORPS_GROUPE cg ON cg.ID_CORPS_GROUPE=CO.ID_CORPS_GROUPE
	JOIN ELECTION_CAP_ELECTEUR E ON E.CODE_CORPS=CO.ID_CORPS
	WHERE E.IDENTIFIANT_ELECTEUR=@IDENTIFIANT_ELECTEUR)
AND C.ID_CLASSE=(SELECT EL.CODE_CLASSE FROM ELECTION_CAP_ELECTEUR EL
			WHERE EL.IDENTIFIANT_ELECTEUR=@IDENTIFIANT_ELECTEUR)">
    <SelectParameters>
        <asp:SessionParameter Name="IDENTIFIANT_ELECTEUR" SessionField="id_elect" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>