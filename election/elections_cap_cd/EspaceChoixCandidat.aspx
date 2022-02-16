<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="EspaceChoixCandidat.aspx.vb" Inherits="elections_EspaceChoixCandidat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <br /><br />
    <p>LISTE DES CANDIDATS</p>
        <asp:Button ID="btnConfirm" runat="server" OnClick="OnConfirm" Text="Raise Confirm" OnClientClick="Confirm()"/>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:CommandField ButtonType="Button" SelectText="Voter" ShowSelectButton="True">
            <ControlStyle BackColor="#33CCFF" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="PHOTO_CANDIDAT">
                <ItemTemplate>
                    <asp:Image ID="PHOTO_CANDIDAT" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_CANDIDAT", "~/elections/images/{0}") %>' AlternateText="Le ticket a été modifié" Visible="true" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT" />
            <asp:BoundField DataField="ID_ENSEIGNANT" HeaderText="ID_ENSEIGNANT" SortExpression="ID_ENSEIGNANT" />
            <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" SortExpression="ID_SYNDICAT" />
            <asp:BoundField DataField="ID_COLLEGE" HeaderText="ID_COLLEGE" SortExpression="ID_COLLEGE" />
            <%--<asp:BoundField DataField="PHOTO_CANDIDAT" HeaderText="PHOTO_CANDIDAT" SortExpression="PHOTO_CANDIDAT" />--%>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_CANDIDAT]"></asp:SqlDataSource>
    </asp:Content>

