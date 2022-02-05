<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Voter.aspx.vb" Inherits="elections_Voter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    <br />
    <br />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1" GroupItemCount="3">
        <AlternatingItemTemplate>
            <td runat="server" style="">ID_CANDIDAT:
                <asp:Label ID="ID_CANDIDATLabel" runat="server" Text='<%# Eval("ID_CANDIDAT") %>' />
                <br />LIBELLE_SYNDICAT:
                <asp:Label ID="LIBELLE_SYNDICATLabel" runat="server" Text='<%# Eval("LIBELLE_SYNDICAT") %>' />
                <br />PRENOM_NOM_SG:
                <asp:Label ID="PRENOM_NOM_SGLabel" runat="server" Text='<%# Eval("PRENOM_NOM_SG") %>' />
                <br />PHOTO_SG:
                <asp:Image ID="PHOTO_SGLabel" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_SG", "~/elections/images/{0}") %>' AlternateText="404" Visible="true" />
                <br />
                <asp:Button ID="Button1" CommandArgument='<%# Eval("ID_CANDIDAT")%>' OnClick="Consulter" runat="server" Text="Button" />
                <br />
                <asp:Button ID="Button2" runat="server" Text="confirm" />
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
            <td runat="server" style="">ID_CANDIDAT:
                <asp:Label ID="ID_CANDIDATLabel" runat="server" Text='<%# Eval("ID_CANDIDAT") %>' />
                <br />LIBELLE_SYNDICAT:
                <asp:Label ID="LIBELLE_SYNDICATLabel" runat="server" Text='<%# Eval("LIBELLE_SYNDICAT") %>' />
                <br />PRENOM_NOM_SG:
                <asp:Label ID="PRENOM_NOM_SGLabel" runat="server" Text='<%# Eval("PRENOM_NOM_SG") %>' />
                <br />PHOTO_SG:
                <asp:Image ID="PHOTO_SGLabel" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_SG", "~/elections/images/{0}") %>' AlternateText="404" Visible="true" />
                <br />
                <asp:Button ID="Button1" CommandArgument='<%# Eval("ID_CANDIDAT")%>' OnClick="Consulter" runat="server" Text="Button" />
                <br />
                <asp:Button ID="Button2" runat="server" Text="confirm" />
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="groupPlaceholderContainer" runat="server" border="0" style="">
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

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ELECTION_CAP_CANDIDAT.ID_CANDIDAT, ELECTION_CAP_SYNDICAT.LIBELLE_SYNDICAT, ELECTION_CAP_SYNDICAT.PRENOM_NOM_SG, ELECTION_CAP_SYNDICAT.PHOTO_SG FROM ELECTION_CAP_CANDIDAT INNER JOIN ELECTION_CAP_SYNDICAT ON ELECTION_CAP_CANDIDAT.ID_SYNDICAT = ELECTION_CAP_SYNDICAT.ID_SYNDICAT"></asp:SqlDataSource>

</asp:Content>

