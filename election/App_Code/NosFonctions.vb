Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System
Imports System.Globalization
Imports System.Data
Imports System.Net
Imports System.Text

Public Class NosFonctions
    Inherits System.Web.UI.Page
    'Dim sconn As String = "Data Source=localhost;Initial Catalog=FUP;User ID=sirh;Password=sirhacdi"
    Dim sconn As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Private out As New Outils
    'Fonction qui retourne l'année en cours dans la table année
    Public Function AnneeEnCours() As Array
		Dim annee(2) As String
		Try
			Dim sqlAnneEncours As New SqlCommand("SELECT CODE_ANNEE, LIBELLE_ANNEE FROM ANNEE WHERE ANNEE_ENCOURS = 1")

			Dim ResultAnnee As DataSet
			ResultAnnee = out.RunQuery(sqlAnneEncours)
			If ResultAnnee.Tables(0).Rows.Count > 0 Then
				Dim rowAnne As DataRow
				For Each rowAnne In ResultAnnee.Tables(0).Rows
					Try
						annee(0) = rowAnne("LIBELLE_ANNEE").ToString
						annee(1) = rowAnne("CODE_ANNEE").ToString
					Catch ex As Exception
					End Try
				Next
			End If
		Catch ex As Exception

		End Try
		Return annee
	End Function

    'Fonction qui recherche le mail de l'agent 
    Public Function findMail(ByVal id_ens As String) As String
		Dim mail_ens As String = Nothing
		Try
			Dim sqlFindMail As New SqlCommand("SELECT MAIL_ENSEIGNANT from ENSEIGNANT " &
			   " where (IDENTIFIANT_ENSEIGNANT = '" & id_ens & "')")

			Dim ResultMail As DataSet
			ResultMail = out.RunQuery(sqlFindMail)
			If ResultMail.Tables(0).Rows.Count > 0 Then
				Dim rowMail As DataRow
				For Each rowMail In ResultMail.Tables(0).Rows
					Try
						mail_ens = rowMail("MAIL_ENSEIGNANT").ToString
					Catch ex As Exception
					End Try
				Next
			End If
		Catch ex As Exception

		End Try
		Return mail_ens
	End Function

    'Fonction qui envoie le mail de validation de la candidature de l'enseignant
    Public Function MailValidCandidature(ByVal id_ens As String) As Boolean
		Dim numDossier As String
		Dim mail_ens As String = findMail(id_ens)
		Dim annee As Array = AnneeEnCours()
		Dim periode As Array = DatesMouvement()
		Dim findepot As DateTime = periode(1)
        'findepost = findepot.AddDays(1)

		Dim an_cours As String = annee(0)
		Dim c_annee As String = annee(1)
		Dim BodyMessage As String
		Dim SujetMessage As String
		Dim posteDmd As String = PostesChoisis(id_ens)
		Dim rstMail As Boolean = False

		Try
			Dim sqlNumDossier As New SqlCommand("SELECT NUMERO_DOSSIER_CANDIDATURE from FUP_DOSSIER_CANDIDATURE " &
			" where (IDENTIFIANT_ENSEIGNANT ='" & id_ens & "') and (CODE_ANNEE='" & c_annee & "')")
			Dim ResultNumDoss As DataSet
			ResultNumDoss = out.RunQuery(sqlNumDossier)
			If ResultNumDoss.Tables(0).Rows.Count > 0 Then
				Dim rowNumDossier As DataRow
				For Each rowNumDossier In ResultNumDoss.Tables(0).Rows
					Try
						numDossier = rowNumDossier("NUMERO_DOSSIER_CANDIDATURE").ToString
					Catch ex As Exception
					End Try
				Next

                'Sujet du message à envoyé
                SujetMessage = "Candidature Mouvement " & an_cours & " Dossier N°" & numDossier & "."
                'Corps du message à envoyer
                BodyMessage = "</html> " _
        & " <body> " _
        & "   <p> " _
        & "Bonjour " & Session("t_prenoms") & " " & Session("t_nom") & ", Matricule: " & Session("t_matricule") _
        & ".<br /><br />Votre  candidature au Mouvement " & an_cours & " est bien enregistrée sous le N° <b>" & numDossier & "</b>.<br/> " _
        & "Voici la liste des postes que vous avez choisis.<br/><br /> <hr /> " & posteDmd & "<br/><br />" _
        & "Vous devez déposer votre fiche de vœux avec les justificatifs au niveau de votre inspection avant le <b>" & findepot.AddDays(1).ToString("D") & " à 12h.</b><br/><br/> " _
        & "La commission locale procédera à la validation de votre candidature au mouvement.<br/><br/> " _
        & "Equipe Mirador</p>" _
        & "</body> </html> "
				out.EnvoiMail(mail_ens, SujetMessage, BodyMessage)
				Return True
			Else
				Return False
			End If
		Catch ex As Exception
			Return False
		End Try
	End Function

    'Fonction qui cherche les postes demandés par l'enseignant
    Public Function PostesChoisis(ByVal idens As String) As String
		Dim listPost As String = Nothing
		Try
			Dim sqlPosteChoisi As New SqlCommand("SELECT FUP_DEMANDE_POSTE_VACANT.IDENTIFIANT_ENSEIGNANT," _
& "FUP_ORDRE_PREFERENCE.LIBELLE_ORDRE_PREFERENCE," _
& "ETABLISSEMENT.NOM_ETABLISSEMENT + ' (' + ATLAS_SYS_DEF_ALL.IDEN + ')' AS ETABLISSEMENT," _
& " FONCTION.LIBELLE_FONCTION, CASE SPECIALITE.CODE_SPECIALITE WHEN '-99' THEN '' ELSE SPECIALITE.LIBELLE_SPECIALITE END AS LIBELLE_SPECIALITE " _
& " FROM FUP_DEMANDE_POSTE_VACANT INNER JOIN " _
& " ANNEE ON FUP_DEMANDE_POSTE_VACANT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN" _
& " FUP_ORDRE_PREFERENCE ON FUP_DEMANDE_POSTE_VACANT.CODE_ORDRE_PREFERENCE = FUP_ORDRE_PREFERENCE.CODE_ORDRE_PREFERENCE INNER JOIN" _
& " ETABLISSEMENT ON FUP_DEMANDE_POSTE_VACANT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN " _
& " ETABLISSEMENT_REGROUPEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT INNER JOIN" _
& " ATLAS_SYS_DEF_ALL ON ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT = ATLAS_SYS_DEF_ALL.code00 INNER JOIN" _
& " FONCTION ON FUP_DEMANDE_POSTE_VACANT.CODE_FONCTION = FONCTION.CODE_FONCTION INNER JOIN" _
& " SPECIALITE ON FUP_DEMANDE_POSTE_VACANT.CODE_SPECIALITE = SPECIALITE.CODE_SPECIALITE" _
& " WHERE (FUP_DEMANDE_POSTE_VACANT.IDENTIFIANT_ENSEIGNANT = " & idens & ") AND (ANNEE.ANNEE_ENCOURS = 1)" _
& " ORDER BY FUP_ORDRE_PREFERENCE.LIBELLE_ORDRE_PREFERENCE")

			Dim RstPost As DataSet
			RstPost = out.RunQuery(sqlPosteChoisi)
			If RstPost.Tables(0).Rows.Count > 0 Then
				Dim rowPoste As DataRow
				For Each rowPoste In RstPost.Tables(0).Rows
					Try
						listPost += "- " & rowPoste("LIBELLE_ORDRE_PREFERENCE").ToString & " " & rowPoste("ETABLISSEMENT").ToString & " " & rowPoste("LIBELLE_FONCTION").ToString & " " & rowPoste("LIBELLE_SPECIALITE").ToString & ".<br />"
					Catch ex As Exception
					End Try
				Next
			End If
		Catch ex As Exception
			Return "Aucun choix n'a été fait par vous"
		End Try
		Return listPost
	End Function


	Public Function CandidaturePossible(ByVal idens As String) As Boolean

        'Procédue pour vérification de candidature possible ou non
        Dim ids As Boolean
		Dim cloture As Boolean = PeriodeOuvertureMouvement()
		If cloture = True Then
			Using con As New SqlConnection(sconn)
				con.Open()
				Dim cmd As New SqlCommand("SELECT possibilite = dbo.CandidaturePossible(" & Session("id_ens") & ")", con)
				Dim reader As SqlDataReader = cmd.ExecuteReader()

				While reader.Read()
					ids = reader.GetBoolean(0)
					Session("possibilite") = ids
				End While
				con.Close()
				reader.Close()
				If Session("possibilite") = True Then
					Return True
				Else
					Return False
				End If

			End Using
		Else
			Return False
		End If
	End Function

	Public Function PeriodeOuvertureMouvement() As Boolean
		Dim date_ouverture As Date
		Dim date_cloture As Date
		Using con As New SqlConnection(sconn)

			con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT isnull(DATE_OUVERTURE_MOUVEMENT,getdate()+1), isnull(DATE_CLOTURE_MOVUEMENT,getdate()-1) from annee where ANNEE_ENCOURS = 1", con)
			Dim reader As SqlDataReader = cmd.ExecuteReader()

			While reader.Read()
				date_ouverture = reader.GetDateTime(0)
				date_cloture = reader.GetDateTime(1)
			End While
			con.Close()
			reader.Close()
			If date_cloture > Date.Now And Date.Now > date_ouverture Then
				Return True
			Else
				Return False
			End If
		End Using
	End Function

