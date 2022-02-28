Imports System.Data.SqlClient
Imports System.Data
Partial Class Account_validpassw
    Inherits System.Web.UI.Page
    Private election As New ElectionCAPCD
    Sub initialiserChamps()
        Try
            TXT_PasswordNew.Text = ""
            TXT_PasswordNew2.Text = ""
            TXT_PasswordInit.Focus()
        Catch ex As Exception

        End Try
    End Sub

    Public Sub AfficherMessage(ByVal Message As String)
        Try

            Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
         & " alert(""" & Message & """); " _
    & "  </script>")

        Catch ex As Exception
            'ex = Nothing

        End Try
    End Sub
    
    Protected Sub BtValid_Click(sender As Object, e As EventArgs) Handles BtValid.Click
        Try
            If TXT_PasswordNew.Text <> TXT_PasswordNew2.Text Then
                LabelMsg.Text = "Le nouveau mot de passe et sa confirmation ne correspondent pas! Merci de vérifier."
                initialiserChamps()

            Else
                ModifPassWord()

            End If
        Catch ex As Exception
        End Try
    End Sub


    Sub ModifPassWord()
        Try
            Dim Passwcrypt As String
            Dim Cryp As New Crypto

            Passwcrypt = Cryp.AES_Encrypt(TXT_PasswordNew.Text, "AxZD1&&é&é%é&&xDSDZA124_312143896")
            'TODO : Tester si ancien password OK

            If Session("passw").ToString = TXT_PasswordInit.Text Then
                Dim sqlEnsUpdate As New SqlCommand("UPDATE ELECTION_CAP_ELECTEUR " _
                    & " SET PASSWORD_VALIDE = 1," _
                    & " PASSWORD_ELECTEUR = '" & Passwcrypt & "'" _
                    & " WHERE IDENTIFIANT_ELECTEUR ='" & Session("id_elect").ToString & "'")

                'Remise nouveau password en session
                Session("passw") = TXT_PasswordNew.Text
                Dim ResultSetEns As DataSet
                Dim con As New Connect
                ResultSetEns = con.RunQuery(sqlEnsUpdate)

                AfficherMessage("Changement de mot de passe bien effectué.")
                If election.ADEJAVOTE(Session("id_elect")) Then
                    AfficherMessage("Vous avez déjà voté")
                Else
                    Session("connexion_ok") = 1
                    Server.Transfer("~/elections_cap_cd/Voter.aspx")
                End If
            Else
                LabelMsg.Text = "Mot de passe initial incorrect"
            End If


        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        LabelMsg.Text = ""
        Try
            LabelMatricule.Text = Session("prenom_elect") & " " & Session("nom_elect") & ", Matricule " & Session("matricule_elect")
            If Session("id_elect") = "" Then
                Server.Transfer("~/elections_cap_cd/Default.aspx")
            End If
        Catch ex As Exception
            Server.Transfer("~/elections_cap_cd/Default.aspx")
        End Try
    End Sub
End Class
