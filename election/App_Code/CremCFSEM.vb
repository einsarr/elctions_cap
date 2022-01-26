Imports System.Data
Imports System.Data.SqlClient

Public Class CremCFSEM
    Dim scon As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Private out As New Outils

#Region "Vérif concordance code et date de naiisance"

    Public Function VerifConcordanceCodeDateNaiss(ByVal codeSms As String, ByVal dateNaiss As String) As Boolean

        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim existenceCode As Boolean
            Dim existenceDate As Boolean
            Dim existenceCdDt As Boolean

            'Si le code existe dans la base
            existenceCode = VerifExistenceCode(codeSms)
            If existenceCode Then

                'Si la date de naissance existe dans la baase
                existenceDate = VerifExistenceDateNaiss(dateNaiss)
                If existenceDate Then

                    'Si la concordance code date naissance existe
                    existenceCdDt = VerifExistenceCodeDate(codeSms, dateNaiss)
                    If existenceCdDt Then

                        'On renvoit true
                        Return True
                    Else

                        'pas de concordance code date
                        Return False
                    End If

                Else
                    'La date de naissance n'existe pas dans la base
                    Return False
                End If

            Else
                'le code n'existe pas dans la baase
                Return False
            End If
        End Using
    End Function

    Public Function VerifExistenceCode(ByVal codeSms As String) As Boolean

        Dim CodeExist As Integer
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rExistenceCode As String

            rExistenceCode = "SELECT COUNT(ID_ELEVE_MAITRE) as EXIST FROM EM_ELEVE_MAITRE WHERE CODE_SMS_ADMIS_CFSEM = '" & codeSms & "'"

            Dim cmd As New SqlCommand(rExistenceCode, con)

            CodeExist = cmd.ExecuteScalar()
            If CodeExist > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function VerifExistenceDateNaiss(ByVal dateNaiss As String) As Boolean

        Dim DateExist As Integer
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rExistenceDate As String

            rExistenceDate = "SELECT COUNT(ID_ELEVE_MAITRE) As EXIST FROM EM_ELEVE_MAITRE WHERE DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "'"

            Dim cmd As New SqlCommand(rExistenceDate, con)

            DateExist = cmd.ExecuteScalar()
            If DateExist > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

    Public Function VerifExistenceCodeDate(ByVal codeSms As String, ByVal dateNaiss As String) As Boolean

        Dim CdDtExist As Integer
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rExistenceCdDt As String

            rExistenceCdDt = "SELECT COUNT(ID_ELEVE_MAITRE) FROM EM_ELEVE_MAITRE WHERE CODE_SMS_ADMIS_CFSEM = '" & codeSms & "' and DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "'"

            Dim cmd As New SqlCommand(rExistenceCdDt, con)

            CdDtExist = cmd.ExecuteScalar()
            If CdDtExist > 0 Then
                Return True
            Else
                Return False
            End If
        End Using
    End Function

#End Region

#Region "Données du candidat admis"

    'On passe par le code et la date naiss
    Public Function RecupInfoAdmis(ByVal codeSms As String, ByVal dateNaiss As String) As Admis

        Dim ad As New Admis
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rExistenceCdDt As String

            rExistenceCdDt = "SELECT ID_ELEVE_MAITRE, NOM_ELEVE_MAITRE," _
                             & " PRENOMS_ELEVE_MAITRE, CNI_ELEVE_MAITRE, " _
                             & " OPTION_ENSEIGNEMENT FROM EM_ELEVE_MAITRE " _
                             & " WHERE CODE_SMS_ADMIS_CFSEM = '" & codeSms & "' and DATE_NAISS_ELEVE_MAITRE = '" & dateNaiss & "'"

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

            rInitieCand = "INSERT INTO EM_CFSEM_VOEUX_ADMIS " _
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

            rExistenceCode = "SELECT count(ID_VOEUX_ADMIS) FROM EM_CFSEM_VOEUX_ADMIS where ID_ELEVE_MAITRE = " & idEleveMaitre & ""

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

            getIdCand = "SELECT ID_VOEUX_ADMIS FROM EM_CFSEM_VOEUX_ADMIS WHERE ID_ELEVE_MAITRE = " & idEleveMaitre & ""

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

            rNombreChoix = "SELECT count(ID_DETAIL_VOEUX_ADMIS) FROM EM_CFSEM_VOEUX_ADMIS_DETAIL where ID_VOEUX_ADMIS = " & idVoeux & ""

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

            rValiderCand = "UPDATE EM_CFSEM_VOEUX_ADMIS " _
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

            rVerifCand = "SELECT count(ID_VOEUX_ADMIS) FROM EM_CFSEM_VOEUX_ADMIS WHERE VOEUX_CLOTURE =1 AND ID_VOEUX_ADMIS = " & idVoeux & ""

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

            rNbrePosteDispo = "SELECT count(ID_POSTE_DISPONIBLE) FROM EM_CFSEM_POSTE_DISPONIBLE " _
                            & "WHERE NOMBRE_DISPONIBLE > 0 and CODE_OPTION = '" & codeOption & "' and CODE_ANNEE = " _
                            & "(SELECT CODE_ANNEE FROM ANNEE WHERE ANNEE_ENCOURS_ELEVE_MAITRE = 1)"

            Dim cmd As New SqlCommand(rNbrePosteDispo, con)
            Dim rst As Integer
            rst = cmd.ExecuteScalar()
            Return rst
        End Using
    End Function
