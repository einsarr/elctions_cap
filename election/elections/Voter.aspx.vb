
Partial Class elections_Voter
    Inherits System.Web.UI.Page
    Private election As New ElectionCAPCD
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If election.PeriodeOuvertureScrutin() = False Then
            Response.Redirect("~/Default.aspx")
        End If

    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs)

    End Sub

    Protected Sub consulter(sender As Object, e As EventArgs)
        'Dim item As ListViewItem = CType(sender, Control).NamingContainer()
        'Dim btn As Button = CType(sender, Button)


        'Dim monLbl As Label = CType(item.FindControl("ID_CANDIDAT"), Label)
        'Dim unLbl As String = monLbl.Text

        'Response.Write(unLbl)
    End Sub
    Protected Sub ListView1_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles ListView1.ItemCommand
        Label1.Text = e.CommandArgument.ToString
        Response.Redirect(String.Format("DetailVote.aspx?confirm={0}", Label1.Text))
    End Sub
    Protected Sub ListView1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ListView1.SelectedIndexChanged

    End Sub
End Class
