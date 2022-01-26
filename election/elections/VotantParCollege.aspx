<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="VotantParCollege.aspx.vb" Inherits="elections_VotantParCollege" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" Runat="Server">
    <br /><br /><br />
    <p>LISTE DES VOTANTS PAR COLLEGES</p>
    <div class="col-md-6">
        <div class="table-responsive" style="padding:0px;">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-hover" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="COLLEGE" HeaderText="COLLEGE" SortExpression="COLLEGE" />
                    <asp:BoundField DataField="NBRE" HeaderText="NBRE" ReadOnly="True" SortExpression="NBRE" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT COUNT(V.ID_COLLEGE) AS NBRE, C.LIBELLE_COLLEGE AS COLLEGE FROM ELECTION_CAP_VOTE AS V RIGHT JOIN ELECTION_CAP_COLLEGE AS C ON V.ID_COLLEGE = C.ID_COLLEGE GROUP BY C.LIBELLE_COLLEGE"></asp:SqlDataSource>
</asp:Content>

