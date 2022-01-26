<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="recherche_miroir.aspx.vb" Inherits="Account_Message2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" runat="Server">
    <section id="desc2" class="pic-text pic-text text-left">
        <div class="container">
            <div class="row">
                <div data-wow-offset="15" data-wow-duration="1.2s" class="col-md-2 wow fadeInLeft animated">
                    <div class="mockup-mobile">
                        <img alt="" class="img-circle" src="../../Images/mirador/search.jpg" />
                        <h4>Rechercher des postes dans le miroir</h4>


                    </div>
                </div>
                <div class="col-lg-10">
                    <div class="col-md-12">
                        <p>
                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/voeux/voeux_o.aspx">Retour aux candidatures</asp:HyperLink></p>
                    </div>
                    <div class="col-md-12">

                        <div class="col-md-3">
                            <asp:DropDownList ID="DropDownListFonction" runat="server" DataSourceID="SqlListFonctions" DataTextField="LIBELLE_FONCTION" DataValueField="CODE_FONCTION" CssClass="form-control" AutoPostBack="True">
                            </asp:DropDownList>

                            <asp:SqlDataSource ID="SqlListFonctions" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT FONCTION.CODE_FONCTION, FONCTION.LIBELLE_FONCTION FROM FONCTION INNER JOIN FUP_POSTE_VACANT ON FONCTION.CODE_FONCTION = FUP_POSTE_VACANT.CODE_FONCTION INNER JOIN FUP_MOUVEMENT ON FUP_POSTE_VACANT.CODE_MOUVEMENT = FUP_MOUVEMENT.CODE_MOUVEMENT INNER JOIN ANNEE ON FUP_MOUVEMENT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN FUP_TYPE_MOUVEMENT_FONCTION ON FONCTION.CODE_FONCTION = FUP_TYPE_MOUVEMENT_FONCTION.CODE_FONCTION INNER JOIN FUP_TYPE_MOUVEMENT ON FUP_TYPE_MOUVEMENT_FONCTION.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT WHERE (FONCTION.CODE_FONCTION &lt;&gt; N'013') AND (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_TYPE_MOUVEMENT.TYPE_MOUVEMENT_OUVERT = 1) GROUP BY FONCTION.CODE_FONCTION, FONCTION.LIBELLE_FONCTION HAVING (FONCTION.CODE_FONCTION &lt;&gt; N'013') UNION SELECT NULL AS CODE_FONCTION, ' Choisir une fonction' AS LIBELLE_FONCTION ORDER BY FONCTION.LIBELLE_FONCTION"></asp:SqlDataSource>
                        </div>

                        <div class="col-md-3">
                            <asp:DropDownList ID="DropDownListSpécialite" runat="server" DataSourceID="SqlListeSpecialite" DataTextField="LIBELLE_SPECIALITE" DataValueField="CODE_SPECIALITE" Font-Overline="False" ToolTip="Sélectionnez la spécialité " CssClass="form-control" SelectionMode="multiple" AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlListeSpecialite" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT SPECIALITE.CODE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE FROM SPECIALITE INNER JOIN FUP_POSTE_VACANT ON SPECIALITE.CODE_SPECIALITE = FUP_POSTE_VACANT.CODE_SPECIALITE INNER JOIN FUP_MOUVEMENT ON FUP_POSTE_VACANT.CODE_MOUVEMENT = FUP_MOUVEMENT.CODE_MOUVEMENT INNER JOIN ANNEE ON FUP_MOUVEMENT.CODE_ANNEE = ANNEE.CODE_ANNEE WHERE (ANNEE.ANNEE_ENCOURS = 1) AND (FUP_POSTE_VACANT.CODE_FONCTION = @CODE_FONCTION) GROUP BY SPECIALITE.CODE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE ORDER BY SPECIALITE.LIBELLE_SPECIALITE">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListFonction" Name="CODE_FONCTION" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <div class="col-md-3">
                            <asp:DropDownList ID="DropDownListIA" runat="server" AutoPostBack="True" DataSourceID="SqlIA" DataTextField="IA" DataValueField="code06" CssClass="form-control">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlIA" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT code06, IA FROM ATLAS_SYS_DEF_ALL GROUP BY code06, IA HAVING (IA &lt;&gt; N'Niveau central (15eme Région)') UNION SELECT NULL AS code06, ' Choisir votre IA...' AS IA ORDER BY IA"></asp:SqlDataSource>
                        </div>

                        <div class="col-md-3">
                            <asp:DropDownList ID="DropDownListIEF" runat="server" AutoPostBack="True" DataSourceID="SqlIEF" DataTextField="IEF" DataValueField="code04" CssClass="form-control">
                            </asp:DropDownList>

                            <asp:SqlDataSource ID="SqlIEF" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT code04, IDEN AS IEF FROM ATLAS_SYS_DEF_ALL GROUP BY code04, IDEN, code06 HAVING (code06 = @code06) 
