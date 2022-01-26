Imports System.Data
Imports System.Data.SqlClient

Partial Class candidature_candidature
    Inherits System.Web.UI.Page

	Public Sub AfficherMessage(ByVal Message As String)
        Try
            Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
         & " alert(""" & Message & """); " _
    & "  </script>")
        Catch ex As Exception
            ex = Nothing
        End Try
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
		If Session("connexion_ok") = 0 Then
			Server.Transfer("~/Default.aspx")
		End If

		If Session("erreur_mod") <> Nothing Then
			LabelError.Text = Session("erreur_mod")
			Session("erreur_mod") = Nothing
		End If

		If Session("PasDeclare") = 1 Then
            AfficherMessage("Ton poste n'a pas été déclaré comme succeptible d'être vacant. Impossible de compétir!")
            Server.Transfer("~/voeux/listemvmt.aspx")
        End If

        Me.LabelBonjour.Text = "Bonjour " & Session("t_prenoms") & " " & Session("t_nom") & "."


        If Session("DejaChoix") = 1 Then
            Me.GridView1.Enabled = False
            Me.LabelMsg.Text = "Impossible de corriger. Au moins un poste est déjà choisi."
        Else
            Me.GridView1.Enabled = True
            Me.LabelMsg.Text = "Tu peux corriger maintenant. Aprés la saisie des postes aucune correction n'est possible."
        End If

		'Procédue pour vérification de candidature possible ou non
		Dim nosf As New NosFonctions()
		Dim periodemvmt As Boolean

		'Modification de données non permise hors période du mouvement.
		periodemvmt = nosf.PeriodeOuvertureMouvement()
		If periodemvmt = False Then
			Server.Transfer("~/voeux/listemvmt.aspx")
		End If

	End Sub

    Protected Sub GridView1_RowUpdated(sender As Object, e As GridViewUpdatedEventArgs) Handles GridView1.RowUpdated
        MajSessionEns()
        'Session("c_spc") = rowEns("code_specialite").ToString
        'Session("c_corps") = rowEns("code_corps").ToString
        'Session("c_etab") = rowEns("code_etablissement").ToString
        'Session("c_fct") = rowEns("code_fonction").ToString

        'MsgBox(GridView1.SelectedRow.Cells(1).Text.ToString)
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged

    End Sub

    Protected Sub MajSessionEns()
        Dim outils As New Outils
        Try


            Dim sqlEns As New SqlCommand("SELECT " _
            & " ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.CODE_ETABLISSEMENT,  ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PASSWORD_VALIDE," _
            & " ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.CODE_CORPS, ENSEIGNANT.CODE_FONCTION,  ENSEIGNANT.CODE_SPECIALITE, ENSEIGNANT.PASSWORD_ENSEIGNANT " _
    & " FROM         ENSEIGNANT " _
    & " WHERE     (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = '" & Session("id_ens") & "')")


            Dim ResultSetEns As DataSet
            'Dim con As New Connect

            ResultSetEns = Outils.RunQuery(sqlEns)

            If ResultSetEns.Tables(0).Rows.Count > 0 Then
              

                Dim rowEns As DataRow
                For Each rowEns In ResultSetEns.Tables(0).Rows
                    Try
                        
                        Session("c_spc") = rowEns("code_specialite").ToString
                        Session("c_corps") = rowEns("code_corps").ToString
                        'Session("c_etab") = rowEns("code_etablissement").ToString
                        Session("c_fct") = rowEns("code_fonction").ToString
                        


                    Catch ex As Exception

                    End Try
                Next

            End If


        Catch ex As Exception
            'AfficherMessage(ex.Message.ToString)
        End Try

    End Sub

	Protected Sub DropDownSystem_DataBound(sender As Object, e As EventArgs) Handles DropDownSystem.DataBound
		Me.LabelStructure.Text = Me.DropDownSystem.SelectedItem.ToString
	End Sub

	Protected Sub Page_Error(sender As Object, e As EventArgs) Handles Me.Error
		Dim exc As Exception = Server.GetLastError
		Session("erreur_mod") = exc.Message
		Response.Redirect("~/voeux/modifdonnees.aspx")
	End Sub
End Class
