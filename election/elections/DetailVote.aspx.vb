Imports System.Data.SqlClient
Imports System.Data
Partial Class elections_Detail
    Inherits System.Web.UI.Page
    Dim outils As New Outils

    Protected Sub BtnConfirmVote_Click(sender As Object, e As EventArgs) Handles BtnConfirmVote.Click
        Dim ipAdresse As String = outils.ipAdr()
        Dim navigateur As String = ""
        Dim paysUser As String = outils.Pays(ipAdresse)

        Dim sqlVote As New SqlCommand("INSERT INTO ELECTION_CAP_VOTE(ID_CANDIDAT) VALUES('" & Request.QueryString("confirm") & "')")
        outils.RunQuery(sqlVote)

        Dim sqlLogconnexionVote As New SqlCommand("INSERT INTO ELECTION_CAP_LOGS(MATRICULE, ADRESSE_IP, NAVIGATEUR,PAYS_CONNEXION) VALUES('" & Session("matricule_elect") & "' ,'" & ipAdresse & "','" & navigateur & "','" & paysUser & "')")
        outils.RunQuery(sqlLogconnexionVote)

        Dim sqlAVoter As New SqlCommand("UPDATE ELECTION_CAP_ELECTEUR SET A_VOTE=1 WHERE IDENTIFIANT_ELECTEUR='" & Session("id_elect") & "'")
        outils.RunQuery(sqlAVoter)
        Response.Redirect("~/Account/deconnexion.aspx")
    End Sub


    Public Sub AfficherMessage(ByVal Message As String)
        Try
            Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
         & " alert(""" & Message & """); " _
    & "  </script>")
        Catch ex As Exception
            ex = Nothing
        End Try
    End Sub
End Class
