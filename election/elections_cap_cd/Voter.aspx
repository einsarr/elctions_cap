<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Voter.aspx.vb" Inherits="elections_Voter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <br />
    <br />
    <div class="row">
        <div class="col-md-4">
            <asp:DetailsView ID="DetailsView1" CssClass="table table-bordered table-striped" runat="server" DataSourceID="SqlDataSource2" AutoGenerateRows="False" DataKeyNames="IDENTIFIANT_ELECTEUR">
                <Fields>
                    <asp:BoundField DataField="MATRICULE_ELECTEUR" HeaderText="MATRICULE" SortExpression="MATRICULE_ELECTEUR" />
                    <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM" SortExpression="NOM_ELECTEUR" />
                    <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM" SortExpression="PRENOM_ELECTEUR" />
                    <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="CLASSE" SortExpression="LIBELLE_CLASSE" >
                    <ItemStyle BackColor="#66CCFF" Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="LIBELLE_CORPS" HeaderText="CORPS" SortExpression="LIBELLE_CORPS" >
                    <ItemStyle BackColor="#66CCFF" Font-Bold="True" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="IDENTIFIANT_ELECTEUR" HeaderText="IDENTIFIANT_ELECTEUR" InsertVisible="False" ReadOnly="True" SortExpression="IDENTIFIANT_ELECTEUR" Visible="False" />
                </Fields>

            </asp:DetailsView>
            <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="~/elections_cap_cd/Account/deconnexion.aspx" CssClass="btn btn-default btn-xs">Déconnexion</asp:LinkButton>
            
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ELECTION_CAP_ELECTEUR.MATRICULE_ELECTEUR, ELECTION_CAP_ELECTEUR.PRENOM_ELECTEUR, ELECTION_CAP_ELECTEUR.NOM_ELECTEUR, ELECTION_CAP_CLASSE.LIBELLE_CLASSE, ELECTION_CAP_CORPS.LIBELLE_CORPS, ELECTION_CAP_ELECTEUR.IDENTIFIANT_ELECTEUR FROM ELECTION_CAP_ELECTEUR INNER JOIN ELECTION_CAP_CORPS ON ELECTION_CAP_ELECTEUR.ID_CORPS = ELECTION_CAP_CORPS.ID_CORPS INNER JOIN ELECTION_CAP_CLASSE ON ELECTION_CAP_ELECTEUR.ID_CLASSE = ELECTION_CAP_CLASSE.ID_CLASSE WHERE ELECTION_CAP_ELECTEUR.IDENTIFIANT_ELECTEUR =@IDENTIFIANT_ELECTEUR">
                <SelectParameters>
                    <asp:SessionParameter Name="IDENTIFIANT_ELECTEUR" SessionField="id_elect" />
                </SelectParameters>
            </asp:SqlDataSource>
    
            <%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
            <br />
            <br />
        </div>
        <div class="col-md-8">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1" GroupItemCount="4">
        <AlternatingItemTemplate>
                <td runat="server" style="width:200px">
                    <asp:Label ID="ID_CANDIDATLabel" runat="server" Width="100%" Text='<%# Eval("ID_CANDIDAT") %>' Visible="false"/>
                    <%--<br />LIBELLE_SYNDICAT:
                    <asp:Label ID="LIBELLE_SYNDICATLabel" runat="server" Text='<%# Eval("LIBELLE_SYNDICAT") %>' />--%>
                    <asp:Label ID="Label2" CssClass="btn btn-success" Width="100%" runat="server" Text='<%# Eval("CODE_SYNDICAT") %>' />
                    <%--<br />PRENOM_NOM_SG:
                    <asp:Label ID="PRENOM_NOM_SGLabel" runat="server" Text='<%# Eval("PRENOM_NOM_SG") %>' />
                    <br />PHOTO_SG:
                    <asp:Image ID="PHOTO_SGLabel" Width="25%" runat="server"  ImageUrl='<%# Eval("PHOTO_SG", "~/elections/images/{0}") %>' AlternateText="404" Visible="true" />--%>
                    <br />
                    <asp:Button ID="Button1" CommandArgument='<%# Eval("ID_CANDIDAT")%>'  OnClick="Consulter" Width="100%" runat="server" Text="Choisir" CssClass="btn btn-warning" />
                    <br />
                </td>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <td runat="server" style="">ID_CANDIDAT:
                <asp:Label ID="ID_CANDIDATLabel1" runat="server" Text='<%# Eval("ID_CANDIDAT") %>' />
                <br />LIBELLE_SYNDICAT:
                <asp:TextBox ID="LIBELLE_SYNDICATTextBox" runat="server" Text='<%# Bind("LIBELLE_SYNDICAT") %>' />
                <br />PRENOM_NOM_SG:
                <asp:TextBox ID="PRENOM_NOM_SGTextBox" runat="server" Text='<%# Bind("PRENOM_NOM_SG") %>' />
                <br />PHOTO_SG:
                <asp:TextBox ID="PHOTO_SGTextBox" runat="server" Text='<%# Bind("PHOTO_SG") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Mettre à jour" />
                <br />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Annuler" />
                <br /></td>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>Aucune donnée n&#39;a été retournée.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
