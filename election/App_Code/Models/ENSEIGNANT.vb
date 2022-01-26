Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

<Table("ENSEIGNANT")>
Partial Public Class ENSEIGNANT
    Public Sub New()
        PEO_PACKAGE_CHOISI = New HashSet(Of PEO_PACKAGE_CHOISI)()
    End Sub

    <Key>
    Public Property IDENTIFIANT_ENSEIGNANT As Integer

    <StringLength(3)>
    Public Property CODE_CORPS As String

    <StringLength(3)>
    Public Property CODE_DIPLOME As String

    <StringLength(3)>
    Public Property CODE_DIPLOME_PROFESSIONNEL As String

    <StringLength(3)>
    Public Property CODE_NATIONALITE As String

    <StringLength(3)>
    Public Property CODE_LANGUE As String

    <StringLength(3)>
    Public Property CODE_EMPLOYEUR As String

    <StringLength(3)>
    Public Property CODE_GRADE As String

    <StringLength(6)>
    Public Property CODE_ETABLISSEMENT As String

    <StringLength(3)>
    Public Property CODE_MATIERE As String

    <Required>
    <StringLength(11)>
    Public Property MATRICULE_ENSEIGNANT As String

    <Required>
    <StringLength(30)>
    Public Property NOM_ENSEIGNANT As String

    <Required>
    <StringLength(30)>
    Public Property PRENOMS_ENSEIGNANT As String

    <Required>
    <StringLength(1)>
    Public Property SEXE_ENSEIGNANT As String

    <Column(TypeName:="smalldatetime")>
    Public Property DATE_NAISS_ENSEIGNANT As Date?

    <Column(TypeName:="smalldatetime")>
    Public Property DATE_ENTREE_ETABLISSEMENT_ENSE As Date?

    <Column(TypeName:="smalldatetime")>
    Public Property DATE_ENTREE_FONCTION_PUBLIQUE_ As Date?

    <Column(TypeName:="smalldatetime")>
    Public Property DATE_ENTREE_ENSEIGNEMENT_ENSEI As Date?

    Public Property VOLUME_HORAIRE_DU As Integer?

    <StringLength(3)>
    Public Property CODE_FONCTION As String

    <StringLength(3)>
    Public Property CODE_SPECIALITE As String

    Public Property NB_HEURES_ASSURES As Short?

    <StringLength(3)>
    Public Property CODE_STATUT_PERSONNEL As String

    Public Property NB_JOUR_FORMATION As Short?

    <StringLength(3)>
    Public Property CODE_TYPE_POSTE As String

    Public Property OK As Boolean?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT As Decimal?

    <Column(TypeName:="numeric")>
    Public Property IDENTIFIANT_ENSEIGNANT_POINTAGE As Decimal?

    <Column(TypeName:="numeric")>
    Public Property IDENTIFIANT_ENSEIGNANT_FUP As Decimal?

    <StringLength(11)>
    Public Property OLD_MATRICULE As String

    Public Property DATE_CORPS As Date?

    <StringLength(15)>
    Public Property SITUATION_MATRIMONIALE As String

    <Column(TypeName:="numeric")>
    Public Property NBRE_ENFANTS As Decimal?

    <StringLength(3)>
    Public Property FUP_CODE_CORPS06 As String

    <StringLength(3)>
    Public Property FUP_CODE_GRADE06 As String

    <StringLength(40)>
    Public Property CREE_PAR As String

    Public Property DATE_CREATION As Date?

    <StringLength(40)>
    Public Property MODIFIE_PAR As String

    Public Property DATE_DERNIERE_MODIFICATION As Date?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2006 As Decimal?

    <StringLength(3)>
    Public Property FUP_CODE_CORPS07 As String

    <StringLength(3)>
    Public Property FUP_CODE_GRADE07 As String

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2007_1erMvmt As Decimal?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2007_2emeMvmt As Decimal?

    <StringLength(3)>
    Public Property FUP_CODE_CORPS08 As String

    <StringLength(3)>
    Public Property FUP_CODE_GRADE08 As String

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2008_1emeMvmt As Decimal?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2008_2emeMvmt As Decimal?

    Public Property IDENTIFIANT_ENSEIGNANT_AXE As Integer?

    <StringLength(3)>
    Public Property CODE_CLASSE_TENUE As String

    <StringLength(50)>
    Public Property CNI As String

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2009_1erMvmt As Decimal?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2010 As Decimal?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2011 As Decimal?

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2012 As Decimal?

    Public Property DECLARATION_PSV As Boolean?

    <StringLength(200)>
    Public Property COMMENTAIRE_ENSEIGNANT As String

    <StringLength(200)>
    Public Property LIEU_NAISSANCE_ENSEIGNANT As String

    <StringLength(100)>
    Public Property MAIL_ENSEIGNANT As String

    <StringLength(100)>
    Public Property MAIL_ENSEIGNANT2 As String

    <Column(TypeName:="numeric")>
    Public Property MOBILE_ENSEIGNANT As Decimal?

    <Column(TypeName:="numeric")>
    Public Property MOBILE_ENSEIGNANT2 As Decimal?

    <StringLength(100)>
    Public Property PASSWORD_ENSEIGNANT As String

    <StringLength(10)>
    Public Property PASSWORD_VALIDE As String

    <StringLength(255)>
    Public Property STATUS As String

    <Column(TypeName:="numeric")>
    Public Property CODE_MOUVEMENT_2014 As Decimal?

    Public Property DATE_INSCRIPTION_MIRADOR As Date?

    <Required>
    <StringLength(3)>
    Public Property CODE_TYPE_UTILISATION As String

    Public Property DATE_OBTENTION_DIPLOME_ACA As Date?

    Public Property DATE_OBTENTION_DIPLOME_PRO As Date?

    <StringLength(3)>
    Public Property CODE_POSITION As String

    Public Overridable Property PEO_PACKAGE_CHOISI As ICollection(Of PEO_PACKAGE_CHOISI)
End Class
