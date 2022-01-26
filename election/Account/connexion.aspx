<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="connexion.aspx.vb" Inherits="_Connect" %>
<asp:Content ID="Content2" ContentPlaceHolderID="Contenu" runat="Server">
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
    <style>
        #Contenu_DropDownTotalInscrits {
            color: #fff;
            visibility: hidden;
        }
    </style>

    <section id="desc2" class="pic-text pic-text text-center">
        <div class="container">
            <div class="row">
                <!-- LEFT PIC-->
                <div data-wow-offset="15" data-wow-duration="1.2s" class="col-md-4 wow fadeInLeft animated">
                    <div class="mockup-mobile">
                        <%--<img src="<%= Page.ResolveUrl("~/Images/mirador/mirador.gif")%>" data-no-retina />--%>
                    </div>

                    <div class="text-center badge alert-warning">
                        <asp:DropDownList ID="DropDownTotalInscrits" runat="server" DataSourceID="SqlTotalInscrits" DataTextField="NbreTotal" DataValueField="NbreTotal" Height="0px" Width="0px">
                        </asp:DropDownList>
                        <asp:Label ID="Label1" runat="server" Text="Nombre d'inscrits au niveau national :"></asp:Label>
                        <asp:Label ID="LabelNbreInscrits" runat="server" CssClass="badge alert-success"></asp:Label>
                        <asp:SqlDataSource ID="SqlTotalInscrits" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT COUNT(ENSEIGNANT.IDENTIFIANT_ENSEIGNANT) AS NbreTotal FROM ENSEIGNANT INNER JOIN ENSEIGNANT_ETABLISSEMENT ON ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 WHERE (NOT (ENSEIGNANT.PASSWORD_ENSEIGNANT IS NULL))"></asp:SqlDataSource>
                    </div>

                    <br><br>
<div class="text-center" style="border: 1px solid #ff7e7e;padding: 14px;background: #ffdede;">
    <p style="font-weight: bold;color: red;">
      <marquee><i class="fa fa-info-circle"></i> Appel à candidatures</marquee><br /> Recrutement d'instituteurs sénégalais pour les écoles franco-sénégalaises de Dakar.
    </p>
    <a href="https://jobs.education.sn/" target="_blank"  class="btn btn-sm btn-danger" style="width:146px;">
      <i class="fa fa-search"></i> Voir l'offre
    </a>
</div>
                </div>

                <div class="row" style="text-align: left">
                    <div class="col-sm-5 col-lg-offset-2">
                        <!-- START panel-->
                        <div class="panel panel-default">
                            <div class="panel-heading">Connexion</div>
                            <div class="panel-body">
                                <%--<form role="form" runat="server" defaultbutton="BT_Login">--%>
                                <div class="form-group">
                                    <label>Matricule </label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ControlToValidate="TXT_Login" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="TXT_Login" runat="server" placeholder="Matricule" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Mot de passe </label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ControlToValidate="TXT_Password" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="TXT_Password" placeholder="mot de passe" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group text-left">
                                    <asp:Button ID="BT_Login" runat="server" CssClass="btn btn-sm btn-success" Text="Connexion" Width="146px" />
                                </div>
                                <div class="form-group text-left">
                                    <asp:HyperLink ID="HyperLink4" runat="server" ToolTip="" NavigateUrl="~/Account/Keycloack.aspx" class="text-warning" style="font-weight: bold">Me connecter avec mon compte <u><i>(IEN) education.sn</i></u></asp:HyperLink><br />
                                </div>
                                <div class="form-group text-left ">
                                      Si tu n'es pas encore inscrit, clique sur
                                        <asp:HyperLink ID="HyperLink1" runat="server" ToolTip="Ré-initialiser Mot de Passe" NavigateUrl="~/Account/inscription.aspx">S'incrire</asp:HyperLink><br />

                                    Si tu as oublié ton mot de passe, clique sur
                                        <asp:HyperLink ID="HyperLink3" runat="server" ToolTip="Ré-initialiser Mot de Passe" NavigateUrl="~/Account/forgetPassword.aspx">Ré-initialiser </asp:HyperLink><br />
                                    Si tu as besoin d'aide clique sur
                                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Account/Message2.aspx">Assistance</asp:HyperLink>

                                </div>
                                <%--</form>--%>
                            </div>
                        </div>
                        <!-- END panel-->
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>


