<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Résultats_CG_CL.aspx.vb" Inherits="elections_cap_cd_Résultats_CG_CL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
    <br />
    <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="LIBELLE_CORPS_GROUPE" DataValueField="ID_CORPS_GROUPE" AutoPostBack="True"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ID_CORPS_GROUPE, LIBELLE_CORPS_GROUPE FROM ELECTION_CAP_CORPS_GROUPE"></asp:SqlDataSource>
    <br />
    <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="LIBELLE_CLASSE" DataValueField="ID_CLASSE" AutoPostBack="True"></asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ID_CLASSE, LIBELLE_CLASSE FROM ELECTION_CAP_CLASSE"></asp:SqlDataSource>
    <br />
        </div>
    <div class="row">
        <div class="col-md-8">
    <asp:GridView ID="GridView2" CssClass="table table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_CORPS_GROUPE" DataSourceID="SqlDataSource4">
        <Columns>
            <asp:BoundField DataField="LIBELLE_CORPS" HeaderText="CORPS" SortExpression="LIBELLE_CORPS" />
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" Visible="False" />
            <asp:BoundField DataField="ID_CORPS_GROUPE" HeaderText="ID_CORPS_GROUPE" InsertVisible="False" ReadOnly="True" SortExpression="ID_CORPS_GROUPE" Visible="False" />
            <asp:BoundField DataField="LIBELLE_HIERARCHIE" HeaderText="HIERARCHIE" SortExpression="LIBELLE_HIERARCHIE" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ELECTION_CAP_CORPS.LIBELLE_CORPS, ELECTION_CAP_CORPS_GROUPE.LIBELLE_CORPS_GROUPE, ELECTION_CAP_CORPS_GROUPE.ID_CORPS_GROUPE, ELECTION_CAP_HIERARCHIE.LIBELLE_HIERARCHIE FROM ELECTION_CAP_CORPS INNER JOIN ELECTION_CAP_CORPS_GROUPE ON ELECTION_CAP_CORPS.ID_CORPS_GROUPE = ELECTION_CAP_CORPS_GROUPE.ID_CORPS_GROUPE INNER JOIN ELECTION_CAP_HIERARCHIE ON ELECTION_CAP_CORPS.ID_HIERARCHIE = ELECTION_CAP_HIERARCHIE.ID_HIERARCHIE WHERE (ELECTION_CAP_CORPS_GROUPE.ID_CORPS_GROUPE = @ID_CORPS_GROUPE)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="ID_CORPS_GROUPE" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
            </div>
    <div class="col-md-4">
    <asp:GridView ID="GridView1" CssClass="table table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3">
        <Columns>
            <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" Visible="False" />
            <asp:BoundField DataField="LIBELLE_CLASSE" HeaderText="LIBELLE_CLASSE" SortExpression="LIBELLE_CLASSE" Visible="False" />
            <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="SYNDICAT" SortExpression="CODE_SYNDICAT" />
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" SortExpression="ID_CANDIDAT" Visible="False" />
            <asp:BoundField DataField="NOMBRE_VOTANTS" HeaderText="NOMBRE DE VOIX" ReadOnly="True" SortExpression="NOMBRE_VOTANTS" />
            <asp:HyperLinkField DataNavigateUrlFields="ID_CORPS_GROUPE,ID_CLASSE" DataNavigateUrlFormatString="http://www.mirador.education.gouv.sn:8081/ReportServer/Pages/ReportViewer.aspx?%2fRSMiroir%2fPV&amp;rs:Command=Render&amp;corpsgroupe_id={0}&classe_id={1}&amp;rs:Format=WORD" HeaderText="Procès verbal" Text="Imprimer" />
            <asp:HyperLinkField DataNavigateUrlFields="ID_CANDIDAT" DataNavigateUrlFormatString="http://www.mirador.education.gouv.sn:8081/ReportServer/Pages/ReportViewer.aspx?%2fRSMiroir%2fListeGagnante&amp;rs:Command=Render&amp;candidat_id={0}&amp;rs:Format=WORD" HeaderText="Liste Gagnante" Text="Imprimer" />
        </Columns>
    </asp:GridView>

        <br />
        <asp:Button CssClass="btn btn-danger" ID="Button1" runat="server" Text="Cloturer" />
        </div>
</div>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT TOP (1) CG.ID_CORPS_GROUPE,CG.LIBELLE_CORPS_GROUPE,CL.ID_CLASSE,CL.LIBELLE_CLASSE, S.CODE_SYNDICAT, V.ID_CANDIDAT, COUNT(V.ID_VOTE) AS NOMBRE_VOTANTS FROM ELECTION_CAP_VOTE AS V INNER JOIN ELECTION_CAP_CANDIDAT AS CDT ON CDT.ID_CANDIDAT = V.ID_CANDIDAT INNER JOIN ELECTION_CAP_CORPS_GROUPE AS CG ON CG.ID_CORPS_GROUPE = CDT.ID_CORPS_GROUPE INNER JOIN ELECTION_CAP_CLASSE AS CL ON CL.ID_CLASSE = CDT.ID_CLASSE INNER JOIN ELECTION_CAP_SYNDICAT AS S ON S.ID_SYNDICAT = CDT.ID_SYNDICAT WHERE (CG.ID_CORPS_GROUPE = @ID_CORPS_GROUPE) AND (CL.ID_CLASSE = @ID_CLASSE) GROUP BY CG.ID_CORPS_GROUPE,CG.LIBELLE_CORPS_GROUPE, CL.LIBELLE_CLASSE,CL.ID_CLASSE, S.CODE_SYNDICAT, V.ID_CANDIDAT ORDER BY CG.LIBELLE_CORPS_GROUPE, NOMBRE_VOTANTS DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="ID_CORPS_GROUPE" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList2" Name="ID_CLASSE" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>



</asp:Content>

