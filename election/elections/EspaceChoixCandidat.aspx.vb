Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Partial Class elections_EspaceChoixCandidat
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'AfficherMessage("ok")
        'Dim con As New SqlConnection("Data Source=.;Initial Catalog=FUP;Integrated Security=True")
        'Dim sda As New SqlDataAdapter("SELECT * FROM ELECTION_CAP_CANDIDAT", con)
        'Dim dt = New DataTable()
        'sda.Fill(dt)
        'ListView1.DataSource = dt
        'ListView1.DataBind()
    End Sub
    'Protected Sub ListView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListView1.SelectedIndexChanged
    '    AfficherMessage("ok")
    'End Sub

    'Protected Sub LinkButton1_Click(sender As Object, e As EventArgs)
    '    AfficherMessage("ok")
    'End Sub
    'Fonction d'affichage de message en js
    Public Sub AfficherMessage(ByVal Message As String)
        Try
            Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
         & " alert(""" & Message & """); " _
    & "  </script>")
        Catch ex As Exception
            ex = Nothing
        End Try
    End Sub
    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim id_college As String = GridView1.SelectedRow.Cells(3).Text
        AfficherMessage("okk=" & id_college)

    End Sub

    Protected Sub OnConfirm(sender As Object, e As EventArgs)
        Dim confirmValue As String = Request.Form("confirm_value")
        If confirmValue = "Yes" Then
            'Response.Redirect("~/elections/Candidat.aspx?val=" & txtBox.Text)
            'ClientScript.RegisterStartupScript(Me.[GetType](), "alert", "alert('You clicked YES!')", True)
        Else
            'ClientScript.RegisterStartupScript(Me.[GetType](), "alert", "alert('You clicked NO!')", True)
        End If
    End Sub
End Class
