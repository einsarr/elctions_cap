<%--<%@ Page Title="Dossier" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="listemvmt.aspx.vb" Inherits="candidature_listemvmt" %>--%>
<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="listemvmt.aspx.vb" Inherits="candidature_listemvmt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" runat="Server">
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script>
        $(document).ready(function () {
            //alert('Merci');
        //    $('table').replaceWith($('table').html()
        //        .replace(/<tbody/gi, "<div class='table'")
        //        .replace(/<tr/gi, "<div")
        //        .replace(/<\/tr>/gi, "</div>")
        //        .replace(/<td/gi, "<span")
        //        .replace(/<\/td>/gi, "</span>")
        //        .replace(/<\/tbody/gi, "<\/div")
        //     );
        //});
    </script>
    <section id="desc2" class="pic-text pic-text-right">
        <div class="container">
            
            <div class="row">
                <div class="col-sm-8">
                    <div data-wow-offset="15" data-wow-duration="1.2s" class="col-md-3 wow fadeInLeft animated">
                        <div class="mockup-mobile text-left">
                            <img src="<%= Page.ResolveUrl("~/Images/mirador/dossierv.jpg")%>" data-no-retina />
                            <asp:Label ID="LabelBonjour" runat="server"></asp:Label>
                           

                        </div>
                    </div>
                    <div class="col-md-9 text-left">
                        <asp:Label ID="Label2" runat="server"></asp:Label><br />
                        <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
                         <asp:Label ID="LabelMsg"  runat="server" CssClass="text-success"></asp:Label>
                         
                       
                        <asp:LinkButton ID="LinkBtnValider" runat="server" CausesValidation="True" Text="Clique ICI pour déclarer ton poste susceptible d'être vacant! " CssClass="text-success"></asp:LinkButton>
                        

                        <asp:DetailsView Visible="false" ID="DetailsViewDeclareMonPoste" BorderColor="White" BorderStyle="None" runat="server" AutoGenerateRows="False" DataSourceID="SqlDeclarePoste" DefaultMode="Edit">
                            <Fields>
                                <asp:TemplateField HeaderText="Pour déclarer ton poste susceptible d'être vaccant" ShowHeader="False" SortExpression="DECLARATION_PSV">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DECLARATION_PSV") %>' Visible="False"></asp:TextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("DECLARATION_PSV") %>' />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <EditItemTemplate>
                                        <asp:Label CssClass="text-danger" ID="LabelMessageAvertissement" runat="server" Text="Es-tu sûr de vouloir déclarer ton poste ?"></asp:Label>
                                        <asp:LinkButton ID="LinkButtonVALIDER" runat="server" CausesValidation="True" CommandName="Update" Text="OK" CssClass="btn btn-success"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="true" PostBackUrl="~/voeux/listemvmt.aspx" Text="Annuler" CssClass="btn btn-warning" OnClick="LinkButton2_Click1"></asp:LinkButton>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Modifier"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                        <asp:Label ID="LBLDeclaration" runat="server" ForeColor="#FF3300"></asp:Label><br />

                        <asp:SqlDataSource ID="SqlDeclarePoste" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT DECLARATION_PSV FROM ENSEIGNANT WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)" UpdateCommand="UPDATE ENSEIGNANT SET DECLARATION_PSV = 1 WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)">
                            <SelectParameters>
                                <asp:SessionParameter Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:SessionParameter Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <br />
                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageBtVoeux" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Images/mirador/candidaturecoche.jpg" PostBackUrl="~/voeux/voeux_o.aspx" ToolTip="Gérer mes demandes de postes" Width="155px" /><br />
                            <label class="text-center text-warning">Mes candidatures au mouvement</label>
                        </div>
                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageBtVoeux0" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Images/mirador/cv.jpg" SkinID="Mes " ToolTip="Gérer mon CV" Width="143px" /><br />
                            <label class="text-center text-warning">Mon CV</label>
                        </div>
                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageButton2" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Images/mirador/permutation.jpg" ToolTip="Marché des permutations" Width="157px" /><br />
                            <label class="text-center text-warning">Mes demandes de permutation</label>
                        </div>

                        

                         <%  
                             'UN ENSEIGNANT UN ORDINATEUR
                             'Si le matricule est bon on affiche le lien du programme

                             Dim pack As New Package
                             If pack.VerifMatriculeOk(Session("t_matricule")) Then
                         %>

                        <%--<div class="col-sm-4 text-center">
                            <asp:ImageButton PostBackUrl="~/peo/choixPackage.aspx" ID="ImageButton4" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Images/mirador/peoLogo.jpg" ToolTip="Un enseignant - Un ordinateur" Width="157px" /><br />
                            <label class="text-center text-warning">Un enseignant - Un ordinateur</label>
                        </div>

                         <div class="col-sm-4 text-center">
                            <asp:ImageButton PostBackUrl="~/latnok/Souscription.aspx" ID="ImageButton6" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/latnok/logo.jpg" ToolTip="Un enseignant un Coffret didactique" Width="157px" /><br />
                            <label class="text-center text-warning">Un enseignant un Coffret didactique</label>
                        </div>--%>
                        <% End If %>

                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageButton1" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Content/img/toit.png" ToolTip="Une famille un toit" Width="157px" PostBackUrl="~/toit/Ficheindivens.aspx" /><br />
                            <asp:Label CssClass="text-center text-warning" ID="untoit" runat="server" Text="Une famille un toit"></asp:Label>
                        </div>
                        

                         <%
                             Dim inscripFormOuvert As Boolean
                             Dim ensNominerFormation As Boolean
                             Dim fform As New FonctionsFormation
                             ensNominerFormation = fform.EnsDansListeNominative(Session("id_ens"))
                             inscripFormOuvert = fform.InscriptionFormationOuvert()
                             If ensNominerFormation = True And inscripFormOuvert = True Then
                        %>
                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageButton3" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Content/img/diplome.png" ToolTip="Une famille un toit" Width="157px" PostBackUrl="~/formation/modifDonnees.aspx" /><br />
                            <asp:Label CssClass="text-center text-warning" ID="Label4" runat="server" Text="Formation diplômante"></asp:Label>
                        </div>
                        <% End If %>

                        <%
                            Dim NbreActe As Integer
                            Dim db As New peo
                            Dim ens As ENSEIGNANT


                            Dim idEns As Integer

                            If String.IsNullOrEmpty(Session("id_ens")) Then
                                Response.Redirect("~/Account/connexion.aspx")
                            Else
                                idEns = Integer.Parse(Session("id_ens"))
                                ens = db.ENSEIGNANT.Find(idEns)


                            End If

                            NbreActe = getNbreActeEnseignant(idEns)
                            If NbreActe <> 0 Then
                        %>

                        
                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageButton5" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Images/mirador/dossier.jpg" ToolTip="Actes" Width="157px" PostBackUrl="~/actes/listeActe.aspx" /><br />
                            <label class="text-center text-warning">Mes Actes</label>
                        </div>
                        
                        
                        
                        
                        <%
                End If
                        %>

                        <%
                            'Seules les promouvables c-a-d les grades 1/2,3/2,2/2,2/4,P3,1/3 et 4/2 peuvent avoir accès au lien
                            Dim estPromouvable As Boolean
                            Dim fpromo As New Fonctioncapcd
                            estPromouvable = fpromo.Promouvable(Session("id_ens"))
                            If estPromouvable = True Then
                        %>
                        <div class="col-sm-4 text-center">
                            <asp:ImageButton ID="ImageButton4" runat="server" BorderStyle="Outset" Height="126px" ImageUrl="~/Images/mirador/avancement.jpg"  ToolTip="CAP" Width="143px" PostBackUrl="~/capcd/capcd.aspx"/><br /> <%--PostBackUrl="~/capcd/capcd.aspx"/><br />--%>
                            <label class="text-center text-warning">CAP <%=DateTime.UtcNow.Year%> et années antérieures</label>
                        </div>
                        <% End If %>
                    </div>
                </div>

                <%--   <div data-wow-offset="15" data-wow-duration="1.2s" class="col-md-3 wow fadeInLeft animated">
                    <div class="mockup-mobile">
                    </div>
                </div>--%>


                <div class="col-md-4 text-right">
                    <h4 style="line-height: 0px;">Données personnelles</h4>
                    <br />
                    <span class="text-danger">NB: Toute saisie de données fausses entrainera un rejet de ta candidature.</span>
                    <div class="table-responsive">
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="IDENTIFIANT_ENSEIGNANT" DataSourceID="SqlDonneesEns" CssClass="table" GridLines="None">
                            <EditRowStyle BackColor="#339966" ForeColor="Black" CssClass="form-group text-right" />
                            <EmptyDataRowStyle ForeColor="Black" />
                            <Fields>
                                <asp:CommandField ShowEditButton="True" ButtonType="Button">
                                    <ControlStyle CssClass="btn btn-success" />
                                </asp:CommandField>
                                <asp:BoundField DataField="IDENTIFIANT_ENSEIGNANT" HeaderText="IDENTIFIANT_ENSEIGNANT" InsertVisible="False" ReadOnly="True" SortExpression="IDENTIFIANT_ENSEIGNANT" Visible="False" />
                                <asp:BoundField DataField="MATRICULE_ENSEIGNANT" HeaderText="MATRICULE" SortExpression="MATRICULE_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="NOM_ETABLISSEMENT" HeaderText="ETABLISSEMENT" ReadOnly="True" SortExpression="NOM_ETABLISSEMENT" />
                                <asp:BoundField DataField="CNI" HeaderText="CNI" ReadOnly="True" SortExpression="CNI" />
                                <asp:BoundField DataField="NOM_ENSEIGNANT" HeaderText="NOM" SortExpression="NOM_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="PRENOMS_ENSEIGNANT" HeaderText="PRENOMS" SortExpression="PRENOMS_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="SEXE_ENSEIGNANT" HeaderText="SEXE" SortExpression="SEXE_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="SITUATION_MATRIMONIALE" HeaderText="SIT MATRIMONIALE" ReadOnly="True" SortExpression="SITUATION_MATRIMONIALE" />
                                <asp:BoundField DataField="NBRE_ENFANTS" HeaderText="NBR ENFANTS" ReadOnly="True" SortExpression="NBRE_ENFANTS" />
                                <asp:BoundField DataField="DATE_NAISS_ENSEIGNANT" DataFormatString="{0:d}" HeaderText="Né(e) le" SortExpression="DATE_NAISS_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="LIEU_NAISSANCE_ENSEIGNANT" HeaderText="à" SortExpression="LIEU_NAISSANCE_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="MAIL_ENSEIGNANT" HeaderText="MAIL 1" SortExpression="MAIL_ENSEIGNANT" ReadOnly="True" >
                                <ItemStyle ForeColor="Black" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MOBILE_ENSEIGNANT" HeaderText="MOBILE 1" SortExpression="MOBILE_ENSEIGNANT" ReadOnly="True" />
                                <asp:BoundField DataField="MAIL_ENSEIGNANT2" HeaderText="MAIL 2" SortExpression="MAIL_ENSEIGNANT2" ControlStyle-ForeColor="Black">
                                    <HeaderStyle BackColor="#339966" ForeColor="White" />
                                    <ItemStyle BackColor="#339966" ForeColor="White" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MOBILE_ENSEIGNANT2" HeaderText="MOBILE 2" SortExpression="MOBILE_ENSEIGNANT2" ControlStyle-ForeColor="Black">
                                    <HeaderStyle BackColor="#339966" ForeColor="White" />
                                    <ItemStyle BackColor="#339966" ForeColor="White" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="ENTREE DANS L'ENSEIGNEMENT" SortExpression="DATE_ENTREE_ENSEIGNEMENT_ENSEI">
                                    <EditItemTemplate>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox2" ErrorMessage="Format date non valide ex jj/mm/aaaa" ForeColor="Red" Font-Bold="true" ValidationExpression="^\d{1,2}/\d{1,2}/\d{4}$"></asp:RegularExpressionValidator>
                                        <asp:TextBox ID="TextBox2" runat="server" Enabled='<%# Eval("MODIF_OK_ENTREE_ENS")%>' Text='<%# Bind("DATE_ENTREE_ENSEIGNEMENT_ENSEI", "{0:d}") %>' ControlStyle-ForeColor="Black"></asp:TextBox>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DATE_ENTREE_ENSEIGNEMENT_ENSEI", "{0:d}") %>'></asp:TextBox>
                                    </InsertItemTemplate>

                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("DATE_ENTREE_ENSEIGNEMENT_ENSEI", "{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="#339966" ForeColor="White" />
                                    <ItemStyle BackColor="#339966" ForeColor="White" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ENTREE ETABLISSEMENT" SortExpression="DATE_ENTREE_ETABLISSEMENT_ENSE">
                                    <EditItemTemplate>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValideEns" runat="server" ControlToValidate="TextBox1" ErrorMessage="Format date non valide ex jj/mm/aaaa" ForeColor="red" Font-Bold="true" ValidationExpression="^\d{1,2}/\d{1,2}/\d{4}$"></asp:RegularExpressionValidator>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DATE_ENTREE_ETABLISSEMENT_ENSE", "{0:d}")%>' Enabled='<%# Eval("MODIF_OK_ENTREE_ETAB") %>' ControlStyle-ForeColor="Black"></asp:TextBox>

                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DATE_ENTREE_ETABLISSEMENT_ENSE", "{0:d}") %>'></asp:TextBox>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("DATE_ENTREE_ETABLISSEMENT_ENSE", "{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="#339966" ForeColor="White" />
                                    <ItemStyle BackColor="#339966" ForeColor="White" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="LIBELLE_GRADE" HeaderText="GRADE" ReadOnly="True" SortExpression="LIBELLE_GRADE" />
                                <asp:TemplateField HeaderText="CORPS" SortExpression="LIBELLE_CORPS">
                                    <EditItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("LIBELLE_CORPS") %>'></asp:Label>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server" Text='<%# Bind("LIBELLE_CORPS") %>'></asp:TextBox>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="LabelCorps" runat="server" Text='<%# Bind("LIBELLE_CORPS") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DATE_CORPS" DataFormatString="{0:d}" HeaderText="DATE CORPS" ReadOnly="True" SortExpression="DATE_CORPS" />
                                <asp:BoundField DataField="LIBELLE_FONCTION" HeaderText="FONCTION" ReadOnly="True" SortExpression="LIBELLE_FONCTION" />
                                <asp:BoundField DataField="LIBELLE_SPECIALITE" HeaderText="SPECIALITE" ReadOnly="True" SortExpression="LIBELLE_SPECIALITE" />
                                <asp:BoundField DataField="LIBELLE_DIPLOME" HeaderText="DIPLOME ACA" ReadOnly="True" SortExpression="LIBELLE_DIPLOME" />
                                <asp:BoundField DataField="LIBELLE_DIPLOME_PROFESSIONNEL" HeaderText="DIPLOME PROF" ReadOnly="True" SortExpression="LIBELLE_DIPLOME_PROFESSIONNEL" />
                                <asp:BoundField DataField="LIBELLE_TYPE_POSTE" HeaderText="POSTE" ReadOnly="True" SortExpression="LIBELLE_TYPE_POSTE" />
                                <asp:BoundField DataField="DATE_ENTREE_FONCTION_PUBLIQUE_" DataFormatString="{0:d}" HeaderText="ENTREE FONCTION PUBLIQUE" ReadOnly="True" SortExpression="DATE_ENTREE_FONCTION_PUBLIQUE_" />
                                <asp:BoundField DataField="LIBELLE_TYPE_UTILISATION" HeaderText="UTILISATION" ReadOnly="True" SortExpression="LIBELLE_TYPE_UTILISATION" />
                                <asp:BoundField DataField="LIBELLE_NATIONALITE" HeaderText="NATIONALITE" ReadOnly="True" SortExpression="LIBELLE_NATIONALITE" />
                            </Fields>
                            <FooterStyle BackColor="White" ForeColor="#333333" />
                            <HeaderStyle BackColor="#336666" CssClass="label-default" />
                            <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="White" ForeColor="#333333" />
                        </asp:DetailsView>
                    </div>

                    <asp:SqlDataSource ID="SqlAnnee" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT [CODE_ANNEE], [LIBELLE_ANNEE] FROM [ANNEE] WHERE ([ANNEE_ENCOURS] = @ANNEE_ENCOURS)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="ANNEE_ENCOURS" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [ENSEIGNANT] WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT" InsertCommand="INSERT INTO [ENSEIGNANT] ([MAIL_ENSEIGNANT], [MAIL_ENSEIGNANT2], [MOBILE_ENSEIGNANT], [MOBILE_ENSEIGNANT2], [PASSWORD_ENSEIGNANT]) VALUES (@MAIL_ENSEIGNANT, @MAIL_ENSEIGNANT2, @MOBILE_ENSEIGNANT, @MOBILE_ENSEIGNANT2, @PASSWORD_ENSEIGNANT)" SelectCommand="SELECT [IDENTIFIANT_ENSEIGNANT], [MAIL_ENSEIGNANT], [MAIL_ENSEIGNANT2], [MOBILE_ENSEIGNANT], [MOBILE_ENSEIGNANT2], [PASSWORD_ENSEIGNANT] FROM [ENSEIGNANT]" UpdateCommand="UPDATE [ENSEIGNANT] SET [MAIL_ENSEIGNANT] = @MAIL_ENSEIGNANT, [MAIL_ENSEIGNANT2] = @MAIL_ENSEIGNANT2, [MOBILE_ENSEIGNANT] = @MOBILE_ENSEIGNANT, [MOBILE_ENSEIGNANT2] = @MOBILE_ENSEIGNANT2, [PASSWORD_ENSEIGNANT] = @PASSWORD_ENSEIGNANT WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT">
                        <DeleteParameters>
                            <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="MAIL_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="MAIL_ENSEIGNANT2" Type="String" />
                            <asp:Parameter Name="MOBILE_ENSEIGNANT" Type="Decimal" />
                            <asp:Parameter Name="MOBILE_ENSEIGNANT2" Type="Decimal" />
                            <asp:Parameter Name="PASSWORD_ENSEIGNANT" Type="String" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="MAIL_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="MAIL_ENSEIGNANT2" Type="String" />
                            <asp:Parameter Name="MOBILE_ENSEIGNANT" Type="Decimal" />
                            <asp:Parameter Name="MOBILE_ENSEIGNANT2" Type="Decimal" />
                            <asp:Parameter Name="PASSWORD_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="SqlDonneesEns" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.SEXE_ENSEIGNANT, ENSEIGNANT.DATE_NAISS_ENSEIGNANT, ENSEIGNANT.MOBILE_ENSEIGNANT, ENSEIGNANT.MAIL_ENSEIGNANT, ENSEIGNANT.PASSWORD_ENSEIGNANT, ENSEIGNANT.LIEU_NAISSANCE_ENSEIGNANT, ENSEIGNANT.CNI, ENSEIGNANT.MAIL_ENSEIGNANT2, ENSEIGNANT.MOBILE_ENSEIGNANT2, CASE WHEN ETABLISSEMENT.NOM_ETABLISSEMENT LIKE '-&gt;%' THEN '' ELSE ETABLISSEMENT.NOM_ETABLISSEMENT END AS NOM_ETABLISSEMENT, GRADE.LIBELLE_GRADE, CORPS.LIBELLE_CORPS, ENSEIGNANT.DATE_CORPS, FONCTION.LIBELLE_FONCTION, SPECIALITE.LIBELLE_SPECIALITE, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL, TYPE_POSTE.LIBELLE_TYPE_POSTE, ENSEIGNANT.SITUATION_MATRIMONIALE, ENSEIGNANT.NBRE_ENFANTS, ENSEIGNANT.DATE_ENTREE_ETABLISSEMENT_ENSE, ENSEIGNANT.DATE_ENTREE_FONCTION_PUBLIQUE_, ENSEIGNANT.DATE_ENTREE_ENSEIGNEMENT_ENSEI, TYPE_UTILISATION.LIBELLE_TYPE_UTILISATION, NATIONALITE.LIBELLE_NATIONALITE, CASE WHEN ENSEIGNANT.DATE_ENTREE_ENSEIGNEMENT_ENSEI IS NULL THEN 1 ELSE 0 END AS MODIF_OK_ENTREE_ENS, CASE WHEN ENSEIGNANT.DATE_ENTREE_ETABLISSEMENT_ENSE IS NULL THEN 1 ELSE 0 END AS MODIF_OK_ENTREE_ETAB FROM ENSEIGNANT INNER JOIN ENSEIGNANT_ETABLISSEMENT ON ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT LEFT OUTER JOIN NATIONALITE ON ENSEIGNANT.CODE_NATIONALITE = NATIONALITE.CODE_NATIONALITE LEFT OUTER JOIN TYPE_UTILISATION ON ENSEIGNANT.CODE_TYPE_UTILISATION = TYPE_UTILISATION.CODE_TYPE_UTILISATION LEFT OUTER JOIN TYPE_POSTE ON ENSEIGNANT.CODE_TYPE_POSTE = TYPE_POSTE.CODE_TYPE_POSTE LEFT OUTER JOIN DIPLOME_PROFESSIONNEL ON ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL LEFT OUTER JOIN DIPLOME_ACADEMIQUE ON ENSEIGNANT.CODE_DIPLOME = DIPLOME_ACADEMIQUE.CODE_DIPLOME LEFT OUTER JOIN SPECIALITE ON ENSEIGNANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE LEFT OUTER JOIN FONCTION ON ENSEIGNANT.CODE_FONCTION = FONCTION.CODE_FONCTION LEFT OUTER JOIN GRADE ON ENSEIGNANT.CODE_GRADE = GRADE.CODE_GRADE LEFT OUTER JOIN CORPS ON ENSEIGNANT.CODE_CORPS = CORPS.CODE_CORPS WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)" UpdateCommand="UPDATE ENSEIGNANT SET MAIL_ENSEIGNANT2 = @MAIL_ENSEIGNANT2, MOBILE_ENSEIGNANT2 = @MOBILE_ENSEIGNANT2, DATE_ENTREE_ENSEIGNEMENT_ENSEI = @DATE_ENTREE_ENSEIGNEMENT_ENSEI, DATE_ENTREE_ETABLISSEMENT_ENSE = @DATE_ENTREE_ETABLISSEMENT_ENSE WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="MAIL_ENSEIGNANT2" />
                            <asp:Parameter Name="MOBILE_ENSEIGNANT2" />
                            <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" />
                            <asp:Parameter Name="DATE_ENTREE_ENSEIGNEMENT_ENSEI" />
                            <asp:Parameter Name="DATE_ENTREE_ETABLISSEMENT_ENSE" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:DropDownList ID="DropDownListAnnee" runat="server" DataSourceID="SqlAnnee" DataTextField="LIBELLE_ANNEE" DataValueField="CODE_ANNEE" CssClass="auto-style3" Visible="False">
                    </asp:DropDownList>

                    <asp:Button ID="BtOK" runat="server" Text="Vérifier Statut" Visible="False" />
                    <asp:Button ID="BtPostulerOld" runat="server" PostBackUrl="~/voeux/voeux.aspx" Text="Postuler" BackColor="Red" CssClass="auto-style13" Visible="False" />

                    <asp:GridView ID="GridViewCandidat" runat="server" AutoGenerateColumns="False" DataKeyNames="IDENTIFIANT_ENSEIGNANT" DataSourceID="SqlEnsCandidat" ShowHeader="False" Visible="False" Width="383px">
                        <Columns>
                            <asp:BoundField DataField="IDENTIFIANT_ENSEIGNANT" HeaderText="IDENTIFIANT_ENSEIGNANT" InsertVisible="False" ReadOnly="True" SortExpression="IDENTIFIANT_ENSEIGNANT" Visible="False" />
                            <asp:HyperLinkField DataNavigateUrlFields="IDENTIFIANT_ENSEIGNANT" DataNavigateUrlFormatString="~/voeux/voeux.aspx" HeaderText="Voeux" Text="Postuler à ce mouvement" />
                        </Columns>
                    </asp:GridView>

                    <br />

                    <asp:SqlDataSource ID="SqlEnsCandidat" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PRENOMS_ENSEIGNANT, FONCTION.LIBELLE_FONCTION, SPECIALITE.LIBELLE_SPECIALITE, ETABLISSEMENT.NOM_ETABLISSEMENT, ATLAS_SYS_DEF_ALL.IDEN, ENSEIGNANT.IDENTIFIANT_ENSEIGNANT FROM ENSEIGNANT INNER JOIN FONCTION ON ENSEIGNANT.CODE_FONCTION = FONCTION.CODE_FONCTION INNER JOIN SPECIALITE ON ENSEIGNANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE INNER JOIN ENSEIGNANT_ETABLISSEMENT ON ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 WHERE (ENSEIGNANT.MATRICULE_ENSEIGNANT = @MATRICULE_ENSEIGNANT)">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="0" Name="MATRICULE_ENSEIGNANT" SessionField="t_matricule" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:Label ID="Label1" runat="server" Text="NB: Les surveillants simples et les personnels des services centraux n'ont pas besoin de déclarer leur poste." Visible="False"></asp:Label>

                    <asp:SqlDataSource ID="SqlMvmt" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT DISTINCT FUP_MOUVEMENT.LIBELLE_MOUVEMENT, FUP_MOUVEMENT.CODE_MOUVEMENT, ENSEIGNANT.IDENTIFIANT_ENSEIGNANT FROM ANNEE INNER JOIN FUP_MOUVEMENT ON ANNEE.CODE_ANNEE = FUP_MOUVEMENT.CODE_ANNEE INNER JOIN FUP_TYPE_MOUVEMENT INNER JOIN FUP_CORPS_TYPE_MOUVEMENT ON FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_CORPS_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT INNER JOIN ENSEIGNANT ON FUP_CORPS_TYPE_MOUVEMENT.CODE_CORPS = ENSEIGNANT.CODE_CORPS ON FUP_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_TYPE_MOUVEMENT.TYPE_MOUVEMENT_PSV_AUTO = 1) AND (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </div>
        </div>
    </section>
</asp:Content>

