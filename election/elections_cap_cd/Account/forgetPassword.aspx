<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="forgetPassword.aspx.vb" Inherits="elections_cap_cd_Account_forgetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script type="text/javascript" language="javascript">
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
                        <img src="<%= Page.ResolveUrl("~/elections_cap_cd/images_app/urne_nationale.png")%>" data-no-retina />
                    </div>
                </div>
                <div class="row" style="text-align: left">
                    <div class="col-lg-offset-3 col-sm-5">
                        <!-- START panel-->
                        <div class="panel panel-default">
                            <div class="panel-heading">Mot de passe oublié</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label>Matricule </label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TXT_Matricule" ErrorMessage="*" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <asp:TextBox placeholder="Matricule" ID="TXT_Matricule" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Email </label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TXT_email1" ErrorMessage="*" CssClass="text-danger"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularMail1" runat="server" ControlToValidate="TXT_email1" CssClass="text-danger" ErrorMessage="Adresse email non valide" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <asp:TextBox placeholder="Email" ID="TXT_email1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="form-group wow fadeInLeft text-left">
                                    <asp:PlaceHolder ID="phTest" runat="server" Visible="true">
                                        <img src="captcha.ashx" id="imgCaptcha" />&nbsp;<a href="javascript:void(0);" onclick="RefreshImage('imgCaptcha');">Nouvelle Image</a><br />
                                        Saisir les caractéres qui apparaissent dans l'image ci-dessus. Si vous ne pouvez pas lire, soumettez une nouvelle image.<br />
                                        <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="bottom" title="Répetez ici le texte de l'image vous pouvez le changer s'il n'est pas lisible."></i>
                                        <asp:TextBox ID="txtCaptcha" CssClass="form-control" placeholder="Repetez le texte ici" runat="server"></asp:TextBox><br />
                                    </asp:PlaceHolder>
                                </div>
                                <div class="form-group">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Nouveau mot de passe par mail" CssClass="btn btn-sm btn-primary" />
                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" PostBackUrl="~/elections_cap_cd/Default.aspx" Text="Annuler" CssClass="btn btn-sm btn-danger" />
                                </div>
                                <div class="form-group">
                                    <asp:PlaceHolder ID="phResult" runat="server" Visible="false">
                                        <p>
                                            <asp:Label ID="lblResult" runat="server" Font-Bold="true"></asp:Label>
                                        </p>
                                        <asp:Button ID="btnRetry" runat="server" Text="Ré-Essayer" />
                                    </asp:PlaceHolder>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

