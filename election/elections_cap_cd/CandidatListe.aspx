<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="CandidatListe.aspx.vb" Inherits="elections_Candidat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h1>Liste des candidats</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
     <br />
     <div class="col-md-12">
        <div class="table-responsive">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-hover table-striped"  runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True">
                <Columns>
                    <asp:BoundField DataField="MATRICULE_ELECTEUR" HeaderText="MATRICULE_ELECTEUR" SortExpression="MATRICULE_ELECTEUR" />
                    <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM_ELECTEUR" SortExpression="PRENOM_ELECTEUR" />
                    <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM_ELECTEUR" SortExpression="NOM_ELECTEUR" />
                    <asp:BoundField DataField="LIBELLE_CORPS" HeaderText="LIBELLE_CORPS" SortExpression="LIBELLE_CORPS" />
                    <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
                    <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" />
                    <asp:BoundField DataField="RANG" HeaderText="RANG" SortExpression="RANG" />
                    <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="CODE_SYNDICAT" SortExpression="CODE_SYNDICAT" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ELECTION_CAP_ELECTEUR.MATRICULE_ELECTEUR, ELECTION_CAP_ELECTEUR.PRENOM_ELECTEUR, ELECTION_CAP_ELECTEUR.NOM_ELECTEUR, ELECTION_CAP_CORPS.LIBELLE_CORPS, ELECTION_CAP_CORPS_GROUPE.LIBELLE_CORPS_GROUPE, ELECTION_CAP_CLASSE.LIBELLE_CLASSE, ELECTION_CAP_CANDIDAT_LISTE.RANG, ELECTION_CAP_SYNDICAT.CODE_SYNDICAT FROM ELECTION_CAP_CANDIDAT_LISTE INNER JOIN ELECTION_CAP_CANDIDAT ON ELECTION_CAP_CANDIDAT_LISTE.ID_CANDIDAT = ELECTION_CAP_CANDIDAT.ID_CANDIDAT INNER JOIN ELECTION_CAP_SYNDICAT ON ELECTION_CAP_CANDIDAT.ID_SYNDICAT = ELECTION_CAP_SYNDICAT.ID_SYNDICAT INNER JOIN ELECTION_CAP_ELECTEUR ON ELECTION_CAP_CANDIDAT_LISTE.ID_ELECTEUR = ELECTION_CAP_ELECTEUR.IDENTIFIANT_ELECTEUR INNER JOIN ELECTION_CAP_CORPS ON ELECTION_CAP_ELECTEUR.ID_CORPS = ELECTION_CAP_CORPS.ID_CORPS INNER JOIN ELECTION_CAP_CORPS_GROUPE ON ELECTION_CAP_CANDIDAT.ID_CORPS_GROUPE = ELECTION_CAP_CORPS_GROUPE.ID_CORPS_GROUPE INNER JOIN ELECTION_CAP_CLASSE ON ELECTION_CAP_CANDIDAT.ID_CLASSE = ELECTION_CAP_CLASSE.ID_CLASSE ORDER BY ELECTION_CAP_CORPS_GROUPE.LIBELLE_CORPS_GROUPE, ELECTION_CAP_CLASSE.LIBELLE_CLASSE, ELECTION_CAP_CANDIDAT_LISTE.RANG,CODE_SYNDICAT"></asp:SqlDataSource>

    <div class="modal fade" id="formulaire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle2">Nouveau syndicat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="DLL_ELECTEUR">CANDIDAT</asp:Label>
                    <asp:DROPDOWNLIST runat="server" ID="DLL_ELECTEUR" DataSourceID="SqlDLL_ELECTEUR" CssClass="form-control" DataTextField="MATRICULE_ELECTEUR" DataValueField="IDENTIFIANT_ELECTEUR"></asp:DROPDOWNLIST>
                    <asp:SqlDataSource ID="SqlDLL_ELECTEUR" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS IDENTIFIANT_ELECTEUR, '--------' AS MATRICULE_ELECTEUR UNION SELECT IDENTIFIANT_ELECTEUR,MATRICULE_ELECTEUR FROM ELECTION_CAP_ELECTEUR WHERE (EST_CANDIDAT = 1)"></asp:SqlDataSource>
                 </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="DLL_CANDIDAT">CANDIDATURE</asp:Label>
                    <asp:DROPDOWNLIST runat="server" ID="DLL_CANDIDAT" DataSourceID="SQL_DLL_CANDIDAT" CssClass="form-control" DataTextField="CANDIDAT" DataValueField="ID_CANDIDAT"></asp:DROPDOWNLIST>
                    <asp:SqlDataSource ID="SQL_DLL_CANDIDAT" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS ID_CANDIDAT, '--------' AS CANDIDAT UNION SELECT ELECTION_CAP_CANDIDAT.ID_CANDIDAT, 
CONCAT(ELECTION_CAP_SYNDICAT.CODE_SYNDICAT,'-',ELECTION_CAP_CLASSE.LIBELLE_CLASSE,'-',ELECTION_CAP_CORPS_GROUPE.LIBELLE_CORPS_GROUPE) AS CANDIDAT
FROM ELECTION_CAP_CANDIDAT INNER JOIN
ELECTION_CAP_CORPS_GROUPE ON ELECTION_CAP_CANDIDAT.ID_CORPS_GROUPE = ELECTION_CAP_CORPS_GROUPE.ID_CORPS_GROUPE INNER JOIN
ELECTION_CAP_SYNDICAT ON ELECTION_CAP_CANDIDAT.ID_SYNDICAT = ELECTION_CAP_SYNDICAT.ID_SYNDICAT INNER JOIN
ELECTION_CAP_CLASSE ON ELECTION_CAP_CANDIDAT.ID_CLASSE = ELECTION_CAP_CLASSE.ID_CLASSE"></asp:SqlDataSource>
                 </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="DDL_TYPE_CANDIDAT">Type candidat</asp:Label>
                    <asp:DropDownList ID="DDL_TYPE_CANDIDAT" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">---</asp:ListItem>
                        <asp:ListItem Value="TITULAIRE">TITULAIRE</asp:ListItem>
                        <asp:ListItem Value="SUPPLIANT">SUPPLIANT</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label for="TXT_RANG">Rang</label>
                    <asp:TextBox ID="TXT_RANG" runat="server" TextMode="Number" class="form-control"></asp:TextBox>
                 </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btn_add_candidat" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>
</asp:Content>






