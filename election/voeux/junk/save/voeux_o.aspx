<%@ Page Title="Voeux" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="voeux_o.aspx.vb" Inherits="candidature_candidature" MaintainScrollPositionOnPostback="True" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" runat="Server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }

        .auto-style5 {
            width: 245px;
        }

        .auto-style14 {
            color: #FF3300;
        }

        .auto-style40 {
            width: 247px;
            color: #FFFFFF;
            font-size: medium;
            text-align: center;
            height: 28px;
        }

        .auto-style41 {
            width: 690px;
            color: #666666;
            font-size: x-large;
            height: 28px;
        }

        .auto-style42 {
            color: #e80c4d;
            font-size: small;
        }

        .auto-style45 {
            width: 81px;
            height: 54px;
        }

        .auto-style46 {
            text-align: right;
            height: 28px;
        }

        .auto-style51 {
            font-size: x-small;
        }

        .auto-style52 {
            width: 30px;
            height: 30px;
        }

        .auto-style69 {
            color: #FF9900;
        }

        .auto-style73 {
            width: 100%;
            height: 99px;
        }

        .auto-style75 {
            height: 33px;
            color: #000000;
            background-color: #FF9900;
        }

        .auto-style80 {
            table-layout: fixed;
            width: 427px;
        }

        .auto-style81 {
            table-layout: fixed;
            width: 100px;
        }

        .auto-style82 {
            table-layout: fixed;
            width: 435px;
            height: 44px;
        }

        .auto-style83 {
            table-layout: fixed;
            width: 100px;
            height: 44px;
        }

        .auto-style86 {
            table-layout: fixed;
            width: 427px;
            height: 23px;
        }

        .auto-style87 {
            table-layout: fixed;
            width: 100px;
            height: 23px;
        }

        .auto-style88 {
            table-layout: fixed;
            height: 23px;
        }

        .auto-style89 {
            width: 114%;
        }

        .auto-style90 {
            color: #000000;
            background-color: #FFFFFF;
        }

        .auto-style92 {
            width: 106%;
        }

        .auto-style93 {
            table-layout: fixed;
            width: 427px;
            height: 44px;
        }

        .auto-style95 {
            width: 454px;
        }

        .auto-style96 {
            height: 33px;
            color: #000000;
            background-color: #669900;
            width: 409px;
        }

        .auto-style97 {
            color: #FFFFFF;
            background-color: #669900;
        }

        .auto-style98 {
            width: 30px;
            height: 30px;
            color: #FFFFFF;
            background-color: #669900;
        }

        .auto-style99 {
            width: 106%;
            background-color: #669900;
        }

        .auto-style101 {
            width: 30px;
            height: 30px;
            background-color: #669900;
        }

        .auto-style103 {
            color: #FFFFFF;
            background-color: #FFFFFF;
        }

        .auto-style104 {
            color: #000000;
            background-color: #669900;
        }

        .auto-style106 {
            width: 30px;
            height: 30px;
            background-color: #FF9900;
        }

        .auto-style107 {
            color: #669900;
        }

        .auto-style109 {
            text-align: right;
        }

        .auto-style108 {
            font-size: small;
            background-color: #669900;
        }

        .auto-style111 {
            width: 450px;
        }

        .auto-style112 {
            font-size: x-small;
            color: #FF3300;
        }

        .auto-style113 {
            font-size: small;
            color: #FF9900;
        }
    </style>

    <section id="desc2" class="pic-text pic-text text-left">
        <div class="container">
            <div class="row">

                <%-- Présentation et bouton retour --%>
                <div class="col-md-12">
                    <div class="col-lg-3">
                        <h3>Candidature</h3>
                        <img alt="" class="auto-style45" src="../Images/mirador/candidaturecoche.jpg" />
                    </div>
                    <div class="col-lg-1 col-lg-offset-8">
                        <asp:Button ID="Button1" runat="server" Text="Retour" PostBackUrl="~/voeux/listemvmt.aspx" />
                    </div>
                </div>
                <div class="col-lg-12 text-center">
                    <asp:Label ID="LabelError" CssClass="text-danger" runat="server" Text=""></asp:Label>
                </div>
                <div class="col-md-12">
                    <%-- Bonjour --%>
                    <div class="col-lg-6">
                        <strong>
                            <asp:Label ID="LabelBonjour" CssClass="text-left" runat="server" Text="Bonjour"></asp:Label>
                            <br />
                        </strong>
                        <asp:Label ID="Label20" runat="server" CssClass="text-left" Text="Les candidatures seront ouvertes  jusqu'au "></asp:Label>
                        <strong>

                            <%--<asp:Label ID="Label22" runat="server" CssClass="text-left text-danger" Text="Mardi 21 Juin 2015 à 23h:59"></asp:Label>--%>
                            <span class="text-danger">
                                <%= dateCloture.ToString("f") %></span>
                        </strong>
                        <br />
                        <asp:Label ID="Label21" runat="server" CssClass="text-left" Text="Tu peux consulter les postes en cliquant sur"></asp:Label>
                        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="text-info" NavigateUrl="~/voeux/recherche/recherche_miroir.aspx">Recherche poste</asp:HyperLink>
                        <br />

                        <em>
                            <strong>
                                <asp:Label ID="LabelPeutCompetir" runat="server" CssClass="auto-style14"></asp:Label>
                                <asp:SqlDataSource ID="SqlModeleFiche" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT FUP_FICHE_MUTATION.LIBELLE_FICHE_MUTATION, FUP_FICHE_MUTATION.DESCRIPTION_FICHE_MUTATION, FUP_FICHE_MUTATION.GRADE_PRIORITAIRE, FUP_MOUVEMENT.LIBELLE_MOUVEMENT, ANNEE.LIBELLE_ANNEE, FUP_MOUVEMENT.CODE_MOUVEMENT FROM FUP_MOUVEMENT INNER JOIN FUP_TYPE_MOUVEMENT ON FUP_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT INNER JOIN FUP_FICHE_MUTATION ON FUP_TYPE_MOUVEMENT.CODE_FICHE_MUTATION = FUP_FICHE_MUTATION.CODE_FICHE_MUTATION INNER JOIN ANNEE ON FUP_MOUVEMENT.CODE_ANNEE = ANNEE.CODE_ANNEE WHERE (FUP_MOUVEMENT.CODE_MOUVEMENT = @CODE_MOUVEMENT)">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="0" Name="CODE_MOUVEMENT" SessionField="c_mvmt" />
                                    </SelectParameters>
                                </asp:SqlDataSource>



                                <asp:DropDownList ID="DropDownListAnnee" runat="server" DataSourceID="SqlAnnee" DataTextField="LIBELLE_ANNEE" DataValueField="CODE_ANNEE" CssClass="auto-style3">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlAnnee" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT [CODE_ANNEE], [LIBELLE_ANNEE] FROM [ANNEE] WHERE ([ANNEE_ENCOURS] = @ANNEE_ENCOURS)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="true" Name="ANNEE_ENCOURS" Type="Boolean" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </strong>
                        </em>
                    </div>

                    <%-- Phase 0 --%>
                    <div class="col-lg-6">
                        <asp:Panel ID="PanelCorrige" runat="server">
                            <img alt="" class="auto-style52" src="../Images/orderedList0.png" style="vertical-align: middle" />
                            Vérifie tes données et clique sur ce lien pour
                                <asp:HyperLink ID="HyperLink2" runat="server" CssClass="text-left text-success" NavigateUrl="~/voeux/modifdonnees.aspx">corriger </asp:HyperLink>
                            au besoin.<br />
                            La correction doit se faire avant le choix des postes.<br />
                            NB: Bien vérifier la combinaison corps/grade et le diplôme professionnel afin d&#39;accéder aux miroirs auxquels tu as droit.<br />
                        </asp:Panel>

                        <asp:Panel ID="PanelDossier" runat="server">

                            <asp:DetailsView ID="GridViewDossierNum" runat="server" AutoGenerateRows="False" DataKeyNames="DOSSIER_CANDIDATURE_ID" DataSourceID="SqlDossierNum" CssClass="text-success badge alert-success" GridLines="None">
                                <Fields>
                                    <asp:BoundField DataField="DOSSIER_CANDIDATURE_ID" HeaderText="DOSSIER_CANDIDATURE_ID" InsertVisible="False" ReadOnly="True" SortExpression="DOSSIER_CANDIDATURE_ID" Visible="False" />
                                    <asp:BoundField DataField="NUMERO_DOSSIER_CANDIDATURE" HeaderText="Ta candidature en ligne est effectuée. Dossier N°" ReadOnly="True" SortExpression="NUMERO_DOSSIER_CANDIDATURE">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Font-Bold="True" CssClass="badge alert-warning" Font-Size="Small" Wrap="False" />
                                    </asp:BoundField>
                                </Fields>
                            </asp:DetailsView>
                            <asp:Label ID="LabelDepot" runat="server" Text="" Visible="False"></asp:Label>
                            <%-- <%= dateCloture.ToString("f") %>--%>
                        </asp:Panel>
                    </div>
                </div>

                <%-- tableau resume donnée ens --%>
                <div class="col-md-12">
                    <div class="table table-responsive">
                        <asp:GridView ID="GridEnseignant" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="IDENTIFIANT_ENSEIGNANT" DataSourceID="SqlEnseignant" ForeColor="Black" GridLines="Vertical" Width="" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" Visible="False">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField EditText="M" ShowEditButton="True" UpdateText="OK" Visible="False" />
                                <asp:BoundField DataField="ETABLISSEMENT" HeaderText="ETABLISSEMENT" ReadOnly="True" SortExpression="ETABLISSEMENT" InsertVisible="False">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </div>

                    <asp:SqlDataSource ID="SqlEnseignant" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, CORPS.LIBELLE_CORPS, GRADE.LIBELLE_GRADE, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL, ENSEIGNANT.DATE_CORPS, TYPE_POSTE.LIBELLE_TYPE_POSTE, ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.CNI, ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.SEXE_ENSEIGNANT, ENSEIGNANT.DATE_NAISS_ENSEIGNANT, ENSEIGNANT.DATE_ENTREE_ETABLISSEMENT_ENSE, ENSEIGNANT.DATE_ENTREE_FONCTION_PUBLIQUE_, ENSEIGNANT.DATE_ENTREE_ENSEIGNEMENT_ENSEI, ENSEIGNANT.NBRE_ENFANTS, ATLAS_SYS_DEF_ALL.code00, ETABLISSEMENT.NOM_ETABLISSEMENT + ' (' + ATLAS_SYS_DEF_ALL.IDEN + ')' AS ETABLISSEMENT, ENSEIGNANT.SITUATION_MATRIMONIALE + ' / ' + CAST(ENSEIGNANT.NBRE_ENFANTS AS varchar) + ' Enfant(s)' AS SITUATION, FONCTION.LIBELLE_FONCTION, SPECIALITE.LIBELLE_SPECIALITE, ENSEIGNANT.CODE_CORPS, ENSEIGNANT.CODE_DIPLOME, ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL, ENSEIGNANT.CODE_GRADE, ENSEIGNANT.MODIFIE_PAR, ENSEIGNANT.DATE_DERNIERE_MODIFICATION FROM ENSEIGNANT INNER JOIN CORPS ON ENSEIGNANT.CODE_CORPS = CORPS.CODE_CORPS INNER JOIN GRADE ON ENSEIGNANT.CODE_GRADE = GRADE.CODE_GRADE INNER JOIN SPECIALITE ON ENSEIGNANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE INNER JOIN FONCTION ON ENSEIGNANT.CODE_FONCTION = FONCTION.CODE_FONCTION INNER JOIN ENSEIGNANT_ETABLISSEMENT ON ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ENSEIGNANT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT AND ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 LEFT OUTER JOIN DIPLOME_PROFESSIONNEL ON ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL LEFT OUTER JOIN DIPLOME_ACADEMIQUE ON ENSEIGNANT.CODE_DIPLOME = DIPLOME_ACADEMIQUE.CODE_DIPLOME LEFT OUTER JOIN TYPE_POSTE ON ENSEIGNANT.CODE_TYPE_POSTE = TYPE_POSTE.CODE_TYPE_POSTE WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)" UpdateCommand="UPDATE ENSEIGNANT SET CODE_CORPS = @CODE_CORPS, CODE_DIPLOME = @CODE_DIPLOME, CODE_DIPLOME_PROFESSIONNEL = @CODE_DIPLOME_PROFESSIONNEL, CODE_GRADE = @CODE_GRADE, NOM_ENSEIGNANT = @NOM_ENSEIGNANT, PRENOMS_ENSEIGNANT = @PRENOMS_ENSEIGNANT, MODIFIE_PAR = @MODIFIE_PAR, DATE_DERNIERE_MODIFICATION = GETDATE(), CODE_FONCTION =, CODE_SPECIALITE = WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="CODE_CORPS" />
                            <asp:Parameter Name="CODE_DIPLOME" />
                            <asp:Parameter Name="CODE_DIPLOME_PROFESSIONNEL" />
                            <asp:Parameter Name="CODE_GRADE" />
                            <asp:Parameter Name="NOM_ENSEIGNANT" />
                            <asp:Parameter Name="PRENOMS_ENSEIGNANT" />
                            <asp:ProfileParameter Name="MODIFIE_PAR" PropertyName="username" />
                            <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <div class="table table-responsive">
                        <asp:GridView ID="GridEnseignant0" runat="server" AutoGenerateColumns="False" CellPadding="2" DataKeyNames="IDENTIFIANT_ENSEIGNANT" DataSourceID="SqlEnseignant" ForeColor="Black" GridLines="None" Width="" CssClass="table tab-content" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" ShowHeader="False">
                            <AlternatingRowStyle BackColor="PaleGoldenrod" />
                            <Columns>
                                <asp:CommandField EditText="M" ShowEditButton="True" UpdateText="OK" Visible="False" />
                                <asp:BoundField DataField="ETABLISSEMENT" HeaderText="ETABLISSEMENT" SortExpression="ETABLISSEMENT">
                                    <HeaderStyle Wrap="False" />
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="MATRICULE" SortExpression="MATRICULE_ENSEIGNANT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("MATRICULE_ENSEIGNANT") %>' Width="80px"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("MATRICULE_ENSEIGNANT") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NOM" SortExpression="NOM_ENSEIGNANT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("NOM_ENSEIGNANT") %>' Width="90px"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label12" runat="server" Text='<%# Bind("NOM_ENSEIGNANT") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PRENOMS" SortExpression="PRENOMS_ENSEIGNANT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("PRENOMS_ENSEIGNANT") %>' Width="100px"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label13" runat="server" Text='<%# Bind("PRENOMS_ENSEIGNANT") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="True" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SEXE" SortExpression="SEXE_ENSEIGNANT">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownListSexe0" runat="server" DataSourceID="SqlSexe0" DataTextField="SEXE" DataValueField="SEXE" SelectedValue='<%# Bind("SEXE_ENSEIGNANT") %>' Width="35px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlSexe0" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT 'M' AS SEXE UNION SELECT 'F' AS SEXE UNION SELECT NULL AS SEXE"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label14" runat="server" Text='<%# Bind("SEXE_ENSEIGNANT") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DATE NAISS" SortExpression="DATE_NAISS_ENSEIGNANT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("DATE_NAISS_ENSEIGNANT", "{0:d}") %>' Width="60px"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label15" runat="server" Text='<%# Bind("DATE_NAISS_ENSEIGNANT", "{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CORPS" SortExpression="CODE_CORPS">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlCorps0" DataTextField="LIBELLE_CORPS" DataValueField="CODE_CORPS" SelectedValue='<%# Bind("CODE_CORPS") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlCorps0" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL CODE_CORPS, '--------' as LIBELLE_CORPS
UNION


