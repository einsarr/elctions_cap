Imports System.Data.SqlClient
Partial Class elections_cap_cd_Résultats_CG_CL
    Inherits System.Web.UI.Page
    Dim outils As New Outils
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim sqlAVoter As New SqlCommand("UPDATE ELECTION_CAP_CANDIDAT SET ETAT_CANDIDAT=0 WHERE ID_CANDIDAT='" & 2 & "'")
        outils.RunQuery(sqlAVoter)
        Response.Redirect("~/elections_cap_cd/Account/deconnexion.aspx")
    End Sub
End Class
