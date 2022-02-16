<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Inscription.aspx.vb" Inherits="elections_cap_cd_Account_Inscri_ption" %>

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
                            <div class="panel-heading">Inscription</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label>Matricule  (ex. 654263/F ou 130701061/O)</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ControlToValidate="TXT_Matricule" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="TXT_Matricule" placeholder="Matricule" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Nom</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ControlToValidate="TXT_Nom" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="TXT_Nom" placeholder="Nom" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Prénom</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="text-danger" runat="server" ControlToValidate="TXT_Prenom" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="TXT_Prenom" placeholder="Prénom" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                
                                <div class="form-group">
                                    <label>Numéro CNI</label>
                                    <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="Mettez ici votre numéro de Carte Nationale d'Indentité."></i>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" CssClass="text-danger" runat="server" ControlToValidate="TXT_CNI" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularTel3" runat="server" ControlToValidate="TXT_CNI" CssClass="text-danger" ErrorMessage="Format numéro CNI non valide" ValidationExpression="(^(1)|(2))[a-zA-Z0-9]{1}[0-9]{11,13}$"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="TXT_CNI" placeholder="Numéro de Carte Nationale d'Indentité" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="Mettez ici votre adresse email si vous en avez pas il faut en créer."></i>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TXT_email" ErrorMessage="*" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularMail1" runat="server" ControlToValidate="TXT_email" CssClass="text-danger" ErrorMessage="Adresse email non valide" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="TXT_email" placeholder="Email principal" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                
                                <div class="form-group">
                                    <label>Téléphone</label>
                                    <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="Mettez ici votre numéro de téléphone."></i>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TXT_Portable" ErrorMessage="*" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularTel" runat="server" ControlToValidate="TXT_Portable" CssClass="text-danger" ErrorMessage="Téléphone non valide" ValidationExpression="(^(70)|(76)|(77)|(78))[0-9]{7}$"></asp:RegularExpressionValidator>
                                    <asp:TextBox ID="TXT_Portable" placeholder="Téléphone portable principal" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="DDL_DEPARTEMENT">Département</asp:Label>
                                    <asp:DROPDOWNLIST runat="server" ID="DDL_DEPARTEMENT" DataSourceID="SqlDpt" CssClass="form-control" DataTextField="LIBELLE_DEPARTEMENT" DataValueField="ID_DEPARTEMENT"></asp:DROPDOWNLIST>
                                    <asp:SqlDataSource ID="SqlDpt" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS ID_DEPARTEMENT, '--------' AS LIBELLE_DEPARTEMENT UNION SELECT ID_DEPARTEMENT, LIBELLE_DEPARTEMENT FROM ELECTION_CAP_DEPARTEMENT ORDER BY LIBELLE_DEPARTEMENT"></asp:SqlDataSource>
                                </div>

                                <div class="form-group col-md-12 wow fadeInLeft text-left">
                                    <asp:PlaceHolder ID="phTest" runat="server" Visible="true">
                                        <img src="captcha.ashx" id="imgCaptcha" />&nbsp;<a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');">Nouvelle Image</a><br />
                                        Saisir les caractéres qui apparaissent dans l'image ci-dessus. Si vous ne pouvez pas lire, soumettez une nouvelle image.<br />
                                        <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="Répetez ici le texte de l'image vous pouvez le changer s'il n'est pas lisible."></i>
                                        <asp:TextBox ID="txtCaptcha" CssClass="form-control" placeholder="Répéter l'image ici" runat="server"></asp:TextBox><br />
                                    </asp:PlaceHolder>
                                    <asp:PlaceHolder ID="phResult" runat="server" Visible="false">
                                        <asp:Label ID="lblResult" runat="server" CssClass="text-danger"></asp:Label>
                                        <asp:Button ID="btnRetry" runat="server" Text="Ré-Essayer" />
                                    </asp:PlaceHolder>
                                </div>

                                

                                <div class="form-group text-left">
                                    <asp:Button ID="btnSubmit" class="btn btn-sm btn-primary" runat="server" Text="S'inscrire" />
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

