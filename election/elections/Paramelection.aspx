<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Paramelection.aspx.vb" Inherits="elections_Paramelection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" Height="16px" DataSourceID="SqlDataSource2" DataTextField="LIBELLE_ANNEE" DataValueField="CODE_ANNEE"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ANNEE]"></asp:SqlDataSource>
            <br />
            <asp:TextBox id="TextBox0" Text="Hello TextBox0!" runat="server" /><br />
            
             <asp:TextBox id="TextBox1" runat="server"  /><br />

             <asp:TextBox id="TextBox2" runat="server" /><br />

            <asp:RadioButton ID="RadioButton1" runat="server" Text="ASP.NET" /><br />

            <p>

            <asp:Button ID="Button1" type="button" runat="server" Text="Enrégistrer" />
            <br />
        </div>
        




        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="annee" HeaderText="annee" SortExpression="annee" />
                <asp:BoundField DataField="libelle_election" HeaderText="libelle_election" SortExpression="libelle_election" />
                <asp:BoundField DataField="date_debut" HeaderText="date_debut" SortExpression="date_debut" />
                <asp:BoundField DataField="date_fin" HeaderText="date_fin" SortExpression="date_fin" />
                <asp:BoundField DataField="etat" HeaderText="etat" SortExpression="etat" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [paramelection]"></asp:SqlDataSource>
        
    </form>
</body>
</html>
