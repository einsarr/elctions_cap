<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Colleges.aspx.vb" Inherits="elections_Colleges" %>

<asp:Content ID="Contenu" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Collèges</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />
     <div class="col-md-12">
        <div class="table-responsive col-md-4">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_COLLEGE" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectText="S" />
                    <asp:BoundField DataField="ID_COLLEGE" HeaderText="N°" InsertVisible="False" ReadOnly="True" SortExpression="ID_COLLEGE" />
                    <asp:BoundField DataField="LIBELLE_COLLEGE" HeaderText="LIBELLE DU COLLEGE" SortExpression="LIBELLE_COLLEGE" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_COLLEGE]"></asp:SqlDataSource>


     
    <div class="modal fade" id="formulaire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle2">Nouveau collège</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>CORPS </label>
                    <asp:DropDownList ID="DLL_CORPS" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="PCEMG">PCEMG</asp:ListItem>
                    <asp:ListItem Value="I">I</asp:ListItem>
                    <asp:ListItem Value="IA">IA</asp:ListItem>
                    </asp:DropDownList>
                </div>

                 <div class="form-group">
                    <label>GRADE </label>
                    <asp:DropDownList ID="DLL_GRADE" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="3/2">3/2</asp:ListItem>
                    <asp:ListItem Value="4/2">4/2</asp:ListItem>
                    <asp:ListItem Value="1/3">1/3</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="modal-footer">
            <asp:Button ID="btn_add_college" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>

</asp:Content>

