Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class Latnok

    Dim scon As String = ConfigurationManager.ConnectionStrings("FUPConnectionString").ConnectionString
    Dim debutMoisEncours As String = "10/" & Month(Date.Now) & "/" & Year(Date.Now)

    Class Enseignant
        Public Property Id As Integer
        Public Property Matricule As String
        Public Property prenom As String
        Public Property nom As String
        Public Property Sexe As String
        Public Property CNI As String
        Public Property Mobile As String
        Public Property Mail As String
        Public Property Adresse As String
        Public Property IA As String
        Public Property IEF As String
    End Class


    Public Function GetEnsConnected(id_ens As String) As Enseignant
        Try
            Using con As New SqlConnection(scon)

                If con.State <> ConnectionState.Open Then
                    con.Open()
                End If

                Dim req As String = "SELECT ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.MATRICULE_ENSEIGNANT,  " _
               & " ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.SEXE_ENSEIGNANT, ENSEIGNANT.CNI,  " _
               & " ENSEIGNANT.MOBILE_ENSEIGNANT, ENSEIGNANT.MAIL_ENSEIGNANT, ISNULL(ENSEIGNANT.ADRESSE, '')  " _
               & " AS Adresse, ATLAS_SYS_DEF_ALL.IA, ATLAS_SYS_DEF_ALL.IDEN AS IEF " _
               & " FROM ATLAS_SYS_DEF_ALL RIGHT OUTER JOIN " _
               & " ETABLISSEMENT_REGROUPEMENT ON ATLAS_SYS_DEF_ALL.code00 = ETABLISSEMENT_REGROUPEMENT.CODE_REGROUPEMENT RIGHT OUTER JOIN " _
               & " ETABLISSEMENT ON ETABLISSEMENT_REGROUPEMENT.CODE_ETABLISSEMENT = ETABLISSEMENT.CODE_ETABLISSEMENT RIGHT OUTER JOIN " _
               & " ENSEIGNANT_ETABLISSEMENT ON ETABLISSEMENT.CODE_ETABLISSEMENT = ENSEIGNANT_ETABLISSEMENT.CODE_ETABLISSEMENT RIGHT OUTER JOIN " _
               & " ENSEIGNANT ON ENSEIGNANT_ETABLISSEMENT.IDENTIFIANT_ENSEIGNANT = ENSEIGNANT.IDENTIFIANT_ENSEIGNANT " _
               & " GROUP BY ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.NOM_ENSEIGNANT,  " _
               & " ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.SEXE_ENSEIGNANT, ENSEIGNANT.CNI,  " _
               & " ENSEIGNANT.MOBILE_ENSEIGNANT, ENSEIGNANT.MAIL_ENSEIGNANT, ISNULL(ENSEIGNANT.ADRESSE, ''),  " _
               & " ATLAS_SYS_DEF_ALL.IA, ATLAS_SYS_DEF_ALL.IDEN " _
               & " HAVING (ENSEIGNANT.IDENTIFIANT_ENSEIGNANT = " & id_ens & ")"

                Dim cmd As New SqlCommand(req, con)
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                Dim ens As New Enseignant
                If reader.HasRows Then
                    While reader.Read()
                        ens.Id = reader.GetInt32(0)
                        ens.Matricule = reader.GetString(1)
                        ens.nom = reader.GetString(2)
                        ens.prenom = reader.GetString(3)
                        ens.Sexe = reader.GetString(4)
                        ens.CNI = reader.GetString(5)
                        ens.Mobile = reader.GetDecimal(6)
                        ens.Mail = reader.GetString(7)
                        ens.Adresse = reader.GetString(8)
                        ens.IA = reader.GetString(9)
                        ens.IEF = reader.GetString(10)
                    End While
                End If
                Return ens
            End Using
        Catch ex As Exception
            Return Nothing
        End Try
    End Function

    Public Function EnsAdhesion(id_ens As String) As Integer

        Try

            'On initie la candidature
            Using con As New SqlConnection(scon)

                If con.State <> ConnectionState.Open Then
                    con.Open()
                End If

                Dim rInitieCand As String

                rInitieCand = "SELECT COUNT(*) as adhesion  FROM LatnokSouscription " _
                            & " where idEnseignant = " & id_ens

                Dim cmd As New SqlCommand(rInitieCand, con)

                Dim rst As Integer = cmd.ExecuteScalar()
                Return rst
            End Using
        Catch ex As Exception
            Return ex.Message
        End Try
    End Function

    Public Function getDatePriseEffet() As String

        Dim SdateSouscription As String() = Split(Date.Now(), "/")

        If (Convert.ToInt32(SdateSouscription(0)) >= 10) Then
            Return Convert.ToDateTime(debutMoisEncours).AddMonths(1)
        Else
            Return Convert.ToDateTime(debutMoisEncours)
        End If
    End Function

    Public Function addSouscription(ens As Enseignant, adresse As String, montant As Integer, DescriptionMontant As String) As Boolean
        Dim messageFrom As String = "Latnokgroup SA <noreply@latnokgroupsa.net>"
        Dim copyMessageTo As String = "papetoure@latnokgroupsa.net"
        Dim Message As String = SetMailSouscription(ens, DescriptionMontant)
        Dim req As String = ""
        Dim dateEffet As DateTime = Convert.ToDateTime(getDatePriseEffet())

        Using con As New SqlConnection(scon)

            If con.State <> ConnectionState.Open Then
                con.Open()
            End If

            If Not IsNothing(adresse) Then
                req = req & "update enseignant set ADRESSE = '" & adresse & "' where IDENTIFIANT_ENSEIGNANT = " & ens.Id & ";"
            End If
            req = req & "INSERT INTO LatnokSouscription (IdEnseignant,IdLatnokTarif, DatePriseEffet, DateSouscription) " _
                    & "VALUES (" & ens.Id & ", " & montant & ", '" & dateEffet & "', getdate())"
            Dim cmd As New SqlCommand(req, con)

            Dim rst As Integer = cmd.ExecuteNonQuery()
            'Si l'adhésion est bien effectuée
            If rst > 0 Then
                'Envoie du mail de confirmation à l'enseignant
                SendMail(ens.Mail, "Adhésion: Un enseignant un Coffret didactique", Message, messageFrom, copyMessageTo)
                Return True

            Else
                Return False
            End If
        End Using




        Return True

    End Function

    Public Function SetMailSouscription(ens As Enseignant, DescriptionMontant As String) As String
        Dim message = ""

        message = " Bonjour " & ens.prenom & ", " & ens.nom & " " _
        & ", Matricule: " & ens.Matricule & " <br />" _
        & "Nous vous confirmons votre souscription dans le cadre du programme <b>« Un enseignant un Coffret didactique »</b>.<br /> " _
        & "Vous avez choisi la formule <b class='text-warning'>" & DescriptionMontant & "</b>. " _
        & "Votre souscription débutera le " & getDatePriseEffet() & ". " _
        & "Nous vous contacterons pour vous donner la date de disponibilité de votre produit.<br />" _
        & "Nous vous remercions pour votre confiance." _
        & "<br /><br /><hr />" _
        & "latnokgroup SA <br /> " _
        & "Lot N°8 Cité Air Afrique Ouest Foire	Dakar Sénégal <br />" _
        & "+221 33 820 26 86 - +221 77 846 15 15"

        Return message
    End Function

    Public Function SendMail(ByVal mMail As String, ByVal mSubject As String, ByVal mMessage As String,
                             from As String, copyTo As String) As Boolean
        Dim client As New System.Net.Mail.SmtpClient
        Dim message As New System.Net.Mail.MailMessage

        
        client.Credentials = New System.Net.NetworkCredential("mirador@education.gouv.sn", "Sirh*Men")

        Try

            client.Port = 25 'définition du port 
            
            client.Host = "10.42.2.13" 'définition du serveur smtp
            'client.Host = "smtp.gouv.sn"
            client.EnableSsl = False

            'message.From = New System.Net.Mail.MailAddress("Mirador <noreply@education.gouv.sn>")
            message.From = New System.Net.Mail.MailAddress(from)

            message.Bcc.Add("miradordrh@gmail.com")
            message.Bcc.Add(copyTo)

            message.To.Add(mMail)
            message.IsBodyHtml = True

            'Dim item As New System.Net.Mail.Attachment("LIEN_DE_LA_PIECE_JOINTE_EVENTUELLE_ICI")
            'message.Attachments.Add(item) 'ajout de la pièce jointe au message

            message.Subject = mSubject
            message.Body = mMessage '+ "<br /><br /><br /><br /><hr /> <span style='color:#FF0000; font-size:18px;'>Veuillez ne pas répondre à cet e-mail!</span>"

            client.Send(message) 'envoi du mail

            Return True

        Catch ex As Exception
            'TODO traiter les erreurs
            ' MsgBox("Envoi mail NOK")
            Return False

        End Try
    End Function

    Public Function FindPrixPaquetEns(id_ens As String) As String

        Try

            'On initie la candidature
            Using con As New SqlConnection(scon)

                If con.State <> ConnectionState.Open Then
                    con.Open()
                End If

                Dim rInitieCand As String

                rInitieCand = "SELECT  LatnokTarif.Description FROM LatnokSouscription INNER JOIN " _
                & " LatnokTarif ON LatnokSouscription.IdLatnokTarif = LatnokTarif.Id " _
                & " WHERE  (LatnokSouscription.IdEnseignant = " & id_ens & ")"

                Dim cmd As New SqlCommand(rInitieCand, con)

                Dim rst As String = cmd.ExecuteScalar()
                Return rst
            End Using
        Catch ex As Exception
            Return ex.Message
        End Try
    End Function
End Class
