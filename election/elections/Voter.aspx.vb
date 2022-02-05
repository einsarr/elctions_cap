
Partial Class elections_Voter
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'If Session("connexion_ok") = 0 Then
        '    Response.Redirect("~/Account/connexion.aspx")
        'End If

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
        Response.Redirect(String.Format("Detail.aspx?ID={0}", Label1.Text))
    End Sub
End Class
