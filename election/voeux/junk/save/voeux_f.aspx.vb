Imports System.Data
Imports System.Data.SqlClient

Partial Class candidature_voeux_f
	Inherits System.Web.UI.Page
	Protected dateCloture As DateTime

	Protected Sub DropIA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropIA.SelectedIndexChanged

		Me.DropIEF.DataBind()
		Me.DropEtab.DataBind()
	End Sub

	Protected Sub DropIEF_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropIEF.SelectedIndexChanged
		Me.DropEtab.DataBind()
	End Sub

	Protected Sub DropEtab_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropEtab.SelectedIndexChanged
		Me.DropFct.DataBind()
		If Me.DropFct.Items.Count = 2 Then
			Me.DropFct.SelectedIndex = 1

		End If
		If Session("verif_spc") = False Then
			Me.DropSpc.DataBind()

			If Me.DropSpc.Items.Count = 2 Then
				Me.DropSpc.SelectedIndex = 1

			End If
		End If
	End Sub



	Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

		'''''SORTIR
		'Server.Transfer("~/voeux/listemvmt.aspx")
		'''''SORTIR

		'Procédue pour vérification de candidature possible ou non
		Dim nosFonc As New NosFonctions()

		'On vérouille tous les choix
		VerrouilleChoix()
		Label20.Text = "Les candidatures ont été cloturées le: "
		Label21.Text = ""
		HyperLink1.Visible = False


		Me.GridViewSupprimeNote.DataBind()

		If Session("PasDeclare") = 1 Then
			AfficherMessage("Ton poste n'a pas été déclaré comme succeptible d'être vacant. Impossible de compétir!")

			Server.Transfer("~/voeux/listemvmt.aspx")
		End If

		Me.LabelMsg.Text = ""
		If Session("connexion_ok") = 0 Then
			Server.Transfer("~/Default.aspx")
		End If
		Session("PeutCompetir") = True
        'Me.LabelBonjour.Text = "Bonjour " & Session("t_prenoms") & " " & Session("t_nom") & ". Merci de selectionner successivement tes choix et cliquer sur le bouton Ajouter."
        Me.LabelBonjour.Text = "Bonjour " & Session("t_prenoms") & " " & Session("t_nom") & "."
		Session("verrouilleChoix") = 0

		Me.DropDownNoteNull.Visible = Me.GridViewNotes.PageCount > 0
		Me.BtValidChoix.Visible = Me.GridViewNotes.PageCount > 0

		Me.LabelMsg.Text = ""

		'Si on la varible session des erreurs n'est pas vide
		If Session("erreur_cand") <> Nothing Then
			Me.LabelError.Text = Session("erreur_cand")
			Session("erreur_cand") = Nothing
		End If
		Dim dateMouv As Array = nosFonc.DatesMouvement
		dateCloture = dateMouv(1)
	End Sub

	Protected Sub DropSpc_DataBound(sender As Object, e As EventArgs) Handles DropSpc.DataBound
		Me.BtAddVoeux.Enabled = Session("PeutCompetir") = True
		If Session("verif_spc") = True Then
			Me.BtAddVoeux.Enabled = Session("c_spc") = Me.DropSpc.SelectedValue.ToString

		End If
        'VerifData()
    End Sub


	Protected Sub DropSpc_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropSpc.SelectedIndexChanged
		VerifData()
	End Sub
	Protected Sub VerifData()
        'Verif Peut Competir
        Me.LabelMsg.Text = ""
		Me.BtAddVoeux.Enabled = Session("PeutCompetir") = True


        'Verif Correspondance Specialité
        If Session("verif_spc") = True Then
			Me.BtAddVoeux.Enabled = Session("c_spc") = Me.DropSpc.SelectedValue.ToString
			If Session("c_spc").ToString <> Me.DropSpc.SelectedValue.ToString Then
				Me.LabelMsg.Text = "Impossible de demander cette spécialité!"
			End If
		End If

        'Verif si demande son propre poste
        'Me.LabelMsg.Text = ""
        If Session("c_etab") = DropEtab.SelectedValue.ToString _
		And Session("c_spc") = DropSpc.SelectedValue.ToString _
		And Session("c_fct") = DropFct.SelectedValue.ToString Then
			Me.LabelMsg.Text = "Impossible de demander ton propre poste!"
			Me.BtAddVoeux.Enabled = False
		End If
        'FIN Verif si demande son propre poste


        'Exception Resp. demande Adj

        If DropSpc.SelectedValue.ToString <> "" Then
			Try
				Dim sqlException As New SqlCommand(
					   "SELECT code_type_mouvement from fup_exception_demande " &
					   "where code_type_mouvement = (select code_type_mouvement from fup_mouvement where code_mouvement = '" & Session("c_mvmt") & "')" &
					   " and code_fonction_agent = '" & Session("c_fct") & "'" &
					   " and code_specialite_agent = '" & Session("c_spc") & "'" &
					   " and code_fonction_poste = '" & Me.DropFct.SelectedValue.ToString & "'"
					   )


				Dim ResultSetException As DataSet
				ResultSetException = RunQuery(sqlException)

				If ResultSetException.Tables(0).Rows.Count > 0 Then

					Me.PanelRespAdj.Visible = True
				Else
					Me.PanelRespAdj.Visible = False

				End If
			Catch
			End Try
		End If
        'FIN Exception Resp. demande Adj

    End Sub
	Protected Sub DropFct_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropFct.SelectedIndexChanged
		Me.DropSpc.DataBind()
		If Session("verif_spc") = False Then
			If Me.DropSpc.Items.Count = 2 Then
				Me.DropSpc.SelectedIndex = 1

			End If
		End If
	End Sub

	Protected Sub BtAddVoeux_Click(sender As Object, e As EventArgs) Handles BtAddVoeux.Click



		Try
			Dim sqlInsertVoeux As New SqlCommand("INSERT INTO FUP_DEMANDE_POSTE_VACANT ( " &
												 "CODE_ETABLISSEMENT, " &
												 "CODE_FONCTION, " &
												 "CODE_SPECIALITE, " &
												 "CODE_MOUVEMENT, " &
												 "IDENTIFIANT_ENSEIGNANT," &
												 "CODE_ORDRE_PREFERENCE, " &
												 "CREE_PAR, " &
												 "CODE_ANNEE )" &
												 "SELECT  '" &
												 Me.DropEtab.SelectedValue.ToString & "','" &
												 Me.DropFct.SelectedValue.ToString & "','" &
												 Me.DropSpc.SelectedValue.ToString & "','" &
												 Me.DropMvmt.SelectedValue.ToString & "','" &
												 Session("id_ens") & "','" &
												 Me.DropOrdre.SelectedValue.ToString & "','" &
												 Session("t_matricule") & "'," &
												 "code_annee from annee where annee_encours = 1")






			RunQuery(sqlInsertVoeux)



		Catch ex As Exception

		End Try
		Me.GridPostesDemandes.DataBind()
		Me.DropOrdre.DataBind()
	End Sub

	Function RunQuery(ByVal sqlQuery As SqlCommand) As DataSet
		Dim connectionString As String
		connectionString =
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
            'LabelMsg.Text = "Impossible de faire cette operation!"
        End Try
		Return resultsDataSet
	End Function



	Protected Sub AddNote()
		Try




			Dim sqlInsertNote As New SqlCommand("INSERT INTO FUP_NOTE_ENSEIGNANT_EN_LIGNE ( " &
												 "IDENTIFIANT_ENSEIGNANT, " &
												 "CODE_ANNEE, " &
												 "CODE_CRITERE, " &
												 "CREE_PAR )" &
												 "SELECT   distinct  " &
												 "ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, " &
												 "ANNEE.CODE_ANNEE, " &
												 "FUP_CRITERE_FICHE_NOTATION.CODE_CRITERE, " &
												  "'" & Session("t_matricule").ToString & "'" &
					"FROM         ENSEIGNANT INNER JOIN " &
					  "FUP_DEMANDE_POSTE_VACANT ON ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = FUP_DEMANDE_POSTE_VACANT.IDENTIFIANT_ENSEIGNANT INNER JOIN " &
					  "FUP_MOUVEMENT ON FUP_DEMANDE_POSTE_VACANT.CODE_MOUVEMENT = FUP_MOUVEMENT.CODE_MOUVEMENT INNER JOIN " &
					  "FUP_TYPE_MOUVEMENT ON FUP_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT INNER JOIN " &
					  "FUP_FICHE_MUTATION ON FUP_TYPE_MOUVEMENT.CODE_FICHE_MUTATION = FUP_FICHE_MUTATION.CODE_FICHE_MUTATION INNER JOIN " &
					  "FUP_CRITERE_FICHE_NOTATION ON FUP_FICHE_MUTATION.CODE_FICHE_MUTATION = FUP_CRITERE_FICHE_NOTATION.CODE_FICHE_MUTATION INNER JOIN " &
					  "FUP_CRITERE ON FUP_CRITERE_FICHE_NOTATION.CODE_CRITERE = FUP_CRITERE.CODE_CRITERE INNER JOIN " &
					  "FUP_CRITERE_SEXE ON FUP_CRITERE.CODE_CRITERE = FUP_CRITERE_SEXE.CODE_CRITERE AND " &
					  "ENSEIGNANT.SEXE_ENSEIGNANT = FUP_CRITERE_SEXE.SEXE INNER JOIN " &
					  "ANNEE ON FUP_DEMANDE_POSTE_VACANT.CODE_ANNEE = ANNEE.CODE_ANNEE AND FUP_MOUVEMENT.CODE_ANNEE = ANNEE.CODE_ANNEE " &
					  "WHERE    (ANNEE.ANNEE_ENCOURS = 1)  " &
					  "AND(ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = '" & Session("id_ens").ToString & "')")



			RunQuery(sqlInsertNote)
            'Me.DropDownMvmtPostul.DataBind()
            'Me.GridViewNotation.DataBind()
            Me.PanelSaisieNote.Visible = False
			Me.GridViewNotes.DataBind()

		Catch ex As Exception

		End Try
	End Sub

	Protected Sub GridPostesDemandes_DataBound(sender As Object, e As EventArgs) Handles GridPostesDemandes.DataBound
		DejaChoisiPoste()
	End Sub

	Protected Sub GridPostesDemandes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridPostesDemandes.RowDataBound



	End Sub
	Protected Sub DejaChoisiPoste()
		Me.ButtonSaisiNote.Enabled = Me.GridPostesDemandes.PageCount > 0

		If Me.GridPostesDemandes.PageCount > 0 Then
			Session("DejaChoix") = 1
		Else
			Session("DejaChoix") = 0
		End If

	End Sub


	Protected Sub GridPostesDemandes_RowDeleted(sender As Object, e As GridViewDeletedEventArgs) Handles GridPostesDemandes.RowDeleted
		Me.DropOrdre.DataBind()
	End Sub

	Protected Sub GridPostesDemandes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridPostesDemandes.SelectedIndexChanged
		Me.DropOrdre.DataBind()
	End Sub




	Protected Sub BtOK_Click(sender As Object, e As EventArgs) Handles BtOK.Click
		Me.BtAddVoeux.Enabled = True
		Me.PanelRespAdj.Visible = False
	End Sub

	Protected Sub BtAnnuler_Click(sender As Object, e As EventArgs) Handles BtAnnuler.Click
		Me.PanelRespAdj.Visible = False
	End Sub

	Protected Sub DropOrdre_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropOrdre.SelectedIndexChanged

	End Sub

	Protected Sub DropMvmt_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropMvmt.SelectedIndexChanged
		Me.Session("c_mvmt") = Me.DropMvmt.SelectedValue
		VerifieConcordSpec()
		Me.DropIA.DataBind()
		Me.DropIEF.DataBind()
		Me.DropEtab.DataBind()
	End Sub

	Sub VerifieConcordSpec()


		'Verifie si GradePrioritaire Mouvement
		Dim sqlverif_spc As New SqlCommand("SELECT  FUP_FICHE_MUTATION.VERIF_CONCORDANC_SPC AS verif_spc, CODE_MOUVEMENT " &
"From FUP_MOUVEMENT INNER Join " &
					  "FUP_TYPE_MOUVEMENT On FUP_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT INNER Join " &
					 " FUP_FICHE_MUTATION On FUP_TYPE_MOUVEMENT.CODE_FICHE_MUTATION = FUP_FICHE_MUTATION.CODE_FICHE_MUTATION " &
						" Where FUP_MOUVEMENT.CODE_MOUVEMENT = '" & Me.DropMvmt.SelectedValue.ToString & "'")



		Dim ResultSet As DataSet
		ResultSet = RunQuery(sqlverif_spc)

		Dim i As Integer
		i = 0
		If ResultSet.Tables.Count > 0 Then
			Dim rowGradePrio As DataRow
			For Each rowGradePrio In ResultSet.Tables(0).Rows
				Try

					Session("verif_spc") = rowGradePrio("verif_spc").ToString
					'MsgBox(Session("GradePrio"))
				Catch ex As Exception

				End Try
			Next
		End If
	End Sub

	Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles BtValidChoix.Click
		Try
			If Me.DropDownNoteNull.SelectedValue > 0 Then
				AfficherMessage("Il faut d'abord saisir toutes les notes avant de valider ta candidature. Mets 0 (zéro) pour les notes pour lesquelles tu n'as aucun point.")
			Else

				Me.PanelValidChoix.Visible = True
				Me.BtValidChoix.Visible = False
			End If
		Catch
			Me.PanelValidChoix.Visible = True
			Me.BtValidChoix.Visible = False
		End Try

	End Sub
	Protected Sub DetailsViewValideChoix_DataBinding(sender As Object, e As EventArgs) Handles DetailsViewValideChoix.DataBinding

        'Me.BtValidChoix.Visible = True
    End Sub
	Protected Sub DetailsViewValideChoix_DataBound(sender As Object, e As EventArgs) Handles DetailsViewValideChoix.DataBound

	End Sub

	Protected Sub DetailsViewValideChoix_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles DetailsViewValideChoix.ItemInserted
        'envoi mail
        Dim fon As New NosFonctions
		Dim rstMail As Boolean = fon.MailValidCandidature(Session("id_ens"))


		Me.BtValidChoix.Visible = False
		Me.GridViewDossierNum.Visible = True
		Me.PanelValidChoix.Visible = False
		Me.DetailsViewValideChoix.Dispose()
		Me.GridViewSupprimeNote.Visible = False
		Me.DataBind()
        '   AfficherMessage("Votre candidature au Mouvement national 2014 est bien enregistrée.")


    End Sub
	Protected Sub DetailsViewValideChoix_PageIndexChanging(sender As Object, e As DetailsViewPageEventArgs) Handles DetailsViewValideChoix.PageIndexChanging

	End Sub

	Protected Sub GridViewDossierNum_DataBound(sender As Object, e As EventArgs) Handles GridViewDossierNum.DataBound
        'MsgBox("Ici")

        If Me.GridViewDossierNum.PageCount > 0 Then
            'MsgBox("la")
            VerrouilleChoix()
			Me.GridViewDossierNum.Visible = True
			Me.PanelValidChoix.Visible = False
			Me.PanelValide.Visible = False
			Me.GridViewNotes.Enabled = False
			Me.LabelDepot.Visible = True
			Me.LabelDepot.Text = "Tu dois déposer ta fiche de vœux avec les justificatifs au niveau de ton inspection avant le <b class=""text-warning"">" & dateCloture.AddDays(1).ToString("D") & " à 17h</b>. La commission locale procédera à la validation de ta candidature au mouvement national."
		End If


	End Sub

	Sub VerrouilleChoix()
		Me.BtAddVoeux.Visible = False
		Me.BtValidChoix.Visible = False
		Me.DetailsViewValideChoix.Enabled = False
		Me.BtAddVoeux.Enabled = False
		Me.DropMvmt.Enabled = False
		Me.DropOrdre.Enabled = False
		Me.DropIA.Enabled = False
		Me.DropIEF.Enabled = False
		Me.DropEtab.Enabled = False
		Me.DropFct.Enabled = False
		Me.DropSpc.Enabled = False
		Me.GridPostesDemandes.Enabled = False
		Me.GridViewSupprimeNote.Visible = False
		Me.GridViewNotes.Enabled = False
		Me.BtOKSaisieNote.Visible = False
		Me.ButtonSaisiNote.Visible = False
		Me.DropDownNoteNull.Visible = False
		'Me.PanelValide.Visible = False
		Me.PanelSaisieNote.Visible = False
		Session("verrouilleChoix") = 1
		Me.PanelCorrige.Visible = False
	End Sub

	Protected Sub DetailsViewValideChoix_Unload(sender As Object, e As EventArgs) Handles DetailsViewValideChoix.Unload
		Me.BtValidChoix.Visible = True
		Me.GridViewDossierNum.Visible = False
		Me.PanelValidChoix.Visible = False
        'Me.DataBind()
    End Sub

	Protected Sub Button2_Click1(sender As Object, e As EventArgs)
		Me.BtValidChoix.Visible = True
		Me.GridViewDossierNum.Visible = False
		Me.PanelValidChoix.Visible = False
		Me.DataBind()
	End Sub

	Protected Sub Button6_Click(sender As Object, e As EventArgs) Handles BtAnnuleSaisieNote.Click
		Me.PanelConfirmeSaisieNotes.Visible = False
		Me.ButtonSaisiNote.Visible = True

	End Sub

	Protected Sub Button5_Click(sender As Object, e As EventArgs) Handles ButtonSaisiNote.Click
		If Me.GridPostesDemandes.PageCount > 0 Then
			Me.PanelConfirmeSaisieNotes.Visible = True
			Me.ButtonSaisiNote.Visible = False
			Me.ButtonSaisiNote.Enabled = True
			Me.ButtonSaisiNote.ToolTip = ""
		Else
			Me.ButtonSaisiNote.Enabled = False
			Me.ButtonSaisiNote.ToolTip = "Merci de choisir d'abord tes postes avant de saisir tes notes!"
			AfficherMessage("Merci de choisir d'abord tes postes avant de saisir tes notes!")
		End If


	End Sub

	Protected Sub BtOKSaisieNote_Click(sender As Object, e As EventArgs) Handles BtOKSaisieNote.Click
		AddNote()
		Me.GridViewSupprimeNote.DataBind()
	End Sub

	Protected Sub GridViewNotes_DataBound(sender As Object, e As EventArgs) Handles GridViewNotes.DataBound
		Me.PanelSaisieNote.Visible = Me.GridViewNotes.PageCount <= 0
		If Me.GridViewNotes.PageCount > 0 Then
			VerrouilleChoix()
		End If

	End Sub



	Protected Sub GridViewDossierNum_Disposed(sender As Object, e As EventArgs) Handles GridViewDossierNum.Disposed
		Me.PanelValidChoix.Visible = False
	End Sub

	Public Sub AfficherMessage(ByVal Message As String)
		Try
			Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
		 & " alert(""" & Message & """); " _
	& "  </script>")
		Catch ex As Exception
			ex = Nothing
		End Try
	End Sub

	Protected Sub GridViewNotes_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridViewNotes.RowDataBound
		Me.DropDownNoteNull.Visible = Me.GridViewNotes.PageCount > 0
		Me.BtValidChoix.Visible = Me.GridViewNotes.PageCount > 0
		Me.DropDownNoteNull.DataBind()
	End Sub

	Protected Sub GridViewNotes_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridViewNotes.SelectedIndexChanged

	End Sub

	Protected Sub GridViewSupprimeNote_RowDeleted(sender As Object, e As GridViewDeletedEventArgs) Handles GridViewSupprimeNote.RowDeleted
		Response.Redirect("~/voeux/voeux_o.aspx")
	End Sub


    'Protected Sub ButtonSupprimNote_Click(sender As Object, e As EventArgs) Handles ButtonSupprimNote.Click
    '    'Suppression notes saisie avant cloture dossier
    '    'Verifie si GradePrioritaire Mouvement
    '    Dim sqlGradePrio As New SqlCommand( _
    '                    "SELECT     FUP_FICHE_MUTATION.GRADE_PRIORITAIRE as grade_prioritaire, FUP_MOUVEMENT.CODE_MOUVEMENT " & _
    '                    "FROM         FUP_MOUVEMENT INNER JOIN FUP_TYPE_MOUVEMENT ON FUP_MOUVEMENT.CODE_TYPE_MOUVEMENT = FUP_TYPE_MOUVEMENT.CODE_TYPE_MOUVEMENT INNER JOIN FUP_FICHE_MUTATION ON FUP_TYPE_MOUVEMENT.CODE_FICHE_MUTATION = FUP_FICHE_MUTATION.CODE_FICHE_MUTATION " & _
    '                    "WHERE     FUP_MOUVEMENT.CODE_MOUVEMENT = '" & Me.DropMvmt.SelectedValue.ToString & "'")



    '    Dim ResultSet As DataSet
    '    ResultSet = RunQuery(sqlGradePrio)

    '    Dim i As Integer
    '    i = 0
    '    If ResultSet.Tables.Count > 0 Then
    '        Dim rowGradePrio As DataRow
    '        For Each rowGradePrio In ResultSet.Tables(0).Rows
    '            Try

    '                Session("GradePrio") = rowGradePrio("grade_prioritaire").ToString
    '                'MsgBox(Session("GradePrio"))
    '            Catch ex As Exception

    '            End Try
    '        Next
    '    End If
    'End Sub

    Protected Sub GridViewSupprimeNote_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridViewSupprimeNote.SelectedIndexChanged

	End Sub

	Protected Sub Page_Error(sender As Object, e As EventArgs) Handles Me.Error
		Dim exc As Exception = Server.GetLastError
		Session("erreur_cand") = exc.Message
		Response.Redirect("~/voeux/voeux_o.aspx")
	End Sub
End Class