#End Region

#Region "Postes et demande"

    Public Class PosteDispo

        Public Property idPoste As Integer
        Public Property codeOption As String
        Public Property codeAnnee As String
        Public Property code04 As String
        Public Property nbreDispo As Decimal

    End Class
    Public Class Affectation

        Public Property annee As String
        Public Property matricule As String
        Public Property ia As String
        Public Property ief As String

    End Class

    Public Function getPosteDispoAll(codeOption As String) As List(Of PosteDispo)
        Dim listePosteDispo As New List(Of PosteDispo)

        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rListePosteDispo As String

            rListePosteDispo = "SELECT ID_POSTE_DISPONIBLE, CODE_OPTION, CODE_ANNEE, " _
                    & "code04, NOMBRE_DISPONIBLE FROM EM_CFSEM_POSTE_DISPONIBLE " _
                    & "where CODE_OPTION =" & codeOption & ""

            Dim cmd As New SqlCommand(rListePosteDispo, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.HasRows Then

                While reader.Read()
                    Dim pstDispo As New PosteDispo()

                    pstDispo.idPoste = reader.GetInt32(0)
                    pstDispo.codeOption = reader.GetString(1)
                    pstDispo.codeAnnee = reader.GetString(2)
                    pstDispo.code04 = reader.GetString(3)
                    pstDispo.nbreDispo = reader.GetDecimal(4)

                    listePosteDispo.Add(pstDispo)
                End While

            End If
        End Using

        Return listePosteDispo
    End Function

    Public Function PosteDejaDemande(idVoeux As Decimal, idPoste As Integer) As Boolean
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rPosteDejaDemande As String

            rPosteDejaDemande = "SELECT COUNT(1) FROM EM_CFSEM_VOEUX_ADMIS_DETAIL " _
                                & " WHERE ID_VOEUX_ADMIS = " & idVoeux & " and ID_POSTE_DISPONIBLE = " & idPoste & ""

            Dim cmd As New SqlCommand(rPosteDejaDemande, con)
            Dim rst As Integer = cmd.ExecuteScalar()
            If rst > 0 Then
                'le poste est deja choisi
                Return True
            Else
                'Poste non choisi
                Return False
            End If
        End Using
    End Function

    Public Function affectationFaite() As Boolean
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rPosteDejaDemande As String

            rPosteDejaDemande = "SELECT ISNULL(CFSEM_DATE_AFFECTATION, getdate()+1) FROM ANNEE WHERE ANNEE_ENCOURS_ELEVE_MAITRE =1"

            Dim cmd As New SqlCommand(rPosteDejaDemande, con)
            Dim dateAffect As Date = cmd.ExecuteScalar()
            If dateAffect <= Date.Now Then
                'le poste est deja choisi
                Return True
            Else
                'Poste non choisi
                Return False
            End If
        End Using

    End Function

    Public Function GetAffectation(idEleveMaitre As Integer) As Affectation
        Dim affect As New Affectation
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rAffect As String

            rAffect = "SELECT ANNEE.LIBELLE_ANNEE, EM_CFSEM_AFFECTATION.MATRICULE, " _
                        & "ATLAS_SYS_DEF_ALL.IA, ATLAS_SYS_DEF_ALL.IDEN FROM EM_CFSEM_AFFECTATION " _
                        & "INNER JOIN ANNEE ON EM_CFSEM_AFFECTATION.CODE_ANNEE = ANNEE.CODE_ANNEE " _
                        & "INNER JOIN EM_CFSEM_POSTE_DISPONIBLE ON EM_CFSEM_AFFECTATION.ID_POSTE_DISPONIBLE " _
                        & "= EM_CFSEM_POSTE_DISPONIBLE.ID_POSTE_DISPONIBLE And " _
                        & "ANNEE.CODE_ANNEE = EM_CFSEM_POSTE_DISPONIBLE.CODE_ANNEE INNER JOIN " _
                        & "ATLAS_SYS_DEF_ALL ON EM_CFSEM_POSTE_DISPONIBLE.code04 = ATLAS_SYS_DEF_ALL.code04 " _
                        & "WHERE (EM_CFSEM_AFFECTATION.ID_ELEVE_MAITRE = " & idEleveMaitre & ") " _
                        & "GROUP BY ANNEE.LIBELLE_ANNEE, EM_CFSEM_AFFECTATION.MATRICULE, " _
                        & "ATLAS_SYS_DEF_ALL.IA, ATLAS_SYS_DEF_ALL.IDEN"

            Dim cmd As New SqlCommand(rAffect, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.HasRows Then

                While reader.Read()

                    affect.annee = reader.GetString(0)
                    affect.matricule = reader.GetString(1)
                    affect.ia = reader.GetString(2)
                    affect.ief = reader.GetString(3)

                End While
            End If
        End Using

        Return affect
    End Function


    Public Function PeutCandidater() As Boolean

        Dim date_ouverture As DateTime
        Dim date_cloture As DateTime
        Using con As New SqlConnection(scon)

            con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT isnull(CFSEM_DATE_OUVERTURE_CAND, GETDATE()+1), isnull(CFSEM_DATE_FERMETURE_CAND, GETDATE()-1) FROM ANNEE " _
                                         & "WHERE (ANNEE_ENCOURS_ELEVE_MAITRE = 1)", con)
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
End Class
