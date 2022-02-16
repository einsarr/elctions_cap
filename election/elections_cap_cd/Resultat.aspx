<%@ Page Title="" Language="VB" MasterPageFile="~/MasterEnseignant.master" AutoEventWireup="false" CodeFile="Resultat.aspx.vb" Inherits="elections_Resultat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Contenu" Runat="Server">

    
    <asp:DataList ID="DataList1" runat="server" style="margin-right: 0px">
        <ItemTemplate>

            <table style="width: 100%">
                <tr>
                    <td colspan="2"><span>&nbsp;Commissions administratives paritaires et conseils de discipline</span></td>
                    <td><span>Nombres d’électeurs</span></td>
                    <td><span>Nombres de suffrages exprimés</span></td>
                </tr>
                <tr>
                    <td rowspan="5"><span>CAP/CD 1 (corps groupés ou corps concernés)</span></td>
                    <td>&nbsp;</td>
                    <td><span>Classe exceptionnelle</span></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td><span>1<sup>e</sup> classe </span></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>2<span><sup>e</sup> classe </span></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>3<span><sup>e</sup> classe </span></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>4<span><sup>e</sup> classe </span></td>
                    <td>&nbsp;</td>
                </tr>
            </table>

        </ItemTemplate>
    </asp:DataList>
</asp:Content>