#Region "Verification periode saisie formulaire toit"
	Public Function PeriodeOuvertureToit() As Boolean
		Dim date_ouverture As Date
		Dim date_cloture As Date
		Using con As New SqlConnection(sconn)

			con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT isnull(DATE_OUVERTURE_FICHE_TOIT,getdate()+1), isnull(DATE_FERMETURE_FICHE_TOIT,getdate()-1) from annee where ANNEE_ENCOURS = 1", con)
			Dim reader As SqlDataReader = cmd.ExecuteReader()

			While reader.Read()
				date_ouverture = reader.GetDateTime(0)
				date_cloture = reader.GetDateTime(1)
			End While
			con.Close()
			reader.Close()
			If date_cloture > Date.Now And Date.Now > date_ouverture Then
				Return True
			Else
				Return False
			End If
		End Using
	End Function
#End Region

#Region "Verification si l'enseignant doit voir le formulaire pour le toit"

	Public Function EigibleToit() As Boolean

        'Procédue pour vérification d'eligibilité au toit
        Dim ids As Boolean

		Dim cloture As Boolean = PeriodeOuvertureToit()
		If cloture = True Then
			Using con As New SqlConnection(sconn)
				con.Open()
				Dim cmd As New SqlCommand("SELECT possibilite = dbo.ELIGBLE_TOIT(" & Session("id_ens") & ")", con)
				Dim reader As SqlDataReader = cmd.ExecuteReader()

				While reader.Read()
					ids = reader.GetBoolean(0)
				End While
				con.Close()
				reader.Close()
				If ids = True Then
					Return True
				Else
					Return False
				End If
			End Using
		Else
			Return False
		End If
	End Function
