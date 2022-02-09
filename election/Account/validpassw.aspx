<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="validpassw.aspx.vb" Inherits="Account_validpassw" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" runat="Server">
    <section id="desc2" class="pic-text pic-text-right">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div data-wow-offset="15" data-wow-duration="1.2s" class="col-md-3 wow fadeInLeft animated">
                        <h4>Modifier mot de passe</h4>
                        <div class="mockup-mobile">

                            <img src="<%= Page.ResolveUrl("~/Images/mirador/validpass.jpg")%>" data-no-retina />
                        </div>
                    </div>
                </div>
                <div class="col-md-6 text-left">
                    <asp:Label ID="LabelMatricule" runat="server"></asp:Label>
                    <label class="text-left text-warning">Le mot de passe doit avoir minimum 6 caractéres, 1 chiffre et 1 caractère spécial !_?*-@#</label>
                    <asp:Label ID="LabelMsg" runat="server" CssClass="text-danger"></asp:Label>

                    <div class="panel panel-default">
                        <div class="panel-heading">Changement de mot de passe</div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label>Ancien mot de passe</label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TXT_PasswordInit" ErrorMessage="*" CssClass="text-danger"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="TXT_PasswordInit" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Nouveau mot de passe</label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TXT_PasswordNew" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TXT_PasswordNew" CssClass="auto-style21" ErrorMessage="Le mot de passe invalide" ValidationExpression="^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!_?*-@#]).{6,}$"></asp:RegularExpressionValidator>
                                <asp:TextBox ID="TXT_PasswordNew" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label>Retaper nouveau mot de passe</label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TXT_PasswordNew2" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="TXT_PasswordNew2" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Button ID="BtValid" CssClass="btn btn-success" runat="server" Text="Valider" />
                                <asp:Button ID="BtAnnuler" CssClass="btn btn-danger" runat="server" CausesValidation="False" PostBackUrl="~/voeux/listemvmt.aspx" Text="Annuler" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</asp:Content>

