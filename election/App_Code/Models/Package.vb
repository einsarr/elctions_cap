'Imports System.Threading.Tasks
Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System
Imports System.Globalization
Imports System.Data
Imports System.Net
Imports System.Text

Public Class Package
    Dim db As New peo
    Dim out As New Outils

    ''' <summary>
    ''' Fonction d'enregistrement du package choisi
    ''' </summary>
    ''' <param name="idPackage"> id du package</param>
    ''' <param name="idEns"> id de l'enseignant</param>
    ''' <param name="codeAnnee"> code de l'annee</param>
    ''' <returns> return true or false</returns>
    Public Function ValiderPackage(idPackage As Decimal, idEns As Integer) As Boolean
        Try
            'Vérification si existence package
            Dim pack As New PEO_PACKAGE
            pack = db.PEO_PACKAGE.Find(idPackage)
            If pack Is Nothing Then
                Return False
            End If

            Dim numSous As String
            Dim idEdition As Integer = EditionEncours()
            Dim nombrePack As Integer = NombrePackage(idEdition)

            Dim packChoisi As New PEO_PACKAGE_CHOISI
            packChoisi.ID_PACKAGE = idPackage
            packChoisi.IDENTIFIANT_ENSEIGNANT = idEns
            packChoisi.ID_EDITION = idEdition
            packChoisi.DATE_CHOIX = DateTime.UtcNow
            packChoisi.CHOIX_VALIDE = True
            packChoisi.MAIL_ENVOYE = 0

            numSous = NumeroSousCription(idEdition, nombrePack)

            packChoisi.NUMERO_SOUSCRIPTION = numSous

            db.PEO_PACKAGE_CHOISI.Add(packChoisi)
            db.SaveChanges()

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function


    ''' <summary>
    ''' Détermine si l'enseignant a déja choisi son package 
    ''' </summary>
    ''' <param name="idEns">Identifiant de l'enseignant connecté</param>
    ''' <param name="codeAnne">Code de l'année en cours</param>
    ''' <returns>Return oui ou non</returns>
    Public Function AChoisiSonPackage(idEns As Integer) As Boolean
        Try
            Dim idEdition As Integer = EditionEncours()
            'Dim packChoisi As New PEO_PACKAGE_CHOISI
            Dim query = From p In db.PEO_PACKAGE_CHOISI Where p.IDENTIFIANT_ENSEIGNANT = idEns And p.ID_EDITION = idEdition Select p

            Dim packChoisi As PEO_PACKAGE_CHOISI = query.SingleOrDefault

            If packChoisi Is Nothing Then
                Return False
            Else
                Return True
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function PackageChoisi(idEns As Integer) As Decimal
        Try
            Dim idEdition As Integer = EditionEncours()
            'Dim packChoisi As New PEO_PACKAGE_CHOISI
            Dim query = From p In db.PEO_PACKAGE_CHOISI Where p.IDENTIFIANT_ENSEIGNANT = idEns And p.ID_EDITION = idEdition
            Dim packChoisi As PEO_PACKAGE_CHOISI = query.DefaultIfEmpty
            Return packChoisi.ID_PACKAGE
        Catch ex As Exception
            Return -1
        End Try
    End Function

    Public Function PackageChoisiParEns(idEns As Integer) As PEO_PACKAGE_CHOISI
        'Dim pakChosen As PEO_PACKAGE_CHOISI
        Try
            Dim idEdition As Integer = EditionEncours()
            Dim query = From pc In db.PEO_PACKAGE_CHOISI Where pc.IDENTIFIANT_ENSEIGNANT = idEns And pc.ID_EDITION = idEdition Select pc
            Return query.FirstOrDefault
        Catch ex As Exception
            Return Nothing
        End Try

    End Function

    Public Function NombrePackage(idEdtion As Integer) As Integer
        Dim nmbrePackage As Integer
        Try
            Dim query = From p In db.PEO_PACKAGE_CHOISI Where p.ID_EDITION = idEdtion And p.CHOIX_VALIDE = True
            nmbrePackage = query.Count
            Return nmbrePackage
        Catch ex As Exception
            Return -1
        End Try
    End Function

    Public Function EditionEncours() As Integer
        Dim edit As Integer
        Try
            Dim query = From e In db.PEO_EDITION Where e.EN_COURS = True Select e.ID_EDITION
            edit = query.First
            Return edit
        Catch ex As Exception
            Return -1
        End Try
    End Function

    Public Function NumeroSousCription(idEdition As Integer, nbrPackage As Integer) As String
        Dim nbreZero As String = ""
        Dim numSous As String
        ' Dim j = Len(nbrPackage.ToString)
        Dim j = CType(nbrPackage, String).Length
        Dim numSuivant = nbrPackage + 1

        Try
            For i = 1 To 6 - CType(numSuivant, String).Length
                nbreZero = nbreZero & "0"
            Next

            Dim anEdition = (From edit In db.PEO_EDITION Where edit.EN_COURS = True Select edit.ANNEE).First

            'numSous = DateTime.UtcNow.Year.ToString & idEdition.ToString & nbreZero.ToString & numSuivant.ToString
            numSous = "SOLINK-" & anEdition & idEdition.ToString & nbreZero.ToString & numSuivant.ToString
            Return numSous
        Catch ex As Exception
            Return "0"
        End Try
        Return numSous
    End Function

    Public Function EditionEncouursOuvert() As Boolean
        Try
            Dim query = From e In db.PEO_EDITION Where e.EN_COURS = True
            Dim edition = query.First
            If edition.DATE_FIN_EDITION > DateTime.UtcNow And DateTime.UtcNow > edition.DATE_DEBUT_EDITION Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function MailSouscription(idEns As Integer, pak As PEO_PACKAGE) As String
        Dim message = ""
        Dim enseignant As ENSEIGNANT
        Dim query = From ens In db.ENSEIGNANT Where ens.IDENTIFIANT_ENSEIGNANT = idEns Select ens
        enseignant = query.First

        message = " Bonjour " & enseignant.PRENOMS_ENSEIGNANT & ", " & enseignant.NOM_ENSEIGNANT & " " _
        & ", Matricule: " & enseignant.MATRICULE_ENSEIGNANT & " <br />" _
        & "Nous vous confirmons votre souscription dans le cadre du programme <b>« Un Enseignant, Un Ordinateur »</b>.<br /> " _
        & "Vous avez choisi le <b class='text-warning'>" & pak.LIBELLE_PACKAGE & "</b>, avec un paiement mensuel de <b class='text-success'>" & pak.MONTANT & " FCFA/ mois pendant 36 mois.</b> <br />" _
        & "Votre package comprend <b class='text-primary'>" & pak.DESCRIPTION_PACKAGE & "</b><br /> " _
        & "Nous vous contacterons pour vous donner la date de disponibilité du formulaire d’engagement auprès de votre IEF, pour signature.<br />" _
        & "Nous vous remercions pour votre confiance." _
        & "<br /><br />" _
        & "SOLINK PS <br /> " _
        & "Contact : Fixe : 33 822 10 11 –  Mobile : 76 223 57 43 <br />" _
        & "Email : contact@solinkps.com"
        Return message
    End Function

    Public Function getPackageByID(idPack As Decimal) As PEO_PACKAGE
        Try
            Dim query = From pa In db.PEO_PACKAGE Where pa.ID_PACKAGE = idPack
            Return query.First
        Catch ex As Exception
            Return Nothing
        End Try

    End Function

    Public Function getEnsByID(idEns As Integer) As ENSEIGNANT
        Try
            Dim query = From ens In db.ENSEIGNANT Where ens.IDENTIFIANT_ENSEIGNANT = idEns
            Return query.First
        Catch ex As Exception
            Return Nothing
        End Try

    End Function

    Public Function NombreConsParPackage(idPackage As Decimal) As Integer
        Try
            Dim idEdition As Integer = EditionEncours()
            Dim query = From pack In db.PEO_PACKAGE_DETAILS Where pack.ID_PACKAGE = idPackage And pack.EST_IMAGE_PACKAGE = True Select pack.ID_PACKAGE
            Return query.Count
        Catch ex As Exception
            Return -1
        End Try

    End Function

    ''' <summary>
    ''' Permet de signifier dans la base de données que le mail est bien envoyée
    ''' </summary>
    ''' <param name="idEns"></param>
    ''' <returns></returns>
    Public Function ConfirmSentMail(idEns As Integer) As Boolean
        Try

            Dim idEdition As Integer = EditionEncours()
            Dim packChoisi As New PEO_PACKAGE_CHOISI

            packChoisi = (From ppc In db.PEO_PACKAGE_CHOISI Where ppc.IDENTIFIANT_ENSEIGNANT = idEns And ppc.ID_EDITION = idEdition And ppc.MAIL_ENVOYE = False).FirstOrDefault
            packChoisi.MAIL_ENVOYE = True
            packChoisi.DATE_ENVOI_MAIL = DateTime.UtcNow
            db.SaveChanges()

            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    ''' <summary>
    ''' Vérifie si le mail du candidat a été envoyé
    ''' </summary>
    ''' <param name="idEns"></param>
    ''' <returns></returns>
    Public Function IsMailSent(idEns As Integer) As Boolean

        Try
            Dim idEdition As Integer = EditionEncours()
            Dim packChoisi As New PEO_PACKAGE_CHOISI

            packChoisi = (From ppc In db.PEO_PACKAGE_CHOISI Where ppc.IDENTIFIANT_ENSEIGNANT = idEns And ppc.ID_EDITION = idEdition).SingleOrDefault
            If packChoisi.MAIL_ENVOYE Then
                Return True
            Else
                Return False

            End If
        Catch ex As Exception
            Return False
        End Try
    End Function


    ''' <summary>
    ''' Cette fonction crée le message destiné aux ensseignant et l'envoie
    ''' </summary>
    ''' <param name="idEns">Identifiant de l'enseignant connecté</param>
    ''' <param name="choix">Le choix fait pas l'enseignant</param>
    ''' <returns></returns>
    Public Function EnvoiMail(idEns As Integer, choix As PEO_PACKAGE_CHOISI) As Boolean
        Try
            Dim ens = db.ENSEIGNANT.Find(idEns)

            'On recupére le package a partir du choix
            Dim lepackChois = db.PEO_PACKAGE.Find(choix.ID_PACKAGE)

            'On formate le message d'envoi du mail
            Dim textMail = MailSouscription(idEns, lepackChois)
            Dim out As New Outils

            If SendMail(ens.MAIL_ENSEIGNANT, "SOLINK SOUSCRIPTION PACKAGE UN ENSEIGNANT UN ORDINATEUR", textMail) Then

                ConfirmSentMail(idEns)
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Return False
        End Try

    End Function

    ''' <summary>
    ''' Vérifie si le format du matricule est ok et return true or false
    ''' </summary>
    ''' <param name="Matricule"></param>
    ''' <returns></returns>
    Public Function VerifMatriculeOk(Matricule As String) As Boolean
        Try
            If Len(Matricule) = 8 And Matricule.Substring(Len(Matricule) - 2, 1) = "/" _
            Or Len(Matricule) = 11 And Matricule.Substring(Len(Matricule) - 2, 1) = "/" Then
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Return False
        End Try
    End Function


    Public Function SendMail(ByVal mMail As String, ByVal mSubject As String, ByVal mMessage As String) As Boolean
        Dim client As New System.Net.Mail.SmtpClient
        Dim message As New System.Net.Mail.MailMessage

        'client.Credentials = New System.Net.NetworkCredential("email@solinkps.com", "ordinateur2016")
        client.Credentials = New System.Net.NetworkCredential("mirador@education.gouv.sn", "Sirh*Men")

        Try

            client.Port = 25 'définition du port 
            'client.Host = "mail.solinkps.com" 'définition du serveur smtp
            client.Host = "10.42.2.13" 'définition du serveur smtp
            'client.Host = "smtp.gouv.sn"
            client.EnableSsl = False

            'message.From = New System.Net.Mail.MailAddress("Mirador <noreply@education.gouv.sn>")
            message.From = New System.Net.Mail.MailAddress("Solink <noreply@solinkps.com>")

            message.Bcc.Add("miradordrh@gmail.com")
            message.Bcc.Add("email@solinkps.com")

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



End Class