<td runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server"></td>
            </tr>
        </GroupTemplate>
        <InsertItemTemplate>
            <td runat="server" style="">LIBELLE_SYNDICAT:
                <asp:TextBox ID="LIBELLE_SYNDICATTextBox" runat="server" Text='<%# Bind("LIBELLE_SYNDICAT") %>' />
                <br />PRENOM_NOM_SG:
                <asp:TextBox ID="PRENOM_NOM_SGTextBox" runat="server" Text='<%# Bind("PRENOM_NOM_SG") %>' />
                <br />PHOTO_SG:
                <asp:TextBox ID="PHOTO_SGTextBox" runat="server" Text='<%# Bind("PHOTO_SG") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insérer" />
                <br />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Désactiver" />
                <br /></td>
        </InsertItemTemplate>
        <ItemTemplate>
            <td runat="server" style="width:200px">
                <asp:Label ID="ID_CANDIDATLabel" Width="100%" runat="server" Text='<%# Eval("ID_CANDIDAT") %>' Visible="false"/>
                <%--<br />LIBELLE_SYNDICAT:
                <asp:Label ID="LIBELLE_SYNDICATLabel" runat="server" Text='<%# Eval("LIBELLE_SYNDICAT") %>' />--%>
                <asp:Label CssClass="btn btn-success" Width="100%" ID="Label2" runat="server" Text='<%# Eval("CODE_SYNDICAT") %>' />
                <%--<br />PRENOM_NOM_SG:
                <asp:Label ID="PRENOM_NOM_SGLabel" runat="server" Text='<%# Eval("PRENOM_NOM_SG") %>' />
                <br />PHOTO_SG:
                <asp:Image ID="PHOTO_SGLabel" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_SG", "~/elections/images/{0}") %>' AlternateText="404" Visible="true" />
                <br />--%>
                <br />
                <asp:Button ID="Button1" CommandArgument='<%# Eval("ID_CANDIDAT")%>' OnClick="Consulter" runat="server" Width="100%" Text="Choisir" CssClass="btn btn-warning" />
                <br />
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server" width="100%">
                        <table id="groupPlaceholderContainer" runat="server" border="0" style="" class="table table-bordered table-hover table-striped">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style=""></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <td runat="server" style="">ID_CANDIDAT:
                <asp:Label ID="ID_CANDIDATLabel" runat="server" Text='<%# Eval("ID_CANDIDAT") %>' />
                <br />LIBELLE_SYNDICAT:
                <asp:Label ID="LIBELLE_SYNDICATLabel" runat="server" Text='<%# Eval("LIBELLE_SYNDICAT") %>' />
                <br />PRENOM_NOM_SG:
                <asp:Label ID="PRENOM_NOM_SGLabel" runat="server" Text='<%# Eval("PRENOM_NOM_SG") %>' />
                <br />PHOTO_SG:
                <asp:Label ID="PHOTO_SGLabel" runat="server" Text='<%# Eval("PHOTO_SG") %>'  />
                <br /></td>
        </SelectedItemTemplate>
    </asp:ListView>
    </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT c.*,s.* FROM ELECTION_CAP_CANDIDAT c 
JOIN ELECTION_CAP_SYNDICAT s on S.ID_SYNDICAT=c.ID_SYNDICAT
WHERE C.ID_CORPS_GROUPE =
(SELECT cg.ID_CORPS_GROUPE FROM ELECTION_CAP_CORPS CO
	JOIN ELECTION_CAP_CORPS_GROUPE cg ON cg.ID_CORPS_GROUPE=CO.ID_CORPS_GROUPE
	JOIN ELECTION_CAP_ELECTEUR E ON E.ID_CORPS=CO.ID_CORPS
	WHERE E.IDENTIFIANT_ELECTEUR=@IDENTIFIANT_ELECTEUR)
AND C.ID_CLASSE=(SELECT EL.ID_CLASSE FROM ELECTION_CAP_ELECTEUR EL
			WHERE EL.IDENTIFIANT_ELECTEUR=@IDENTIFIANT_ELECTEUR) ORDER BY CODE_SYNDICAT">
        <SelectParameters>
            <asp:SessionParameter Name="IDENTIFIANT_ELECTEUR" SessionField="id_elect" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

