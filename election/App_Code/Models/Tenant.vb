Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Module Tenant
    Dim scon As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString

    Public Function Tenant() As String
        Dim url As String = HttpContext.Current.Request.Url.AbsoluteUri
        If url.Contains("mfpaa") Then
            Return "mfpaa"
        Else
            Return "men"
        End If
    End Function

    Public Function GetMinistereEnseignant(matricule As String) As String
        Dim ministere As String

        'On recupere l'id de la candidature
        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            Dim rNombreChoix As String

            rNombreChoix = "SELECT  MINISTERE.SIGLE_MINISTERE FROM ENSEIGNANT INNER JOIN ENSEIGNANT_ETABLISSEMENT " _
            & " ON ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT INNER JOIN " _
            & " ETABLISSEMENT ON ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT INNER JOIN " _
            & " SYSTEME_ENSEIGNEMENT ON ETABLISSEMENT.CODE_SYSTEME = SYSTEME_ENSEIGNEMENT.CODE_SYSTEME INNER JOIN " _
            & " MINISTERE ON SYSTEME_ENSEIGNEMENT.ID_MINISTERE = MINISTERE.ID_MINISTERE " _
            & " WHERE       (ENSEIGNANT.MATRICULE_ENSEIGNANT = '" & matricule & "')"

            Dim cmd As New SqlCommand(rNombreChoix, con)

            ministere = cmd.ExecuteScalar()

            Return ministere
        End Using
    End Function


    Public Function CanConnectTenant(tenant As String, ministere As String) As Boolean

        If ministere.ToLower() = tenant.ToLower() Then
            Return True
        Else
            Return False
        End If
    End Function

End Module