SELECT CORPS.CODE_CORPS, CORPS.LIBELLE_CORPS FROM ENSEIGNANT INNER JOIN CORPS ON ENSEIGNANT.CODE_CORPS = CORPS.CODE_CORPS WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)

UNION

SELECT CORPS.CODE_CORPS, CORPS.LIBELLE_CORPS FROM ETABLISSEMENT INNER JOIN ENSEIGNANT_ETABLISSEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN CORPS_SYSTEME INNER JOIN CORPS ON CORPS_SYSTEME.CODE_CORPS = CORPS.CODE_CORPS ON ETABLISSEMENT.CODE_SYSTEME = CORPS_SYSTEME.CODE_SYSTEME WHERE (ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)
order by  LIBELLE_CORPS">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label16" runat="server" Text='<%# Bind("LIBELLE_CORPS") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="GRADE" SortExpression="CODE_GRADE">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="SqlGrade0" DataTextField="LIBELLE_GRADE" DataValueField="CODE_GRADE" SelectedValue='<%# Bind("CODE_GRADE") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlGrade0" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT null [CODE_GRADE],'--------' as [LIBELLE_GRADE]
union
SELECT GRADE.CODE_GRADE, GRADE.LIBELLE_GRADE FROM GRADE INNER JOIN GRADE_CORPS ON GRADE.CODE_GRADE = GRADE_CORPS.CODE_GRADE ORDER BY GRADE.LIBELLE_GRADE"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label17" runat="server" Text='<%# Bind("LIBELLE_GRADE") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DIPLOME ACA" SortExpression="CODE_DIPLOME">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="SqlDiplomeAca0" DataTextField="LIBELLE_DIPLOME" DataValueField="CODE_DIPLOME" SelectedValue='<%# Bind("CODE_DIPLOME") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDiplomeAca0" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT null CODE_DIPLOME, '--------' as LIBELLE_DIPLOME 
union
SELECT DIPLOME_ACADEMIQUE.CODE_DIPLOME, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME FROM ENSEIGNANT INNER JOIN DIPLOME_ACADEMIQUE ON ENSEIGNANT.CODE_DIPLOME = DIPLOME_ACADEMIQUE.CODE_DIPLOME WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ISNULL(@IDENTIFIANT_ENSEIGNANT, '0'))
union
SELECT DIPLOME_ACADEMIQUE.CODE_DIPLOME, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME FROM ENSEIGNANT_ETABLISSEMENT INNER JOIN ENSEIGNANT ON ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN DIPLOME_ACADEMIQUE INNER JOIN DIPLOME_ACADEMIQUE_SYSTEME ON DIPLOME_ACADEMIQUE.CODE_DIPLOME = DIPLOME_ACADEMIQUE_SYSTEME.CODE_DIPLOME ON ETABLISSEMENT.CODE_SYSTEME = DIPLOME_ACADEMIQUE_SYSTEME.CODE_SYSTEME WHERE (ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) ORDER BY DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label18" runat="server" Text='<%# Bind("LIBELLE_DIPLOME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DIPLOME PROF" SortExpression="CODE_DIPLOME_PROFESSIONNEL">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList8" runat="server" DataSourceID="SqlDiplomeProf0" DataTextField="LIBELLE_DIPLOME_PROFESSIONNEL" DataValueField="CODE_DIPLOME_PROFESSIONNEL" SelectedValue='<%# Bind("CODE_DIPLOME_PROFESSIONNEL") %>'>
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDiplomeProf0" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT null CODE_DIPLOME_PROFESSIONNEL, '--------' as LIBELLE_DIPLOME_PROFESSIONNEL
union 


