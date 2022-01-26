Imports System
Imports System.Collections.Generic
Imports System.ComponentModel.DataAnnotations
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Data.Entity.Spatial
<Table("ADM_MESSAGERIE_ACTUALITE")>
Public Class Actualite
    <Key>
    <DatabaseGenerated(DatabaseGeneratedOption.Identity)>
    Public Property idMessage As Integer

    <Required>
    <StringLength(100)>
    Public Property titreMessage As String

    <Required>
    <Column(TypeName:="text")>
    Public Property chapeauMessage As String

    <Required>
    <Column(TypeName:="text")>
    Public Property message As String

    <Required>
    Public Property datePublication As Date

    <Required>
    <StringLength(50)>
    Public Property publiePar As String

    <Required>
    Public Property aPublie As Boolean

    <Required>
    Public Property publieSur As Integer

    <StringLength(50)>
    Public Property modifiePar As String

    Public Property dateModification As Date?

    <Required>
    Public Property alaUne As Boolean

End Class
