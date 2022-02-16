<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Grade.aspx.vb" Inherits="elections_Colleges" %>

<asp:Content ID="Contenu" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Grade</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />
     <div class="col-md-12">
        <div class="table-responsive col-md-6">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_GRADE" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="ID_GRADE" HeaderText="ID_GRADE" InsertVisible="False" ReadOnly="True" SortExpression="ID_GRADE" />
                    <asp:BoundField DataField="CLASSE" HeaderText="CLASSE" SortExpression="CLASSE" />
                    <asp:BoundField DataField="ECHELON" HeaderText="ECHELON" SortExpression="ECHELON" />
                    <asp:BoundField DataField="LIBELLE_GRADE" HeaderText="LIBELLE_GRADE" SortExpression="LIBELLE_GRADE" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_GRADE]"></asp:SqlDataSource>


     
    <div class="modal fade" id="formulaire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLongTitle2">Nouveau grade</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="TXT_LIBELLE_CLASSE">Classe</label>
                    <asp:TextBox ID="TXT_LIBELLE_CLASSE" runat="server" placeholder="CLASSE" class="form-control"></asp:TextBox>
                 </div>

                <div class="form-group">
                    <label for="TXT_LIBELLE_ECHELON">Echelon</label>
                    <asp:TextBox ID="TXT_LIBELLE_ECHELON" runat="server" placeholder="ECHELON" class="form-control"></asp:TextBox>
                 </div>

                <div class="form-group">
                    <label for="TXT_LIBELLE_GRADE">Libellé grade</label>
                    <asp:TextBox ID="TXT_LIBELLE_GRADE" runat="server" placeholder="LIBELLE GRADE" class="form-control"></asp:TextBox>
                 </div>


            </div>
            <div class="modal-footer">
            <asp:Button ID="btn_add_grade" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>

</asp:Content>

