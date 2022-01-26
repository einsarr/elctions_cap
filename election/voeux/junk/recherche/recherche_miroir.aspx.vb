
Partial Class Account_Message2
    Inherits System.Web.UI.Page

   

    Protected Sub DropDownListFonction_DataBound(sender As Object, e As EventArgs) Handles DropDownListFonction.DataBound

        Me.GridViewResultMiroir.DataBind()
        Me.DropDownNbrePoste.DataBind()
    End Sub

    Protected Sub DropDownListFonction_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownListFonction.SelectedIndexChanged
        Me.DropDownListSpécialite.DataBind()
        Me.GridViewResultMiroir.DataBind()
        Me.DropDownNbrePoste.DataBind()
    End Sub

    Protected Sub DropDownListSpécialite_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownListSpécialite.SelectedIndexChanged
        Me.GridViewResultMiroir.DataBind()
        Me.DropDownNbrePoste.DataBind()
    End Sub

    Protected Sub DropDownListIEF_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownListIEF.SelectedIndexChanged
        Me.GridViewResultMiroir.DataBind()
        Me.DropDownNbrePoste.DataBind()
    End Sub

    Protected Sub DropDownListIA_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownListIA.SelectedIndexChanged
        Me.DropDownListIEF.DataBind()
        Me.GridViewResultMiroir.DataBind()
        Me.DropDownNbrePoste.DataBind()
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

    


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("connexion_ok") = 0 Then
            Server.Transfer("~/Default.aspx")
        End If

    End Sub
End Class
