﻿Imports System.Data
Imports System.Data.SqlClient
Partial Class elections_Colleges
    Inherits System.Web.UI.Page

    Protected Sub btn_add_btn_add_corps_groupes_Click(sender As Object, e As EventArgs) Handles btn_add_corps_groupes.Click
        Dim con As New SqlConnection
        Dim cmd As New SqlCommand
        Dim libelle_corps_groupes As String = TXT_LIBELLE_CORPS_GROUPES.Text
        con.ConnectionString = "Data Source=.;Initial Catalog=FUP;Integrated Security=True"
        con.Open()

        Dim SQL_ADD_CORPS_GROUPES As SqlCommand = New SqlCommand("INSERT INTO CORPS_GROUPES(LIBELLE_CORPS_GROUPES)VALUES(@LIBELLE_CORPS_GROUPES)", con)
        SQL_ADD_CORPS_GROUPES.Parameters.AddWithValue("@LIBELLE_CORPS_GROUPES", libelle_corps_groupes)
        SQL_ADD_CORPS_GROUPES.ExecuteNonQuery()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub
End Class
