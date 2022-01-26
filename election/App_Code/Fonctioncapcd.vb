Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System
Imports System.Globalization
Imports System.Data
Imports System.Net
Imports System.Text

Public Class Fonctioncapcd
    Inherits System.Web.UI.Page
    'Dim sconn As String = "Data Source=localhost;Initial Catalog=FUP;User ID=sirh;Password=sirhacdi"
    Dim sconn As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Private out As New Outils
    'Fonction qui vérifie si l'agent est promouvable
    Public Function Promouvable(ByVal id_ens As Integer) As Boolean

        Dim ids As Integer

        Using con As New SqlConnection(sconn)
            con.Open()
            Dim cmd As New SqlCommand("SELECT COUNT(CODE_GRADE) FROM ENSEIGNANT WHERE CODE_GRADE IN('002','003','005','006','007','017','039','041') AND IDENTIFIANT_ENSEIGNANT=" & id_ens & "", con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                ids = reader.GetInt32(0)
            End While
            con.Close()
            reader.Close()
            If ids = 0 Then
                Return False
            Else
                Return True
            End If
        End Using

    End Function

    'Fonction qui recherche le corps de l'agent 
    Public Function findCorps(ByVal id_ens As String) As String
        Dim corps_ens As String = Nothing
        Try
            Dim sqlFindCorps As New SqlCommand("SELECT C.LIBELLE_CORPS FROM ENSEIGNANT E" &
                " JOIN CORPS C  ON C.CODE_CORPS=E.CODE_CORPS" &
               " WHERE (E.IDENTIFIANT_ENSEIGNANT = '" & id_ens & "')")

            Dim ResulCorps As DataSet
            ResulCorps = out.RunQuery(sqlFindCorps)
            If ResulCorps.Tables(0).Rows.Count > 0 Then
                Dim rowCorps As DataRow
                For Each rowCorps In ResulCorps.Tables(0).Rows
                    Try
                        corps_ens = rowCorps("LIBELLE_CORPS").ToString
                    Catch ex As Exception
                    End Try
                Next
            End If
        Catch ex As Exception

        End Try
        Return corps_ens
    End Function

    'Fonction qui retourne l'année en cours dans la table année
    Public Function AnneeEnCours() As String
        Dim annee As String = Nothing
        Try
            Dim sqlAnneEncours As New SqlCommand("SELECT CODE_ANNEE FROM ANNEE WHERE ANNEE_ENCOURS = 1")

            Dim ResultAnnee As DataSet
            ResultAnnee = out.RunQuery(sqlAnneEncours)
            If ResultAnnee.Tables(0).Rows.Count > 0 Then
                Dim rowAnne As DataRow
                For Each rowAnne In ResultAnnee.Tables(0).Rows
                    Try
                        annee = rowAnne("CODE_ANNEE").ToString
                    Catch ex As Exception
                    End Try
                Next
            End If
        Catch ex As Exception

        End Try
        Return annee
    End Function

    'Fonction qui retourne la période d'ouverture des candidatures au cap
    Public Function PeriodeOuvertureCandidatureCAP() As Boolean
        Dim date_ouverture As Date
        Dim date_cloture As Date
        Using con As New SqlConnection(sconn)

            con.Open()
            'Dim cmd As New SqlCommand("select case when CAP_DATE_OUVERTURE_CANDIDATURE < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT isnull(CAP_DATE_OUVERTURE_CANDIDATURE,getdate()+1), isnull(CAP_DATE_FERMETURE_CANDIDATURE,getdate()-1) FROM ANNEE WHERE ANNEE_ENCOURS = 1", con)
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

    'Fonction qui recherche la date de fermeture ds candidatures
    Public Function findDateFermetureCandidature() As String
        Dim dateFermeture As String = Nothing
        Try
            Dim sqlFindDateFerm As New SqlCommand("SELECT CONCAT(FORMAT(CAST(CAP_DATE_FERMETURE_CANDIDATURE As date),'dd/MM/yyyy'),' à ',CAST(CAP_DATE_FERMETURE_CANDIDATURE As TIME(0)))   CAP_DATE_FERMETURE FROM ANNEE WHERE ANNEE_ENCOURS=1")

            Dim ResultDateFer As DataSet
            ResultDateFer = out.RunQuery(sqlFindDateFerm)
            If ResultDateFer.Tables(0).Rows.Count > 0 Then
                Dim rowDateF As DataRow
                For Each rowDateF In ResultDateFer.Tables(0).Rows
                    Try
                        dateFermeture = rowDateF("CAP_DATE_FERMETURE").ToString
                    Catch ex As Exception
                    End Try
                Next
            End If
        Catch ex As Exception

        End Try
        Return dateFermeture
    End Function
End Class
