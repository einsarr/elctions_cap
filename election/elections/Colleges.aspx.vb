Imports System.Data
Imports System.Data.SqlClient
Partial Class elections_Colleges
    Inherits System.Web.UI.Page

    Protected Sub btn_add_college_Click(sender As Object, e As EventArgs) Handles btn_add_college.Click
        Dim con As New SqlConnection
        Dim cmd As New SqlCommand
        Dim libelle_college As String = DLL_CORPS.SelectedValue.ToString & "" & DLL_GRADE.SelectedValue.ToString
        con.ConnectionString = "Data Source=.;Initial Catalog=FUP;Integrated Security=True"
        con.Open()

        Dim SQL_ADD_COLLEGE As SqlCommand = New SqlCommand("INSERT INTO ELECTION_CAP_COLLEGE(LIBELLE_COLLEGE)VALUES(@LIBELLE_COLLEGE)", con)
        SQL_ADD_COLLEGE.Parameters.AddWithValue("@LIBELLE_COLLEGE", libelle_college)
        SQL_ADD_COLLEGE.ExecuteNonQuery()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub
End Class
