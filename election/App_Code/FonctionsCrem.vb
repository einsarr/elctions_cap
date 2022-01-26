Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System
Imports System.Globalization
Imports System.Data
Imports System.Net
Imports System.Text


Public Class FonctionsCrem
    Dim sconn As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Private out As New Outils


#Region "Cherche dossier receptionné"
    Public Function modifDossierCremPossible(ByVal id_em As Integer) As Boolean

        ' Public Property 
        Using con As New SqlConnection(sconn)

            con.Open()
            'On cherche si le dossier est reçu au niveau du site
            Dim cmd As New SqlCommand("SELECT 1 AS CLOTURER FROM EM_ELEVE_MAITRE_CANDIDATURE INNER JOIN ANNEE ON EM_ELEVE_MAITRE_CANDIDATURE.CODE_ANNEE = ANNEE.CODE_ANNEE WHERE (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) AND (NOT (EM_ELEVE_MAITRE_CANDIDATURE.SITE_RECEPTION_DOSSIER IS NULL)) AND (EM_ELEVE_MAITRE_CANDIDATURE.ID_ELEVE_MAITRE = " & id_em & ")", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.HasRows Then
                con.Close()

                'Si le dossier est reçu au niveau IEF
                Return False
            Else
                con.Close()
                'Si le dossier n'est reçu au niveau IEF
                Return True
            End If
        End Using
    End Function
#End Region


#Region "Récupérer le dossier du candidat pour l'annee en cours"
    Public Function RecupDossierCremPossible(ByVal id_em As Integer) As DossierEleveMaitre

        Dim DossierEm As New DossierEleveMaitre
        ' Public Property 
        Using con As New SqlConnection(sconn)

            con.Open()
            'On cherche si le dossier est reçu au niveau du site
            Dim cmd As New SqlCommand("SELECT  EM_ELEVE_MAITRE.NUMERO_BAC, EM_ELEVE_MAITRE.ID_SERIE_BAC, EM_ELEVE_MAITRE.ANNEE_BAC, EM_ELEVE_MAITRE.NIVEAU_ETUDE, EM_ELEVE_MAITRE.ID_DIPLOME, EM_ELEVE_MAITRE.ANNEE_OBTENTION_DIPLOME_ELEVE, EM_ELEVE_MAITRE.ID_ECOLE_FORMATION, EM_ELEVE_MAITRE.AUTRE_ECOLE_FORMATION, " &
                      "EM_ELEVE_MAITRE.SPECIALITE_NIVEAU_ETUDE, EM_ELEVE_MAITRE.OPTION_ENSEIGNEMENT, EM_ELEVE_MAITRE.TYPE_NUMERO_BAC, EM_ELEVE_MAITRE.NUMERO_TABLE_BAC, " &
                      "EM_ELEVE_MAITRE.SESSION_BAC, EM_ELEVE_MAITRE_CANDIDATURE.IAEXAM, EM_ELEVE_MAITRE_CANDIDATURE.IAAFFECT " &
                      "From EM_ELEVE_MAITRE INNER Join " &
                      "EM_ELEVE_MAITRE_CANDIDATURE On EM_ELEVE_MAITRE.ID_ELEVE_MAITRE = EM_ELEVE_MAITRE_CANDIDATURE.ID_ELEVE_MAITRE INNER Join " &
                      "ANNEE On EM_ELEVE_MAITRE_CANDIDATURE.CODE_ANNEE = ANNEE.CODE_ANNEE " &
                      "Where(ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_ELEVE_MAITRE.ID_ELEVE_MAITRE = " & id_em & ")", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.HasRows Then
                While reader.Read()
                    Try

                        DossierEm.NUMERO_BAC = reader.GetString(0)
                        DossierEm.ID_SERIE_BAC = reader.GetInt32(1)
                        DossierEm.ANNEE_BAC = reader.GetString(2)
                        DossierEm.NIVEAU_ETUDE = reader.GetString(3)
                        DossierEm.ID_DIPLOME = reader.GetDecimal(4)
                        DossierEm.ANNEE_OBTENTION_DIPLOME_ELEVE = reader.GetString(5)
                        DossierEm.ID_ECOLE_FORMATION = reader.GetDecimal(6)
                        DossierEm.AUTRE_ECOLE_FORMATION = reader.GetString(7)
                        DossierEm.SPECIALITE_NIVEAU_ETUDE = reader.GetString(8)
                        DossierEm.OPTION_ENSEIGNEMENT = reader.GetString(9)
                        DossierEm.TYPE_NUMERO_BAC = reader.GetString(10)
                        DossierEm.NUMERO_TABLE_BAC = reader.GetInt32(11)
                        DossierEm.SESSION_BAC = reader.GetString(12)
                        DossierEm.IAEXAM = reader.GetString(13)
                        DossierEm.IAAFFECT = reader.GetInt32(14)

                    Catch ex As Exception
                        DossierEm.AUTRE_ECOLE_FORMATION = "Erreur sur le remplissage"
                    End Try
                End While
            End If
            reader.Close()
            con.Close()
            Return DossierEm
        End Using
    End Function
#End Region

#Region "Classe Dossier Eleve Maitre"
    Public Class DossierEleveMaitre
        Public Property NUMERO_BAC As String
        Public Property ID_SERIE_BAC As Integer
        Public Property ANNEE_BAC As String
        Public Property NIVEAU_ETUDE As String
        Public Property ID_DIPLOME As Integer
        Public Property ANNEE_OBTENTION_DIPLOME_ELEVE As String
        Public Property ID_ECOLE_FORMATION As Integer
        Public Property AUTRE_ECOLE_FORMATION As String
        Public Property SPECIALITE_NIVEAU_ETUDE As String
        Public Property OPTION_ENSEIGNEMENT As String
        Public Property TYPE_NUMERO_BAC As String
        Public Property NUMERO_TABLE_BAC As Integer
        Public Property SESSION_BAC As String
        Public Property IAEXAM As String
        Public Property IAAFFECT As Integer
    End Class
#End Region


#Region "Retourne l'id de la phase qui est validée"
    Public Function GetIdPhaseValide() As Decimal

        Dim phaseId As Decimal
        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand("SELECT PHASE_EXAM_ID FROM EM_EXAM_PHASE WHERE PHASE_VALIDE = 1", con)

                phaseId = cmd.ExecuteScalar()

            End Using
        Catch ex As Exception
            Return 0
        End Try
        Return phaseId

    End Function
#End Region

#Region "Regarde si une phase a été validée"
    Public Function PhaseIsValided() As Integer

        Dim phaseValided As Integer = 0
        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand("SELECT count(1) AS phase_active FROM EM_EXAM_PHASE WHERE (PHASE_VALIDE = 1)", con)

                phaseValided = cmd.ExecuteScalar()

            End Using

            Return phaseValided

        Catch ex As Exception
            Return 0
        End Try

    End Function
#End Region

#Region "Noms Phase en cours valide  id "
    Public Function GetNomPhase(ByVal idPhase As Decimal) As String

        Dim nomPhase As String
        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand("SELECT LIBELLE_PHASE_EXAM FROM EM_EXAM_PHASE WHERE (PHASE_EXAM_ID = " & idPhase & ")", con)

                nomPhase = cmd.ExecuteScalar()

            End Using

            Return nomPhase

        Catch ex As Exception
            Return ""
        End Try

    End Function
#End Region

#Region "Phase Si admis a la phase en cours"
    Public Function ChercheAdmisParPhase(ByVal dateNaiss As String, ByVal numTable As Decimal, ByVal cni As String, ByVal phaseId As Integer) As Integer

        Dim requeteResultParPhase As String = ""

        Dim estAdmis As Integer
        'On construit la requete de recherche resultat pour les phase differentes de la dernieres
        If phaseId <> 3 Then
            requeteResultParPhase = "SELECT COUNT(EM_NUMERO_TABLE_CANDIDAT.ID_DOSSIER_ELEVE_MAITRE) AS admis " _
            & " FROM   EM_NUMERO_TABLE_CANDIDAT INNER JOIN " _
            & " ANNEE On EM_NUMERO_TABLE_CANDIDAT.CODE_ANNEE = ANNEE.CODE_ANNEE And EM_NUMERO_TABLE_CANDIDAT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN " _
            & " EM_ELEVE_MAITRE_CANDIDATURE On EM_NUMERO_TABLE_CANDIDAT.ID_DOSSIER_ELEVE_MAITRE = EM_ELEVE_MAITRE_CANDIDATURE.ID_DOSSIER_ELEVE_MAITRE AND EM_NUMERO_TABLE_CANDIDAT.CODE_ANNEE = EM_ELEVE_MAITRE_CANDIDATURE.CODE_ANNEE  INNER JOIN " _
            & " EM_ELEVE_MAITRE On EM_ELEVE_MAITRE_CANDIDATURE.ID_ELEVE_MAITRE = EM_ELEVE_MAITRE.ID_ELEVE_MAITRE " _
            & " WHERE  (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_NUMERO_TABLE_CANDIDAT.NUMERO_TABLE = " & numTable & " ) And (EM_ELEVE_MAITRE.CNI_ELEVE_MAITRE = '" & cni & "') And  " _
            & " (EM_ELEVE_MAITRE.DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "') And (EM_NUMERO_TABLE_CANDIDAT.PHASE_EXAM_ID = " & phaseId + 1 & ")"

        Else
            'On recherche le candidat dans la phase 3 
            Dim estParmisAdmis As Integer = EstDanslaPhase3(dateNaiss, numTable, cni)

            '0 renvoit à l'échec du candidat il n'est pas dans la liste
            'On a une liste d'attente avec 3 rst possible echec attente et admis à la phase 3
            If estParmisAdmis = 0 Then
                Return -1
            End If

            requeteResultParPhase = "SELECT CASE EM_EXAM_TEMP_ADMIS_JURY.ADMIS when  1 then 1 else 0 END AS ADMIS" _
            & " FROM    EM_EXAM_TEMP_ADMIS_JURY INNER JOIN" _
            & " ANNEE ON EM_EXAM_TEMP_ADMIS_JURY.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN" _
            & " EM_ELEVE_MAITRE On EM_EXAM_TEMP_ADMIS_JURY.ID_ELEVE_MAITRE = EM_ELEVE_MAITRE.ID_ELEVE_MAITRE" _
            & " WHERE   (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_EXAM_TEMP_ADMIS_JURY.NUMERO_TABLE = " & numTable & " ) And (EM_ELEVE_MAITRE.DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "') And " _
            & " (EM_ELEVE_MAITRE.CNI_ELEVE_MAITRE = '" & cni & "')"

        End If
        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand(requeteResultParPhase, con)
                estAdmis = cmd.ExecuteScalar()
            End Using

            Return estAdmis
        Catch ex As Exception
            Return -2
        End Try

    End Function
#End Region

#Region "Recherche présence candidat dans la phase 3"
    Public Function EstDanslaPhase3(ByVal dateNaiss As String, ByVal numTable As Decimal, ByVal cni As String) As Integer

        Dim requeteResultParPhase As String = ""

        Dim estAdmis As Integer
        'On construit la requete de recherche resultat pour les phase differentes de la dernieres


        requeteResultParPhase = "SELECT COUNT(EM_EXAM_TEMP_ADMIS_JURY.ADMIS) AS ADMIS" _
            & " FROM    EM_EXAM_TEMP_ADMIS_JURY INNER JOIN" _
            & " ANNEE ON EM_EXAM_TEMP_ADMIS_JURY.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN" _
            & " EM_ELEVE_MAITRE On EM_EXAM_TEMP_ADMIS_JURY.ID_ELEVE_MAITRE = EM_ELEVE_MAITRE.ID_ELEVE_MAITRE" _
            & " WHERE   (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_EXAM_TEMP_ADMIS_JURY.NUMERO_TABLE = " & numTable & " ) And (EM_ELEVE_MAITRE.DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "') And " _
            & " (EM_ELEVE_MAITRE.CNI_ELEVE_MAITRE = '" & cni & "')"


        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand(requeteResultParPhase, con)
                estAdmis = cmd.ExecuteScalar()
            End Using

            Return estAdmis
        Catch ex As Exception
            Return -1
        End Try

    End Function
#End Region

#Region "Recherche UserId du candidat "
    Public Function GetUserId(ByVal dateNaiss As String, ByVal numTable As Decimal, ByVal cni As String) As String

        Dim requeteResultParPhase As String = ""

        Dim userId As String
        'On construit la requete de recherche resultat pour les phase differentes de la dernieres


        requeteResultParPhase = "SELECT EM_ELEVE_MAITRE.UserId" _
            & " FROM   EM_NUMERO_TABLE_CANDIDAT INNER JOIN " _
            & " ANNEE On EM_NUMERO_TABLE_CANDIDAT.CODE_ANNEE = ANNEE.CODE_ANNEE And EM_NUMERO_TABLE_CANDIDAT.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN " _
            & " EM_ELEVE_MAITRE_CANDIDATURE On EM_NUMERO_TABLE_CANDIDAT.ID_DOSSIER_ELEVE_MAITRE = EM_ELEVE_MAITRE_CANDIDATURE.ID_DOSSIER_ELEVE_MAITRE INNER JOIN " _
            & " EM_ELEVE_MAITRE On EM_ELEVE_MAITRE_CANDIDATURE.ID_ELEVE_MAITRE = EM_ELEVE_MAITRE.ID_ELEVE_MAITRE " _
            & " WHERE  (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_NUMERO_TABLE_CANDIDAT.NUMERO_TABLE = " & numTable & " ) And (EM_ELEVE_MAITRE.CNI_ELEVE_MAITRE = '" & cni & "') And  " _
            & " (EM_ELEVE_MAITRE.DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "') GROUP BY EM_ELEVE_MAITRE.UserId"


        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand(requeteResultParPhase, con)
                userId = cmd.ExecuteScalar().ToString
            End Using

            Return userId
        Catch ex As Exception
            Return "-1"
        End Try

    End Function
#End Region

#Region "Recuperation CRPFPE du candidat qui a reussit"
    Public Function RecupCrfpe(ByVal dateNaiss As String, ByVal numTable As Decimal, ByVal cni As String) As String

        'On recherche le candidat dans la phase 3 
        Dim estParmisAdmis As Integer = EstDanslaPhase3(dateNaiss, numTable, cni)

        '0 renvoit à l'échec du candidat il n'est pas dans la liste
        'On a une liste d'attente avec 3 rst possible echec attente et admis à la phase 3
        If estParmisAdmis = 0 Then
            Return "-1"
        End If


        'On construit la requete de recherche resultat pour les phase differentes de la dernieres
        Dim requeteResultParPhase As String = "SELECT	EM_CRFPE.LIBELLE_CRFPE" _
            & " FROM    EM_EXAM_TEMP_ADMIS_JURY INNER JOIN" _
            & " ANNEE ON EM_EXAM_TEMP_ADMIS_JURY.CODE_ANNEE = ANNEE.CODE_ANNEE INNER JOIN" _
            & " EM_ELEVE_MAITRE ON EM_EXAM_TEMP_ADMIS_JURY.ID_ELEVE_MAITRE = EM_ELEVE_MAITRE.ID_ELEVE_MAITRE INNER JOIN" _
            & " EM_CRFPE ON EM_EXAM_TEMP_ADMIS_JURY.ID_CRFPE = EM_CRFPE.ID_CRFPE" _
            & " WHERE   (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_EXAM_TEMP_ADMIS_JURY.NUMERO_TABLE = " & numTable & " ) And (EM_ELEVE_MAITRE.DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "') And " _
            & " (EM_ELEVE_MAITRE.CNI_ELEVE_MAITRE = '" & cni & "') GROUP BY (EM_CRFPE.LIBELLE_CRFPE)"


        Try
            Dim crfpe As String
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand(requeteResultParPhase, con)
                crfpe = cmd.ExecuteScalar()
            End Using

            Return crfpe
        Catch ex As Exception
            Return "-1"
        End Try

    End Function
#End Region


#Region "Année CREM"
    Public Function GetAnneeCrem() As String

        'On construit la requete de recherche resultat pour les phase differentes de la dernieres
        Dim requeteResultParPhase As String = "SELECT LIBELLE_ANNEE AS ANNEE FROM ANNEE WHERE ANNEE_ENCOURS_ELEVE_MAITRE = 1"
        Try
            Dim anCrem As String
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand(requeteResultParPhase, con)
                anCrem = cmd.ExecuteScalar()
            End Using

            Return anCrem
        Catch ex As Exception
            Return DateTime.UtcNow.Year.ToString
        End Try

    End Function
#End Region

#Region "Fonction de vérification des dates d'ouverture et de fermeture des inscriptions et des candidature"
    Public Function DateDuCrem() As List(Of DateTime)
        Dim date_ouverture As Date
        Dim date_cloture As Date
        Dim date_controle As DateTime
        Using con As New SqlConnection(sconn)
            Try


                con.Open()
                'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
                Dim cmd As New SqlCommand("SELECT COALESCE(ELEVE_MAITRE_DATE_OUVERTURE, 0 ) AS ELEVE_MAITRE_DATE_OUVERTURE, COALESCE(ELEVE_MAITRE_DATE_CLOTURE, GETDATE()-1) AS ELEVE_MAITRE_DATE_CLOTURE, DATE_CONTROLE_LIMITE_AGE FROM PARAMETRAGE_DATE INNER JOIN ANNEE ON PARAMETRAGE_DATE.CODE_ANNEE = ANNEE.CODE_ANNEE WHERE (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1)", con)
                Dim reader As SqlDataReader = cmd.ExecuteReader()

                While reader.Read()
                    date_ouverture = reader.GetDateTime(0)
                    date_cloture = reader.GetDateTime(1)
                    date_controle = reader.GetDateTime(2)
                End While

                Dim dateCrem As New List(Of DateTime)
                dateCrem.Add(date_ouverture)
                dateCrem.Add(date_cloture)
                dateCrem.Add(date_controle)

                con.Close()
                reader.Close()

                Return dateCrem

            Catch ex As Exception

            End Try
        End Using
    End Function
#End Region
End Class
