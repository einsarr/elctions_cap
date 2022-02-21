<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="DetailVote.aspx.vb" Inherits="elections_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <br />
    <asp:button id="btnCancel" CssClass="btn btn-default" runat="server" text="Retour" OnClientClick="JavaScript:window.history.back(1); return false;" /> 
    
    <%--<asp:ImageButton ID="btnCancel" runat="server" Height="35px" ImageUrl="~/elections_cap_cd/images/retour.png" Width="40px" OnClientClick="JavaScript:window.history.back(1); return false;" />--%>


    <br />
    <br />
    <%--<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>--%>
    <div class="col-md-8 col-md-offset-1">

        <div class="row">
            <div class="col-md-4">
                <asp:DetailsView ID="Dtv_CandidatChoisi" runat="server" AutoGenerateRows="False" DataKeyNames="CODE_SYNDICAT" CssClass="table table-bordered table-striped">
                    <Fields>
                        <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="MON CHOIX" SortExpression="CODE_SYNDICAT">
                        <ControlStyle BackColor="#FF6666" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#CC0000" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                    </Fields>
                </asp:DetailsView>
            </div>
            <div class="col-md-8">
                <asp:GridView ID="Gv_lstCandidats" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_CANDIDAT_LISTE" CssClass="table table-bordered table-striped">
                    <Columns>
                        <asp:BoundField DataField="ID_CANDIDAT_LISTE" HeaderText="ID_CANDIDAT_LISTE" Visible="false" ReadOnly="True" SortExpression="ID_CANDIDAT_LISTE" />
                        <asp:BoundField DataField="ID_ELECTEUR" HeaderText="ID_ELECTEUR" SortExpression="ID_ELECTEUR" Visible="false" />
                        <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" SortExpression="ID_CANDIDAT" Visible="false" />
                        <asp:BoundField DataField="PRENOM_ELECTEUR" HeaderText="PRENOM" SortExpression="PRENOM_ELECTEUR" >
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOM_ELECTEUR" HeaderText="NOM" SortExpression="NOM_ELECTEUR" >
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TYPE_CANDIDAT" HeaderText="TYPE" SortExpression="TYPE_CANDIDAT" >
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RANG" HeaderText="RANG" SortExpression="RANG" />
                        <asp:BoundField DataField="LIBELLE_CORPS" HeaderText="CORPS" SortExpression="LIBELLE_CORPS" >
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    
    <%--<asp:Button ID="BtnConfirmVote" runat="server" Text="Valider mon choix" CssClass="btn-xs btn-primary"/>--%>
    
        <div class="col-md-12 col-md-offset-6">
    <asp:ImageButton ID="BtnConfirmVote" runat="server" ImageUrl="~/elections_cap_cd/images/urne-vote.gif" Width="20%" />
            <asp:Panel ID="PanelConfirmVote" runat="server">
                <table>
                    <tr>
                        <td>Valider le vote avec le bouton [<strong>OK</strong>]. Sinon cliquer sur [<strong>Annuler</strong>] </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="bt_poursuivreVote" CssClass="btn-xs btn-success btn-xs" runat="server" Text="OK" />
                            <asp:Button ID="bt_annulerVote" CssClass="btn-xs btn-danger btn-xs" runat="server" Text="Annuler" />
                        </td>
                    </tr>
                </table>

            </asp:Panel>
        </div>
</div>

</asp:Content>

