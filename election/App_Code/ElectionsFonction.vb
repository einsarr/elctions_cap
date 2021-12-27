Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Public Class ElectionsFonction
    Dim sconn As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString

    Public Function EnsDejaVote(ByVal id_ens As Integer) As Boolean
        Dim dejavote As Integer
        Using con As New SqlConnection(sconn)
            con.Open()
            'Dim cmd As New SqlCommand("select case when DATE_OUVERTURE_MOUVEMENT < GETDATE() then 1 else 0 end  as CLOTURE from ANNEE WHERE ANNEE_ENCOURS = 1")
            Dim cmd As New SqlCommand("SELECT ID_ENSEIGNANT FROM ELECTION_CAP_VOTE WHERE ID_ENSEIGNANT = " & id_ens, con)
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            While reader.Read()
                dejavote = reader.GetInt32(0)
            End While
            con.Close()
            reader.Close()
            If dejavote = 0 Then
                Return False
            Else
                Return True
            End If
        End Using
    End Function
End Class
