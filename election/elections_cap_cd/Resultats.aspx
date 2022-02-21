<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Resultats.aspx.vb" Inherits="elections_Resultats" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Button ID="Button1" runat="server" Text="Imprimer" />
    <br />
    <br />
    <asp:GridView ID="GridView4" CssClass="table table-bordered table-striped" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4">
        <Columns>
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
            <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" />
            <asp:BoundField DataField="INSCRITS" HeaderText="INSCRITS" ReadOnly="True" SortExpression="INSCRITS" />
            <asp:BoundField DataField="VOTANT" HeaderText="VOTANT" ReadOnly="True" SortExpression="VOTANT" />
            <asp:BoundField DataField="BULLETIN_NULL" HeaderText="BULLETIN_NULL" ReadOnly="True" SortExpression="BULLETIN_NULL" />
            <asp:BoundField DataField="SUFFRAGE_VALABLEMENT_EXPRIME" HeaderText="SUFFRAGE_VALABLEMENT_EXPRIME" ReadOnly="True" SortExpression="SUFFRAGE_VALABLEMENT_EXPRIME" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE,
    COUNT (CASE WHEN E.A_VOTE=0 OR E.A_VOTE=1 THEN 1 ELSE NULL END )AS INSCRITS ,
    COUNT (CASE WHEN E.A_VOTE=1 THEN 1 ELSE NULL END ) AS VOTANT,
	0 BULLETIN_NULL,
	COUNT (CASE WHEN E.A_VOTE=1 THEN 1 ELSE NULL END ) AS SUFFRAGE_VALABLEMENT_EXPRIME
FROM ELECTION_CAP_ELECTEUR E
JOIN ELECTION_CAP_CLASSE CL ON CL.ID_CLASSE=E.ID_CLASSE
JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS = E.ID_CORPS 
JOIN ELECTION_CAP_CORPS_GROUPE CG ON CG.ID_CORPS_GROUPE=C.ID_CORPS_GROUPE
GROUP BY CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE
ORDER BY CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE"></asp:SqlDataSource>
    <br />
    <br />
    
    <div class="col-md-12">
        <div class="table-responsive col-md-12">
            

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-striped">
                <Columns>
                    <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
                    <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" />
                    <asp:BoundField DataField="NOMBRE_INSCRITS" HeaderText="NOMBRE_INSCRITS" SortExpression="NOMBRE_INSCRITS" ReadOnly="True" />
                </Columns>
            </asp:GridView>
        </div>
    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="
SELECT CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE,COUNT(E.IDENTIFIANT_ELECTEUR) NOMBRE_INSCRITS
FROM ELECTION_CAP_ELECTEUR E
JOIN ELECTION_CAP_CLASSE CL ON CL.ID_CLASSE=E.ID_CLASSE
JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS = E.ID_CORPS 
JOIN ELECTION_CAP_CORPS_GROUPE CG ON CG.ID_CORPS_GROUPE=C.ID_CORPS_GROUPE
GROUP BY CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE"></asp:SqlDataSource>


    <asp:GridView ID="GridView2" CssClass="table table-bordered table-striped" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
        <Columns>
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
            <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" />
            <asp:BoundField DataField="NOMBRE_VOTANTS" HeaderText="NOMBRE_VOTANTS" ReadOnly="True" SortExpression="NOMBRE_VOTANTS" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE,COUNT(E.IDENTIFIANT_ELECTEUR) NOMBRE_VOTANTS
FROM ELECTION_CAP_ELECTEUR E
JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS=E.ID_CORPS
JOIN ELECTION_CAP_CORPS_GROUPE CG ON CG.ID_CORPS_GROUPE=C.ID_CORPS_GROUPE
JOIN ELECTION_CAP_CLASSE CL ON CL.ID_CLASSE=E.ID_CLASSE
WHERE E.A_VOTE=1
GROUP BY CL.LIBELLE_CLASSE,CG.LIBELLE_CORPS_GROUPE"></asp:SqlDataSource>



<asp:GridView ID="GridView3" CssClass="table table-bordered table-striped" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
    <Columns>
        <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
        <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" />
        <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="CODE_SYNDICAT" SortExpression="CODE_SYNDICAT" />
        <asp:BoundField DataField="NOMBRE_VOTANTS" HeaderText="NOMBRE_VOTANTS" ReadOnly="True" SortExpression="NOMBRE_VOTANTS" />
    </Columns>
    </asp:GridView>



    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE,S.CODE_SYNDICAT,COUNT(V.ID_VOTE) NOMBRE_VOTANTS FROM ELECTION_CAP_VOTE V
JOIN ELECTION_CAP_CANDIDAT CDT ON CDT.ID_CANDIDAT=V.ID_CANDIDAT
JOIN ELECTION_CAP_CORPS_GROUPE CG ON CG.ID_CORPS_GROUPE=CDT.ID_CORPS_GROUPE
JOIN ELECTION_CAP_CLASSE CL ON CL.ID_CLASSE=CDT.ID_CLASSE
JOIN ELECTION_CAP_SYNDICAT S ON S.ID_SYNDICAT=CDT.ID_SYNDICAT
GROUP BY CG.LIBELLE_CORPS_GROUPE,CL.LIBELLE_CLASSE,S.CODE_SYNDICAT
ORDER BY CG.LIBELLE_CORPS_GROUPE,S.CODE_SYNDICAT,NOMBRE_VOTANTS"></asp:SqlDataSource>



</asp:Content>

