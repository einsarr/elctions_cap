<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ReportForm.aspx.vb" Inherits="elections_ReportForm" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <hr />
    <hr />
    Country:
 
    <asp:Button ID="Button1" runat="server" Text="Imprimer" />

    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"  Height="50px" ReportSourceID="CrystalReportSource1" ToolPanelView="None" ToolPanelWidth="200px" Width="350px" />
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="~/elections/CrystalReport1.rpt">
        </Report>
    </CR:CrystalReportSource>
</asp:Content>

