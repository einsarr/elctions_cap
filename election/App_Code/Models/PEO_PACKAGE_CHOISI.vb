Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial

Partial Public Class PEO_PACKAGE_CHOISI
    <Key>
    <Column(TypeName:="numeric")>
    <DatabaseGenerated(DatabaseGeneratedOption.Identity)>
    Public Property ID_CHOIX As Decimal

    <Column(TypeName:="numeric")>
    Public Property ID_PACKAGE As Decimal
    Public Overridable Property PEO_PACKAGE As PEO_PACKAGE


    Public Property IDENTIFIANT_ENSEIGNANT As Integer
    Public Overridable Property ENSEIGNANT As ENSEIGNANT

    Public Property ID_EDITION As Integer
    Public Overridable Property PEO_EDITION As PEO_EDITION

    Public Property DATE_CHOIX As Date

    Public Property CHOIX_VALIDE As Boolean

    <Required>
    <StringLength(50)>
    Public Property NUMERO_SOUSCRIPTION As String

    Public Property MAIL_ENVOYE As Boolean

    Public Property DATE_ENVOI_MAIL As Date?
End Class
