Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Partial Class elections_Candidat
    Inherits System.Web.UI.Page

    Protected Sub btn_add_candidat_Click(sender As Object, e As EventArgs) Handles btn_add_candidat.Click
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
        Dim query As String = "INSERT INTO ELECTION_CAP_CANDIDAT_LISTE(ID_ELECTEUR,ID_CANDIDAT,TYPE_CANDIDAT,RANG) VALUES (@ID_ELECTEUR,@ID_CANDIDAT,@TYPE_CANDIDAT,@RANG)"
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand(query, con)
        cmd.Parameters.AddWithValue("@ID_ELECTEUR", DLL_ELECTEUR.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID_CANDIDAT", DLL_CANDIDAT.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@TYPE_CANDIDAT", DDL_TYPE_CANDIDAT.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@RANG", TXT_RANG.Text)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub

    Public Sub AfficherMessage(ByVal Message As String)
        Try
            Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
         & " alert(""" & Message & """); " _
    & "  </script>")
        Catch ex As Exception
            ex = Nothing
        End Try
    End Sub

End Class
