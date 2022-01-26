Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class PEO_CONSOMMABLE
    Public Sub New()
        PEO_PACKAGE_DETAILS = New HashSet(Of PEO_PACKAGE_DETAILS)()
    End Sub

    <Key>
    <Column(TypeName:="numeric")>
    <DatabaseGenerated(DatabaseGeneratedOption.Identity)>
    Public Property ID_CONSOMMABLE As Decimal

    <Required>
    <StringLength(50)>
    Public Property LIBELLE_CONSOMMABLE As String

    <Column(TypeName:="text")>
    Public Property DESCRIPTION_CONSOMMABLE As String

    <StringLength(50)>
    Public Property IMAGE_CONSOMMABLE As String

    <Required>
    <StringLength(50)>
    Public Property AJOUTER_PAR As String

    Public Property DATE_AJOUT As Date

    <StringLength(50)>
    Public Property MODIFIER_PAR As String

    Public Property DATE_DERNIERE_MODIF As Date?

    Public Overridable Property PEO_PACKAGE_DETAILS As ICollection(Of PEO_PACKAGE_DETAILS)
End Class
