Imports System.Data.SqlClient
Imports System.Data
Partial Class elections_cap_cd_Account_forgetPassword
    Inherits System.Web.UI.Page
    Private Property Timer As Object
    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        If IsNothing(Session("ASPCAPTCHA")) OrElse Session("ASPCAPTCHA").ToString.Trim.Length = 0 Then
            lblResult.Text = "Cet essai a expiré."
            lblResult.ForeColor = Drawing.Color.Red
        Else
            Dim TestValue As String = txtCaptcha.Text.Trim.ToUpper(System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))
            If StrComp(TestValue, Session("ASPCAPTCHA").ToString.Trim, CompareMethod.Text) = 0 Then
                'lblResult.Text = "CAPTCHA PASSED"
                lblResult.Text = ""
                lblResult.ForeColor = Drawing.Color.Green
                ModifPassword()
            Else
                lblResult.Text = "LE TEXTE NE CORRESPOND PAS A L'IMAGE"
                lblResult.ForeColor = Drawing.Color.Red
            End If
            '//IMPORTANT: You must remove session value for security after the CAPTCHA test//
            Session.Remove("ASPCAPTCHA")
            '//////////
        End If

        phTest.Visible = False
        phResult.Visible = True
    End Sub

    Protected Sub btnRetry_Click(sender As Object, e As System.EventArgs) Handles btnRetry.Click
        RelaodCaptcha()
    End Sub
    Protected Sub RelaodCaptcha()
        txtCaptcha.Text = ""
        phTest.Visible = True
        phResult.Visible = False
    End Sub




    Protected Sub ModifPassword()

        Try

            Dim sqlEns As New SqlCommand("SELECT " _
            & " ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, " _
            & " ENSEIGNANT.MATRICULE_ENSEIGNANT, " _
            & " ENSEIGNANT.MAIL_ENSEIGNANT, " _
            & " ENSEIGNANT.PRENOMS_ENSEIGNANT, " _
            & " ENSEIGNANT.NOM_ENSEIGNANT " _
& " FROM         ENSEIGNANT " _
& " WHERE     (upper(ENSEIGNANT.MATRICULE_ENSEIGNANT) = '" & TXT_Matricule.Text.ToUpper & "') " _
& " AND       (upper(ENSEIGNANT.MAIL_ENSEIGNANT) = '" & TXT_email1.Text.ToUpper & "')")

            Dim ResultSetEns As DataSet

            ResultSetEns = RunQuery(sqlEns)


            If ResultSetEns.Tables(0).Rows.Count > 0 Then

                Dim rowEns As DataRow
                'Dim dejaInscrit As Boolean
                For Each rowEns In ResultSetEns.Tables(0).Rows
                    Try

                        ' Session("id_ens_new") = rowEns("identifiant_enseignant").ToString

                        Dim prenom As String = rowEns("prenoms_enseignant").ToString
                        Dim nom As String = rowEns("nom_enseignant").ToString
                        Dim id_Ens As String = rowEns("identifiant_enseignant").ToString

                        Dim Passw As String
                        Dim Passwcrypt As String
                        Dim Cryp As New Crypto
                        Dim gPass As New Password

                        Passw = gPass.GeneratePassword(2, 5, 3, 5, 6, 1, 1)
                        Passwcrypt = Cryp.AES_Encrypt(Passw, "AxZD1&&é&é%é&&xDSDZA124_312143896")

                        ' AfficherMessage(Passwcrypt)




                        'AfficherMessage("Bonjour " & TXT_Prenoms.Text & " " & TXT_Nom.Text & ". Ton inscription est bien pris en compte. Ton mot de passe est :   " & CodeValid & "  . Tu peux le changer aprés la connexion")

                        Dim BodyMessage As String
                        Dim SujetMessage As String

                        SujetMessage = "Réinitialisation mot de passe MIRADOR/" & prenom & " " & nom & "-" & TXT_Matricule.Text

                        BodyMessage = "</html> " _
          & " <body> " _
          & "   <p> " _
          & "Bonjour " & prenom & " " & nom & ", Matricule " & TXT_Matricule.Text & "<br/> " _
          & "Votre nouveau mot de passe: <b>" & Passw & "</b><br/> " _
          & "Vous devez le changer à la prochaine connexion.<br/><br/> " _
          & "Pour accéder à Mirador cliquez sur le lien ci-après <a href='http://www.mirador.education.gouv.sn'>http://www.mirador.education.gouv.sn</a> <br/><br/> " _
          & "Equipe Mirador</p>" _
          & "</body> </html> "


                        Dim envoi As New Outils
                        Dim RepSmtpOK As Boolean
                        RepSmtpOK = envoi.EnvoiMail(TXT_email1.Text, SujetMessage, BodyMessage)

                        If RepSmtpOK Then

                            Dim sqlEnsUpdate As New SqlCommand("UPDATE ENSEIGNANT " _
         & " SET    PASSWORD_VALIDE = 0," _
         & "        PASSWORD_ENSEIGNANT = '" & Passwcrypt & "'" _
         & " WHERE  IDENTIFIANT_ENSEIGNANT ='" & id_Ens & "'")


                            Dim ResultSetEnsUpdate As DataSet
                            ResultSetEnsUpdate = RunQuery(sqlEnsUpdate)
                            AfficherMessage("Votre mot de passe est réinitialisé. Un mot de passe vous est envoyé à votre adresse email " & TXT_email1.Text & ". Vous devez le changer à la premiere connexion.")
                        Else
                            AfficherMessage("Modification impossible en ce moment! Merci de ré-essayer plus tard.")
                        End If

                        'AfficherMessage("Bienvenue à Mirador, votre code de confirmation est le " & CodeValid)


                    Catch ex As Exception
                        AfficherMessage("Modification impossible!")
                        RelaodCaptcha()
                    End Try
                Next


                initialiserChamps()
                Server.Transfer("~/Account/connexion.aspx")
            Else


                AfficherMessage("Le matricule et/ou le mail saisis ne correspondent pas!")
                TXT_Matricule.Focus()
                RelaodCaptcha()
            End If


        Catch ex As Exception

        End Try
    End Sub

    Function RunQuery(ByVal sqlQuery As SqlCommand) As DataSet
        Dim connectionString As String
        connectionString =
            ConfigurationManager.ConnectionStrings _
            ("FUPConnectionString").ConnectionString
        Dim dbConnection As New SqlConnection
        dbConnection.ConnectionString = connectionString
        Dim dbAdapter As New SqlDataAdapter
        dbAdapter.SelectCommand = sqlQuery
        sqlQuery.Connection = dbConnection
        Dim resultsDataSet As DataSet = New DataSet
        Try
            dbAdapter.Fill(resultsDataSet)
        Catch ex As Exception
            'LabelMsg.Text = "Impossible de faire cette operation!"
        End Try
        Return resultsDataSet
    End Function

    Sub initialiserChamps()
        Try
            Me.TXT_Matricule.Text = ""

            Me.TXT_email1.Text = ""

            Me.TXT_Matricule.Focus()


        Catch ex As Exception

        End Try
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
