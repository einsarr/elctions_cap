Imports System.Data
Imports System.Data.SqlClient
Partial Class elections_Colleges
    Inherits System.Web.UI.Page

    Protected Sub btn_add_grade_Click(sender As Object, e As EventArgs) Handles btn_add_grade.Click
        Dim con As New SqlConnection
        Dim cmd As New SqlCommand
        Dim LIBELLE_CLASSE As String = TXT_LIBELLE_CLASSE.Text
        Dim LIBELLE_ECHELLON As String = TXT_LIBELLE_ECHELON.Text
        Dim LIBELLE_GRADE As String = TXT_LIBELLE_GRADE.Text
        con.ConnectionString = "Data Source=.;Initial Catalog=FUP;Integrated Security=True"
        con.Open()

        Dim SQL_ADD_GRADE As SqlCommand = New SqlCommand("INSERT INTO ELECTION_CAP_GRADE(CLASSE,ECHELON,LIBELLE_GRADE)VALUES(@CLASSE,@ECHELON,@LIBELLE_GRADE)", con)
        SQL_ADD_GRADE.Parameters.AddWithValue("@CLASSE", LIBELLE_CLASSE)
        SQL_ADD_GRADE.Parameters.AddWithValue("@ECHELON", LIBELLE_ECHELLON)
        SQL_ADD_GRADE.Parameters.AddWithValue("@LIBELLE_GRADE", LIBELLE_GRADE)
        SQL_ADD_GRADE.ExecuteNonQuery()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub
End Class
