Imports Owin
Imports Microsoft.Owin.Security.Cookies
Imports Microsoft.Owin.Security.Google
Imports Microsoft.Owin

Partial Public Class Startup
    ' Pour plus d'informations sur la configuration de l'authentification, visitez https://go.microsoft.com/fwlink/?LinkId=301883
    Public Sub ConfigureAuth(app As IAppBuilder)
        ' Laisser l’application utiliser un cookie pour stocker les informations de l’utilisateur connecté
        ' et stocke aussi les informations sur la connexion d’un utilisateur avec un fournisseur de connexion tiers.
        ' Ceci est obligatoire si votre application autorise les utilisateurs à se connecter
        app.UseCookieAuthentication(New CookieAuthenticationOptions() With {
        .AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
        .LoginPath = New PathString("/Account/Login")})
        app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie)

        ' Décommenter les lignes suivantes pour activer la connexion avec des fournisseurs de connexion tiers
        'app.UseMicrosoftAccountAuthentication(
        '    clientId:= "",
        '    clientSecret:= "")

        'app.UseTwitterAuthentication(
        '   consumerKey:= "",
        '   consumerSecret:= "")

        'app.UseFacebookAuthentication(
        '   appId:= "",
        '   appSecret:= "")

        'app.UseGoogleAuthentication(New GoogleOAuth2AuthenticationOptions() With {
        '   .ClientId = "",
        '   .ClientSecret = ""})
    End Sub
End Class
