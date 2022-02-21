<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ParamScrutin.aspx.vb" Inherits="elections_ParamScrutin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h1>Paramétrage du scrutin</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />
     <div class="col-md-12">
        <div class="table-responsive">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_PARAM_ELECTION" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField SelectText="S" ShowSelectButton="True" />
                    <asp:BoundField DataField="ID_PARAM_ELECTION" HeaderText="N°" InsertVisible="False" ReadOnly="True" SortExpression="ID_PARAM_ELECTION" />
                    <asp:BoundField DataField="CODE_ANNEE" HeaderText="ANNEE" SortExpression="CODE_ANNEE"></asp:BoundField>
                    <asp:BoundField DataField="LIBELLE_ELECTION" HeaderText="LIBELLE ELECTION" SortExpression="LIBELLE_ELECTION" />
                    <asp:BoundField DataField="DATE_OUVERTURE_SCRUTIN" HeaderText="DATE DE DEBUT" SortExpression="DATE_OUVERTURE_SCRUTIN" />
                    <asp:BoundField DataField="DATE_FERMETURE_SCRUTIN" HeaderText="DATE DE FIN" SortExpression="DATE_FERMETURE_SCRUTIN" />
                    <asp:BoundField DataField="ANNEE_ENCOURS" HeaderText="ETAT" SortExpression="ANNEE_ENCOURS" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_PARAM_ELECTION]"></asp:SqlDataSource>

    <div class="modal fade" id="formulaire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle2">Nouveau strutin</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="TXT_LIBELLE_SCRUTIN">Libellé</label>
                    <asp:TextBox ID="TXT_LIBELLE_SCRUTIN" runat="server" placeholder="LIBELLE" class="form-control"></asp:TextBox>
                 </div>
                <div class="form-group">
                    <label for="TXT_DATE_DEBUT">DATE DE DEBUT</label>
                    <asp:TextBox ID="TXT_DATE_DEBUT" runat="server" TextMode="DateTimeLocal" class="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="TXT_DATE_FIN">DATE DE FIN</label>
                     <asp:TextBox ID="TXT_DATE_FIN" runat="server" TextMode="DateTimeLocal" class="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label>ANNEE </label>
                    <asp:DropDownList ID="DLL_ANNEE" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="2021">2021</asp:ListItem>
                    <asp:ListItem Value="2022">2022</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btn_add_scrutin" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>
</asp:Content>

