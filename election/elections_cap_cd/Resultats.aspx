<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Resultats.aspx.vb" Inherits="elections_Resultats" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Button ID="Button1" runat="server" Text="Imprimer" />
    <div class="col-md-12">
        <div class="table-responsive col-md-12">
            

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-striped">
                <Columns>
                    <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="CODE_SYNDICAT" SortExpression="CODE_SYNDICAT" />
                    <asp:BoundField DataField="LIBELLE_CORPS_GROUPES" HeaderText="LIBELLE_CORPS_GROUPES" SortExpression="LIBELLE_CORPS_GROUPES" />
                    <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" />
                    <asp:BoundField DataField="NOMBRE_VOIX" HeaderText="NOMBRE_VOIX" ReadOnly="True" SortExpression="NOMBRE_VOIX" />
                </Columns>
            </asp:GridView>
        </div>
    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT S.CODE_SYNDICAT,CG.LIBELLE_CORPS_GROUPES,CL.LIBELLE_CLASSE,COUNT(V.ID_VOTE) NOMBRE_VOIX
FROM ELECTION_CAP_VOTE V
JOIN ELECTION_CAP_CANDIDAT C ON C.ID_CANDIDAT = V.ID_CANDIDAT
JOIN ELECTION_CAP_SYNDICAT S ON S.ID_SYNDICAT = C.ID_SYNDICAT
JOIN ELECTION_CAP_CORPS_GROUPES CG ON CG.ID_CORPS_GROUPES = V.ID_CORPS_GROUPE
JOIN ELECTION_CAP_ELECTEURS E ON E.ID_ELECTEUR=V.ID_ELECTEUR
JOIN ELECTION_CAP_CLASSE CL ON CL.ID_CLASSE=E.ID_CLASSE
GROUP BY S.CODE_SYNDICAT,CG.LIBELLE_CORPS_GROUPES,CL.LIBELLE_CLASSE
ORDER BY CG.LIBELLE_CORPS_GROUPES,CL.LIBELLE_CLASSE,NOMBRE_VOIX DESC"></asp:SqlDataSource>



</asp:Content>

