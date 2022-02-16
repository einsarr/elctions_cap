Imports System.Data.SqlClient
Imports System.Data
Partial Class elections_cap_cd_Account_Inscri_ption
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
                lblResult.ForeColor = Drawing.Color.Blue
                Inscription()
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

    Protected Sub Inscription()

        Try

            Dim sqlEns As New SqlCommand("SELECT " _
                & " CAP.MATRICULE_ELECTEUR, CAP.IDENTIFIANT_ELECTEUR, CAP.NIN_ELECTEUR,  CAP.NOM_ELECTEUR, " _
                & " CAP.PRENOM_ELECTEUR, CAP.PASSWORD_ELECTEUR " _
                & " FROM ELECTION_CAP_ELECTEUR AS CAP " _
                & " WHERE(upper(CAP.MATRICULE_ELECTEUR) = '" & TXT_Matricule.Text.ToUpper & "') " _
                & " AND(upper(replace(CAP.PRENOM_ELECTEUR,' ', '')) = '" & TXT_Prenom.Text.ToUpper.Replace(" ", "") & "') " _
                & " AND(CAP.NIN_ELECTEUR='" & TXT_CNI.Text & "') " _
                & " AND(CAP.PASSWORD_ELECTEUR IS NULL) " _
                & " AND(upper(CAP.NOM_ELECTEUR) = '" & TXT_Nom.Text.ToUpper & "')")

            Dim ResultSetEns As DataSet
            ResultSetEns = RunQuery(sqlEns)


            If ResultSetEns.Tables(0).Rows.Count > 0 Then

                Dim rowEns As DataRow
                'Dim dejaInscrit As Boolean
                For Each rowEns In ResultSetEns.Tables(0).Rows
                    Try

                        Session("id_elect_new") = rowEns("IDENTIFIANT_ELECTEUR").ToString

                        '-> Vérifie les doublons
                        '--> Vérifie l'existence du matricule
                        Dim sqlMatricule As New SqlCommand("select NIN_ELECTEUR FROM ELECTION_CAP_ELECTEUR WHERE NIN_ELECTEUR = '" & TXT_CNI.Text & "' AND IDENTIFIANT_ELECTEUR <> " & rowEns("IDENTIFIANT_ELECTEUR").ToString)
                        Dim ResultSetMatricule As DataSet
                        ResultSetMatricule = RunQuery(sqlMatricule)

                        '--> Vérifie l'existence du mail
                        Dim sqlMail As New SqlCommand("SELECT NIN_ELECTEUR FROM ELECTION_CAP_ELECTEUR WHERE EMAIL_ELECTEUR ='" & TXT_email.Text & "'")
                        Dim ResultSetMail As DataSet
                        ResultSetMail = RunQuery(sqlMail)

                        '--> Vérifie l'existence du TElephone
                        Dim sqlPhone As New SqlCommand("SELECT NIN_ELECTEUR FROM ELECTION_CAP_ELECTEUR WHERE TELEPHONE_ELECTEUR ='" & TXT_Portable.Text & "'")
                        Dim ResultSetPhone As DataSet
                        ResultSetPhone = RunQuery(sqlPhone)
                        'AfficherMessage(ResultSetPhone.Tables(0).Rows.Count)
                        ' Si pas de doublons
                        If ResultSetMatricule.Tables(0).Rows.Count = 0 _
                            And ResultSetMail.Tables(0).Rows.Count = 0 _
                            And ResultSetPhone.Tables(0).Rows.Count = 0 _
                                Then

                            Dim Passw As String
                            Dim Passwcrypt As String
                        Dim Cryp As New Crypto
                        Dim gPass As New Password

                        Passw = gPass.GeneratePassword(2, 5, 3, 5, 6, 1, 1)
                        Passwcrypt = Cryp.AES_Encrypt(Passw, "AxZD1&&é&é%é&&xDSDZA124_312143896")

                        Dim BodyMessage As String
                        Dim SujetMessage As String

                        SujetMessage = "Inscription MIRADOR/" & TXT_Prenom.Text & " " & TXT_Nom.Text & "-" & TXT_Matricule.Text

                        BodyMessage = "</html> " _
                          & " <body> " _
                          & "   <p> " _
                          & "Bonjour " & TXT_Prenom.Text & " " & TXT_Nom.Text & ", Matricule " & TXT_Matricule.Text & ".<br/> " _
                          & "Nous vous remercions pour votre inscription sur Mirador, Portail RH du MEN/MFPAA.<br/><br/> " _
                          & "Votre mot de passe initial est : <b>" & Passw & "</b><br/> " _
                          & "Vous devez le changer à la premiére connexion.<br/><br/> " _
                          & "Pour accéder à Mirador cliquez sur le lien ci-après <a href='http://www.mirador.education.gouv.sn'>http://www.mirador.education.gouv.sn</a> <br/><br/> " _
                          & "Equipe Mirador</p>" _
                          & "</body> </html> "

                        'Dim envoi As New Outils
                        'Dim RepSmtpOK As Boolean
                        '    RepSmtpOK = envoi.EnvoiMail(TXT_email.Text, SujetMessage, BodyMessage)

                        Dim sqlEnsUpdate As New SqlCommand("UPDATE ELECTION_CAP_ELECTEUR " _
                                 & " SET    EMAIL_ELECTEUR = '" & TXT_email.Text & "'," _
                                 & "        TELEPHONE_ELECTEUR = '" & TXT_Portable.Text & "'," _
                                 & "        ID_DEPARTEMENT = '" & DDL_DEPARTEMENT.SelectedValue.ToString & "'," _
                                 & "        PASSWORD_VALIDE = 0," _
                                 & "        PASSWORD_ELECTEUR = '" & Passwcrypt & "'" _
                                 & " WHERE  IDENTIFIANT_ELECTEUR ='" & Session("id_elect_new") & "'")


                        Dim ResultSetEnsUpdate As DataSet
                        ResultSetEnsUpdate = RunQuery(sqlEnsUpdate)

                        AfficherMessage("Votre inscription est effective. Un mot de passe vous est envoyé à votre adresse email " & TXT_email.Text & ". Vous devez le changer à la premiere connexion.")
                        Server.Transfer("~/default.aspx")
                        initialiserChamps()

                        'Else
                        '    AfficherMessage("Inscription impossible en ce moment! Merci de ré-essayer plus tard.")
                        'End If

                        'AfficherMessage("Bienvenue à Mirador, votre code de confirmation est le " & CodeValid)

                        Else
                        AfficherMessage("Ce numéro de CNI, de teléphone ou adresse email est déja utilisé ! Merci de vérifier ou demander assistance en ligne.")
                        TXT_Matricule.Focus()
                            RelaodCaptcha()
                        End If
        Catch ex As Exception
            'AfficherMessage("Inscription impossible! Merci de vérifier la saisie.")
            'RelaodCaptcha()
        End Try
                Next

                'initialiserChamps()
                'Server.Transfer("~/default.aspx")
            Else
                AfficherMessage("Informations incorrectes! veuillez ré-essayer ou demander assistance en ligne à partir de la page d'accueil de Mirador.")
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
            Me.TXT_Nom.Text = ""
            Me.TXT_Prenom.Text = ""
            Me.TXT_CNI.Text = ""
            Me.TXT_email.Text = ""
            Me.TXT_email.Text = ""
            Me.TXT_Portable.Text = ""
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
