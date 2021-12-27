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
            <asp:GridView ID="GridView1" CssClass="table table-bordered table-striped" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_CANDIDAT" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField SelectText="S" ShowSelectButton="True" />
                    <asp:BoundField DataField="ID_CANDIDAT" HeaderText="ID_CANDIDAT" InsertVisible="False" ReadOnly="True" SortExpression="ID_CANDIDAT" />
                    <asp:BoundField DataField="ID_ENSEIGNANT" HeaderText="ID_ENSEIGNANT" SortExpression="ID_ENSEIGNANT" />
                    <asp:BoundField DataField="ID_SYNDICAT" HeaderText="ID_SYNDICAT" SortExpression="ID_SYNDICAT" />
                    <asp:BoundField DataField="ID_COLLEGE" HeaderText="ID_COLLEGE" SortExpression="ID_COLLEGE" />
                    <asp:TemplateField HeaderText="LOGO">
                        <ItemTemplate>
                            <asp:Image ID="PHOTO_CANDIDAT" Width="25%" runat="server" ImageUrl='<%# Eval("PHOTO_CANDIDAT", "~/elections/images/{0}") %>' AlternateText="Le ticket a été modifié" Visible="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

     
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT * FROM [ELECTION_CAP_CANDIDAT]"></asp:SqlDataSource>

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
                    <label>AGENT </label>
                    <asp:DropDownList ID="DLL_ENSEIGNANT" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="1">Moussa SARR</asp:ListItem>
                    <asp:ListItem Value="2">Fatoumata LY</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>SYNDICAT </label>
                    <asp:DropDownList ID="DLL_SYNDICAT" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="1">CUSEMS</asp:ListItem>
                    <asp:ListItem Value="2">SELS</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label>COLLEGE </label>
                    <asp:DropDownList ID="DLL_COLLGEE" runat="server" CssClass="form-control">
                    <asp:ListItem Value="">---</asp:ListItem>
                    <asp:ListItem Value="2">PCEMG3/2</asp:ListItem>
                    <asp:ListItem Value="3">I2/4</asp:ListItem>
                    </asp:DropDownList>
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






