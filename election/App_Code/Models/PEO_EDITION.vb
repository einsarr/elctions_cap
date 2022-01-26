Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Public Class PEO_EDITION
    <Key>
    <DatabaseGenerated(DatabaseGeneratedOption.Identity)>
    Public Property ID_EDITION As Integer

    <Required>
    <StringLength(50)>
    Public Property LIBELLE_EDITION As String

    <Required>
    <StringLength(50)>
    Public Property ANNEE As String

    <Required>
    Public Property DATE_DEBUT_EDITION As Date

    <Required>
    Public Property DATE_FIN_EDITION As Date

    <Required>
    Public Property EN_COURS As Boolean

    Public Overridable Property PEO_PACKAGE As ICollection(Of PEO_PACKAGE)

    Public Overridable Property PEO_PACKAGE_CHOISI As ICollection(Of PEO_PACKAGE_CHOISI)
End Class
