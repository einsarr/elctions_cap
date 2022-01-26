Imports System.Data
Imports System.Data.SqlClient
Imports System.Exception

Partial Class candidature_listemvmt
	Inherits System.Web.UI.Page

	Private nosf As New NosFonctions
	Function RunQuery(ByVal sqlQuery As SqlCommand) As DataSet
        Dim connectionString As String
        connectionString = _
            ConfigurationManager.ConnectionStrings _
            ("FUPConnectionString").ConnectionString
        Dim dbConnection As New SqlConnection
        dbConnection.ConnectionString = connectionString
        Dim dbAdapter As New SqlDataAdapter
        dbAdapter.SelectCommand = sqlQuery
        sqlQuery.Connection = dbConnection
        Dim resultsDataSet As DataSet = New DataSet
        Try
            dbAdapter.Fill(resultsDataSet)
        Catch ex As Exception
            LabelMsg.Text = "Impossible de faire cette operation!"
        End Try
        Return resultsDataSet
    End Function

    Protected Sub Page_Error(sender As Object, e As EventArgs) Handles Me.Error
        Dim exc As Exception = Server.GetLastError
        Session("erreur_declaration") = exc.Message
        Response.Redirect("~/voeux/listemvmt.aspx")
    End Sub


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Session("connexion_ok") = 0 Then
            Response.Redirect("~/Account/connexion.aspx")
        Else
			Session("PasDeclare") = 0

            'Procédue pour vérification de candidature possible ou non
            Dim nosFonc As New NosFonctions()
			Dim possibilite As Boolean
			Dim periodemvmt As Boolean

			periodemvmt = nosf.PeriodeOuvertureMouvement()
            If periodemvmt = True Then
                possibilite = nosf.CandidaturePossible(Session("id_ens"))
                If possibilite = True Then
                    Label2.Text = "Les candidatures au mouvement national sont ouvertes. "
                Else
                    Label3.Text = "Les candidatures au mouvement national sont ouvertes. <br /> <span class='text-danger'>Impossible de participer au mouvement.</span>"
                    LabelMsg.Visible = False
                End If
            Else
                'Si la periode de mouvement est dépassée on masque les message de délcaration et on change le lien vers les voeux fermés
                Label2.Text = "Les candidatures au mouvement national sont cloturées."
                LabelMsg.Text = ""
                ImageBtVoeux.PostBackUrl = "~/voeux/voeux_f.aspx"
            End If

            'Déclaration de psv visible ou non en fonction de la periode 
            Dim declarationPSV As Boolean
            declarationPSV = nosf.PeriodedeclarationPSV()
            If declarationPSV = False Then
                DetailsViewDeclareMonPoste.Visible = False
                LinkBtnValider.Visible = False
                LBLDeclaration.Visible = False
            End If

            'Affichage lien vers le formulaire  une famille un toit
            Dim afficher_formulaire As Boolean
			afficher_formulaire = nosf.EigibleToit()
			If afficher_formulaire = False Then
				ImageButton1.Visible = False
				Me.untoit.visible = False
			End If


			Me.LabelBonjour.Text = Session("t_prenoms") & " " & Session("t_nom") & ". Mon dossier en ligne."
            PostulerMvmt()


            'PostulerMvmt()

            'Me.PanelMatricule.Visible = False
            'Me.GridViewCandidat.Visible = False

			Dim AdPSV As Boolean = Adeclarer(Session("id_ens"))
			If AdPSV Then
				DetailsViewDeclareMonPoste.Visible = False
				DetailsViewDeclareMonPoste.Enabled = False
				LinkBtnValider.Visible = False
				Me.LBLDeclaration.Text = "Ton poste est déclaré suscpetible d'etre vacant."
				Me.LBLDeclaration.CssClass = "text-succes"
				Me.LBLDeclaration.ForeColor = System.Drawing.Color.Green
			End If


			'Si on la varible session des erreurs n'est pas vide
			If Session("erreur_declaration") <> Nothing Then
				Me.LBLDeclaration.Text = Session("erreur_declaration")
				Session("erreur_declaration") = Nothing
			End If

		End If


	End Sub

    Protected Sub PostulerMvmt()
       
        'Verifie matricule et déclaration
        Dim sqlPSV As New SqlCommand( _
                         "select ens.matricule_enseignant, ens.identifiant_enseignant, ens.code_specialite, ens.code_fonction, ens.code_mouvement, ens_etab.code_etablissement " & _
                          "from enseignant ens, enseignant_etablissement ens_etab" & _
                            " where ens.matricule_enseignant = '" & Session("t_matricule") & "'" & _
                            "and ens.identifiant_enseignant = ens_etab.identifiant_enseignant " & _
                            " and (ens.declaration_psv = 1 or ens.code_type_poste='002')" & _
                            "union " & _
                            "select ens.matricule_enseignant, ens.identifiant_enseignant, ens.code_specialite, ens.code_fonction, ens.code_mouvement, ens_etab.code_etablissement " & _
                          "from enseignant ens, enseignant_etablissement ens_etab, etablissement etab,systeme_enseignement systeme" & _
                            " where ens.matricule_enseignant = '" & Session("t_matricule") & "'" & _
                            "and ens.identifiant_enseignant = ens_etab.identifiant_enseignant " & _
                            " and etab.code_etablissement = ens_etab.code_etablissement " & _
                            " and etab.code_systeme = systeme.code_systeme " & _
                            "and systeme.systeme_declare_pas = 1 " & _
                             "union " & _
                            "select ens.matricule_enseignant, ens.identifiant_enseignant, ens.code_specialite, ens.code_fonction, ens.code_mouvement, ens_etab.code_etablissement " & _
                          "from enseignant ens, fonction fct , enseignant_etablissement ens_etab " & _
                            " where ens.matricule_enseignant = '" & Session("t_matricule") & "'" & _
                            "and ens.code_fonction = fct.code_fonction " & _
                            "and ens.identifiant_enseignant = ens_etab.identifiant_enseignant " & _
                            " and fct.fonction_declare_pas = 1 ")

        Dim ResultSet As DataSet
        ResultSet = RunQuery(sqlPSV)
        Me.GridViewCandidat.Visible = False
        LabelMsg.Text = ""
        Dim i As Integer
        i = 0
        If ResultSet.Tables(0).Rows.Count > 0 Then
            'Mettre code_specialite en session
			'   LabelMsg.Text = "Les candidatures au mouvement national sont clôturées. Clique sur le bouton Mes candidatures au mouvement pour voir ton dossier.<br>"
            LabelMsg.Text = "Clique sur le bouton Mes candidatures au mouvement pour voir ton dossier.<br>"
            Me.BtOK.Visible = False
        Else
            'LabelMsg.Text = "Bonjour " & Session("t_prenoms") & " " & Session("t_nom") & ". Ton poste n'a pas été déclaré comme succeptible d'être vacant. Impossible de compétir!"
            LabelMsg.Text = "Ton poste n'a pas été déclaré comme susceptible d'être vacant. Impossible de compétir !"

            Me.ImageBtVoeux.Enabled = False
            Session("PasDeclare") = 1


        End If
        Me.LabelMsg.DataBind()
    End Sub

    Protected Sub BtOK_Click(sender As Object, e As EventArgs) Handles BtOK.Click
        PostulerMvmt()
    End Sub

