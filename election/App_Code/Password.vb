Imports Microsoft.VisualBasic

Public Class Password
    Public Enum PwdCaseType
        pwdUPPER = 1
        pwdLOWER = 2
        pwdMIXED = 3
    End Enum

    Public Function GeneratePassword(ByVal minAlpha As Long, _
                                     ByVal maxAlpha As Long, _
                                     ByVal alphaCase As PwdCaseType, _
                                     ByVal minDigit As Long, _
                                     ByVal maxDigit As Long, _
                                     ByVal minOther As Long, _
                                     ByVal maxOther As Long) As String
        Dim alpha As String
        Dim digit As String
        Dim other As String
        Dim i As Long
        Dim pwd As String

        Dim alphas As String
        Dim digits As String
        Dim others As String

        Dim a As Long
        Dim b As Long
        Dim l As Long
        Dim tmp As String

        Const MAX_PERMUT As Long = 100

        alphas = "ABCDEFGHIJKLMNPQRSTUVWXYZ"    ' exclude O
        digits = "123456789"                    ' exclude zero
        'others = "&@#§$%_"
        others = "1"


        Randomize(Timer())

        For i = 1 To minAlpha + Int(Rnd() * (maxAlpha - minAlpha + 1))
            alpha = alpha & Mid$(alphas, 1 + Int(Rnd() * Len(alphas)), 1)
        Next i

        If alphaCase = 2 Then
            alpha = LCase(alpha)
        ElseIf alphaCase = 3 Then
            For i = 1 To Len(alpha) Step 2
                Mid$(alpha, i, 1) = LCase(Mid$(alpha, i, 1))
            Next i
        End If

        ' generate digit if any
        For i = 1 To minDigit + Int(Rnd() * (maxDigit - minDigit + 1))
            digit = digit & Mid$(digits, 1 + Int(Rnd() * Len(digits)), 1)
        Next i

        ' generate others if any
        For i = 1 To minOther + Int(Rnd() * (maxOther - minOther + 1))
            other = other & Mid$(others, 1 + Int(Rnd() * Len(others)), 1)
        Next i

        pwd = alpha & digit & other

        ' scramble
        l = Len(pwd)
        For i = 1 To MAX_PERMUT
            a = 1 + Int(Rnd() * l)
            b = 1 + Int(Rnd() * l)
            tmp = Mid$(pwd, a, 1)
            Mid$(pwd, a, 1) = Mid$(pwd, b, 1)
            Mid$(pwd, b, 1) = tmp
        Next i

        GeneratePassword = pwd

    End Function
End Class
