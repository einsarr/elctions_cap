<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="PV.aspx.vb" Inherits="fup_OS_os" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <section class="content-header">
        <h1>RESULTATS DU SCRUTIN
        </h1>      
    </section>
    <section class="content">
        <div class="row">
                <div class="col-md-12 form-inline">
                <div class="box box-primary">
                    <div class="box-body">
                        <div class="table-responsive">
               Liste des Ordres de Service par Site
                <asp:GridView ID="GridViewPV" runat="server" CssClass="table table-bordered table-hover" PagerStyle-CssClass="paginations" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="SqlPV" PageSize="15" DataKeyNames="ID_CORPS_GROUPE">
                    <Columns>
                        <asp:BoundField DataField="ETAT_CORPS_GROUPE" HeaderText="ETAT_CORPS_GROUPE" SortExpression="ETAT_CORPS_GROUPE" Visible="False" />
                        <asp:BoundField DataField="LIBELLE_CORPS_GROUPE" HeaderText="LIBELLE_CORPS_GROUPE" SortExpression="LIBELLE_CORPS_GROUPE" />
                        <asp:BoundField DataField="ID_CORPS_GROUPE" HeaderText="ID_CORPS_GROUPE" SortExpression="ID_CORPS_GROUPE" InsertVisible="False" ReadOnly="True" Visible="False" >
                        </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="ID_CORPS_GROUPE" DataNavigateUrlFormatString="http://www.mirador.education.gouv.sn:8081/ReportServer/Pages/ReportViewer.aspx?%2fRSMiroir%2fPV2&amp;rs:Command=Render&amp;rs:Format=PDF" HeaderText="Procès verbal" Text="PV" />
                    </Columns>

<PagerStyle CssClass="paginations"></PagerStyle>

                    <SelectedRowStyle CssClass="" BackColor="#EEEEEE" Font-Bold="True" ForeColor="black" />
                    <HeaderStyle ForeColor="#444444" CssClass="bg-gray" />
                    <EditRowStyle BackColor="#EEEEEE" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlPV" runat="server" ConnectionString="<%$ ConnectionStrings:FUPConnectionString %>" SelectCommand="SELECT ETAT_CORPS_GROUPE, LIBELLE_CORPS_GROUPE, ID_CORPS_GROUPE FROM ELECTION_CAP_CORPS_GROUPE">
                </asp:SqlDataSource>
                            </div>
                        </div>
                    </div>
                    </div>
            </div>
        </section>             
</asp:Content>

