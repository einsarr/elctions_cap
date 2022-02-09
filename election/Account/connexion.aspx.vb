Imports System.Data.SqlClient
Imports System.Data
Partial Class _Connect
    Inherits System.Web.UI.Page
    Private election As New ElectionCAPCD
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Try
            TXT_Login.Focus()

        Catch ex As Exception

        End Try
        If Session("connexion_ok") = 1 Then
            If Session("a_voter") = 0 Then
                Response.Redirect("~/elections/Voter.aspx")
            End If
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
            & " CAP.MATRICULE_ELECTEUR, CAP.IDENTIFIANT_ELECTEUR,CAP.NOM_ELECTEUR, CAP.PASSWORD_VALIDE," _
            & " CAP.DATE_NAISSANCE_ELECTEUR,CAP.PRENOM_ELECTEUR,CAP.ID_CORPS,CAP.ID_CLASSE,CAP.ID_GRADE,CAP.PASSWORD_ELECTEUR " _
    & " FROM ELECTION_CAP_ELECTEUR AS CAP " _
    & " WHERE(CAP.MATRICULE_ELECTEUR = '" & TXT_Login.Text & "') AND (CAP.PASSWORD_ELECTEUR = '" & Passwcrypt & "')")

            Dim ResultSetEns As DataSet

            ResultSetEns = outils.RunQuery(sqlEns)

            If ResultSetEns.Tables(0).Rows.Count > 0 Then

                'On initialise le statut de log_connexion_mirador à 1 car connexion
                statut = 1
                Dim sqlLogconnexion As New SqlCommand("INSERT INTO ELECTION_CAP_LOGS(MATRICULE, ADRESSE_IP, NAVIGATEUR,PAYS_CONNEXION) VALUES('" & Session("matricule_elect") & "' ,'" & ipAdresse & "','" & navigateur & "','" & paysUser & "')")
                Dim ResultInsLogCon As DataSet
                ResultInsLogCon = outils.RunQuery(sqlLogconnexion)

                Dim rowEns As DataRow
                For Each rowEns In ResultSetEns.Tables(0).Rows
                    Try
                        Session("id_elect") = rowEns("IDENTIFIANT_ELECTEUR")
                        Session("matricule_elect") = rowEns("MATRICULE_ELECTEUR").ToString
                        Session("nom_elect") = rowEns("NOM_ELECTEUR").ToString
                        Session("classe_elect") = rowEns("ID_CLASSE").ToString
                        Session("prenom_elect") = rowEns("PRENOM_ELECTEUR").ToString
                        Session("grade_elect") = rowEns("ID_GRADE").ToString
                        Session("corps_elect") = rowEns("ID_CORPS").ToString
                        Session("date_naiss_elect") = rowEns("DATE_NAISSANCE_ELECTEUR")
                        Session("pass_valid") = rowEns("PASSWORD_VALIDE").ToString
                        Session("a_voter") = rowEns("A_VOTE").ToString
                        Session("passw") = TXT_Password.Text
                    Catch ex As Exception

                    End Try
                Next

                If Session("pass_valid") = 1 Then
                    If election.PeriodeOuvertureScrutin() = True Then
                        If election.CalculAge(Session("date_naiss_elect")) <= 60 Then
                            If election.ADEJAVOTE(Session("id_elect")) = False Then
                                If election.CompteBloque(Session("id_elect")) = False Then
                                    Session("connexion_ok") = 1
                                    Server.Transfer("~/elections/Voter.aspx")
                                Else
                                    AfficherMessage("Compte bloqué - Veuillez saisir l'administrateur")
                                End If
                            Else
                                AfficherMessage("Déjà voté")
                            End If
                        Else
                            AfficherMessage("L'âge d'éligibilité dépassé")
                        End If
                    Else
                        AfficherMessage("Scrutin fermé")
                    End If

                Else
                    Server.Transfer("~/Account/validpassw.aspx")
                End If

            Else

                'On initialise le statut de log_connexion_mirador à 0 car echec connexion
                'statut = 0
                Dim sqlLogconnexion As New SqlCommand("INSERT INTO ELECTION_CAP_LOGS(MATRICULE, ADRESSE_IP, NAVIGATEUR,PAYS_CONNEXION) VALUES('" & TXT_Login.Text & "' ,'" & ipAdresse & "','" & navigateur & "','" & paysUser & "')")
                Dim ResultInsLogCon As DataSet
                ResultInsLogCon = outils.RunQuery(sqlLogconnexion)

                Dim sqlEtat As New SqlCommand("UPDATE ELECTION_CAP_ELECTEUR SET TENTATIVE=TENTATIVE+1 WHERE MATRICULE_ELECTEUR='" & TXT_Login.Text & "'")
                outils.RunQuery(sqlEtat)

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
