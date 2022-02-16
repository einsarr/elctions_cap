Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Public Class ElectionCAPCD
    Dim sconn As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Private Outils As New Outils

    'Corps qui partent à la retraite à 65 ans
    Public Function CORPS_RETRAITE_65ANS(ByVal id_elect As Integer) As Boolean
        Dim ids As Integer
        Using con As New SqlConnection(sconn)
            con.Open()
            Dim cmd As New SqlCommand("SELECT COUNT(C.ID_CORPS)" _
            & " FROM ELECTION_CAP_ELECTEUR CAP " _
            & " INNER JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS=CAP.ID_CORPS" _
            & " WHERE C.AGE_RETRAITE=65" _
            & " AND CAP.IDENTIFIANT_ELECTEUR=" & id_elect & "", con)
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

    'Corps qui partent à la retraite à 55 ans
    Public Function CORPS_RETRAITE_55ANS(ByVal id_elect As Integer) As Boolean
        Dim ids As Integer
        Using con As New SqlConnection(sconn)
            con.Open()
            Dim cmd As New SqlCommand("SELECT COUNT(C.ID_CORPS)" _
            & " FROM ELECTION_CAP_ELECTEUR CAP " _
            & " INNER JOIN ELECTION_CAP_CORPS C ON C.ID_CORPS=CAP.ID_CORPS" _
            & " WHERE C.AGE_RETRAITE =55" _
            & " AND IDENTIFIANT_ELECTEUR=" & id_elect & "", con)
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

    'CALCUL DE L'AGE
    Public Function CalculAge(ByVal birthdate As DateTime) As Integer
        Dim years As Integer = DateTime.Now.Year - birthdate.Year
        If (DateTime.Now.Month < birthdate.Month Or (DateTime.Now.Month = birthdate.Month And DateTime.Now.Day < birthdate.Day)) Then
            years = years - 1
        End If
        Return years
    End Function

    'Fonction qui retourne la période d'ouverture des elections au cap
    Public Function PeriodeOuvertureScrutin() As Boolean
        Dim date_ouverture As Date
        Dim date_cloture As Date
        Using con As New SqlConnection(sconn)
            con.Open()
            Dim cmd As New SqlCommand("SELECT isnull(DATE_OUVERTURE_SCRUTIN,getdate()+1), isnull(DATE_FERMETURE_SCRUTIN,getdate()-1) FROM ELECTION_CAP_PARAM_ELECTION WHERE ANNEE_ENCOURS = 1", con)
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
    'Vérifie si l'electeur à déjà voter
    Public Function ADEJAVOTE(ByVal id_ens As Integer) As Boolean
        Dim ids As Integer
        Using con As New SqlConnection(sconn)
            con.Open()
            Dim cmd As New SqlCommand("SELECT COUNT(IDENTIFIANT_ELECTEUR) FROM ELECTION_CAP_ELECTEUR WHERE A_VOTE=1 AND IDENTIFIANT_ELECTEUR=" & id_ens & "", con)
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

    'BLOQUER LE COMPTE - si le nombre de tentative est supérieur à 2
    Public Function CompteBloque(ByVal id_ens As Integer) As Boolean
        Dim ids As Integer
        Using con As New SqlConnection(sconn)
            con.Open()
            Dim cmd As New SqlCommand("SELECT COUNT(IDENTIFIANT_ELECTEUR) FROM ELECTION_CAP_ELECTEUR WHERE TENTATIVE >=3 AND IDENTIFIANT_ELECTEUR=" & id_ens & "", con)
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


End Class
