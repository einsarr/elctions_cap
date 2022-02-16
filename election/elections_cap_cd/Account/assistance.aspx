<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="assistance.aspx.vb" Inherits="elections_cap_cd_Account_assistance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script type="text/javascript">
        function RefreshImage(valImageId) {
            var objImage = document.getElementById(valImageId)
            if (objImage == undefined) {
                return;
            }
            var now = new Date();
            objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
        }
    </script>
    
    <section id="desc2" class="pic-text pic-text-right">
        
        <div class="container">
            
            <div class="row">
                
                <!-- LEFT PIC-->
                <div data-wow-offset="15" data-wow-duration="1.2s" class="col-md-3 wow fadeInLeft animated">
                    <div class="mockup-mobile">
                        <%--						<img src="<%= Page.ResolveUrl("~/Content/img/ipad-air.png")%>" data-no-retina>--%>
                        <img src="<%= Page.ResolveUrl("~/elections_cap_cd/images_app/urne_nationale.png")%>" data-no-retina />
                    </div>
                </div>

                <div class="row" style="text-align: left">
                    <div class="col-lg-offset-3 col-sm-5">
                        <!-- START panel-->
                        <div class="panel panel-default">
                            <div class="panel-heading">Assistance</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label>Matricule (ex. 654263/F ou 130701061/O)</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ControlToValidate="TXT_Matricule" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="TXT_Matricule" placeholder="Matricule" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                 
                                <div class="form-group">
                                    <label>Problème</label>
                                    <asp:DropDownList CssClass="form-control" ID="DDLIST_PROBLEME" runat="server">
                                            <asp:ListItem Value="">Type</asp:ListItem>
                                            <asp:ListItem Value="inscription">inscription</asp:ListItem>
                                            <asp:ListItem Value="email">Email</asp:ListItem>
                                            <asp:ListItem Value="Telephone">Téléphone</asp:ListItem>
                                           <asp:ListItem Value="mise à jour">Mise à jour</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="form-group">
                                    <label>Message</label>
                                    <asp:TextBox placeholder="Saisir votre message" ID="TXT_MESSAGE" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                </div>
                                
                                <div class="form-group text-left">
                                    <asp:Button ID="btnSubmit" class="btn btn-sm btn-primary" runat="server" Text="Envoyer" />
                                    <asp:Button ID="Button1" runat="server" class="btn btn-sm btn-danger" CausesValidation="False" PostBackUrl="~/elections_cap_cd/Default.aspx" Text="Annuler" />
                                </div>
                            </div>
                        </div>
                        <!-- END panel-->
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>

