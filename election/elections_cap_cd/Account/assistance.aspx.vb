Imports System.Data.SqlClient
Imports System.Data
Partial Class elections_cap_cd_Account_assistance
    Inherits System.Web.UI.Page
    Private Property Timer As Object
    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        'If IsNothing(Session("ASPCAPTCHA")) OrElse Session("ASPCAPTCHA").ToString.Trim.Length = 0 Then
        '    lblResult.Text = "Cet essai a expiré."
        '    lblResult.ForeColor = Drawing.Color.Red
        'Else
        '    Dim TestValue As String = txtCaptcha.Text.Trim.ToUpper(System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))
        '    If StrComp(TestValue, Session("ASPCAPTCHA").ToString.Trim, CompareMethod.Text) = 0 Then
        '        'lblResult.Text = "CAPTCHA PASSED"
        '        lblResult.Text = ""
        '        lblResult.ForeColor = Drawing.Color.Green
        '        Inscription()
        '    Else
        '        lblResult.Text = "LE TEXTE NE CORRESPOND PAS A L'IMAGE"
        '        lblResult.ForeColor = Drawing.Color.Red
        '    End If
        '//IMPORTANT: You must remove session value for security after the CAPTCHA test//
        Session.Remove("ASPCAPTCHA")
        '//////////
        'End If

        'phTest.Visible = False
        'phResult.Visible = True
    End Sub

    'Protected Sub btnRetry_Click(sender As Object, e As System.EventArgs) Handles btnRetry.Click
    '    RelaodCaptcha()
    'End Sub
    'Protected Sub RelaodCaptcha()
    '    txtCaptcha.Text = ""
    '    phTest.Visible = True
    '    phResult.Visible = False
    'End Sub




    '    Protected Sub Inscription()

    '        Try

    '            Dim sqlEns As New SqlCommand("SELECT " _
    '            & " ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.date_naiss_enseignant,  ENSEIGNANT.NOM_ENSEIGNANT, " _
    '            & " ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.PASSWORD_ENSEIGNANT, ENSEIGNANT.CNI " _
    '& " FROM         ENSEIGNANT " _
    '& " WHERE     (upper(ENSEIGNANT.MATRICULE_ENSEIGNANT) = '" & TXT_Matricule.Text.ToUpper & "') " _
    '& " AND       (upper(replace(ENSEIGNANT.PRENOMS_ENSEIGNANT,' ', '')) = '" & TXT_Prenoms.Text.ToUpper.Replace(" ", "") & "') " _
    '& " AND       (isnull(ENSEIGNANT.CNI, '" & TXT_CNI.Text & "') = '" & TXT_CNI.Text & "') " _
    '& " AND       (ENSEIGNANT.date_naiss_enseignant = '" & TXT_DateNaiss.Text & "') " _
    '& " AND       (ENSEIGNANT.PASSWORD_ENSEIGNANT IS NULL) " _
    '& " AND       (upper(ENSEIGNANT.NOM_ENSEIGNANT) = '" & TXT_Nom.Text.ToUpper & "')")


    '            Dim ResultSetEns As DataSet
    '            ResultSetEns = RunQuery(sqlEns)


    '            If ResultSetEns.Tables(0).Rows.Count > 0 Then

    '                Dim rowEns As DataRow
    '                'Dim dejaInscrit As Boolean
    '                For Each rowEns In ResultSetEns.Tables(0).Rows
    '                    Try

    '                        Session("id_ens_new") = rowEns("identifiant_enseignant").ToString

    '                        '-> Vérifie les doublons
    '                        '--> Vérifie l'existence du matricule
    '                        Dim sqlMatricule As New SqlCommand("select CNI from ENSEIGNANT where CNI = '" & TXT_CNI.Text & "' and identifiant_enseignant <> " & rowEns("identifiant_enseignant").ToString)
    '                        Dim ResultSetMatricule As DataSet
    '                        ResultSetMatricule = RunQuery(sqlMatricule)
    '                        'AfficherMessage(sqlMatricule.CommandText.ToString)

    '                        '--> Vérifie l'existence du mail
    '                        Dim txtSQlMail As String

    '                        If Len(LTrim(RTrim(TXT_Email2.Text))) = 0 Then

    '                            txtSQlMail = "select CNI from ENSEIGNANT where (MAIL_ENSEIGNANT IN('" & TXT_email1.Text & "') OR MAIL_ENSEIGNANT2  IN('" & TXT_email1.Text & "'))"
    '                        Else

    '                            txtSQlMail = "select CNI from ENSEIGNANT where (MAIL_ENSEIGNANT IN('" & TXT_email1.Text & "','" & TXT_Email2.Text & "') OR MAIL_ENSEIGNANT2  IN('" & TXT_email1.Text & "', '" & TXT_Email2.Text & "'))"
    '                        End If

    '                        Dim sqlMail As New SqlCommand(txtSQlMail)
    '                        Dim ResultSetMail As DataSet
    '                        ResultSetMail = RunQuery(sqlMail)
    '                        'AfficherMessage(sqlMail.CommandText.ToString)

    '                        '--> Vérifie l'existence du TElephone

    '                        Dim txtSQlPhone As String

    '                        If Len(LTrim(RTrim(TXT_Portable2.Text))) = 0 Then

    '                            txtSQlPhone = "select CNI from ENSEIGNANT where (MAIL_ENSEIGNANT IN('" & TXT_Portable1.Text & "') OR MAIL_ENSEIGNANT2  IN('" & TXT_Portable1.Text & "'))"
    '                        Else

    '                            txtSQlPhone = "select CNI from ENSEIGNANT where (MAIL_ENSEIGNANT IN('" & TXT_Portable1.Text & "','" & TXT_Portable2.Text & "') OR MAIL_ENSEIGNANT2  IN('" & TXT_Portable1.Text & "', '" & TXT_Portable2.Text & "'))"
    '                        End If
    '                        Dim sqlPhone As New SqlCommand(txtSQlPhone)
    '                        Dim ResultSetPhone As DataSet
    '                        ResultSetPhone = RunQuery(sqlMail)
    '                        'AfficherMessage(sqlPhone.CommandText.ToString)

    '                        ' Si pas de doublons
    '                        If ResultSetMatricule.Tables(0).Rows.Count = 0 _
    '                            And ResultSetMail.Tables(0).Rows.Count = 0 _
    '                            And ResultSetPhone.Tables(0).Rows.Count = 0 _
    'Then


    '                            Dim Passw As String
    '                            Dim Passwcrypt As String
    '                            Dim Cryp As New Crypto
    '                            Dim gPass As New Password

    '                            Passw = gPass.GeneratePassword(2, 5, 3, 5, 6, 1, 1)
    '                            Passwcrypt = Cryp.AES_Encrypt(Passw, "AxZD1&&é&é%é&&xDSDZA124_312143896")

    '                            ' AfficherMessage(Passwcrypt)


    '                            If TXT_Email2.Text = "" Then
    '                                TXT_Email2.Text = " "

    '                            End If

    '                            If TXT_Portable2.Text = "" Then
    '                                TXT_Portable2.Text = "0"

    '                            End If

    '                            'AfficherMessage("Bonjour " & TXT_Prenoms.Text & " " & TXT_Nom.Text & ". Ton inscription est bien pris en compte. Ton mot de passe est :   " & CodeValid & "  . Tu peux le changer aprés la connexion")

    '                            Dim BodyMessage As String
    '                            Dim SujetMessage As String

    '                            SujetMessage = "Inscription MIRADOR/" & TXT_Prenoms.Text & " " & TXT_Nom.Text & "-" & TXT_Matricule.Text

    '                            BodyMessage = "</html> " _
    '              & " <body> " _
    '              & "   <p> " _
    '              & "Bonjour " & TXT_Prenoms.Text & " " & TXT_Nom.Text & ", Matricule " & TXT_Matricule.Text & ".<br/> " _
    '              & "Nous vous remercions pour votre inscription sur Mirador, Portail RH du MEN/MFPAA.<br/><br/> " _
    '              & "Votre mot de passe initial est : <b>" & Passw & "</b><br/> " _
    '              & "Vous devez le changer à la premiére connexion.<br/><br/> " _
    '              & "Pour accéder à Mirador cliquez sur le lien ci-après <a href='http://www.mirador.education.gouv.sn'>http://www.mirador.education.gouv.sn</a> <br/><br/> " _
    '              & "Equipe Mirador</p>" _
    '              & "</body> </html> "

    '                            Dim envoi As New Outils
    '                            Dim RepSmtpOK As Boolean
    '                            RepSmtpOK = envoi.EnvoiMail(TXT_email1.Text, SujetMessage, BodyMessage)

    '                            If RepSmtpOK Then

    '                                Dim sqlEnsUpdate As New SqlCommand("UPDATE ENSEIGNANT " _
    '             & " SET    LIEU_NAISSANCE_ENSEIGNANT = '" & TXT_LieuNaiss.Text & "'," _
    '             & "        MAIL_ENSEIGNANT = '" & TXT_email1.Text & "'," _
    '             & "        MAIL_ENSEIGNANT2 = '" & TXT_Email2.Text & "'," _
    '             & "        MOBILE_ENSEIGNANT = '" & TXT_Portable1.Text & "'," _
    '             & "        MOBILE_ENSEIGNANT2 = '" & TXT_Portable2.Text & "'," _
    '             & "        CNI = '" & TXT_CNI.Text & "'," _
    '             & "        PASSWORD_VALIDE = 0," _
    '             & "        PASSWORD_ENSEIGNANT = '" & Passwcrypt & "'" _
    '             & " WHERE  IDENTIFIANT_ENSEIGNANT ='" & Session("id_ens_new").ToString & "'")


    '                                Dim ResultSetEnsUpdate As DataSet
    '                                ResultSetEnsUpdate = RunQuery(sqlEnsUpdate)
    '                                AfficherMessage("Votre inscription est effective. Un mot de passe vous est envoyé à votre adresse email " & TXT_email1.Text & ". Vous devez le changer à la premiere connexion.")

    '                                Server.Transfer("~/default.aspx")
    '                                initialiserChamps()

    '                            Else
    '                                AfficherMessage("Inscription impossible en ce moment! Merci de ré-essayer plus tard.")
    '                            End If

    '                            'AfficherMessage("Bienvenue à Mirador, votre code de confirmation est le " & CodeValid)

    '                        Else
    '                            AfficherMessage("Ce numéro de CNI, de teléphone ou adresse email existe déja dans Mirador! Merci de vérifier ou demander assistance en ligne à partir de la page d'accueil de Mirador.")
    '                            TXT_Matricule.Focus()
    '                            RelaodCaptcha()
    '                        End If
    '                    Catch ex As Exception
    '                        'AfficherMessage("Inscription impossible! Merci de vérifier la saisie.")
    '                        'RelaodCaptcha()
    '                    End Try
    '                Next


    '                'initialiserChamps()
    '                'Server.Transfer("~/default.aspx")
    '            Else


    '                AfficherMessage("Informations incorrectes! veuillez ré-essayer ou demander assistance en ligne à partir de la page d'accueil de Mirador.")
    '                TXT_Matricule.Focus()
    '                RelaodCaptcha()
    '            End If


    '        Catch ex As Exception

    '        End Try
    '    End Sub

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

    'Sub initialiserChamps()
    '    Try
    '        Me.TXT_Matricule.Text = ""
    '        Me.TXT_Nom.Text = ""
    '        Me.TXT_Prenoms.Text = ""
    '        Me.TXT_DateNaiss.Text = ""
    '        Me.TXT_LieuNaiss.Text = ""
    '        Me.TXT_CNI.Text = ""
    '        Me.TXT_email1.Text = ""
    '        Me.TXT_Email2.Text = ""
    '        Me.TXT_Portable1.Text = ""
    '        Me.TXT_Portable2.Text = ""

    '        Me.TXT_Matricule.Focus()


    '    Catch ex As Exception

    '    End Try
    'End Sub



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
