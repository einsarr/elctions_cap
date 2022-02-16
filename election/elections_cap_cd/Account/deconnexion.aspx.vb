
Partial Class _Deconnect
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Session("connexion_sso") = 1 Then
            Session("connexion_ok") = 0
            Session.Clear()
            Session.Abandon()
            Session.RemoveAll()
            Session.Clear()
            Response.Redirect("https://sso.education.sn/auth/realms/education/protocol/openid-connect/logout?redirect_uri=https://education.sn")
        Else
            Session("connexion_ok") = 0
            Session.Clear()
            Session.Abandon()
            Session.RemoveAll()
            Session.Clear()
            Response.Redirect("~/elections_cap_cd/Default.aspx")
        End If
        'Try
        '    Session("connexion_ok") = 0
        '    Session("Message") = ""
        '    'Session.Abandon()
        '    Response.Redirect("~/Default.aspx")
        'Catch ex As Exception
        '    'Session.Abandon()
        '    Session("connexion_ok") = 0
        '    Server.Transfer("~/Default.aspx")
        'End Try
    End Sub
End Class