#Region "Quand il déclare son poste SV"
	Protected Sub DetailsViewDeclareMonPoste_ItemUpdated(sender As Object, e As DetailsViewUpdatedEventArgs) Handles DetailsViewDeclareMonPoste.ItemUpdated
		If e.ExceptionHandled Then

			If e.Exception.ToString = Nothing Then
                'On lui affiche le message du poste déclaré
                Me.LBLDeclaration.Text = "Ton poste est déclaré comme susceptible d'être vacant !"

                'On masque le gridView
                DetailsViewDeclareMonPoste.Visible = False
				DetailsViewDeclareMonPoste.Enabled = False
				Me.LinkBtnValider.Visible = False


			Else
				Session("erreur_declaration") = e.Exception.Message
				Response.Redirect("~/voeux/listemvmt.aspx")
				Me.LBLDeclaration.Text = e.Exception.Message
			End If
		Else
            'On affiche le message S'il n'ya aucune erreur
            Me.LBLDeclaration.Text = "Ton poste est déclaré comme susceptible d'être vacant !"
            Me.LBLDeclaration.ForeColor = System.Drawing.Color.Green
			'On masque le gridview
			Me.LinkBtnValider.Visible = False
			DetailsViewDeclareMonPoste.Visible = False
			DetailsViewDeclareMonPoste.Enabled = False

		End If
	End Sub
#End Region

#Region "Fonction qui chercher si l'enseignant à déclarer son poste ou pas"
	Public Function Adeclarer(ByVal idEns As String) As Boolean
		Dim sqlAdeclarerPSV As New SqlCommand("SELECT DECLARATION_PSV FROM ENSEIGNANT WHERE IDENTIFIANT_ENSEIGNANT =" & idEns & "")
		Dim ResultSet As DataSet
		ResultSet = RunQuery(sqlAdeclarerPSV)
		Me.GridViewCandidat.Visible = False
		Dim adcla As Boolean
		If ResultSet.Tables(0).Rows.Count > 0 Then
			Dim rowEns As DataRow
			'Dim dejaInscrit As Boolean
			For Each rowEns In ResultSet.Tables(0).Rows
				Try
					adcla = CBool(rowEns("DECLARATION_PSV").ToString)
				Catch ex As Exception
					'TODO
				End Try
			Next
			If adcla Then
				Return True
			Else
				Return False
			End If
		End If
	End Function

#End Region

#Region "Qand il clique sur annuler apres le message d'avertissement de la déclaration"

	Protected Sub LinkButton2_Click1(sender As Object, e As EventArgs)
		Me.DetailsViewDeclareMonPoste.Visible = False
		Response.Redirect("~/voeux/listemvmt.aspx")

	End Sub
#End Region

#Region "Qand on clique pour la premiere fois pour déclarer son poste"
	Protected Sub LinkBtnValider_Click(sender As Object, e As EventArgs) Handles LinkBtnValider.Click
		Me.LBLDeclaration.Text = ""
		Me.DetailsViewDeclareMonPoste.Visible = True
	End Sub
#End Region


End Class
