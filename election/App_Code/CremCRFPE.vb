Imports System.Data
Imports System.Data.SqlClient

Public Class CremCRFPE
    Dim scon As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Private out As New Outils

    Public Function PhaseEntretienJuryValide() As Boolean

        Dim entretienJuryOk As Integer
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rEntretienJuryValided As String

            rEntretienJuryValided = " SELECT COUNT(EM_EXAM_TEMP_ADMIS_JURY.ID_DOSSIER_ELEVE_MAITRE) " _
                            & " FROM     EM_EXAM_TEMP_ADMIS_JURY INNER JOIN " _
                            & " ANNEE ON EM_EXAM_TEMP_ADMIS_JURY.CODE_ANNEE = ANNEE.CODE_ANNEE " _
                            & " WHERE(ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) And (EM_EXAM_TEMP_ADMIS_JURY.ADMIS = 1)"

            Dim cmd As New SqlCommand(rEntretienJuryValided, con)

            entretienJuryOk = cmd.ExecuteScalar()
            If entretienJuryOk > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function EstAdmisEntretienJury(id_em As Integer) As Boolean

        Dim estAdmis As Integer
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rEstAdmis As String

            rEstAdmis = " SELECT COUNT(EM_EXAM_TEMP_ADMIS_JURY.ID_DOSSIER_ELEVE_MAITRE) " _
               & "FROM    EM_EXAM_TEMP_ADMIS_JURY INNER JOIN " _
               & "ANNEE On EM_EXAM_TEMP_ADMIS_JURY.CODE_ANNEE = ANNEE.CODE_ANNEE " _
               & "WHERE   (ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1)  AND (EM_EXAM_TEMP_ADMIS_JURY.ADMIS = 1) " _
               & "And (EM_EXAM_TEMP_ADMIS_JURY.ID_ELEVE_MAITRE = " & id_em & ")"

            Dim cmd As New SqlCommand(rEstAdmis, con)

            estAdmis = cmd.ExecuteScalar()
            If estAdmis > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

#Region "periode inscription aux formations"
    Public Function CandidaturreAffectationCRFPEOuvert() As Boolean

        Dim date_ouverture As DateTime
        Dim date_cloture As DateTime
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim cmd As New SqlCommand("select isnull(CRFPE_DATE_DEBUT_CAND, " _
                                      & "GETDATE()+1),isnull(CRFPE_DATE_FIN_CAND, GETDATE()-1) " _
                                      & "FROM ANNEE WHERE ANNEE_ENCOURS_ELEVE_MAITRE = 1", con)
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


