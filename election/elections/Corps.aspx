<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Corps.aspx.vb" Inherits="elections_Colleges" %>

<asp:Content ID="Contenu" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Corps</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />
     <div class="col-md-12">
        <div class="table-responsive col-md-6">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_CORPS" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="ID_CORPS" HeaderText="ID_CORPS" InsertVisible="False" ReadOnly="True" SortExpression="ID_CORPS" />
                    <asp:BoundField DataField="LIBELLE_CORPS" HeaderText="LIBELLE_CORPS" SortExpression="LIBELLE_CORPS" />
                    <asp:BoundField DataField="HIERARCHIE" HeaderText="HIERARCHIE" SortExpression="HIERARCHIE" />
                    <asp:BoundField DataField="ID_CORPS_GROUPE" HeaderText="ID_CORPS_GROUPE" SortExpression="ID_CORPS_GROUPE" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_CORPS]"></asp:SqlDataSource>


     
    <div class="modal fade" id="formulaire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle2">Nouveau collège</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="TXT_LIBELLE_CORPS">Libellé corps</label>
                    <asp:TextBox ID="TXT_LIBELLE_CORPS" runat="server" placeholder="LIBELLE" class="form-control"></asp:TextBox>
                 </div>
                <div class="form-group">
                    <label>HIERARCHIE </label>
                    <asp:DropDownList ID="DLL_HIERARCHIE" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="A spécial">A spécial</asp:ListItem>
                    <asp:ListItem Value="A1">A1</asp:ListItem>
                    <asp:ListItem Value="A2">A2</asp:ListItem>
                    <asp:ListItem Value="A3">A3</asp:ListItem>
                    <asp:ListItem Value="B1">B1</asp:ListItem>
                    <asp:ListItem Value="B2">B2</asp:ListItem>
                    <asp:ListItem Value="B3">B3</asp:ListItem>
                    <asp:ListItem Value="B4">B4</asp:ListItem>
                    <asp:ListItem Value="C1">C1</asp:ListItem>
                    <asp:ListItem Value="C2">C2</asp:ListItem>
                    <asp:ListItem Value="C3">C3</asp:ListItem>
                    </asp:DropDownList>
                </div>

                 <div class="form-group">
                    <label>CORPS GROUPES </label>
                    <asp:DropDownList ID="DLL_CORPS_GROUPES" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="1">Administrateurs civils</asp:ListItem>
                    <asp:ListItem Value="2">Inspecteurs des Impôts</asp:ListItem>
                    <asp:ListItem Value="3">Contrôleurs des Impôts et des Domaines</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="modal-footer">
            <asp:Button ID="btn_add_corps" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>

</asp:Content>