#End Region

#Region "Periode de declaration de PSV"
	Public Function PeriodedeclarationPSV() As Boolean
		Dim date_ouverture As Date
		Dim date_cloture As Date
		Using con As New SqlConnection(sconn)

			con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT isnull(DATE_OUVERTURE_DECLARATION_PSV,getdate()+1), isnull(DATE_CLOTURE_DECLARATION_PSV,getdate()-1) from annee where ANNEE_ENCOURS = 1", con)
			Dim reader As SqlDataReader = cmd.ExecuteReader()

			While reader.Read()
				date_ouverture = reader.GetDateTime(0)
				date_cloture = reader.GetDateTime(1)
			End While
			con.Close()
			reader.Close()
			If date_cloture > Date.Now And Date.Now > date_ouverture Then
				Return True
			Else
				Return False
			End If
		End Using
	End Function
#End Region

#Region "Dates du mouvement"
	Public Function DatesMouvement() As Array
		Dim dates(2) As DateTime

		Using con As New SqlConnection(sconn)

			con.Open()
			Dim cmd As New SqlCommand("SELECT isnull(DATE_OUVERTURE_MOUVEMENT,getdate()+1), isnull(DATE_CLOTURE_MOVUEMENT,getdate()-1) from annee where ANNEE_ENCOURS = 1", con)
			Dim reader As SqlDataReader = cmd.ExecuteReader()

			While reader.Read()
				dates(0) = reader.GetDateTime(0)
				dates(1) = reader.GetDateTime(1)
			End While
			con.Close()
			reader.Close()
			Return dates
		End Using
	End Function
#End Region
End Class
