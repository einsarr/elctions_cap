Imports System.IO
Imports CrystalDecisions.CrystalReports.Engine

Partial Class elections_ReportForm
    Inherits System.Web.UI.Page


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        Dim crystalReport As New ReportDocument()
        crystalReport.Load(Server.MapPath("~/elections_cap_cd/CrystalReport1.rpt"))
        CrystalReportViewer1.ReportSource = crystalReport
        CrystalReportViewer1.RefreshReport()
    End Sub
End Class
