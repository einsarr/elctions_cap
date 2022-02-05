<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Detail.aspx.vb" Inherits="elections_Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1">
        <Fields>
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT" />
            <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" SortExpression="ID_SYNDICAT" />
            <asp:BoundField DataField="ID_CORPS_GROUPES" HeaderText="ID_CORPS_GROUPES" SortExpression="ID_CORPS_GROUPES" />
            <asp:BoundField DataField="ID_CLASSE" HeaderText="ID_CLASSE" SortExpression="ID_CLASSE" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_CANDIDAT] WHERE ([ID_CANDIDAT] = @ID_CANDIDAT)">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID_CANDIDAT" QueryStringField="ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT" />
            <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" SortExpression="ID_SYNDICAT" />
            <asp:BoundField DataField="ID_CORPS_GROUPES" HeaderText="ID_CORPS_GROUPES" SortExpression="ID_CORPS_GROUPES" />
            <asp:BoundField DataField="ID_CLASSE" HeaderText="ID_CLASSE" SortExpression="ID_CLASSE" />
        </Columns>
    </asp:GridView>






</asp:Content>

