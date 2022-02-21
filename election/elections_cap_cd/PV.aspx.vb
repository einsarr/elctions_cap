Imports System.Data.SqlClient
Imports System.Data
Partial Class fup_OS_os
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

    End Sub

    'Protected Sub DropDownSite_DataBound(sender As Object, e As EventArgs) Handles DropDownSite.DataBound
    '    'If Not Page.IsPostBack Then

    '    '    Me.DropDownSite.SelectedIndex = Session("site_idx")


    '    'End If
    'End Sub

    'Protected Sub DropDownSite_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownSite.SelectedIndexChanged
    '    'Session("site_id") = Me.DropDownSite.SelectedValue
    '    'Session("site_idx") = Me.DropDownSite.SelectedIndex
    '    'Me.GridViewListeOS.PageIndex = Session("site_Page_idx")

    'End Sub

    Protected Sub GridViewPV_PageIndexChanged(sender As Object, e As EventArgs) Handles GridViewPV.PageIndexChanged

    End Sub



    Protected Sub GridViewListeOS_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridViewPV.SelectedIndexChanged
        'Session("site_Page_idx") = Me.GridViewListeOS.PageIndex
    End Sub

    'Protected Sub DetailsViewAdd_DataBound(sender As Object, e As EventArgs) Handles DetailsViewAdd.DataBound
    '    'Me.PanelAdd.Visible = False
    '    Me.GridViewListeOS.DataBind()
    'End Sub

    'Protected Sub DetailsViewAdd_Disposed(sender As Object, e As EventArgs) Handles DetailsViewAdd.Disposed

    '    'Me.PanelAdd.Visible = False
    '    Me.GridViewListeOS.DataBind()
    'End Sub



    'Protected Sub DetailsViewAdd_ItemInserted(sender As Object, e As DetailsViewInsertedEventArgs) Handles DetailsViewAdd.ItemInserted
    '    'Me.PanelAdd.Visible = False
    '    Me.GridViewListeOS.DataBind()
    'End Sub

    'Protected Sub DetailsViewAdd_PageIndexChanging(sender As Object, e As DetailsViewPageEventArgs) Handles DetailsViewAdd.PageIndexChanging

    'End Sub

    'Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
    '    'Me.PanelAdd.Visible = True
    '    Me.box.Visible = True
    'End Sub

    Protected Sub LinkButton2_Click(sender As Object, e As EventArgs)
        'box.Visible = False
    End Sub
End Class
