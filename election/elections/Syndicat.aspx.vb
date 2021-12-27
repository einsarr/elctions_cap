Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Partial Class elections_Syndicat
    Inherits System.Web.UI.Page

    Protected Sub btn_add_syndicat_Click(sender As Object, e As EventArgs) Handles btn_add_syndicat.Click
        Dim logo As String
        Dim photosg As String
        System.Threading.Thread.Sleep(5000)
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
        Dim folderpath As String = Server.MapPath("~/elections/images/")
        logo = TXT_CODE_SYNDICAT.Text & "_logo" & System.IO.Path.GetExtension(IMG_LOGO_SYNDICAT.FileName)
        photosg = TXT_CODE_SYNDICAT.Text & "_photosg" & System.IO.Path.GetExtension(IMG_PHOTO_SG_SYNDICAT.FileName)
        If Me.IMG_LOGO_SYNDICAT.HasFile Then
            IMG_LOGO_SYNDICAT.SaveAs(folderpath & logo)
            IMG_PHOTO_SG_SYNDICAT.SaveAs(folderpath & photosg)
        End If
        Dim query As String = "INSERT INTO ELECTION_CAP_SYNDICAT(CODE_SYNDICAT,LIBELLE_SYNDICAT,LOGO,PHOTO_SG) VALUES (@CODE_SYNDICAT,@LIBELLE_SYNDICAT,@LOGO,@PHOTO_SG)"
        Dim con As New SqlConnection(connectionString)
        Dim cmd As New SqlCommand(query, con)
        cmd.Parameters.AddWithValue("@CODE_SYNDICAT", TXT_CODE_SYNDICAT.Text)
        cmd.Parameters.AddWithValue("@LIBELLE_SYNDICAT", TXT_LIBELLE_SYNDICAT.Text)
        cmd.Parameters.AddWithValue("@LOGO", logo)
        cmd.Parameters.AddWithValue("@PHOTO_SG", photosg)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub

End Class