#Region "Données du candidat admis CREM"

    'On passe par le code et la date naiss
    Public Function RecupInfoAdmis(idEm As Integer) As Admis

        Dim ad As New Admis
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rExistenceCdDt As String

            rExistenceCdDt = "SELECT ID_ELEVE_MAITRE, NOM_ELEVE_MAITRE," _
                             & " PRENOMS_ELEVE_MAITRE, CNI_ELEVE_MAITRE, " _
                             & " OPTION_ENSEIGNEMENT FROM EM_ELEVE_MAITRE " _
                             & " WHERE ID_ELEVE_MAITRE = " & idEm & ""

            Dim cmd As New SqlCommand(rExistenceCdDt, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.HasRows Then

                While reader.Read()
                    ad.idCandidat = reader.GetInt32(0)
                    ad.nomCandidat = reader.GetString(1)
                    ad.prenomCandidat = reader.GetString(2)
                    ad.cniCandidat = reader.GetString(3)
                    ad.optionCandidat = reader.GetString(4)
                End While

            End If

            Return ad
        End Using
    End Function

    Public Class Admis

        Public Property idCandidat As Integer
        Public Property nomCandidat As String
        Public Property prenomCandidat As String
        Public Property cniCandidat As String
        Public Property optionCandidat As String

    End Class

    Public Function InitierCandidature(ByVal idEleveMaitre As Integer) As Boolean

        'On initie la candidature
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rInitieCand As String

            rInitieCand = "INSERT INTO EM_ELEVE_MAITRE_CANDIDATURE_CRFPE " _
                & "(ID_ELEVE_MAITRE, CODE_ANNEE, DATE_VOEUX, VOEUX_CLOTURE) " _
                & "VALUES (" & idEleveMaitre & ", (SELECT CODE_ANNEE FROM ANNEE WHERE ANNEE_ENCOURS_ELEVE_MAITRE = 1), " _
                & "getdate(), 0)"

            Dim cmd As New SqlCommand(rInitieCand, con)

            Dim rst As Integer = cmd.ExecuteNonQuery()
            If rst > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function VerifCandInitier(ByVal idEleveMaitre As Integer) As Boolean

        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rExistenceCode As String

            rExistenceCode = "SELECT count(ID_VOEUX_ADMIS) FROM EM_ELEVE_MAITRE_CANDIDATURE_CRFPE where ID_ELEVE_MAITRE = " & idEleveMaitre & ""

            Dim cmd As New SqlCommand(rExistenceCode, con)

            Dim candInit As Integer = cmd.ExecuteScalar()
            If candInit > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function RecupIDCand(ByVal idEleveMaitre As Integer) As Decimal

        Dim idCand As Decimal

        'On recupere l'id de la candidature
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim getIdCand As String

            getIdCand = "SELECT ID_VOEUX_ADMIS FROM EM_ELEVE_MAITRE_CANDIDATURE_CRFPE WHERE ID_ELEVE_MAITRE = " & idEleveMaitre & ""

            Dim cmd As New SqlCommand(getIdCand, con)

            idCand = cmd.ExecuteScalar()

            Return idCand
        End Using

    End Function

    Public Function CompteChoix(ByVal idVoeux As Decimal) As Integer
        Dim nombreChoix As Integer

        'On recupere l'id de la candidature
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rNombreChoix As String

            rNombreChoix = "SELECT count(ID_DETAIL_VOEUX_ADMIS) FROM EM_ELEVE_MAITRE_CANDIDATURE_CRFPE_DETAIL where ID_VOEUX_ADMIS = " & idVoeux & ""

            Dim cmd As New SqlCommand(rNombreChoix, con)

            nombreChoix = cmd.ExecuteScalar()

            Return nombreChoix
        End Using
    End Function

    Public Function ValiderCandidature(idVoeux As Decimal) As Boolean

        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rValiderCand As String

            rValiderCand = "UPDATE EM_ELEVE_MAITRE_CANDIDATURE_CRFPE " _
                & "SET VOEUX_CLOTURE = 1, DATE_CLOTURE = GETDATE() WHERE ID_VOEUX_ADMIS = " & idVoeux & ""

            Dim cmd As New SqlCommand(rValiderCand, con)

            Dim rst As Integer = cmd.ExecuteNonQuery()
            If rst > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function VerifCandValider(idVoeux As Decimal) As Boolean

        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rVerifCand As String

            rVerifCand = "SELECT count(ID_VOEUX_ADMIS) FROM EM_ELEVE_MAITRE_CANDIDATURE_CRFPE WHERE VOEUX_CLOTURE =1 And ID_VOEUX_ADMIS = " & idVoeux & ""

            Dim cmd As New SqlCommand(rVerifCand, con)
            Dim rst As Integer
            rst = cmd.ExecuteScalar()
            If rst > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function NombrePosteDispo(codeOption As String) As Integer
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rNbrePosteDispo As String

            rNbrePosteDispo = "SELECT	COUNT(EM_CRFPE_POSTE_DISPONIBLE.ID_CRFPE_DISPONIBLE) " _
                        & "FROM	EM_CRFPE_POSTE_DISPONIBLE INNER JOIN " _
                        & "ANNEE On EM_CRFPE_POSTE_DISPONIBLE.CODE_ANNEE = ANNEE.CODE_ANNEE " _
                        & "WHERE(ANNEE.ANNEE_ENCOURS_ELEVE_MAITRE = 1) " _
                        & "Group BY EM_CRFPE_POSTE_DISPONIBLE.CODE_OPTION " _
                        & "HAVING(EM_CRFPE_POSTE_DISPONIBLE.CODE_OPTION = '" & codeOption & "')"

            Dim cmd As New SqlCommand(rNbrePosteDispo, con)
            Dim rst As Integer
            rst = cmd.ExecuteScalar()
            Return rst
        End Using
    End Function

#End Region
End Class
