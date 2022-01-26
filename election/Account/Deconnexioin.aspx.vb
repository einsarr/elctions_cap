
Partial Class nouveau_sortant_Account_Deconnexioin
    Inherits System.Web.UI.Page

    Private Sub nouveau_sortant_Account_Deconnexioin_Load(sender As Object, e As EventArgs) Handles Me.Load
        Session("id_ens") = Nothing
        Session("t_matricule") = Nothing
        Session("t_cni") = Nothing
        Session("t_nom") = Nothing
        Session("t_prenoms") = Nothing
        Session("pass_valid") = Nothing
        Session("passw") = Nothing

        Response.Redirect("~/nouveau_sortant/Default.aspx")
    End Sub
End Class