SELECT DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL FROM ENSEIGNANT INNER JOIN DIPLOME_PROFESSIONNEL ON ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)


UNION
SELECT DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL FROM ENSEIGNANT_ETABLISSEMENT INNER JOIN ENSEIGNANT ON ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN DIPLOME_PROFESSIONNEL INNER JOIN DIPLOME_PROFESSIONNEL_SYSTEME ON DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL_SYSTEME.CODE_DIPLOME_PROFESSIONNEL ON ETABLISSEMENT.CODE_SYSTEME = DIPLOME_PROFESSIONNEL_SYSTEME.CODE_SYSTEME WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)
order by LIBELLE_DIPLOME_PROFESSIONNEL">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label19" runat="server" Text='<%# Bind("LIBELLE_DIPLOME_PROFESSIONNEL") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="LIBELLE_FONCTION" HeaderText="FONCTION" SortExpression="LIBELLE_FONCTION" ReadOnly="True">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="LIBELLE_SPECIALITE" HeaderText="SPECIALITE" SortExpression="LIBELLE_SPECIALITE" ReadOnly="True">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="Tan" />
                            <HeaderStyle BackColor="Tan" Font-Bold="True" />
                            <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                            <SortedAscendingCellStyle BackColor="#FAFAE7" />
                            <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                            <SortedDescendingCellStyle BackColor="#E1DB9C" />
                            <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                        </asp:GridView>
                    </div>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [ENSEIGNANT] WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT" InsertCommand="INSERT INTO [ENSEIGNANT] ([CODE_CORPS], [CODE_DIPLOME], [CODE_DIPLOME_PROFESSIONNEL], [CODE_GRADE], [SEXE_ENSEIGNANT], [MATRICULE_ENSEIGNANT], [NOM_ENSEIGNANT], [PRENOMS_ENSEIGNANT], [DATE_NAISS_ENSEIGNANT]) VALUES (@CODE_CORPS, @CODE_DIPLOME, @CODE_DIPLOME_PROFESSIONNEL, @CODE_GRADE, @SEXE_ENSEIGNANT, @MATRICULE_ENSEIGNANT, @NOM_ENSEIGNANT, @PRENOMS_ENSEIGNANT, @DATE_NAISS_ENSEIGNANT)" SelectCommand="SELECT [CODE_CORPS], [CODE_DIPLOME], [CODE_DIPLOME_PROFESSIONNEL], [CODE_GRADE], [SEXE_ENSEIGNANT], [MATRICULE_ENSEIGNANT], [NOM_ENSEIGNANT], [PRENOMS_ENSEIGNANT], [DATE_NAISS_ENSEIGNANT], [IDENTIFIANT_ENSEIGNANT] FROM [ENSEIGNANT]" UpdateCommand="UPDATE [ENSEIGNANT] SET [CODE_CORPS] = @CODE_CORPS, [CODE_DIPLOME] = @CODE_DIPLOME, [CODE_DIPLOME_PROFESSIONNEL] = @CODE_DIPLOME_PROFESSIONNEL, [CODE_GRADE] = @CODE_GRADE, [SEXE_ENSEIGNANT] = @SEXE_ENSEIGNANT, [MATRICULE_ENSEIGNANT] = @MATRICULE_ENSEIGNANT, [NOM_ENSEIGNANT] = @NOM_ENSEIGNANT, [PRENOMS_ENSEIGNANT] = @PRENOMS_ENSEIGNANT, [DATE_NAISS_ENSEIGNANT] = @DATE_NAISS_ENSEIGNANT WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT">
                        <DeleteParameters>
                            <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="CODE_CORPS" Type="String" />
                            <asp:Parameter Name="CODE_DIPLOME" Type="String" />
                            <asp:Parameter Name="CODE_DIPLOME_PROFESSIONNEL" Type="String" />
                            <asp:Parameter Name="CODE_GRADE" Type="String" />
                            <asp:Parameter Name="SEXE_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="MATRICULE_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="NOM_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="PRENOMS_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="DATE_NAISS_ENSEIGNANT" Type="DateTime" />
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="CODE_CORPS" Type="String" />
                            <asp:Parameter Name="CODE_DIPLOME" Type="String" />
                            <asp:Parameter Name="CODE_DIPLOME_PROFESSIONNEL" Type="String" />
                            <asp:Parameter Name="CODE_GRADE" Type="String" />
                            <asp:Parameter Name="SEXE_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="MATRICULE_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="NOM_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="PRENOMS_ENSEIGNANT" Type="String" />
                            <asp:Parameter Name="DATE_NAISS_ENSEIGNANT" Type="DateTime" />
                            <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                </div>

                <div class="col-md-12">
                    <%-- 1 Sélectionne Poste --%>
                    <div class="col-lg-4">
                        <div style="background-color: #27c24c; padding: 2px; color: #FFFFFF">
                            <%--                            <span class="badge text-warning">1</span>--%>
                            <img alt="" class="auto-style52" src="../Images/orderedList1.png" style="vertical-align: middle" />
                            <strong style="vertical-align: middle">
                                <span>Sélectionne et ajoute tes postes, un par un, en cliquant sur le bouton ​"ajouter" après chaque choix.</span>
                            </strong>
                        </div>
                        <span class="text-warning">NB: il faut ajouter tous tes choix de postes, d&#39;adjoint comme de responsabilité, avant de saisir les notes.</span>
                        <div class="form-group">
                            <asp:DropDownList ID="DropOrdre" runat="server" DataSourceID="SqlOrdre" DataTextField="LIBELLE_ORDRE_PREFERENCE" DataValueField="CODE_ORDRE_PREFERENCE" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlOrdre" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT CODE_ORDRE_PREFERENCE, LIBELLE_ORDRE_PREFERENCE FROM FUP_ORDRE_PREFERENCE 
