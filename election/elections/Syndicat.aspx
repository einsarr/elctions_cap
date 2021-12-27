<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Syndicat.aspx.vb" Inherits="elections_Syndicat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <h1>SYNDICAT</h1>
    <p>
        <asp:Button ID="btnShowModal" data-backdrop="static" data-keyboard="false" runat="server" Text="Nouveau" CssClass="btn btn-primary" data-target="#formulaire"
        data-toggle="modal" OnClientClick="javascript:return false;"/>
    </p>
    
        <br />
     <div class="col-md-12">
        <div class="table-responsive">
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_SYNDICAT" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField SelectText="S" ShowSelectButton="True" />
                    <asp:BoundField DataField="ID_SYNDICAT" HeaderText="N°" InsertVisible="False" ReadOnly="True" SortExpression="ID_SYNDICAT" />
                    <asp:BoundField DataField="CODE_SYNDICAT" HeaderText="CODE SYNDICAT" SortExpression="CODE_SYNDICAT" />
                    <asp:BoundField DataField="LIBELLE_SYNDICAT" HeaderText="LIBELLE SYNDICAT" SortExpression="LIBELLE_SYNDICAT" />
                    <asp:TemplateField HeaderText="LOGO">
                        <ItemTemplate>
                            <asp:Image ID="LOGO" Width="25%" runat="server" ImageUrl='<%# Eval("LOGO", "~/elections/images/{0}") %>' AlternateText="Le ticket a été modifié" Visible="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PHOTO SG">
                        <ItemTemplate>
                            <asp:Image ID="PHOTO" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_SG", "~/elections/images/{0}") %>' AlternateText="Le ticket a été modifié" Visible="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_SYNDICAT]"></asp:SqlDataSource>

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
                    <label for="TXT_CODE_SYNDICAT">Code syndicat</label>
                    <asp:TextBox ID="TXT_CODE_SYNDICAT" runat="server" placeholder="Code syndicat" class="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="TXT_LIBELLE_SYNDICAT">Libellé du syndicat</label>
                    <asp:TextBox ID="TXT_LIBELLE_SYNDICAT" runat="server" placeholder="LIBELLE" class="form-control"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="IMG_LOGO_SYNDICAT">Logo du syndicat</label>
                    <asp:FileUpload ID="IMG_LOGO_SYNDICAT" runat="server"  AllowMultiple="false" class="form-control" />
                </div>
                <div class="form-group">
                    <label for="IMG_PHOTO_SG_SYNDICAT">Photo SG du syndicat</label>
                    <asp:FileUpload ID="IMG_PHOTO_SG_SYNDICAT" runat="server"  AllowMultiple="false" class="form-control" />
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btn_add_syndicat" runat="server" CssClass="btn btn-primary" Text="Enregistrer" Width="146px" TabIndex="1" Enabled="true"/><br />
            </div>
        </div>
        </div>
    </div>
</asp:Content>

