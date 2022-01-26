Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class PEO_PACKAGE
    Public Sub New()
        PEO_PACKAGE_CHOISI = New HashSet(Of PEO_PACKAGE_CHOISI)()
        PEO_PACKAGE_DETAILS = New HashSet(Of PEO_PACKAGE_DETAILS)()
    End Sub

    <Key>
    <Column(TypeName:="numeric")>
    <DatabaseGenerated(DatabaseGeneratedOption.Identity)>
    Public Property ID_PACKAGE As Decimal

    <Required>
    <StringLength(200)>
    Public Property LIBELLE_PACKAGE As String

    <Column(TypeName:="text")>
    Public Property DESCRIPTION_PACKAGE As String

    <StringLength(50)>
    Public Property IMAGE_PACKAGE As String

    Public Property ID_EDITION As Integer
    Public Overridable Property PEO_EDITION As PEO_EDITION

    Public Property DATE_AJOUT As Date

    <Required>
    <StringLength(50)>
    Public Property AJOUTER_PAR As String

    Public Property DATE_DERNIERE_MODIF As Date?

    <StringLength(50)>
    Public Property MODIFIER_PAR As String

    Public Property PACKAGE_ACTIVE As Boolean

    <Column(TypeName:="numeric")>
    Public Property MONTANT As Decimal

    <StringLength(50)>
    Public Property DUREE_PAIEMENT As String

    Public Property ORDRE_PACKAGE As Integer

    Public Overridable Property PEO_PACKAGE_CHOISI As ICollection(Of PEO_PACKAGE_CHOISI)

    Public Overridable Property PEO_PACKAGE_DETAILS As ICollection(Of PEO_PACKAGE_DETAILS)
End Class
