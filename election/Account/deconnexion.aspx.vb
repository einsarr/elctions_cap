Imports System.Data.SqlClient
Imports System.Data
Partial Class _Deconnect
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Session("connexion_ok") = 0
        Session.Clear()
        Session.Abandon()
        Session.RemoveAll()
        Session.Clear()
        Response.Redirect("~/Default.aspx")
    End Sub
End Class
