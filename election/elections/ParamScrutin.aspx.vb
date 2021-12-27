Imports System.Data
Imports System.Data.SqlClient
Partial Class elections_ParamScrutin
    Inherits System.Web.UI.Page

    Protected Sub btn_add_scrutin_Click(sender As Object, e As EventArgs) Handles btn_add_scrutin.Click
        Dim con As New SqlConnection
        Dim cmd As New SqlCommand
        con.ConnectionString = "Data Source=.;Initial Catalog=FUP;Integrated Security=True"
        con.Open()

        Dim SQL_ADD_COLLEGE As SqlCommand = New SqlCommand("INSERT INTO ELECTION_CAP_PARAM_ELECTION(CODE_ANNEE,LIBELLE_ELECTION,DATE_DEBUT,DATE_FIN)VALUES(@CODE_ANNEE,@LIBELLE_ELECTION,@DATE_DEBUT,@DATE_FIN)", con)
        SQL_ADD_COLLEGE.Parameters.AddWithValue("@CODE_ANNEE", DLL_ANNEE.SelectedValue.ToString)
        SQL_ADD_COLLEGE.Parameters.AddWithValue("@LIBELLE_ELECTION", TXT_LIBELLE_SCRUTIN.Text)
        SQL_ADD_COLLEGE.Parameters.AddWithValue("@DATE_DEBUT", DateTime.Parse(TXT_DATE_DEBUT.Text))
        SQL_ADD_COLLEGE.Parameters.AddWithValue("@DATE_FIN", DateTime.Parse(TXT_DATE_FIN.Text))
        SQL_ADD_COLLEGE.ExecuteNonQuery()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub
End Class
