<%@ Page Title="Voeux" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="modifdonnees.aspx.vb" Inherits="candidature_candidature" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" runat="Server">
    <style>
        #Contenu_GridView1 {
            font-size: 12px;
        }

        #Contenu_DropDownSystem {
            visibility: hidden;
            display: none;
        }

        select {
            height: auto !important;
            padding: 0px !important;
            width: 150px !important;
            font-size: small !important;
            line-height: normal !important;
        }
    </style>
    <section id="desc2" class="pic-text pic-text text-center">
        <div class="container">
            <div class="row">

                <!-- LEFT PIC-->
                <div class="col-md-3">
                    <div>
                        <h4>Correction</h4>
                        <asp:Label ID="LabelBonjour" runat="server" Text="Bonjour"></asp:Label>
                        <br />
                        <p>Cette page te permet de corriger tes données qui seront vérifiées pendant l&#39;exploitation des fiches et avant attribution définitive.</p>


                    </div>
                    <div class="mockup-mobile">
                        <img alt="" class="img-responsive center-block" src="../Images/mirador/candidaturecoche.jpg" />
                    </div>
                </div>

                <div class="col-md-9 text-left">
                    <div class="col-md-12">
                        <asp:Label ID="LabelError" runat="server" Text="" CssClass="text-danger"></asp:Label>
                     
                         <br /><br />
                    </div>
                   
                    <div class="col-md-12">
                        <p class="badge alert-warning">Correction</p>
                        <asp:HyperLink ID="HyperLink1" CssClass="text-right right text-info" runat="server" NavigateUrl="~/voeux/voeux_o.aspx">Retour à la candidature</asp:HyperLink>
                        <asp:DropDownList ID="DropDownListAnnee" runat="server" DataSourceID="SqlAnnee" DataTextField="LIBELLE_ANNEE" DataValueField="CODE_ANNEE" Visible="False">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlAnnee" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT [CODE_ANNEE], [LIBELLE_ANNEE] FROM [ANNEE] WHERE ([ANNEE_ENCOURS] = @ANNEE_ENCOURS)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="true" Name="ANNEE_ENCOURS" Type="Boolean" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>

                    <div class="col-md-12">
                        <p>
                            Systeme:
                                            <asp:Label ID="LabelStructure" runat="server" CssClass="danger zoomOutRight"></asp:Label>
                        </p>
                        <asp:SqlDataSource ID="SqlSysteme" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ETABLISSEMENT.CODE_SYSTEME, SYSTEME_ENSEIGNEMENT.LIBELLE_SYSTEME FROM ETABLISSEMENT INNER JOIN SYSTEME_ENSEIGNEMENT ON ETABLISSEMENT.CODE_SYSTEME = SYSTEME_ENSEIGNEMENT.CODE_SYSTEME WHERE (ETABLISSEMENT.CODE_ETABLISSEMENT = @CODE_ETABLISSEMENT)">
                            <SelectParameters>
                                <asp:SessionParameter Name="CODE_ETABLISSEMENT" SessionField="c_etab" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:DropDownList ID="DropDownSystem" runat="server" DataSourceID="SqlSysteme" DataTextField="LIBELLE_SYSTEME" DataValueField="CODE_SYSTEME" Enabled="False" CssClass="form-control">
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-12">
                        <asp:Label ID="LabelMsg" runat="server" CssClass="text-danger"></asp:Label>
                    </div>

                    <div class="col-md-12">
                        <asp:Label ID="LabelMsg0" runat="server" CssClass="text-danger">Attention: quiconque fournit de fausses informations s&#39;expose à de lourdes sanctions!</asp:Label>
                    </div>

                    <div class="panel-body col-md-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BorderStyle="None" CssClass="table" DataKeyNames="IDENTIFIANT_ENSEIGNANT" DataSourceID="SqlEns" ForeColor="Black" GridLines="None">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-Wrap="false">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="OK" CssClass="btn btn-success btn-xs"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Annuler" CssClass=" btn btn-default btn-xs"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Modifier" CssClass="btn btn-success btn-xs"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="IDENTIFIANT_ENSEIGNANT" HeaderText="IDENTIFIANT_ENSEIGNANT" InsertVisible="False" ReadOnly="True" SortExpression="IDENTIFIANT_ENSEIGNANT" Visible="False" />
                                    <asp:BoundField DataField="MATRICULE_ENSEIGNANT" HeaderText="MATRICULE" ReadOnly="True" SortExpression="MATRICULE_ENSEIGNANT" />
                                    <asp:BoundField DataField="NOM_ENSEIGNANT" HeaderText="NOM" ReadOnly="True" SortExpression="NOM_ENSEIGNANT" />
                                    <asp:BoundField DataField="PRENOMS_ENSEIGNANT" HeaderText="PRENOM" ReadOnly="True" SortExpression="PRENOMS_ENSEIGNANT" />
                                    <asp:BoundField DataField="SEXE_ENSEIGNANT" HeaderText="SEXE" ReadOnly="True" SortExpression="SEXE_ENSEIGNANT" />
                                    <asp:BoundField DataField="DATE_NAISS_ENSEIGNANT" DataFormatString="{0:d}" HeaderText="DATE NAISS" ReadOnly="True" SortExpression="DATE_NAISS_ENSEIGNANT" />

                                    <asp:TemplateField HeaderText="CORPS" SortExpression="CODE_CORPS">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlCorpsSysteme" DataTextField="LIBELLE_CORPS" DataValueField="CODE_CORPS" SelectedValue='<%# Bind("CODE_CORPS") %>' CssClass="form-control" Width="150">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlCorpsSysteme" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT CORPS.CODE_CORPS, CORPS.LIBELLE_CORPS FROM CORPS INNER JOIN CORPS_SYSTEME ON CORPS.CODE_CORPS = CORPS_SYSTEME.CODE_CORPS WHERE (CORPS_SYSTEME.CODE_SYSTEME = @CODE_SYSTEME) UNION SELECT NULL AS CODE_CORPS, ' ' AS LIBELLE_CORPS UNION SELECT CORPS.CODE_CORPS, CORPS.LIBELLE_CORPS FROM ENSEIGNANT INNER JOIN CORPS ON ENSEIGNANT.CODE_CORPS = CORPS.CODE_CORPS WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) ORDER BY CORPS.LIBELLE_CORPS">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownSystem" Name="CODE_SYSTEME" PropertyName="SelectedValue" />
                                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("LIBELLE_CORPS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="GRADE" SortExpression="CODE_GRADE">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlGrade" DataTextField="LIBELLE_GRADE" DataValueField="CODE_GRADE" SelectedValue='<%# Bind("CODE_GRADE") %>' CssClass="form-control">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlGrade" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT [CODE_GRADE], [LIBELLE_GRADE] FROM [GRADE] UNION SELECT null  CODE_GRADE, ' ' LIBELLE_GRADE ORDER BY [LIBELLE_GRADE]"></asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("LIBELLE_GRADE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="DIPLOME ACA" SortExpression="CODE_DIPLOME">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="SqlDipAcaSysteme" DataTextField="LIBELLE_DIPLOME" DataValueField="CODE_DIPLOME" SelectedValue='<%# Bind("CODE_DIPLOME") %>' CssClass="form-control">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDipAcaSysteme" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT DIPLOME_ACADEMIQUE.CODE_DIPLOME, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME FROM DIPLOME_ACADEMIQUE INNER JOIN DIPLOME_ACADEMIQUE_SYSTEME ON DIPLOME_ACADEMIQUE.CODE_DIPLOME = DIPLOME_ACADEMIQUE_SYSTEME.CODE_DIPLOME WHERE (DIPLOME_ACADEMIQUE_SYSTEME.CODE_SYSTEME = @CODE_SYSTEME) UNION SELECT NULL CODE_DIPLOME, ' ' LIBELLE_DIPLOME UNION SELECT DIPLOME_ACADEMIQUE.CODE_DIPLOME, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME FROM ENSEIGNANT INNER JOIN DIPLOME_ACADEMIQUE ON ENSEIGNANT.CODE_DIPLOME = DIPLOME_ACADEMIQUE.CODE_DIPLOME WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ISNULL(@IDENTIFIANT_ENSEIGNANT, '0')) ORDER BY DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownSystem" Name="CODE_SYSTEME" PropertyName="SelectedValue" />
                                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("LIBELLE_DIPLOME") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="DIPLOME PROF" SortExpression="CODE_DIPLOME_PROFESSIONNEL">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlDiplomeProfSysteme" DataTextField="LIBELLE_DIPLOME_PROFESSIONNEL" DataValueField="CODE_DIPLOME_PROFESSIONNEL" SelectedValue='<%# Bind("CODE_DIPLOME_PROFESSIONNEL") %>' CssClass="form-control">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDiplomeProfSysteme" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL FROM DIPLOME_PROFESSIONNEL INNER JOIN DIPLOME_PROFESSIONNEL_SYSTEME ON DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL_SYSTEME.CODE_DIPLOME_PROFESSIONNEL WHERE (DIPLOME_PROFESSIONNEL_SYSTEME.CODE_SYSTEME = @CODE_SYSTEME) UNION SELECT NULL AS CODE_DIPLOME_PROFESSIONNEL, ' ' AS LIBELLE_DIPLOME_PROFESSIONNEL UNION SELECT DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL FROM ENSEIGNANT INNER JOIN DIPLOME_PROFESSIONNEL ON ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) ORDER BY DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownSystem" Name="CODE_SYSTEME" PropertyName="SelectedValue" />
                                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("LIBELLE_DIPLOME_PROFESSIONNEL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="FONCTION" SortExpression="CODE_FONCTION">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="SqlFctSysteme" DataTextField="LIBELLE_FONCTION" DataValueField="CODE_FONCTION" SelectedValue='<%# Bind("CODE_FONCTION") %>' CssClass="form-control">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlFctSysteme" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT FONCTION.CODE_FONCTION, FONCTION.LIBELLE_FONCTION FROM FONCTION INNER JOIN FONCTION_SYSTEME ON FONCTION.CODE_FONCTION = FONCTION_SYSTEME.CODE_FONCTION WHERE (FONCTION_SYSTEME.CODE_SYSTEME = @CODE_SYSTEME) UNION SELECT NULL AS CODE_FONCTION, ' ' AS LIBELLE_FONCTION UNION SELECT FONCTION.CODE_FONCTION, FONCTION.LIBELLE_FONCTION FROM ENSEIGNANT INNER JOIN FONCTION ON ENSEIGNANT.CODE_FONCTION = FONCTION.CODE_FONCTION WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT) ORDER BY FONCTION.LIBELLE_FONCTION">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownSystem" Name="CODE_SYSTEME" PropertyName="SelectedValue" />
                                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("LIBELLE_FONCTION") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="SPECIALITE" SortExpression="CODE_SPECIALITE">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList7" runat="server" DataSourceID="SqlSpcSysteme" DataTextField="LIBELLE_SPECIALITE" DataValueField="CODE_SPECIALITE" SelectedValue='<%# Bind("CODE_SPECIALITE") %>' CssClass="form-control">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlSpcSysteme" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT SPECIALITE.CODE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE FROM SPECIALITE INNER JOIN SPECIALITE_SYSTEME ON SPECIALITE.CODE_SPECIALITE = SPECIALITE_SYSTEME.CODE_SPECIALITE WHERE (SPECIALITE_SYSTEME.CODE_SYSTEME = @CODE_SYSTEME) UNION SELECT NULL AS CODE_SPECIALITE, ' ' AS LIBELLE_SPECIALITE UNION SELECT SPECIALITE.CODE_SPECIALITE, SPECIALITE.LIBELLE_SPECIALITE FROM ENSEIGNANT INNER JOIN SPECIALITE ON ENSEIGNANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = isnull(@IDENTIFIANT_ENSEIGNANT,'0')) ORDER BY SPECIALITE.LIBELLE_SPECIALITE">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownSystem" Name="CODE_SYSTEME" PropertyName="SelectedValue" />
                                                    <asp:SessionParameter DefaultValue="0" Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("LIBELLE_SPECIALITE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="MODIFIE PAR" InsertVisible="False" SortExpression="NomPrenom" Visible="False">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("NomPrenom") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("NomPrenom") %>' ToolTip='<%# Eval("MOBILE_ENSEIGNANT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="DATE_DERNIERE_MODIFICATION" HeaderText="DATE MODIFICATION" InsertVisible="False" ReadOnly="True" SortExpression="DATE_DERNIERE_MODIFICATION" Visible="False" />
                                </Columns>
                                <FooterStyle />
                                <HeaderStyle CssClass="table table-responsive text-lowercase" />
                                <PagerStyle />
                                <FooterStyle />
                                <SelectedRowStyle />
                                <SortedAscendingCellStyle />
                                <SortedAscendingHeaderStyle />
                                <SortedDescendingCellStyle />
                                <SortedDescendingHeaderStyle />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlEns" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" DeleteCommand="DELETE FROM [ENSEIGNANT] WHERE [IDENTIFIANT_ENSEIGNANT] = @IDENTIFIANT_ENSEIGNANT" InsertCommand="INSERT INTO [ENSEIGNANT] ([CODE_CORPS], [CODE_DIPLOME], [CODE_DIPLOME_PROFESSIONNEL], [CODE_NATIONALITE], [CODE_GRADE], [CODE_FONCTION], [CODE_SPECIALITE], [MODIFIE_PAR], [DATE_DERNIERE_MODIFICATION], [MATRICULE_ENSEIGNANT], [NOM_ENSEIGNANT], [PRENOMS_ENSEIGNANT], [SEXE_ENSEIGNANT], [DATE_NAISS_ENSEIGNANT]) VALUES (@CODE_CORPS, @CODE_DIPLOME, @CODE_DIPLOME_PROFESSIONNEL, @CODE_NATIONALITE, @CODE_GRADE, @CODE_FONCTION, @CODE_SPECIALITE, @MODIFIE_PAR, @DATE_DERNIERE_MODIFICATION, @MATRICULE_ENSEIGNANT, @NOM_ENSEIGNANT, @PRENOMS_ENSEIGNANT, @SEXE_ENSEIGNANT, @DATE_NAISS_ENSEIGNANT)" SelectCommand="SELECT ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.CODE_CORPS, ENSEIGNANT.CODE_DIPLOME, ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL, ENSEIGNANT.CODE_NATIONALITE, ENSEIGNANT.CODE_GRADE, ENSEIGNANT.CODE_FONCTION, ENSEIGNANT.CODE_SPECIALITE, ENSEIGNANT.MODIFIE_PAR, ENSEIGNANT.DATE_DERNIERE_MODIFICATION, ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.NOM_ENSEIGNANT + ' ' + ENSEIGNANT.PRENOMS_ENSEIGNANT AS NomPrenom, ENSEIGNANT.SEXE_ENSEIGNANT, ENSEIGNANT.DATE_NAISS_ENSEIGNANT, CORPS.LIBELLE_CORPS, GRADE.LIBELLE_GRADE, FONCTION.LIBELLE_FONCTION, SPECIALITE.LIBELLE_SPECIALITE, DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL, ENSEIGNANT.MOBILE_ENSEIGNANT FROM ENSEIGNANT INNER JOIN CORPS ON ENSEIGNANT.CODE_CORPS = CORPS.CODE_CORPS LEFT OUTER JOIN GRADE ON ENSEIGNANT.CODE_GRADE = GRADE.CODE_GRADE LEFT OUTER JOIN FONCTION ON ENSEIGNANT.CODE_FONCTION = FONCTION.CODE_FONCTION LEFT OUTER JOIN SPECIALITE ON ENSEIGNANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE LEFT OUTER JOIN DIPLOME_ACADEMIQUE ON ENSEIGNANT.CODE_DIPLOME = DIPLOME_ACADEMIQUE.CODE_DIPLOME LEFT OUTER JOIN DIPLOME_PROFESSIONNEL ON ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL WHERE (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)" UpdateCommand="UPDATE ENSEIGNANT SET CODE_CORPS = @CODE_CORPS, CODE_DIPLOME = @CODE_DIPLOME, CODE_DIPLOME_PROFESSIONNEL = @CODE_DIPLOME_PROFESSIONNEL, CODE_NATIONALITE = @CODE_NATIONALITE, CODE_GRADE = @CODE_GRADE, CODE_FONCTION = @CODE_FONCTION, CODE_SPECIALITE = @CODE_SPECIALITE, MODIFIE_PAR = @MODIFIE_PAR, DATE_DERNIERE_MODIFICATION = GETDATE() WHERE (IDENTIFIANT_ENSEIGNANT = @IDENTIFIANT_ENSEIGNANT)">
                                <DeleteParameters>
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="CODE_CORPS" Type="String" />
                                    <asp:Parameter Name="CODE_DIPLOME" Type="String" />
                                    <asp:Parameter Name="CODE_DIPLOME_PROFESSIONNEL" Type="String" />
                                    <asp:Parameter Name="CODE_NATIONALITE" Type="String" />
                                    <asp:Parameter Name="CODE_GRADE" Type="String" />
                                    <asp:Parameter Name="CODE_FONCTION" Type="String" />
                                    <asp:Parameter Name="CODE_SPECIALITE" Type="String" />
                                    <asp:Parameter Name="MODIFIE_PAR" Type="String" />
                                    <asp:Parameter Name="DATE_DERNIERE_MODIFICATION" Type="DateTime" />
                                    <asp:Parameter Name="MATRICULE_ENSEIGNANT" Type="String" />
                                    <asp:Parameter Name="NOM_ENSEIGNANT" Type="String" />
                                    <asp:Parameter Name="PRENOMS_ENSEIGNANT" Type="String" />
                                    <asp:Parameter Name="SEXE_ENSEIGNANT" Type="String" />
                                    <asp:Parameter Name="DATE_NAISS_ENSEIGNANT" Type="DateTime" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="IDENTIFIANT_ENSEIGNANT" SessionField="id_ens" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="CODE_CORPS" Type="String" />
                                    <asp:Parameter Name="CODE_DIPLOME" Type="String" />
                                    <asp:Parameter Name="CODE_DIPLOME_PROFESSIONNEL" Type="String" />
                                    <asp:Parameter Name="CODE_NATIONALITE" Type="String" />
                                    <asp:Parameter Name="CODE_GRADE" Type="String" />
                                    <asp:Parameter Name="CODE_FONCTION" Type="String" />
                                    <asp:Parameter Name="CODE_SPECIALITE" Type="String" />
                                    <asp:SessionParameter Name="MODIFIE_PAR" SessionField="id_ens" Type="String" />
                                    <asp:Parameter Name="IDENTIFIANT_ENSEIGNANT" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

