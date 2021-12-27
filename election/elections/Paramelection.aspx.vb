Imports System.Data.SqlClient

Partial Class elections_Paramelection
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Data Source=.;Initial Catalog=FUP;Integrated Security=True")
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim cmd As New SqlCommand
        cmd.CommandText = "INSERT INTO paramelection VALUES('" & Convert.ToInt32(DropDownList1.Text) & "','" & TextBox0.Text & "','" & TextBox1.Text & "','" & TextBox2.Text & "','" & 8 & "')"
        cmd.Connection = conn
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
    End Sub
End Class
