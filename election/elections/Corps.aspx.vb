Imports System.Data
Imports System.Data.SqlClient
Partial Class elections_Colleges
    Inherits System.Web.UI.Page

    Protected Sub btn_add_corps_Click(sender As Object, e As EventArgs) Handles btn_add_corps.Click
        Dim con As New SqlConnection
        Dim cmd As New SqlCommand
        Dim LIBELLE_CORPS As String = TXT_LIBELLE_CORPS.Text
        Dim HIERARCHIE As String = DLL_HIERARCHIE.SelectedValue.ToString
        Dim ID_CORPS_GROUPE As Integer = CInt(DLL_CORPS_GROUPES.SelectedValue.ToString)
        con.ConnectionString = "Data Source=.;Initial Catalog=FUP;Integrated Security=True"
        con.Open()

        Dim SQL_ADD_CORPS As SqlCommand = New SqlCommand("INSERT INTO ELECTION_CAP_CORPS(LIBELLE_CORPS,HIERARCHIE,ID_CORPS_GROUPE)VALUES(@LIBELLE_CORPS,@HIERARCHIE,@ID_CORPS_GROUPE)", con)
        SQL_ADD_CORPS.Parameters.AddWithValue("@LIBELLE_CORPS", LIBELLE_CORPS)
        SQL_ADD_CORPS.Parameters.AddWithValue("@HIERARCHIE", HIERARCHIE)
        SQL_ADD_CORPS.Parameters.AddWithValue("@ID_CORPS_GROUPE", ID_CORPS_GROUPE)
        SQL_ADD_CORPS.ExecuteNonQuery()
        Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)
    End Sub
End Class