EXCEPT 
SELECT FUP_ORDRE_PREFERENCE.CODE_ORDRE_PREFERENCE, FUP_ORDRE_PREFERENCE.LIBELLE_ORDRE_PREFERENCE FROM ANNEE INNER JOIN FUP_DEMANDE_POSTE_VACANT ON ANNEE.CODE_ANNEE = FUP_DEMANDE_POSTE_VACANT.CODE_ANNEE INNER JOIN FUP_ORDRE_PREFERENCE ON FUP_DEMANDE_POSTE_VACANT.CODE_ORDRE_PREFERENCE = FUP_ORDRE_PREFERENCE.CODE_ORDRE_PREFERENCE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_DEMANDE_POSTE_VACANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)
ORDER BY LIBELLE_ORDRE_PREFERENCE">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <div class="form-group">
                            <asp:DropDownList ID="DropMvmt" runat="server" AutoPostBack="True" DataSourceID="SqlMvmt" DataTextField="LIBELLE_MOUVEMENT" DataValueField="CODE_MOUVEMENT" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlMvmt" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS CODE_MOUVEMENT, ' Choisis un mouvement...' AS LIBELLE_MOUVEMENT UNION SELECT MvmtAutorise_1.CODE_MOUVEMENT, MvmtAutorise_1.LIBELLE_MOUVEMENT FROM dbo.MvmtAutorise(@id_ens) AS MvmtAutorise_1 INNER JOIN FUP_MOUVEMENT ON MvmtAutorise_1.CODE_MOUVEMENT = FUP_MOUVEMENT.CODE_MOUVEMENT INNER JOIN FUP_TYPE_MOUVEMENT ON FUP_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT WHERE (FUP_TYPE_MOUVEMENT.TYPE_MOUVEMENT_OUVERT = 1) ORDER BY LIBELLE_MOUVEMENT">
                                <SelectParameters>
                                    <asp:SessionParameter Name="id_ens" SessionField="id_ens" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <div class="form-group">
                            <asp:DropDownList ID="DropIA" runat="server" AutoPostBack="True" DataSourceID="SqlIA" DataTextField="IA" DataValueField="code06" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlIA" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS code06, ' Choisis une IA...' AS IA UNION SELECT ATLAS_SYS_DEF_ALL.code06, ATLAS_SYS_DEF_ALL.IA FROM FUP_POSTE_VACANT INNER JOIN ETABLISSEMENT ON FUP_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 CROSS JOIN ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_POSTE_VACANT.CODE_MOUVEMENT = @CODE_MOUVEMENT) AND (NOT (ETABLISSEMENT.NOM_ETABLISSEMENT LIKE N'%audit%')) GROUP BY ATLAS_SYS_DEF_ALL.code06, ATLAS_SYS_DEF_ALL.IA, ETABLISSEMENT.NOM_ETABLISSEMENT HAVING (NOT (ETABLISSEMENT.NOM_ETABLISSEMENT LIKE N'-&gt;%')) ORDER BY IA">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropMvmt" DefaultValue="0" Name="CODE_MOUVEMENT" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:SqlDataSource ID="SqlIARegional" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ATLAS_SYS_DEF_ALL.code06, ATLAS_SYS_DEF_ALL.IA FROM ENSEIGNANT_ETABLISSEMENT INNER JOIN ENSEIGNANT ON ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT.IDENTIFIANT_ENSEIGNANT INNER JOIN ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) ORDER BY ATLAS_SYS_DEF_ALL.IA">
                                <SelectParameters>
                                    <asp:SessionParameter Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <div class="form-group">
                            <asp:DropDownList ID="DropIEF" runat="server" AutoPostBack="True" DataSourceID="SqlIEF" DataTextField="IEF" DataValueField="code04" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlIEF" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT null code04, ' Chosis une IEF...' as IEF 
union

SELECT ATLAS_SYS_DEF_ALL.code04, ATLAS_SYS_DEF_ALL.IDEN AS IEF 
FROM FUP_POSTE_VACANT INNER JOIN ETABLISSEMENT ON FUP_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 CROSS JOIN ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_POSTE_VACANT.CODE_MOUVEMENT = @CODE_MOUVEMENT) AND (ATLAS_SYS_DEF_ALL.code06 = @IA) GROUP BY ATLAS_SYS_DEF_ALL.code04, ATLAS_SYS_DEF_ALL.IDEN
order by IEF ">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropMvmt" DefaultValue="0" Name="CODE_MOUVEMENT" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropIA" DefaultValue="0" Name="IA" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </div>

                        <div class="form-group">
                            <asp:DropDownList ID="DropEtab" runat="server" AutoPostBack="True" DataSourceID="SqlEtab" DataTextField="ETABLISSEMENT" DataValueField="CODE_ETABLISSEMENT" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlEtab" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT        NULL CODE_ETABLISSEMENT, ' Choisis un établissement...' AS ETABLISSEMENT
UNION
SELECT ETABLISSEMENT.CODE_ETABLISSEMENT, UPPER(ETABLISSEMENT.NOM_ETABLISSEMENT) AS ETABLISSEMENT FROM FUP_POSTE_VACANT INNER JOIN ETABLISSEMENT ON FUP_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 CROSS JOIN ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_POSTE_VACANT.CODE_MOUVEMENT = @CODE_MOUVEMENT) AND (ATLAS_SYS_DEF_ALL.code04 = @IEF) GROUP BY ETABLISSEMENT.CODE_ETABLISSEMENT, UPPER(ETABLISSEMENT.NOM_ETABLISSEMENT), FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT ORDER BY ETABLISSEMENT">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropMvmt" DefaultValue="0" Name="CODE_MOUVEMENT" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropIEF" DefaultValue="0" Name="IEF" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <div class="form-group">
                            <asp:DropDownList ID="DropFct" runat="server" AutoPostBack="True" DataSourceID="SqlFct" DataTextField="LIBELLE_FONCTION" DataValueField="CODE_FONCTION" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlFct" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT null CODE_FONCTION, ' Choisis une fonction...' as LIBELLE_FONCTION
