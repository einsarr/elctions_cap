Imports System.Data.SqlClient
Imports System.IO
Imports System.Text
Imports System.Security.Cryptography
Imports System.Data
Partial Class elections_Detail
    Inherits System.Web.UI.Page
    Dim outils As New Outils
    Dim secure As New SecureQueryString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Session("connexion_ok") = 1 Then
            Dim electeur As Integer = secure.Decrypt(HttpUtility.UrlDecode(Request.QueryString("confirm")))
            'Label1.Text = nbre.ToString
            Dim sqlListCandidats As New SqlCommand("SELECT EC.ID_CANDIDAT_LISTE, EC.ID_ELECTEUR,
            EC.ID_CANDIDAT, EC.RANG, E.PRENOM_ELECTEUR, E.NOM_ELECTEUR,EC.TYPE_CANDIDAT,CO.LIBELLE_CORPS 
            FROM ELECTION_CAP_CANDIDAT_LISTE AS EC 
            INNER JOIN ELECTION_CAP_ELECTEUR AS E ON E.IDENTIFIANT_ELECTEUR = EC.ID_ELECTEUR 
            INNER JOIN ELECTION_CAP_CANDIDAT AS C ON C.ID_CANDIDAT = EC.ID_CANDIDAT
            INNER JOIN ELECTION_CAP_CORPS CO ON CO.ID_CORPS=E.ID_CORPS
            WHERE C.ID_CANDIDAT = '" & electeur & "' ORDER BY EC.RANG")
            Dim sqlCandidatChoisi As New SqlCommand("SELECT ELECTION_CAP_SYNDICAT.CODE_SYNDICAT FROM  ELECTION_CAP_SYNDICAT INNER JOIN ELECTION_CAP_CANDIDAT ON ELECTION_CAP_SYNDICAT.ID_SYNDICAT = ELECTION_CAP_CANDIDAT.ID_SYNDICAT WHERE ID_CANDIDAT = '" & electeur & "'")

            Gv_lstCandidats.DataSource = outils.RunQuery(sqlListCandidats)
            Gv_lstCandidats.DataBind()

            Dtv_CandidatChoisi.DataSource = outils.RunQuery(sqlCandidatChoisi)
            Dtv_CandidatChoisi.DataBind()

            PanelConfirmVote.Visible = False
        Else
            Response.Redirect("~/elections_cap_cd/Default.aspx")
        End If

    End Sub

    Protected Sub BtnConfirmVote_Click(sender As Object, e As EventArgs) Handles BtnConfirmVote.Click
        PanelConfirmVote.Visible = True
        BtnConfirmVote.Visible = False
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

    Protected Sub bt_poursuivreVote_Click(sender As Object, e As EventArgs) Handles bt_poursuivreVote.Click
        Dim ipAdresse As String = outils.ipAdr()
        Dim navigateur As String = ""
        Dim paysUser As String = outils.Pays(ipAdresse)
        Dim electeur As Integer = secure.Decrypt(HttpUtility.UrlDecode(Request.QueryString("confirm")))

        Dim sqlVote As New SqlCommand("INSERT INTO ELECTION_CAP_VOTE(ID_CANDIDAT) VALUES('" & electeur & "')")
        outils.RunQuery(sqlVote)

        Dim sqlLogconnexionVote As New SqlCommand("INSERT INTO ELECTION_CAP_LOGS(MATRICULE, ADRESSE_IP, NAVIGATEUR,PAYS_CONNEXION) VALUES('" & Session("matricule_elect") & "' ,'" & ipAdresse & "','" & navigateur & "','" & paysUser & "')")
        outils.RunQuery(sqlLogconnexionVote)

        Dim sqlAVoter As New SqlCommand("UPDATE ELECTION_CAP_ELECTEUR SET A_VOTE=1 WHERE IDENTIFIANT_ELECTEUR='" & Session("id_elect") & "'")
        outils.RunQuery(sqlAVoter)
        Response.Redirect("~/elections_cap_cd/Account/deconnexion.aspx")
    End Sub
    Protected Sub bt_annulerVote_Click(sender As Object, e As EventArgs) Handles bt_annulerVote.Click
        BtnConfirmVote.Visible = True
    End Sub

End Class
