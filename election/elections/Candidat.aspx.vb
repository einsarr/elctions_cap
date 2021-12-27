﻿Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Partial Class elections_Candidat
    Inherits System.Web.UI.Page




    Protected Sub btn_add_candidat_Click(sender As Object, e As EventArgs) Handles btn_add_candidat.Click
        Dim photo_candicat As String
        System.Threading.Thread.Sleep(5000)
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
        Dim folderpath As String = Server.MapPath("~/elections/images/")
        photo_candicat = DLL_SYNDICAT.SelectedValue.ToString & "_photocandidat" & System.IO.Path.GetExtension(IMG_PHOTO_CANDIDAT.FileName)
        If Me.IMG_PHOTO_CANDIDAT.HasFile Then
            IMG_PHOTO_CANDIDAT.SaveAs(folderpath & photo_candicat)
        End If
        Dim query As String = "INSERT INTO ELECTION_CAP_CANDIDAT(ID_ENSEIGNANT,ID_SYNDICAT,ID_COLLEGE,PHOTO_CANDIDAT) VALUES (@ID_ENSEIGNANT,@ID_SYNDICAT,@ID_COLLEGE,@PHOTO_CANDIDAT)"
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand(query, con)
        cmd.Parameters.AddWithValue("@ID_ENSEIGNANT", DLL_ENSEIGNANT.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID_SYNDICAT", DLL_SYNDICAT.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@ID_COLLEGE", DLL_COLLGEE.SelectedValue.ToString)
        cmd.Parameters.AddWithValue("@PHOTO_CANDIDAT", photo_candicat)
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
