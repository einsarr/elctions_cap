Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class FonctionsFormation
    Dim sconn As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString

    Private out As New Outils
    Private Nosf As New NosFonctions

#Region "periode inscription aux formations"
    Public Function InscriptionFormationOuvert() As Boolean

        Dim date_ouverture As DateTime
        Dim date_cloture As DateTime
        Using con As New SqlConnection(sconn)

            con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT isnull(DATE_DEBUT_EDITION, GETDATE()+1), isnull(DATE_FIN_EDITION, GETDATE()-1) FROM FORM_EDITION " _
                                         & "WHERE (EDTION_ENCOURS = 1)", con)
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

#Region "Dates d'inscription aux formations"
    Public Function DatesInscriptionFormation() As Array
        Dim dates(2) As DateTime

        Using con As New SqlConnection(sconn)

            con.Open()
            Dim cmd As New SqlCommand("SELECT isnull(DATE_DEBUT_EDITION, GETDATE()+1), isnull(DATE_FIN_EDITION, GETDATE()-1) FROM FORM_EDITION " _
                                         & "WHERE (EDTION_ENCOURS = 1)", con)
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

#Region "Récupération du code de l'édition encours"
    Public Function GetCodeEditonEncours() As Integer
        Dim id_edition As Integer

        Using con As New SqlConnection(sconn)

            con.Open()
            Dim cmd As New SqlCommand("SELECT ID_EDITION FROM FORM_EDITION WHERE (EDTION_ENCOURS = 1)", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                id_edition = reader.GetInt32(0)
            End While
            con.Close()
            reader.Close()

            Return id_edition
        End Using
    End Function
#End Region

#Region "Classe Formation"
    Public Class Formation
        Public Property ID_FORMATION As Integer
        Public Property ID_EDITION As Integer
        Public Property LIBELLE_FORMATION As String
        Public Property DESCRIPTION_FORMATION As String
        Public Property LIEU_FORMATION As String
        Public Property AGE_MINI As Integer
        Public Property AGE_MAXI As Integer
        Public Property LISTE_NOMIVATIVE As Boolean
        Public Property DATE_DEBUT_FORMATION As DateTime
        Public Property DATE_FIN_FORMATION As DateTime
    End Class
#End Region

#Region "Classe Enseignant"
    Public Class Enseignant
        Public Property IDENTIFIANT_ENSEIGNANT As Integer
        Public Property MATRICULE_ENSEIGNANT As String
        Public Property NOM_ENSEIGNANT As String
        Public Property PRENOMS_ENSEIGNANT As String
        Public Property SEXE_ENSEIGNANT As String
        Public Property DATE_NAISS_ENSEIGNANT As DateTime
        Public Property CODE_DIPLOME As String
        Public Property CODE_DIPLOME_PROFESSIONNEL As String
        Public Property LIBELLE_DIPLOME_ACA As String
        Public Property LIBELLE_DIPLOME_PROFESSIONNEL As String
        Public Property DATE_OBTENTION_DIPLOME_ACA As DateTime
        Public Property DATE_OBTENTION_DIPLOME_PRO As DateTime

        Public Property MAIL_ENSEIGNANT As String
        Public Property MAIL_ENSEIGNANT2 As String
        Public Property MOBILE_ENSEIGNANT As Integer
        Public Property MOBILE_ENSEIGNANT2 As Integer
    End Class
#End Region

#Region "recupération de la liste des formations de l'édition encours"
    Public Function ListeFormationsParEdition(ByVal id_edition As Integer) As List(Of Formation)
        Dim ListeFormations As New List(Of Formation)
        'Dim Syndicat As New NameValueCollection

        ' Public Property 
        Using con As New SqlConnection(sconn)

            con.Open()
            Dim cmd As New SqlCommand("SELECT ID_FORMATION, ID_EDITION, LIBELLE_FORMATION, " _
                                      & "DESCRIPTION_FORMATION, LIEU_FORMATION, AGE_MINI, AGE_MAXI, " _
                                      & "LISTE_NOMIVATIVE, DATE_DEBUT_FORMATION, DATE_FIN_FORMATION " _
                                      & "FROM FORM_FORMATION WHERE (ID_EDITION = " & id_edition & ")", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                Dim formation As New Formation
                formation.ID_FORMATION = reader.GetInt32(0)
                formation.ID_EDITION = reader.GetInt32(1)
                formation.LIBELLE_FORMATION = reader.GetString(2)
                formation.DESCRIPTION_FORMATION = reader.GetString(3)
                formation.LIEU_FORMATION = reader.GetString(4)
                formation.AGE_MINI = reader.GetInt32(5)
                formation.AGE_MAXI = reader.GetInt32(6)
                formation.LISTE_NOMIVATIVE = reader.GetBoolean(7)
                formation.DATE_DEBUT_FORMATION = reader.GetDateTime(8)
                formation.DATE_FIN_FORMATION = reader.GetDateTime(9)

                'On met dans le arrayList
                ListeFormations.Add(formation)

            End While
            con.Close()
            reader.Close()
            Return ListeFormations
        End Using
    End Function
#End Region

#Region "Verif si enseignant dans liste nominative"
    Public Function EnsDansListeNominative(ByVal id_ens As Integer) As Boolean

        Dim Eligible As Integer
        Using con As New SqlConnection(sconn)

            con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT COUNT(FORM_LISTE_NOMINATIVE.ID_LISTE_NOMINATIVE) AS Eligible " _
                                    & "FROM  FORM_LISTE_NOMINATIVE INNER JOIN " _
                                    & "FORM_FORMATION ON FORM_LISTE_NOMINATIVE.ID_FORMATION = FORM_FORMATION.ID_FORMATION INNER JOIN " _
                                    & "FORM_EDITION ON FORM_FORMATION.ID_EDITION = FORM_EDITION.ID_EDITION " _
                                    & "WHERE (FORM_EDITION.EDTION_ENCOURS = 1) AND (FORM_LISTE_NOMINATIVE.IDENTIFIANT_ENSEIGNANT = " & id_ens & ")", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                Eligible = reader.GetInt32(0)
            End While
            con.Close()
            reader.Close()
            If Eligible = 0 Then
                Return False
            Else
                Return True
            End If
        End Using
    End Function
#End Region

#Region "Verification si l'enseignant à deja valider le formulaire d'ajout de données"
    Public Function EnsModifEffective(ByVal id_ens As Integer) As Boolean

        Dim dejaModif As Integer
        Using con As New SqlConnection(sconn)

            con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT DONNEES_SUP_VALIDEES " _
                                     & "FROM FORM_LISTE_NOMINATIVE " _
                                     & "WHERE IDENTIFIANT_ENSEIGNANT = " & id_ens & "", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                dejaModif = reader.GetBoolean(0)
            End While
            con.Close()
            reader.Close()
            If dejaModif = 0 Then
                Return False
            Else
                Return True
            End If
        End Using
    End Function
#End Region

#Region "Enregistrer le choix de la formation"
    Public Function ChoisirFormation(ByVal id_ens As Integer, ByVal id_formation As Integer) As Boolean

        'Procédue pour vérification de candidature possible ou non
        'Dim cloture As Boolean = InscriptionFormationOuvert()
        Try
            Using con As New SqlConnection(sconn)
                con.Open()
                Dim cmd As New SqlCommand("INSERT INTO FORM_ENSEIGNANT_INSCRIT " _
                                          & "(IDENTIFIANT_ENSEIGNANT, ID_FORMATION) " _
                                          & " VALUES (" & id_ens & ", " & id_formation & ")", con)

                Dim rst As Integer = cmd.ExecuteNonQuery()
                con.Close()
                If rst > 0 Then
                    Return True
                Else
                    Return False
                End If
            End Using
        Catch ex As Exception
            Return False
        End Try
    End Function
#End Region

#Region "Verification si l'enseignant à deja choisi une formation"
    Public Function DejaChoisiForm(ByVal id_ens As Integer) As Boolean

        Dim dejaChoisiForma As Integer
        Using con As New SqlConnection(sconn)

            con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT COUNT(FORM_ENSEIGNANT_INSCRIT.IDENTIFIANT_ENSEIGNANT) AS presence " _
                                        & "FROM FORM_ENSEIGNANT_INSCRIT INNER JOIN " _
                                        & "FORM_FORMATION ON FORM_ENSEIGNANT_INSCRIT.ID_FORMATION = FORM_FORMATION.ID_FORMATION INNER JOIN " _
                                        & "FORM_EDITION ON FORM_FORMATION.ID_EDITION = FORM_EDITION.ID_EDITION " _
                                        & "WHERE (FORM_EDITION.EDTION_ENCOURS = 1) " _
                                        & "And (FORM_ENSEIGNANT_INSCRIT.IDENTIFIANT_ENSEIGNANT = " & id_ens & ")", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                dejaChoisiForma = reader.GetInt32(0)
            End While
            con.Close()
            reader.Close()
            If dejaChoisiForma = 0 Then
                Return False
            Else
                Return True
            End If
        End Using
    End Function
#End Region

#Region "Rcuperation des données de la formation choisie"
    Public Function GetFormationChoisie(ByVal id_ens As Integer) As Formation
        Dim formation As New Formation
        'Dim Syndicat As New NameValueCollection

        ' Public Property 
        Using con As New SqlConnection(sconn)

            con.Open()
            Dim cmd As New SqlCommand("SELECT FORM_FORMATION.ID_FORMATION, FORM_FORMATION.ID_EDITION, FORM_FORMATION.LIBELLE_FORMATION, FORM_FORMATION.DESCRIPTION_FORMATION, " _
                      & "FORM_FORMATION.LIEU_FORMATION, FORM_FORMATION.AGE_MINI, FORM_FORMATION.AGE_MAXI, FORM_FORMATION.LISTE_NOMIVATIVE, FORM_FORMATION.DATE_DEBUT_FORMATION, " _
                      & "FORM_FORMATION.DATE_FIN_FORMATION " _
                      & "FROM  FORM_FORMATION INNER JOIN " _
                      & "FORM_ENSEIGNANT_INSCRIT On FORM_FORMATION.ID_FORMATION = FORM_ENSEIGNANT_INSCRIT.ID_FORMATION " _
                      & "WHERE (FORM_ENSEIGNANT_INSCRIT.IDENTIFIANT_ENSEIGNANT = " & id_ens & ")", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                formation.ID_FORMATION = reader.GetInt32(0)
                formation.ID_EDITION = reader.GetInt32(1)
                formation.LIBELLE_FORMATION = reader.GetString(2)
                formation.DESCRIPTION_FORMATION = reader.GetString(3)
                formation.LIEU_FORMATION = reader.GetString(4)
                formation.AGE_MINI = reader.GetInt32(5)
                formation.AGE_MAXI = reader.GetInt32(6)
                formation.LISTE_NOMIVATIVE = reader.GetBoolean(7)
                formation.DATE_DEBUT_FORMATION = reader.GetDateTime(8)
                formation.DATE_FIN_FORMATION = reader.GetDateTime(9)

            End While
            con.Close()
            reader.Close()
            Return formation
        End Using
    End Function
#End Region

#Region "Recupartion données enseignant inscrit au formation"
    Public Function GetEnsInscrit(ByVal id_ens As Integer) As Enseignant
        Dim ens As New Enseignant
        'Dim Syndicat As New NameValueCollection

        ' Public Property 
        Using con As New SqlConnection(sconn)

            con.Open()
            Dim cmd As New SqlCommand("SELECT FORM_ENSEIGNANT_INSCRIT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PRENOMS_ENSEIGNANT, " _
                        & "ENSEIGNANT.SEXE_ENSEIGNANT, Enseignant.DATE_NAISS_ENSEIGNANT, Enseignant.CODE_DIPLOME, Enseignant.CODE_DIPLOME_PROFESSIONNEL, " _
                        & "DIPLOME_ACADEMIQUE.LIBELLE_DIPLOME, DIPLOME_PROFESSIONNEL.LIBELLE_DIPLOME_PROFESSIONNEL, Enseignant.DATE_OBTENTION_DIPLOME_ACA, " _
                        & "ENSEIGNANT.DATE_OBTENTION_DIPLOME_PRO, isnull(Enseignant.MAIL_ENSEIGNANT,''), isnull(Enseignant.MAIL_ENSEIGNANT2,''), isnull(Enseignant.MOBILE_ENSEIGNANT, 0), " _
                        & "isnull(ENSEIGNANT.MOBILE_ENSEIGNANT2,0) " _
                        & "FROM  FORM_ENSEIGNANT_INSCRIT INNER JOIN " _
                        & "ENSEIGNANT On FORM_ENSEIGNANT_INSCRIT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT.IDENTIFIANT_ENSEIGNANT INNER JOIN " _
                        & "DIPLOME_ACADEMIQUE On ENSEIGNANT.CODE_DIPLOME = DIPLOME_ACADEMIQUE.CODE_DIPLOME INNER JOIN " _
                        & "DIPLOME_PROFESSIONNEL On ENSEIGNANT.CODE_DIPLOME_PROFESSIONNEL = DIPLOME_PROFESSIONNEL.CODE_DIPLOME_PROFESSIONNEL " _
                        & "WHERE (FORM_ENSEIGNANT_INSCRIT.IDENTIFIANT_ENSEIGNANT = " & id_ens & ")", con)

            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                ens.IDENTIFIANT_ENSEIGNANT = reader.GetInt32(0)
                ens.MATRICULE_ENSEIGNANT = reader.GetString(1)
                ens.NOM_ENSEIGNANT = reader.GetString(2)
                ens.PRENOMS_ENSEIGNANT = reader.GetString(3)
                ens.SEXE_ENSEIGNANT = reader.GetString(4)
                ens.DATE_NAISS_ENSEIGNANT = reader.GetDateTime(5)
                ens.CODE_DIPLOME = reader.GetString(6)
                ens.CODE_DIPLOME_PROFESSIONNEL = reader.GetString(7)
                ens.LIBELLE_DIPLOME_ACA = reader.GetString(8)
                ens.LIBELLE_DIPLOME_PROFESSIONNEL = reader.GetString(9)
                ens.DATE_OBTENTION_DIPLOME_ACA = reader.GetDateTime(10)
                ens.DATE_OBTENTION_DIPLOME_PRO = reader.GetDateTime(11)
                ens.MAIL_ENSEIGNANT = reader.GetString(12)
                ens.MAIL_ENSEIGNANT2 = reader.GetString(13)
                ens.MOBILE_ENSEIGNANT = reader.GetDecimal(14)
                ens.MOBILE_ENSEIGNANT2 = reader.GetDecimal(15)


            End While
            con.Close()
            reader.Close()
            Return ens
        End Using
    End Function
#End Region
End Class

