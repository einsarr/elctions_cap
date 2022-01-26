Imports System.Data.SqlClient
Imports System.Data
Partial Class _Connect
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            'BD.rempli = False
            TXT_Login.Focus()

        Catch ex As Exception

        End Try
        If Session("connexion_ok") = 1 Then
            Response.Redirect("~/voeux/listemvmt.aspx")
        End If
    End Sub


    Sub initialiserChamps()
        Try
            TXT_Login.Text = ""
            TXT_Password.Text = ""
            TXT_Password.Focus()
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

    Protected Sub BT_Login_Click(sender As Object, e As EventArgs) Handles BT_Login.Click

        Dim outils As New Outils
        Dim matEns As String = TXT_Login.Text
        Dim ipAdresse As String = outils.ipAdr()
        Dim navigateur As String = ""

        'On passe en parametre l'adresse ip du visteur pour trouver son pays
        'C'est cette meme fonction qui appelle la fonction qui fait du ipNumber 
        Dim paysUser As String = outils.Pays(ipAdresse)

        Dim statut As Integer = 0
        With Request.Browser
            navigateur = .Browser & vbCrLf
        End With

        Try
            Dim Passwcrypt As String
            Dim Cryp As New Crypto

            Passwcrypt = Cryp.AES_Encrypt(TXT_Password.Text, "AxZD1&&é&é%é&&xDSDZA124_312143896")


            Dim sqlEns As New SqlCommand("SELECT " _
            & " ENSEIGNANT.MATRICULE_ENSEIGNANT, ENSEIGNANT.IDENTIFIANT_ENSEIGNANT, ENSEIGNANT.CODE_ETABLISSEMENT,  ENSEIGNANT.NOM_ENSEIGNANT, ENSEIGNANT.PASSWORD_VALIDE," _
            & " ENSEIGNANT.PRENOMS_ENSEIGNANT, ENSEIGNANT.CODE_CORPS, ENSEIGNANT.CODE_FONCTION,  ENSEIGNANT.CODE_SPECIALITE, ENSEIGNANT.PASSWORD_ENSEIGNANT " _
    & " FROM         ENSEIGNANT " _
    & " WHERE     (ENSEIGNANT.MATRICULE_ENSEIGNANT = '" & TXT_Login.Text & "') AND (ENSEIGNANT.PASSWORD_ENSEIGNANT = '" & Passwcrypt & "')")


            Dim ResultSetEns As DataSet
            'Dim con As New Connect

            ResultSetEns = outils.RunQuery(sqlEns)

            If ResultSetEns.Tables(0).Rows.Count > 0 Then
                'On initialise le statut de log_connexion_mirador à 1 car connexion
                statut = 1
                Dim sqlLogconnexion As New SqlCommand("INSERT INTO ADM_LOG_CONNEXION_MIRADOR (MATRICULE_ENSEIGNANT, PAYS_CONNEXION, ADRESSE_IP, NAVIGATEUR, STATUT) VALUES('" & matEns & "','" & paysUser & "','" & ipAdresse & "','" & navigateur & "'," & statut & ")")
                Dim ResultInsLogCon As DataSet
                ResultInsLogCon = outils.RunQuery(sqlLogconnexion)

                Dim rowEns As DataRow
                For Each rowEns In ResultSetEns.Tables(0).Rows
                    Try
                        Session("connexion_sso") = 0
                        Session("id_ens") = rowEns("identifiant_enseignant").ToString
                        Session("t_matricule") = rowEns("matricule_enseignant").ToString
                        Session("t_nom") = rowEns("nom_enseignant").ToString
                        Session("t_prenoms") = rowEns("prenoms_enseignant").ToString
                        Session("c_spc") = rowEns("code_specialite").ToString
                        Session("c_corps") = rowEns("code_corps").ToString
                        Session("c_etab") = rowEns("code_etablissement").ToString
                        Session("c_fct") = rowEns("code_fonction").ToString
                        'Session("c_mvt_ens") = rowEns("code_mouvement").ToString
                        Session("pass_valid") = rowEns("PASSWORD_VALIDE").ToString
                        Session("passw") = TXT_Password.Text


                    Catch ex As Exception

                    End Try
                Next
                'initialiserChamps()


                'AfficherMessage(Session("pass_valid").ToString)
                'AfficherMessage(Session("pass_valid") = 1)

                If Session("pass_valid") = 1 Then
                    'AfficherMessage("OK")
                    Session("connexion_ok") = 1

                    Server.Transfer("~/voeux/listemvmt.aspx")
                Else
                    'AfficherMessage("NOK A valider")

                    Server.Transfer("~/Account/validpassw.aspx")
                End If

            Else
                'On initialise le statut de log_connexion_mirador à 0 car echec connexion
                statut = 0
                Dim sqlLogconnexion As New SqlCommand("INSERT INTO ADM_LOG_CONNEXION_MIRADOR (MATRICULE_ENSEIGNANT,  PAYS_CONNEXION, ADRESSE_IP, NAVIGATEUR, STATUT) VALUES('" & matEns & "' ,'" & paysUser & "','" & ipAdresse & "','" & navigateur & "'," & statut & ")")
                Dim ResultInsLogCon As DataSet
                ResultInsLogCon = outils.RunQuery(sqlLogconnexion)

                Session("connexion_ok") = 0

                AfficherMessage("Identifiant ou mot de passe incorrect! veuillez recommencer!")
                TXT_Password.Text = ""
                TXT_Login.Focus()
            End If


        Catch ex As Exception
            'AfficherMessage(ex.Message.ToString)
        End Try


    End Sub

    Protected Sub DropDownTotalInscrits_DataBound(sender As Object, e As EventArgs) Handles DropDownTotalInscrits.DataBound
        Me.LabelNbreInscrits.Text = Me.DropDownTotalInscrits.SelectedValue.ToString
    End Sub




End Class
