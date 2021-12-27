<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Vote.aspx.vb" Inherits="elections_Candidat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h1>VOTE</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />

     <%
'Dim ensNominerFormation As Boolean
'Dim fform As New FonctionsFormation
'ensNominerFormation = fform.EnsDansListeNominative(Session("id_ens"))
'inscripFormOuvert = fform.InscriptionFormationOuvert()
'If ensNominerFormation = True And inscripFormOuvert = True Then
    %>
    <div class="row">
        <div class="col-md-12">
            <asp:DataList ID="DataList1" CssClass="table table-bordered table-striped"  runat="server" DataSourceID="SqlDataSource1" Height="109px" RepeatDirection="Horizontal" Width="144px">
                <ItemTemplate>
                    <table align="center" style="width: 100%">
                        <tr>
                            <td class="btn btn-primary">
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ID_CANDIDAT") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="btn btn-info">
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("ID_SYNDICAT") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("PHOTO_CANDIDAT", "~/elections/images/{0}") %>' Width="100%" />
                            </td>
                        </tr>
                        <tr>
                            <td class="btn btn-warning">
                                <asp:Button ID="Button1" runat="server" Font-Bold="True" ForeColor="#FF3300" Text="Voter" CommandName="bnt_voter" CommandArgument='<%# Eval("ID_CANDIDAT") & " " & Eval("ID_ENSEIGNANT") & " " & Eval("ID_COLLEGE") %>'/>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>

            </asp:DataList>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT C.ID_CANDIDAT, C.ID_ENSEIGNANT, C.ID_SYNDICAT, C.ID_COLLEGE, C.PHOTO_CANDIDAT, COL.ID_COLLEGE AS Expr1, COL.LIBELLE_COLLEGE FROM ELECTION_CAP_CANDIDAT AS C INNER JOIN ELECTION_CAP_COLLEGE AS COL ON C.ID_COLLEGE = COL.ID_COLLEGE WHERE COL.LIBELLE_COLLEGE = (SELECT CONCAT(C.LIBELLE_CORPS,G.LIBELLE_GRADE) AS Expr1 FROM ENSEIGNANT AS E INNER JOIN CORPS AS C ON E.CODE_CORPS = C.CODE_CORPS INNER JOIN GRADE AS G ON E.CODE_GRADE = G.CODE_GRADE WHERE (E.IDENTIFIANT_ENSEIGNANT = @ID))">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1889969" Name="ID" />
                </SelectParameters>
        </asp:SqlDataSource>
            <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_CANDIDAT]"></asp:SqlDataSource>--%>
     </div>

     <% 'End If %>
</asp:Content>

