<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Vote.aspx.vb" Inherits="elections_Vote" %>

<asp:Content ID="Contenu1" ContentPlaceHolderID="MainContent" Runat="Server">
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
                        <asp:Button ID="Button1" runat="server" Font-Bold="True" ForeColor="#FF3300" Text="Confirmer" CommandName="bnt_voter" CommandArgument='<%# Eval("ID_SYNDICAT") & " " & Eval("ID_CORPS_GROUPES") %>'/>
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
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ELECTION_CAP_CANDIDAT.ID_SYNDICAT, ELECTION_CAP_CANDIDAT.ID_CORPS_GROUPES, 
	ELECTION_CAP_SYNDICAT.CODE_SYNDICAT, ELECTION_CAP_SYNDICAT.PRENOM_NOM_SG, 
    ELECTION_CAP_SYNDICAT.PHOTO_SG
FROM ELECTION_CAP_CANDIDAT INNER JOIN ELECTION_CAP_SYNDICAT 
ON ELECTION_CAP_CANDIDAT.ID_SYNDICAT = ELECTION_CAP_SYNDICAT.ID_SYNDICAT
WHERE ELECTION_CAP_CANDIDAT.ID_CORPS_GROUPES = (SELECT C.ID_CORPS_GROUPE FROM ELECTION_CAP_CORPS C
INNER JOIN ELECTION_CAP_ELECTEURS E ON E.ID_CORPS = C.ID_CORPS
WHERE E.ID_ELECTEUR=1 AND ELECTION_CAP_CANDIDAT.ID_CLASSE = E.ID_CLASSE)">
</asp:SqlDataSource>
</asp:Content>