Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System
Imports System.Globalization
Imports System.Data
Imports System.Net
Imports System.Text
Public Class Outils
    Inherits System.Web.UI.Page

    ' Fonction AfficherMessage
    Public Sub AfficherMessage(ByVal Message As String)
        Try

            Response.Write("<script language=""javascript"" type=""text/javascript""  > " _
         & " alert(""" & Message & """); " _
    & "  </script>")

        Catch ex As Exception
            'ex = Nothing

        End Try
    End Sub



    'Fonction Envoi mail
    Public Function EnvoiMail(ByVal mMail As String, ByVal mSubject As String, ByVal mMessage As String) As Boolean
        'Dim resultat As Boolean = False
        Dim client As New System.Net.Mail.SmtpClient
        Dim message As New System.Net.Mail.MailMessage
        'client.Credentials = New System.Net.NetworkCredential("contact@abouwone.net", "alhamdou")
        client.Credentials = New System.Net.NetworkCredential("no-replymirador@gouv.sn", "Sirh*Men")

        Try

            client.Port = 25 'définition du port 
            'client.Host = "smtp.abouwone.net" 'définition du serveur .
            'client.Host = "smtp.gouv.sn"
            client.Host = "smtp-appli1.sec.gouv.sn"
            client.EnableSsl = False

            'message.Bcc.Add("mirador@education.gouv.sn")
            message.From = New System.Net.Mail.MailAddress("no-replymirador@gouv.sn")
            'message.From = New System.Net.Mail.MailAddress("mirador@education.gouv.sn")
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
            'MsgBox("Envoi mail NOK")
            Return False

        End Try

    End Function

    Public Function RunQuery(ByVal sqlQuery As SqlCommand) As DataSet
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

    Public Function ipAdr() As String
        Dim ipaddress As String
        'On initialise l'ip adresse sans proxy
        ipaddress = System.Web.HttpContext.Current.Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If ipaddress = "" Or ipaddress Is Nothing Then
            'On initialise l'ip avec proxy 
            ipaddress = System.Web.HttpContext.Current.Request.ServerVariables("REMOTE_ADDR")
            If ipaddress = "" Or ipaddress Is Nothing Then
                'Si on a aucune adresse on retourne 127.0.0.1
                ipaddress = "::1"
            End If
        End If

        If ipaddress = "::1" Then
            ipAdr = "127.0.0.1"
        Else
            ipAdr = ipaddress
        End If
    End Function

    'Recherche du pays à travers l'adresse ip du visiteur
    Public Function Pays(ByVal ip As String) As String
        Dim country As String = ""
        Dim ipNumber As Double

        'Ici on recherche l'ipNumber grace à la fonction qui si situe dans la meme classe 
        ipNumber = Dot2LongIP(ip)

        'Requete SQL de recherche du pays dans la BDD
        Dim sqlFindCountry As New SqlCommand("SELECT country from FUP.dbo.TOOLS_IPLOCATION " &
        " where (ip_from <= '" & ipNumber & "') AND ( ip_to >= '" & ipNumber & "')")

        Dim ResultFindCountry As DataSet
        ResultFindCountry = RunQuery(sqlFindCountry)
        If ResultFindCountry.Tables(0).Rows.Count > 0 Then
            Dim rowCountry As DataRow
            For Each rowCountry In ResultFindCountry.Tables(0).Rows
                Try
                    country += " " + rowCountry("country").ToString
                Catch ex As Exception
                End Try
            Next
        Else
            Pays = "Non repertorié"
        End If
        Return country
    End Function

    'ip to ipNumber IpNumber sert à retrouver le pays dans la base
    Public Function Dot2LongIP(ByVal DottedIP As String) As Double
        Dim arrDec() As String
        Dim i As Integer
        Dim intResult As Long

        'Si l'adresse est vide on return 0 Dot2longIP = 0
        If DottedIP = "" Then
            Dot2LongIP = 0

            'Si l'adresse est locale machine on t
        ElseIf DottedIP = "::1" Then
            DottedIP = "127.0.0.1"
            arrDec = DottedIP.Split(".")
            For i = arrDec.Length - 1 To 0 Step -1
                intResult = intResult + ((Int(arrDec(i)) Mod 256) * Math.Pow(256, 3 - i))
            Next
            Dot2LongIP = intResult
        Else
            arrDec = DottedIP.Split(".")
            For i = arrDec.Length - 1 To 0 Step -1
                intResult = intResult + ((Int(arrDec(i)) Mod 256) * Math.Pow(256, 3 - i))
            Next
            Dot2LongIP = intResult
        End If
    End Function



End Class
