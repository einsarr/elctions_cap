
Partial Class elections_cap_cd_Statistiques
    Inherits System.Web.UI.Page
    Private election As New ElectionCAPCD
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Label1.Text = (Format((election.NombreDeVotants() / election.NombreDInscrits()) * 100, "#.00")).ToString + "%"
    End Sub
End Class
