Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class PEO_PACKAGE_DETAILS
    <Key>
    <Column(TypeName:="numeric")>
    <DatabaseGenerated(DatabaseGeneratedOption.Identity)>
    Public Property ID_PACKAGE_DETAILS As Decimal

    <Column(TypeName:="numeric")>
    Public Property ID_PACKAGE As Decimal
    Public Overridable Property PEO_PACKAGE As PEO_PACKAGE

    <Column(TypeName:="numeric")>
    Public Property ID_CONSOMMABLE As Decimal
    Public Overridable Property PEO_CONSOMMABLE As PEO_CONSOMMABLE

    <Required>
    <StringLength(50)>
    Public Property AJOUTER_PAR As String

    Public Property DATE_AJOUT As Date

    Public Property EST_IMAGE_PACKAGE As Boolean

    Public Property ORDRE_PACKAGE As Integer

End Class
