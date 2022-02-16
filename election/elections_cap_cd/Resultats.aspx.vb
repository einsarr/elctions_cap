Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.CrystalReports
Partial Class elections_Resultats
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim cr1 As New ReportDocument
        cr1.Load("~/elections_cap_cd/CrystalReport.rpt")


    End Sub
End Class
