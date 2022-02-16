Imports System.Web.Routing
Imports System.IO
Imports System.Text
Imports System.Security.Cryptography
Partial Class elections_Voter
    Inherits System.Web.UI.Page
    Private election As New ElectionCAPCD
    Dim secure As New SecureQueryString

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("connexion_ok") = 1 Then
            If election.PeriodeOuvertureScrutin() = False Then
                Response.Redirect("~/elections_cap_cd/Default.aspx")
            End If
        Else
            Response.Redirect("~/elections_cap_cd/Default.aspx")
        End If
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs)
    End Sub

    Protected Sub consulter(sender As Object, e As EventArgs)
    End Sub

    Protected Sub ListView1_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles ListView1.ItemCommand
        Dim confirm As String = HttpUtility.UrlEncode(secure.Encrypt(e.CommandArgument.ToString))
        Response.Redirect(String.Format("DetailVote.aspx?confirm={0}", confirm))
    End Sub

    Protected Sub ListView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListView1.SelectedIndexChanged
    End Sub
End Class