UNION SELECT NULL code04, ' Choisir votre IEF...' as IEF
ORDER BY IEF">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListIA" Name="code06" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>

                        <asp:DropDownList ID="DropDownNbrePoste" runat="server" DataSourceID="SqlCountResult" DataTextField="NbrePoste" DataValueField="NbrePoste" Visible="false">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlCountResult" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT count(*) as NbrePoste

FROM ETABLISSEMENT INNER JOIN FUP_POSTE_VACANT ON ETABLISSEMENT.CODE_ETABLISSEMENT = FUP_POSTE_VACANT.CODE_ETABLISSEMENT INNER JOIN FONCTION ON FUP_POSTE_VACANT.CODE_FONCTION = FONCTION.CODE_FONCTION INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 INNER JOIN SPECIALITE ON FUP_POSTE_VACANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE INNER JOIN FUP_MOUVEMENT ON FUP_POSTE_VACANT.CODE_MOUVEMENT = FUP_MOUVEMENT.CODE_MOUVEMENT INNER JOIN ANNEE ON FUP_MOUVEMENT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN SYSTEME_ENSEIGNEMENT ON ETABLISSEMENT.CODE_SYSTEME = SYSTEME_ENSEIGNEMENT.CODE_SYSTEME WHERE (ATLAS_SYS_DEF_ALL.code04 = @code04) AND (FUP_POSTE_VACANT.CODE_SPECIALITE = @CODE_SPECIALITE) AND (FUP_POSTE_VACANT.CODE_FONCTION = @CODE_FONCTION) AND (ANNEE.ANNEE_ENCOURS = 1) AND (NOT (ETABLISSEMENT.NOM_ETABLISSEMENT LIKE N'%-&gt;%')) AND (NOT (ETABLISSEMENT.NOM_ETABLISSEMENT LIKE N'%audit%')) AND (ETABLISSEMENT.CODE_SYSTEME &lt;&gt; N'-99') AND (LTRIM(RTRIM(ETABLISSEMENT.NOM_ETABLISSEMENT)) &lt;&gt; N'') AND (FUP_POSTE_VACANT.CODE_FONCTION &lt;&gt; N'013')">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownListIEF" Name="code04" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListSpécialite" Name="CODE_SPECIALITE" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListFonction" Name="CODE_FONCTION" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />

                    </div>
                </div>

                <div class="col-md-10">
                    <div class="col-md-12">
                        <h4 class="text-success">Résultat de la recherche</h4>
                    </div>
                    <hr />
                    <div class="table table-responsive col-md-12">
                        <asp:GridView ID="GridViewResultMiroir" runat="server" Width="100%" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlSearchMiroir" ForeColor="#333333" GridLines="None" CssClass="table" Font-Size="Small">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="LIBELLE_FONCTION" HeaderText="Fonction" SortExpression="LIBELLE_FONCTION" />
                                <asp:BoundField DataField="LIBELLE_SPECIALITE" HeaderText="Spécialité" SortExpression="LIBELLE_SPECIALITE" />
                                <asp:BoundField DataField="LIBELLE_SYSTEME" HeaderText="Systéme" SortExpression="LIBELLE_SYSTEME">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="localite" HeaderText="Localité" SortExpression="localite">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Etablissement" SortExpression="NOM_ETABLISSEMENT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("NOM_ETABLISSEMENT") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <strong>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("NOM_ETABLISSEMENT") %>'></asp:Label>
                                        </strong>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="NBRE_CLASSE" SortExpression="NBRE_CLASSE" />
                                <asp:TemplateField HeaderText="PV" SortExpression="NOMBRE_POSTE_VACANT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NOMBRE_POSTE_VACANT") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <strong>
                                            <asp:Label ID="Label1" runat="server" CssClass="auto-style11" Text='<%# Bind("NOMBRE_POSTE_VACANT") %>' Visible='<%# Eval("[PV>0]") %>' Width="25px" Style="color: #000000; background-color: #009900"></asp:Label>
                                        </strong>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Right" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PSV" SortExpression="NOMBRE_POSTE_SUCCEPTIBLE_VACANT">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NOMBRE_POSTE_SUCCEPTIBLE_VACANT") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("NOMBRE_POSTE_SUCCEPTIBLE_VACANT") %>' Visible='<%# Eval("[PSV>0]") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:CheckBoxField DataField="POSTE_PRIORITE_FEMME" HeaderText="Priorité femme" SortExpression="POSTE_PRIORITE_FEMME" Visible="False" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#669900" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#669900" Font-Bold="True" ForeColor="White" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle BackColor="#669900" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>

                            <asp:SqlDataSource ID="SqlSearchMiroir" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT DISTINCT ATLAS_SYS_DEF_ALL.IA, ATLAS_SYS_DEF_ALL.IDEN AS IEF, FONCTION.LIBELLE_FONCTION, SPECIALITE.LIBELLE_SPECIALITE, CASE SYSTEME_ENSEIGNEMENT.AFFICHER_NBRE_CLASSE WHEN 1 THEN CAST(ETABLISSEMENT.NB_CLASSE AS varchar) + ' Classes' ELSE '' END AS NBRE_CLASSE, ETABLISSEMENT.NOM_ETABLISSEMENT, FUP_POSTE_VACANT.POSTE_PRIORITE_FEMME, CASE FUP_POSTE_VACANT.POSTE_PRIORITE_FEMME WHEN 1 THEN CAST(FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT AS varchar) + '*' ELSE CAST(FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT AS varchar) + '  ' END AS NOMBRE_POSTE_VACANT, ETABLISSEMENT.NB_CLASSE, SYSTEME_ENSEIGNEMENT.AFFICHER_NBRE_CLASSE, FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT AS Expr1, FUP_POSTE_VACANT.NOMBRE_POSTE_SUCCEPTIBLE_VACANT, CASE FUP_POSTE_VACANT.NOMBRE_POSTE_VACANT WHEN 0 THEN 0 ELSE 1 END AS [PV&gt;0], CASE FUP_POSTE_VACANT.NOMBRE_POSTE_SUCCEPTIBLE_VACANT WHEN 0 THEN 0 ELSE 1 END AS [PSV&gt;0], SYSTEME_ENSEIGNEMENT.LIBELLE_SYSTEME, ISNULL(ATLAS_SYS_DEF_ALL.Commune, '') + ' ' + ISNULL(ATLAS_SYS_DEF_ALL.Arrondissement, '') + ' ' + ISNULL(ATLAS_SYS_DEF_ALL.[Communauté rurale], '') AS localite FROM ETABLISSEMENT INNER JOIN FUP_POSTE_VACANT ON ETABLISSEMENT.CODE_ETABLISSEMENT = FUP_POSTE_VACANT.CODE_ETABLISSEMENT INNER JOIN FONCTION ON FUP_POSTE_VACANT.CODE_FONCTION = FONCTION.CODE_FONCTION INNER JOIN ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 INNER JOIN SPECIALITE ON FUP_POSTE_VACANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE INNER JOIN FUP_MOUVEMENT ON FUP_POSTE_VACANT.CODE_MOUVEMENT = FUP_MOUVEMENT.CODE_MOUVEMENT INNER JOIN ANNEE ON FUP_MOUVEMENT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN SYSTEME_ENSEIGNEMENT ON ETABLISSEMENT.CODE_SYSTEME = SYSTEME_ENSEIGNEMENT.CODE_SYSTEME INNER JOIN FUP_TYPE_MOUVEMENT_FONCTION ON FONCTION.CODE_FONCTION = FUP_TYPE_MOUVEMENT_FONCTION.CODE_FONCTION INNER JOIN FUP_TYPE_MOUVEMENT ON SYSTEME_ENSEIGNEMENT.CODE_SYSTEME = FUP_TYPE_MOUVEMENT.CODE_SYSTEME AND FUP_TYPE_MOUVEMENT_FONCTION.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT WHERE (ATLAS_SYS_DEF_ALL.code04 = @code04) AND (FUP_POSTE_VACANT.CODE_SPECIALITE = @CODE_SPECIALITE) AND (FUP_POSTE_VACANT.CODE_FONCTION = @CODE_FONCTION) AND (ANNEE.ANNEE_ENCOURS = 1) AND (NOT (ETABLISSEMENT.NOM_ETABLISSEMENT LIKE N'%-&gt;%')) AND (NOT (ETABLISSEMENT.NOM_ETABLISSEMENT LIKE N'%audit%')) AND (ETABLISSEMENT.CODE_SYSTEME &lt;&gt; N'-99') AND (LTRIM(RTRIM(ETABLISSEMENT.NOM_ETABLISSEMENT)) &lt;&gt; N'') AND (FUP_POSTE_VACANT.CODE_FONCTION &lt;&gt; N'013') AND (FUP_TYPE_MOUVEMENT.TYPE_MOUVEMENT_OUVERT = 1) ORDER BY ETABLISSEMENT.NOM_ETABLISSEMENT">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListIEF" Name="code04" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownListSpécialite" Name="CODE_SPECIALITE" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="DropDownListFonction" Name="CODE_FONCTION" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                    </div>

                    <div class="col-md-12">
                        <strong>
                            <asp:Label ID="Label3" runat="server" CssClass="auto-style14" Text="Aucun poste pour cette selection" Visible="False"></asp:Label>
                            <br />
                        </strong>
                        <div>
                            Tu peux cliquer sur l&#39;entête de colonne pour trier.
                                <br />
                            Les numéros en bas du tableau permettent d&#39;aller dans les différentes pages de la liste.<br />
                            <br />
                            Les chiffres précédés du signe moins ( - ) correspondent à des surnombres.
                        </div>
                        <div>
                            Les postes vacants, suivis du signe étoile ( * ) sont priorisés pour les femmes.<br />
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/miroirs/PDFMiroirs/Guide-du-Mouvement.pdf" Target="_blank">Pour plus d&#39;informations veuillez consulter le guide du mouvement</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

