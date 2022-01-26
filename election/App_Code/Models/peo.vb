Imports System
Imports System.Data.Entity
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Linq

Partial Public Class peo
    Inherits DbContext

    Public Sub New()
        MyBase.New("name=FUPConnectionString")
    End Sub

    Public Overridable Property ENSEIGNANT As DbSet(Of ENSEIGNANT)
    Public Overridable Property PEO_CONSOMMABLE As DbSet(Of PEO_CONSOMMABLE)
    Public Overridable Property PEO_EDITION As DbSet(Of PEO_EDITION)
    Public Overridable Property PEO_PACKAGE As DbSet(Of PEO_PACKAGE)
    Public Overridable Property PEO_PACKAGE_CHOISI As DbSet(Of PEO_PACKAGE_CHOISI)
    Public Overridable Property PEO_PACKAGE_DETAILS As DbSet(Of PEO_PACKAGE_DETAILS)
    Public Overridable Property Actualite As DbSet(Of Actualite)

    Protected Overrides Sub OnModelCreating(ByVal modelBuilder As DbModelBuilder)
        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.IDENTIFIANT_ENSEIGNANT_POINTAGE) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.IDENTIFIANT_ENSEIGNANT_FUP) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.NBRE_ENFANTS) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2006) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2007_1erMvmt) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2007_2emeMvmt) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2008_1emeMvmt) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2008_2emeMvmt) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2009_1erMvmt) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2010) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2011) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2012) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.MOBILE_ENSEIGNANT) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.MOBILE_ENSEIGNANT2) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.PASSWORD_VALIDE) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.STATUS) _
            .IsUnicode(False)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_MOUVEMENT_2014) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .Property(Function(e) e.CODE_POSITION) _
            .IsUnicode(False)

        modelBuilder.Entity(Of ENSEIGNANT)() _
            .HasMany(Function(e) e.PEO_PACKAGE_CHOISI) _
            .WithRequired(Function(e) e.ENSEIGNANT) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of PEO_CONSOMMABLE)() _
            .Property(Function(e) e.ID_CONSOMMABLE) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of PEO_CONSOMMABLE)() _
            .Property(Function(e) e.DESCRIPTION_CONSOMMABLE) _
            .IsUnicode(False)

        modelBuilder.Entity(Of PEO_CONSOMMABLE)() _
            .HasMany(Function(e) e.PEO_PACKAGE_DETAILS) _
            .WithRequired(Function(e) e.PEO_CONSOMMABLE) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of PEO_PACKAGE)() _
            .Property(Function(e) e.ID_PACKAGE) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of PEO_PACKAGE)() _
            .Property(Function(e) e.DESCRIPTION_PACKAGE) _
            .IsUnicode(False)

        modelBuilder.Entity(Of PEO_PACKAGE)() _
            .HasMany(Function(e) e.PEO_PACKAGE_CHOISI) _
            .WithRequired(Function(e) e.PEO_PACKAGE) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of PEO_PACKAGE)() _
            .HasMany(Function(e) e.PEO_PACKAGE_DETAILS) _
            .WithRequired(Function(e) e.PEO_PACKAGE) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of PEO_PACKAGE_CHOISI)() _
            .Property(Function(e) e.ID_CHOIX) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of PEO_PACKAGE_CHOISI)() _
            .Property(Function(e) e.ID_PACKAGE) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of PEO_PACKAGE_DETAILS)() _
            .Property(Function(e) e.ID_PACKAGE_DETAILS) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of PEO_PACKAGE_DETAILS)() _
            .Property(Function(e) e.ID_PACKAGE) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of PEO_PACKAGE_DETAILS)() _
            .Property(Function(e) e.ID_CONSOMMABLE) _
            .HasPrecision(18, 0)
    End Sub
End Class