union 
SELECT FUP_POSTE_VACANT.CODE_FONCTION, FONCTION.LIBELLE_FONCTION FROM FUP_POSTE_VACANT INNER JOIN ETABLISSEMENT ON FUP_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN FONCTION ON FUP_POSTE_VACANT.CODE_FONCTION = FONCTION.CODE_FONCTION CROSS JOIN ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_POSTE_VACANT.CODE_MOUVEMENT = @CODE_MOUVEMENT) GROUP BY FUP_POSTE_VACANT.CODE_ETABLISSEMENT, FUP_POSTE_VACANT.CODE_FONCTION, FONCTION.LIBELLE_FONCTION, FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT HAVING (FUP_POSTE_VACANT.CODE_ETABLISSEMENT = @CODE_ETABLISSEMENT) ORDER BY FONCTION.LIBELLE_FONCTION">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropMvmt" DefaultValue="0" Name="CODE_MOUVEMENT" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropEtab" DefaultValue="0" Name="CODE_ETABLISSEMENT" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <div class="form-group">
                            <asp:DropDownList ID="DropSpc" runat="server" AutoPostBack="True" DataSourceID="SqlSpc" DataTextField="LIBELLE_SPECIALITE" DataValueField="CODE_SPECIALITE" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlSpc" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT NULL AS CODE_SPECIALITE, ' Choisis une spécialité...' AS LIBELLE_SPECIALITE, ' Choisis une spécialité...' AS SpcPvPsv UNION SELECT FUP_POSTE_VACANT.CODE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE + ' (PV: ' + CAST(FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT AS varchar) + ' - PSV: ' + CAST(FUP_POSTE_VACANT.NOMBRE_POSTE_SUCCEPTIBLE_VACANT AS varchar) +')' AS SpcPvPsv FROM FUP_POSTE_VACANT INNER JOIN ETABLISSEMENT ON FUP_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN SPECIALITE ON FUP_POSTE_VACANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE CROSS JOIN ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_POSTE_VACANT.CODE_MOUVEMENT = @CODE_MOUVEMENT) GROUP BY FUP_POSTE_VACANT.CODE_ETABLISSEMENT, FUP_POSTE_VACANT.CODE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE, FUP_POSTE_VACANT.CODE_FONCTION, FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT, FUP_POSTE_VACANT.NOMBRE_POSTE_SUCCEPTIBLE_VACANT HAVING (FUP_POSTE_VACANT.CODE_ETABLISSEMENT = @CODE_ETABLISSEMENT) AND (FUP_POSTE_VACANT.CODE_FONCTION = @CODE_FONCTION) ORDER BY LIBELLE_SPECIALITE">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropMvmt" DefaultValue="0" Name="CODE_MOUVEMENT" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropEtab" DefaultValue="0" Name="CODE_ETABLISSEMENT" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropFct" DefaultValue="0" Name="CODE_FONCTION" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <asp:Label ID="LabelMsg" runat="server" CssClass="auto-style14"></asp:Label>

                    </div>

                    <%-- Bouton ajouter poste --%>
                    <div class="col-lg-2">
                        <asp:Button ID="BtAddVoeux" runat="server" Text="Ajouter &gt;" CssClass="btn btn-block btn-success" />
                        <br />
                        <asp:Panel ID="PanelRespAdj" runat="server" Visible="false" CssClass="text-danger" Style="background-color: #FFFFFF">
                            <asp:Label ID="Label10" runat="server" Text="Est-tu sûr de vouloir candidater à ce poste d'adjoint?" CssClass="text-danger"></asp:Label>
                            <br />
                            <asp:Button ID="BtOK" runat="server" Text="Oui" CssClass="btn btn-success" />
                            <asp:Button ID="BtAnnuler" runat="server" Text="Annuler" CssClass="btn btn-danger" />
                            <br />
                        </asp:Panel>

                    </div>

                    <%-- 2 liste des poste choisis --%>
                    <div class="col-lg-6">
                        <div class="" style="background-color: #27c24c; padding: 2px; color: #FFFFFF">
                            <%--<span class="badge warning text-warning">2</span>--%>
                            <img alt="" class="auto-style52" src="../Images/orderedList2.png" style="vertical-align: middle" />
                            <span>Les postes selectionnés s&#39;ajoutent dans la liste.</span>
                        </div>
                        <p></p>
                        <div class="table table-responsive">

                            <asp:GridView ID="GridPostesDemandes" runat="server" AutoGenerateColumns="False" DataKeyNames="CODE_ETABLISSEMENT,CODE_FONCTION,CODE_SPECIALITE,CODE_MOUVEMENT,IDENTIFIANT_ENSEIGNANT,CODE_ANNEE" DataSourceID="SqlDemandes" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" CssClass="table" ShowHeader="False" Style="font-size: x-small">
                                <%--<SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                        <SortedDescendingHeaderStyle BackColor="#242121" />--%>
                                <FooterStyle BackColor="#669900" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#669900" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#669900" ForeColor="White" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:CommandField DeleteImageUrl="~/Images/mirador/del.png" ShowDeleteButton="True" />
                                    <asp:BoundField DataField="CODE_ETABLISSEMENT" HeaderText="CODE_ETABLISSEMENT" ReadOnly="True" SortExpression="CODE_ETABLISSEMENT" Visible="False" />
                                    <asp:BoundField DataField="CODE_FONCTION" HeaderText="CODE_FONCTION" ReadOnly="True" SortExpression="CODE_FONCTION" Visible="False" />
                                    <asp:BoundField DataField="CODE_SPECIALITE" HeaderText="CODE_SPECIALITE" ReadOnly="True" SortExpression="CODE_SPECIALITE" Visible="False" />
                                    <asp:BoundField DataField="CODE_MOUVEMENT" HeaderText="CODE_MOUVEMENT" ReadOnly="True" SortExpression="CODE_MOUVEMENT" Visible="False" />
                                    <asp:BoundField DataField="IDENTIFIANT_ENSEIGNANT" HeaderText="IDENTIFIANT_ENSEIGNANT" ReadOnly="True" SortExpression="IDENTIFIANT_ENSEIGNANT" Visible="False" />
                                    <asp:BoundField DataField="CODE_ORDRE_PREFERENCE" HeaderText="CODE_ORDRE_PREFERENCE" SortExpression="CODE_ORDRE_PREFERENCE" Visible="False" />
                                    <asp:BoundField DataField="CODE_ANNEE" HeaderText="CODE_ANNEE" ReadOnly="True" SortExpression="CODE_ANNEE" Visible="False" />
                                    <asp:BoundField DataField="LIBELLE_ORDRE_PREFERENCE" HeaderText="ORDRE" SortExpression="LIBELLE_ORDRE_PREFERENCE">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ETABLISSEMENT" HeaderText="ETABLISSEMENT" SortExpression="ETABLISSEMENT">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LIBELLE_FONCTION" HeaderText="FONCTION" SortExpression="LIBELLE_FONCTION">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="LIBELLE_SPECIALITE" HeaderText="SPECIALITE" SortExpression="LIBELLE_SPECIALITE">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CREE_PAR" HeaderText="CREE_PAR" SortExpression="CREE_PAR" Visible="False">
                                        <ItemStyle Wrap="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="DATE_CREATION" HeaderText="DATE CREATION" SortExpression="DATE_CREATION" Visible="False">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                <PagerSettings Mode="NumericFirstLast" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>

                            <asp:SqlDataSource ID="SqlDemandes" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [FUP_DEMANDE_POSTE_VACANT] WHERE [CODE_ETABLISSEMENT] = @CODE_ETABLISSEMENT AND [CODE_FONCTION] = @CODE_FONCTION AND [CODE_SPECIALITE] = @CODE_SPECIALITE AND [CODE_MOUVEMENT] = @CODE_MOUVEMENT AND [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT AND [CODE_ANNEE] = @CODE_ANNEE" InsertCommand="INSERT INTO [FUP_DEMANDE_POSTE_VACANT] ([CODE_ETABLISSEMENT], [CODE_FONCTION], [CODE_SPECIALITE], [CODE_MOUVEMENT], [IDENTIFIANT_ENSEIGNANT], [CODE_ORDRE_PREFERENCE], [CODE_ANNEE], [CREE_PAR], [DATE_CREATION], [MODIFIE_PAR], [DATE_DERNIER_MODIFICATION]) VALUES (@CODE_ETABLISSEMENT, @CODE_FONCTION, @CODE_SPECIALITE, @CODE_MOUVEMENT, @IDENTIFIANT_ENSEIGNANT, @CODE_ORDRE_PREFERENCE, @CODE_ANNEE, @CREE_PAR, @DATE_CREATION, @MODIFIE_PAR, @DATE_DERNIER_MODIFICATION)" SelectCommand="SELECT FUP_DEMANDE_POSTE_VACANT.CODE_ETABLISSEMENT, FUP_DEMANDE_POSTE_VACANT.CODE_FONCTION, FUP_DEMANDE_POSTE_VACANT.CODE_SPECIALITE, FUP_DEMANDE_POSTE_VACANT.CODE_MOUVEMENT, FUP_DEMANDE_POSTE_VACANT.IDENTIFIANT_ENSEIGNANT, FUP_DEMANDE_POSTE_VACANT.CODE_ORDRE_PREFERENCE, FUP_DEMANDE_POSTE_VACANT.CODE_ANNEE, FUP_DEMANDE_POSTE_VACANT.CREE_PAR, FUP_DEMANDE_POSTE_VACANT.DATE_CREATION, FUP_DEMANDE_POSTE_VACANT.MODIFIE_PAR, FUP_DEMANDE_POSTE_VACANT.DATE_DERNIER_MODIFICATION, ATLAS_SYS_DEF_ALL.code00, FUP_ORDRE_PREFERENCE.LIBELLE_ORDRE_PREFERENCE, ETABLISSEMENT.NOM_ETABLISSEMENT + ' (' + ATLAS_SYS_DEF_ALL.IDEN + ')' AS ETABLISSEMENT, SPECIALITE.LIBELLE_SPECIALITE, FONCTION.LIBELLE_FONCTION FROM FUP_DEMANDE_POSTE_VACANT INNER JOIN ANNEE ON FUP_DEMANDE_POSTE_VACANT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN FUP_ORDRE_PREFERENCE ON FUP_DEMANDE_POSTE_VACANT.CODE_ORDRE_PREFERENCE = FUP_ORDRE_PREFERENCE.CODE_ORDRE_PREFERENCE INNER JOIN ETABLISSEMENT ON FUP_DEMANDE_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 INNER JOIN FONCTION ON FUP_DEMANDE_POSTE_VACANT.CODE_FONCTION = FONCTION.CODE_FONCTION INNER JOIN SPECIALITE ON FUP_DEMANDE_POSTE_VACANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE WHERE (FUP_DEMANDE_POSTE_VACANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) AND (ANNEE.ANNEE_ENCOURS = 1) ORDER BY FUP_ORDRE_PREFERENCE.LIBELLE_ORDRE_PREFERENCE" UpdateCommand="UPDATE [FUP_DEMANDE_POSTE_VACANT] SET [CODE_ORDRE_PREFERENCE] = @CODE_ORDRE_PREFERENCE, [CREE_PAR] = @CREE_PAR, [DATE_CREATION] = @DATE_CREATION, [MODIFIE_PAR] = @MODIFIE_PAR, [DATE_DERNIER_MODIFICATION] = @DATE_DERNIER_MODIFICATION WHERE [CODE_ETABLISSEMENT] = @CODE_ETABLISSEMENT AND [CODE_FONCTION] = @CODE_FONCTION AND [CODE_SPECIALITE] = @CODE_SPECIALITE AND [CODE_MOUVEMENT] = @CODE_MOUVEMENT AND [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT AND [CODE_ANNEE] = @CODE_ANNEE">
                                <DeleteParameters>
                                    <asp:Parameter Name="CODE_ETABLISSEMENT" Type="String" />
                                    <asp:Parameter Name="CODE_FONCTION" Type="String" />
                                    <asp:Parameter Name="CODE_SPECIALITE" Type="String" />
                                    <asp:Parameter Name="CODE_MOUVEMENT" Type="Decimal" />
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="CODE_ETABLISSEMENT" Type="String" />
                                    <asp:Parameter Name="CODE_FONCTION" Type="String" />
                                    <asp:Parameter Name="CODE_SPECIALITE" Type="String" />
                                    <asp:Parameter Name="CODE_MOUVEMENT" Type="Decimal" />
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_ORDRE_PREFERENCE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                    <asp:Parameter Name="CREE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_CREATION" Type="DateTime" />
                                    <asp:Parameter Name="MODIFIE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_DERNIER_MODIFICATION" Type="DateTime" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="CODE_ORDRE_PREFERENCE" Type="Decimal" />
                                    <asp:Parameter Name="CREE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_CREATION" Type="DateTime" />
                                    <asp:Parameter Name="MODIFIE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_DERNIER_MODIFICATION" Type="DateTime" />
                                    <asp:Parameter Name="CODE_ETABLISSEMENT" Type="String" />
                                    <asp:Parameter Name="CODE_FONCTION" Type="String" />
                                    <asp:Parameter Name="CODE_SPECIALITE" Type="String" />
                                    <asp:Parameter Name="CODE_MOUVEMENT" Type="Decimal" />
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                </UpdateParameters>
                            </asp:SqlDataSource>


                        </div>


                        <div style="background-color: #27c24c; color: #FFFFFF">
                            <%--<span class="badge text-warning">3</span>--%>
                            <img alt="" class="auto-style52" src="../Images/orderedList3.png" style="vertical-align: middle" />
                            <span class="">Saisis tes notes pour chaque critère, ligne par ligne.<br />
                            </span>

                        </div>
                        <p class="text-left">
                            Mets 0 (zéro) pour les notes pour lesquelles tu n&#39;as pas de point.<br />
                            Mets une virgule (,) pour les nombres décimaux.
                        </p>


                        <asp:Panel ID="PanelSaisieNote" runat="server">
                            <asp:Button ID="ButtonSaisiNote" runat="server" CssClass="btn btn-success" Text="Saisis tes notes" Width="200px" />

                            <br />
                            <asp:Panel ID="PanelConfirmeSaisieNotes" runat="server" Visible="False">
                                <span class="auto-style14">Attention : dès que tu saisis tes notes, tu ne peux plus modifier les postes que tu as choisis. Veux-tu saisir tes notes?<br />
                                </span>
                                <asp:Button ID="BtOKSaisieNote" runat="server" CssClass="btn btn-success" Text="OK" />
                                <asp:Button ID="BtAnnuleSaisieNote" runat="server" CssClass="btn btn-danger" Text="Annuler" />
                            </asp:Panel>
                        </asp:Panel>

                        <br />
                        <div class="table table-responsive">

                            <asp:GridView ID="GridViewNotes" runat="server" AutoGenerateColumns="False" DataKeyNames="CODE_ANNEE,IDENTIFIANT_ENSEIGNANT,CODE_CRITERE" DataSourceID="SqlNotes" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" CssClass="table" ForeColor="Black" GridLines="Horizontal">

                                <%--<FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />--%>

                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Critère" SortExpression="LIBELLE_CRITERE">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("LIBELLE_CRITERE") %>' ToolTip='<%# Eval("TEXTE_CRITERE") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("LIBELLE_CRITERE") %>' ToolTip='<%# Eval("TEXTE_CRITERE") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" EditText="Saisir" UpdateText="OK" />
                                    <asp:TemplateField HeaderText="Note" SortExpression="NOTE">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBoxNote" runat="server" Text='<%# Bind("NOTE") %>' Width="36px" ToolTip='<%# Eval("Maxi") %>' BackColor="#CCFF33" BorderColor="Black" BorderStyle="Inset"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="TextBoxMaxi" ControlToValidate="TextBoxNote" CssClass="auto-style14" ErrorMessage="Note Maxi!" Operator="LessThanEqual" SetFocusOnError="True" Type="Double"></asp:CompareValidator>
                                            <asp:TextBox ID="TextBoxMaxi" runat="server" Text='<%# Bind("VAL_MAX_CRITERE") %>' Visible="False" Width="27px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("NOTE") %>' ToolTip='<%# Eval("DateS") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CODE_ANNEE" HeaderText="CODE_ANNEE" ReadOnly="True" SortExpression="CODE_ANNEE" Visible="False" />
                                    <asp:BoundField DataField="IDENTIFIANT_ENSEIGNANT" HeaderText="IDENTIFIANT_ENSEIGNANT" SortExpression="IDENTIFIANT_ENSEIGNANT" ReadOnly="True" Visible="False" />
                                    <asp:BoundField DataField="CODE_CRITERE" HeaderText="CODE_CRITERE" ReadOnly="True" SortExpression="CODE_CRITERE" Visible="False" />
                                    <asp:BoundField DataField="CREE_PAR" HeaderText="Saisie par" InsertVisible="False" SortExpression="CREE_PAR" Visible="False" />
                                    <asp:BoundField DataField="DATE_CREATION" HeaderText="Date saisie" InsertVisible="False" SortExpression="DATE_CREATION" Visible="False">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MODIFIE_PAR" HeaderText="Modifié par" InsertVisible="False" SortExpression="MODIFIE_PAR" Visible="False" />
                                    <asp:BoundField DataField="DATE_DERNIER_MODIFICATION" HeaderText="Date modification" SortExpression="DATE_DERNIER_MODIFICATION" Visible="False">
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Columns>

                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                <SortedDescendingHeaderStyle BackColor="#242121" />
                            </asp:GridView>

                            <asp:SqlDataSource ID="SqlNotes" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [FUP_NOTE_ENSEIGNANT_EN_LIGNE] WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT AND [CODE_CRITERE] = @CODE_CRITERE AND [CODE_ANNEE] = @CODE_ANNEE" InsertCommand="INSERT INTO [FUP_NOTE_ENSEIGNANT_EN_LIGNE] ([IDENTIFIANT_ENSEIGNANT], [CODE_CRITERE], [CODE_ANNEE], [NOTE], [CREE_PAR], [DATE_CREATION], [MODIFIE_PAR], [DATE_DERNIER_MODIFICATION]) VALUES (@IDENTIFIANT_ENSEIGNANT, @CODE_CRITERE, @CODE_ANNEE, @NOTE, @CREE_PAR, @DATE_CREATION, @MODIFIE_PAR, @DATE_DERNIER_MODIFICATION)" SelectCommand="SELECT FUP_CRITERE.LIBELLE_CRITERE, FUP_CRITERE.TEXTE_CRITERE, FUP_CRITERE.VAL_MAX_CRITERE, 'Maxi: ' + CAST(FUP_CRITERE.VAL_MAX_CRITERE AS varchar) AS Maxi, FUP_NOTE_ENSEIGNANT_EN_LIGNE.NOTE, FUP_NOTE_ENSEIGNANT_EN_LIGNE.CODE_ANNEE, FUP_NOTE_ENSEIGNANT_EN_LIGNE.IDENTIFIANT_ENSEIGNANT, FUP_NOTE_ENSEIGNANT_EN_LIGNE.CODE_CRITERE, FUP_NOTE_ENSEIGNANT_EN_LIGNE.CREE_PAR, FUP_NOTE_ENSEIGNANT_EN_LIGNE.DATE_CREATION, FUP_NOTE_ENSEIGNANT_EN_LIGNE.MODIFIE_PAR, FUP_NOTE_ENSEIGNANT_EN_LIGNE.DATE_DERNIER_MODIFICATION,
case FUP_NOTE_ENSEIGNANT_EN_LIGNE.DATE_DERNIER_MODIFICATION when null then FUP_NOTE_ENSEIGNANT_EN_LIGNE.DATE_CREATION else FUP_NOTE_ENSEIGNANT_EN_LIGNE.DATE_DERNIER_MODIFICATION end as DateS

 FROM FUP_NOTE_ENSEIGNANT_EN_LIGNE INNER JOIN FUP_CRITERE ON FUP_NOTE_ENSEIGNANT_EN_LIGNE.CODE_CRITERE = FUP_CRITERE.CODE_CRITERE WHERE (FUP_NOTE_ENSEIGNANT_EN_LIGNE.CODE_ANNEE = @CODE_ANNEE) AND (FUP_NOTE_ENSEIGNANT_EN_LIGNE.IDENTIFIANT_ENSEIGNANT = @id_ens) ORDER BY FUP_CRITERE.ORDRE_CRITERE"
                                UpdateCommand="UPDATE FUP_NOTE_ENSEIGNANT_EN_LIGNE SET NOTE = @NOTE, MODIFIE_PAR = @MODIFIE_PAR, DATE_DERNIER_MODIFICATION = GETDATE() WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) AND (CODE_CRITERE = @CODE_CRITERE) AND (CODE_ANNEE = @CODE_ANNEE)">
                                <DeleteParameters>
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_CRITERE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_CRITERE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                    <asp:Parameter Name="NOTE" Type="Single" />
                                    <asp:Parameter Name="CREE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_CREATION" Type="DateTime" />
                                    <asp:Parameter Name="MODIFIE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_DERNIER_MODIFICATION" Type="DateTime" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListAnnee" Name="CODE_ANNEE" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="id_ens" SessionField="id_ens" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="NOTE" Type="Single" />
                                    <asp:SessionParameter Name="MODIFIE_PAR" SessionField="t_matricule" Type="String" />
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_CRITERE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                </UpdateParameters>
                            </asp:SqlDataSource>

                        </div>


                        <div class="">
                            <asp:DropDownList ID="DropDownNoteNull" runat="server" DataSourceID="SqlNotesNull" DataTextField="noteNonSaisie" DataValueField="NbreNull" Enabled="False">
                            </asp:DropDownList>

                            <asp:SqlDataSource ID="SqlNotesNull" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [FUP_NOTE_ENSEIGNANT_EN_LIGNE] WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT AND [CODE_CRITERE] = @CODE_CRITERE AND [CODE_ANNEE] = @CODE_ANNEE" InsertCommand="INSERT INTO [FUP_NOTE_ENSEIGNANT_EN_LIGNE] ([IDENTIFIANT_ENSEIGNANT], [CODE_CRITERE], [CODE_ANNEE], [NOTE], [CREE_PAR], [DATE_CREATION], [MODIFIE_PAR], [DATE_DERNIER_MODIFICATION]) VALUES (@IDENTIFIANT_ENSEIGNANT, @CODE_CRITERE, @CODE_ANNEE, @NOTE, @CREE_PAR, @DATE_CREATION, @MODIFIE_PAR, @DATE_DERNIER_MODIFICATION)" SelectCommand="SELECT IDENTIFIANT_ENSEIGNANT, COUNT(CODE_CRITERE) AS NbreNull,

cast (ISNULL(COUNT(CODE_CRITERE), 0) as varchar) + ' Notes non saisies' as noteNonSaisie,
 CODE_ANNEE FROM FUP_NOTE_ENSEIGNANT_EN_LIGNE WHERE (NOTE IS NULL) GROUP BY IDENTIFIANT_ENSEIGNANT, NOTE, CODE_ANNEE HAVING (IDENTIFIANT_ENSEIGNANT = @id_ens) AND (CODE_ANNEE = @CODE_ANNEE)"
                                UpdateCommand="UPDATE FUP_NOTE_ENSEIGNANT_EN_LIGNE SET NOTE = @NOTE, MODIFIE_PAR = @MODIFIE_PAR, DATE_DERNIER_MODIFICATION = GETDATE() WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) AND (CODE_CRITERE = @CODE_CRITERE) AND (CODE_ANNEE = @CODE_ANNEE)">
                                <DeleteParameters>
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_CRITERE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_CRITERE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                    <asp:Parameter Name="NOTE" Type="Single" />
                                    <asp:Parameter Name="CREE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_CREATION" Type="DateTime" />
                                    <asp:Parameter Name="MODIFIE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_DERNIER_MODIFICATION" Type="DateTime" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="id_ens" SessionField="id_ens" />
                                    <asp:ControlParameter ControlID="DropDownListAnnee" Name="CODE_ANNEE" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="NOTE" Type="Single" />
                                    <asp:SessionParameter Name="MODIFIE_PAR" SessionField="t_matricule" Type="String" />
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                    <asp:Parameter Name="CODE_CRITERE" Type="Decimal" />
                                    <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>

                    <div class="">
                        <p></p>

                        <asp:GridView ID="GridViewSupprimeNote" runat="server" GridLines="None" AutoGenerateColumns="False" DataSourceID="SqlSupprimeNote" ShowHeader="False">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CssClass="text-warning" CommandName="Delete" Text="Clique ici si tu veux enlever tes notes et refaire tes choix."></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                        <asp:SqlDataSource ID="SqlSupprimeNote" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM FUP_NOTE_ENSEIGNANT_EN_LIGNE FROM FUP_NOTE_ENSEIGNANT_EN_LIGNE INNER JOIN ANNEE ON FUP_NOTE_ENSEIGNANT_EN_LIGNE.CODE_ANNEE = ANNEE.CODE_ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_NOTE_ENSEIGNANT_EN_LIGNE.IDENTIFIANT_ENSEIGNANT = @idens)" SelectCommand="SELECT DISTINCT FUP_NOTE_ENSEIGNANT_EN_LIGNE.IDENTIFIANT_ENSEIGNANT AS SUPPRIMER FROM FUP_NOTE_ENSEIGNANT_EN_LIGNE INNER JOIN ANNEE ON FUP_NOTE_ENSEIGNANT_EN_LIGNE.CODE_ANNEE = ANNEE.CODE_ANNEE LEFT OUTER JOIN FUP_DOSSIER_CANDIDATURE ON FUP_NOTE_ENSEIGNANT_EN_LIGNE.IDENTIFIANT_ENSEIGNANT = FUP_DOSSIER_CANDIDATURE.IDENTIFIANT_ENSEIGNANT WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_NOTE_ENSEIGNANT_EN_LIGNE.IDENTIFIANT_ENSEIGNANT = @idens) AND (FUP_DOSSIER_CANDIDATURE.IDENTIFIANT_ENSEIGNANT IS NULL)">
                            <DeleteParameters>
                                <asp:SessionParameter Name="idens" SessionField="id_ens" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="idens" SessionField="id_ens" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                    </div>

                    <br />
                    </div>
                </div>

                <%-- Validation Note --%>
                <div class="col-md-12">

                    <asp:Panel ID="PanelValide" runat="server">
                        <div style="background-color: #FF9900; padding: 2px; color: #FFFFFF">
                            <%--<span class="badge text-warning">4</span>--%>
                            <img alt="" class="auto-style52" src="../Images/orderedList4.png" style="vertical-align: middle" />
                            <span>Valide et clôture ta candidature. </span>
                        </div>
                        <p></p>
                        <asp:Button ID="BtValidChoix" CssClass="btn btn-success" runat="server" Text="Valide ta candidature" />
                    </asp:Panel>

                    <asp:Panel ID="PanelValidChoix" runat="server" Visible="false">
                        <p class="text-danger">
                            Veux-tu vraiment valider et clôturer ta candidature?
                    <br />
                            Aprés la validation, il te sera impossible de revenir sur tes choix et tes notes.
                        </p>

                        <asp:DetailsView ID="DetailsViewValideChoix" runat="server" AutoGenerateRows="False" BorderStyle="None" GridLines="None" DataKeyNames="DOSSIER_CANDIDATURE_ID" DataSourceID="SqlDossier" DefaultMode="Insert">
                            <Fields>
                                <asp:BoundField DataField="DOSSIER_CANDIDATURE_ID" HeaderText="DOSSIER_CANDIDATURE_ID" InsertVisible="False" ReadOnly="True" SortExpression="DOSSIER_CANDIDATURE_ID" Visible="False" />
                                <asp:BoundField DataField="IDENTIFIANT_ENSEIGNANT" HeaderText="IDENTIFIANT_ENSEIGNANT" SortExpression="IDENTIFIANT_ENSEIGNANT" Visible="False" />
                                <asp:BoundField DataField="CODE_ANNEE" HeaderText="CODE_ANNEE" SortExpression="CODE_ANNEE" Visible="False" />
                                <asp:TemplateField ShowHeader="False">
                                    <InsertItemTemplate>
                                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandName="Insert" Text="OK" CssClass="btn btn-success" />
                                        &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" OnClick="Button2_Click1" Text="Annuler" CssClass="btn btn-danger" />
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="Button4" runat="server" CausesValidation="False" CommandName="New" Text="Nouveau" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>

                        <asp:SqlDataSource ID="SqlDossier" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [FUP_DOSSIER_CANDIDATURE] WHERE [DOSSIER_CANDIDATURE_ID] = @DOSSIER_CANDIDATURE_ID" InsertCommand="INSERT INTO [FUP_DOSSIER_CANDIDATURE] ([IDENTIFIANT_ENSEIGNANT], [CODE_ANNEE]) VALUES (@IDENTIFIANT_ENSEIGNANT, @CODE_ANNEE)" SelectCommand="SELECT [DOSSIER_CANDIDATURE_ID], [IDENTIFIANT_ENSEIGNANT], [CODE_ANNEE] FROM [FUP_DOSSIER_CANDIDATURE]" UpdateCommand="UPDATE [FUP_DOSSIER_CANDIDATURE] SET [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT, [CODE_ANNEE] = @CODE_ANNEE WHERE [DOSSIER_CANDIDATURE_ID] = @DOSSIER_CANDIDATURE_ID">
                            <DeleteParameters>
                                <asp:Parameter Name="DOSSIER_CANDIDATURE_ID" Type="Decimal" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:SessionParameter Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownListAnnee" Name="CODE_ANNEE" PropertyName="SelectedValue" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                <asp:Parameter Name="DOSSIER_CANDIDATURE_ID" Type="Decimal" />
                            </UpdateParameters>
                        </asp:SqlDataSource>

                        <asp:SqlDataSource ID="SqlDossierNum" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [FUP_DOSSIER_CANDIDATURE] WHERE [DOSSIER_CANDIDATURE_ID] = @DOSSIER_CANDIDATURE_ID" InsertCommand="INSERT INTO [FUP_DOSSIER_CANDIDATURE] ([IDENTIFIANT_ENSEIGNANT], [CODE_ANNEE]) VALUES (@IDENTIFIANT_ENSEIGNANT, @CODE_ANNEE)" SelectCommand="SELECT FUP_DOSSIER_CANDIDATURE.DOSSIER_CANDIDATURE_ID, FUP_DOSSIER_CANDIDATURE.NUMERO_DOSSIER_CANDIDATURE FROM FUP_DOSSIER_CANDIDATURE INNER JOIN ANNEE ON FUP_DOSSIER_CANDIDATURE.CODE_ANNEE = ANNEE.CODE_ANNEE WHERE (FUP_DOSSIER_CANDIDATURE.IDENTIFIANT_ENSEIGNANT = @id_ens) AND (ANNEE.ANNEE_ENCOURS = 1)" UpdateCommand="UPDATE [FUP_DOSSIER_CANDIDATURE] SET [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT, [CODE_ANNEE] = @CODE_ANNEE WHERE [DOSSIER_CANDIDATURE_ID] = @DOSSIER_CANDIDATURE_ID">
                            <DeleteParameters>
                                <asp:Parameter Name="DOSSIER_CANDIDATURE_ID" Type="Decimal" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:SessionParameter Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownListAnnee" Name="CODE_ANNEE" PropertyName="SelectedValue" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="id_ens" SessionField="id_ens" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                <asp:Parameter Name="CODE_ANNEE" Type="String" />
                                <asp:Parameter Name="DOSSIER_CANDIDATURE_ID" Type="Decimal" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

