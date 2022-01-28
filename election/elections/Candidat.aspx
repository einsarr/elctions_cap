<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Candidat.aspx.vb" Inherits="elections_Candidat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h1>SYNDICAT</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />
     <div class="col-md-12">
        <div class="table-responsive">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Expr1" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="Expr1" HeaderText="Expr1" InsertVisible="False" ReadOnly="True" SortExpression="Expr1" />
                    <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="CODE_SYNDICAT" SortExpression="CODE_SYNDICAT" />
                    <asp:BoundField DataField="LIBELLE_CORPS_GROUPES" HeaderText="LIBELLE_CORPS_GROUPES" SortExpression="LIBELLE_CORPS_GROUPES" />
                    <asp:TemplateField HeaderText="LOGO">
                        <ItemTemplate>
                            <asp:Image ID="PHOTO_CANDIDAT" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_CANDIDAT", "~/elections/images/{0}") %>' AlternateText="Le ticket a été modifié" Visible="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ELECTION_CAP_CANDIDAT.ID_CANDIDAT AS Expr1, ELECTION_CAP_SYNDICAT.CODE_SYNDICAT, CORPS_GROUPES.LIBELLE_CORPS_GROUPES, ELECTION_CAP_CANDIDAT.PHOTO_CANDIDAT FROM ELECTION_CAP_CANDIDAT INNER JOIN ELECTION_CAP_SYNDICAT ON ELECTION_CAP_CANDIDAT.ID_SYNDICAT = ELECTION_CAP_SYNDICAT.ID_SYNDICAT INNER JOIN CORPS_GROUPES ON ELECTION_CAP_CANDIDAT.ID_CORPS_GROUPES = CORPS_GROUPES.ID_CORPS_GROUPES"></asp:SqlDataSource>

    <div class="modal fade" id="formulaire" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
        <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle2">Nouveau syndicat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
               
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="DLL_SYNDICAT">SYNDICAT</asp:Label>
                    <asp:DROPDOWNLIST runat="server" ID="DLL_SYNDICAT" DataSourceID="SQL_DLL_SYNDICAT" CssClass="form-control" DataTextField="CODE_SYNDICAT" DataValueField="ID_SYNDICAT"></asp:DROPDOWNLIST>
                    <asp:SqlDataSource ID="SQL_DLL_SYNDICAT" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS ID_SYNDICAT, '--------' AS CODE_SYNDICAT UNION SELECT ID_SYNDICAT, CODE_SYNDICAT FROM ELECTION_CAP_SYNDICAT ORDER BY CODE_SYNDICAT"></asp:SqlDataSource>
                 </div>

                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="DLL_CORPS_GROUPES">CORPS GROUPES</asp:Label>
                    <asp:DROPDOWNLIST runat="server" ID="DLL_CORPS_GROUPES" DataSourceID="SqlDLL_CORPS_GROUPES" CssClass="form-control" DataTextField="LIBELLE_CORPS_GROUPES" DataValueField="ID_CORPS_GROUPES"></asp:DROPDOWNLIST>
                    <asp:SqlDataSource ID="SqlDLL_CORPS_GROUPES" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS ID_CORPS_GROUPES, '--------' AS LIBELLE_CORPS_GROUPES UNION SELECT ID_CORPS_GROUPES, LIBELLE_CORPS_GROUPES FROM CORPS_GROUPES ORDER BY LIBELLE_CORPS_GROUPES"></asp:SqlDataSource>
                 </div>

                <div class="form-group">
                    <label for="IMG_PHOTO_CANDIDAT">Photo du candidat</label>
                    <asp:FileUpload ID="IMG_PHOTO_CANDIDAT" runat="server"  AllowMultiple="false" class="form-control" />
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btn_add_candidat" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>

</asp:Content>






