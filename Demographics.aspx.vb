Imports System.Text.RegularExpressions
Public Class Demographics
    Inherits System.Web.UI.Page
    Private oSS As New clsSelfScheduling
    Private mstrFacilID As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim sGUID As String = System.Guid.NewGuid.ToString()
        'Session("sessionID") = sGUID
        'Dim fid As String = Session("fid")
        Dim oFacil As clsFacil
        If Not IsPostBack Then
            If "" & Session("ptID") <> "" Then
                LoadDemographicsFromSession()
            Else
                mstrFacilID = "" & Request.QueryString("fid")
                Session("facilID") = mstrFacilID
                oFacil = New clsFacil(CInt(mstrFacilID))
                With oFacil
                    imgFacilLogo.Src = "assets/img/" & .LogoImage
                    lblFacilPhone.Text = "If you have any questions, please call the Urgent Care desk at " & .Phone

                    'lblFacil.Text = .Name
                End With
            End If
        Else
            mstrFacilID = Session("facilID")
        End If

    End Sub
    Private Function SaveDemographics() As Integer
        Dim ptID As Integer
        Dim strFirstName As String = first_name.Text
        Dim strLastName As String = last_name.Text
        Dim strDOB As String = ddlMonth.Value & ddlDay.Value & ", " & ddlYear.Value
        Dim strDOBMonth As String = ddlMonth.Value
        Dim strDOBDay As String = ddlDay.Value
        Dim strDOBYear As String = ddlYear.Value

        '= txtDOB.Text
        Dim strEmail As String = txtEmail.Text
        Dim strPhone As String = txtPhone.Text
        Dim strGender As String = ddlGender.Value
        Dim strAddress As String = address.Text
        Dim strCity As String = city.Text
        Dim strState As String = state.Value
        Dim strZip As String = zip.Text
        Dim strDr As String = dr.Text
        Dim strEcFirstName As String = txtEcFirstName.Text
        Dim strEcLastName As String = txtEcLastName.Text
        Dim strEcPhone As String = txtEcPhone.Text
        Dim strNokFirstName As String = txtNokFirstName.Text
        Dim strNokLastName As String = txtNokLastName.Text
        Dim strNokPhone As String = txtNokPhone.Text
        Dim strDx As String
        Dim strSx As String
        Dim strConsent As String
        Dim strFin As String
        If rbDxYes.Checked = True Then
            strDx = "Yes"
        Else
            strDx = "No"
        End If
        If rbSxYes.Checked = True Then
            strSx = "Yes"
        Else
            strSx = "No"
        End If

        If rbConsentYes.Checked = True Then
            strConsent = "Yes"
        Else
            strConsent = "No"
        End If

        If rbFinYes.Checked = True Then
            strFin = "Yes"
        Else
            strFin = "No"
        End If
        Session("first_name") = strFirstName
        Session("last_name") = strLastName
        Session("dob") = strDOB
        Session("dobMonth") = strDOBMonth
        Session("dobDay") = strDOBDay
        Session("dobYear") = strDOBYear
        Session("email") = strEmail
        Session("address") = strAddress
        Session("city") = strCity
        Session("phone") = strPhone
        Session("gender") = strGender
        Session("state") = strState
        Session("zip") = strZip
        Session("dr") = strDr
        Session("EcFirstName") = strEcFirstName
        Session("EcLastName") = strEcLastName
        Session("EcPhone") = strEcPhone
        Session("strNokFirstName") = strNokFirstName
        Session("NokLastName") = strNokLastName
        Session("NokPhone") = strNokPhone
        Session("Dx") = strDx
        Session("Sx") = strSx
        Session("Consent") = strConsent
        Session("Fin") = strFin

        ' Session("fasted") = strFasted

        Dim imgFile As HttpPostedFile = fileOrder.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileOrder") = "Image Selected"
        Else
            Session("fileOrder") = "No Image"
        End If
        imgFile = fileIns1F.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileIns1") = "Image Selected"
        Else
            Session("fileIns1") = "No Image"
        End If
        imgFile = fileIns1B.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileIns2") = "Image Selected"
        Else
            Session("fileIns2") = "No Image"
        End If
        imgFile = fileSelfie.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileSelfie") = "Image Selected"
        Else
            Session("fileSelfie") = "No Image"
        End If

        ptID = oSS.Demographics_Save(ptID, strFirstName, strLastName, strDOB, strPhone, strGender, strEmail, strDr, strAddress, strCity, strState, strZip, strEcFirstName, strEcLastName, strEcPhone, strNokFirstName, strNokLastName, strNokPhone, strDx, strSx, strConsent, strFin, mstrFacilID)
        Return ptID
    End Function
    Private Function SaveImages(ByVal ptID As Integer) As Integer
        Dim oRC As New clsSelfScheduling
        Dim imgFile As HttpPostedFile = fileOrder.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileOrder") = "  Image Selected"
            Call oRC.saveImageToDB(ptID, imgFile, "Order")
        Else
            Session("fileOrder") = "  No Image"
        End If
        imgFile = fileIns1F.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileIns1") = "  Image Selected"
            Call oRC.saveImageToDB(ptID, imgFile, "Ins1")
        Else
            Session("fileIns1") = "  No Image"
        End If
        imgFile = fileIns1B.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileIns2") = "  Image Selected"
            Call oRC.saveImageToDB(ptID, imgFile, "Ins2")
        Else
            Session("fileIns2") = "  No Image"
        End If
        imgFile = fileSelfie.PostedFile
        If (imgFile IsNot Nothing) AndAlso (imgFile.ContentLength > 0) Then
            Session("fileSelfie") = "  Image Selected"
            Call oRC.saveImageToDB(ptID, imgFile, "Selfie")
        Else
            Session("fileSelfie") = "  No Image"
        End If


    End Function
    Private Sub LoadDemographicsFromSession()
        Dim oSS As New clsSelfScheduling
        Dim aryDOB As String()
        Dim strDOB As String = Session("dob")
        Dim strConsTreat As String = Session("ConsTreat")
        Dim strConsFin As String = Session("ConsFin")
        'checks to see if user has arrived by hitting back button
        '  If so, load from session, then call function to NULL out time slot, since the calendar page will
        '  default to the earliest time of currernt day
        mstrFacilID = Session("facilID")
        If strDOB.Length > 0 Then
            aryDOB = strDOB.Split("/")
            ddlMonth.Value = aryDOB(0)
            ddlDay.Value = aryDOB(1)
            ddlYear.Value = aryDOB(2)
        End If
        If "" & Session("ptID") <> "" Then
            first_name.Text = Session("first_name")
            last_name.Text = Session("last_name")
            ddlMonth.Value = Session("dobMonth")
            ddlDay.Value = Session("dobDay")
            ddlYear.Value = Session("dobYear")
            txtEmail.Text = Session("email")
            address.Text = Session("address")
            city.Text = Session("city")
            txtPhone.Text = Session("phone")
            ddlGender.Value = Session("dob")
            state.Value = Session("state")
            zip.Text = Session("zip")
            dr.Text = Session("dr")
            txtEcFirstName.Text = Session("EcFirstName")
            txtEcLastName.Text = Session("EcLastName")
            txtEcPhone.Text = Session("EcPhone")
            txtNokFirstName.Text = Session("NokFirstName")
            txtNokLastName.Text = Session("NokLastName")
            txtNokPhone.Text = Session("NokPhone")
            lblFileOrder.Text = Session("fileOrder")
            lblFileIns1F.Text = Session("fileIns1")
            lblFileIns1B.Text = Session("fileIns2")
            lblFileSelfie.Text = Session("fileSelfie")
            Dim strDate As String = Session("SelDate")
            Dim strTime As String = Session("SelTime")
            oSS.Reset_TimeSlot(strDate, strTime)
            'ClientScript.RegisterStartupScript(Me.GetType(), "Javascript", "javascript:checkValid(); ", True)
            'Page.ClientScript.RegisterStartupScript(Me.GetType(), "window-script", "EnableButton()", True)
            'ClientScript.RegisterStartupScript(Me.GetType(), "EnableButton()", True)
            'ScriptManager.RegisterClientScriptBlock(TypeOf (Page), Me.GetType(), "alert", message, True)
            ' Page.ClientScript.RegisterStartupScript(Me.GetType, "Registered Script", "alert('hello world');", True)
            Page.ClientScript.RegisterStartupScript(Me.GetType, "Registered Script", "$('#btnSubmit').prop('disabled', false);", True)
        End If

    End Sub

    'Private Sub cmdNext_Click(sender As Object, e As EventArgs) Handles cmdNext.Click
    '    Dim httpRequest As HttpRequest = HttpContext.Current.Request
    '    Dim ptID As Integer = SaveDemographics()
    '    Session("ptID") = ptID
    '    Call SaveImages(ptID)

    '    Server.Transfer("CalM.aspx", True)

    '    'If httpRequest.Browser.IsMobileDevice Then
    '    '    Server.Transfer("CalM.aspx", True)
    '    'Else
    '    '    Server.Transfer("Cal.aspx", True)
    '    'End If

    'End Sub

    Private Sub btnSubmit_ServerClick(sender As Object, e As EventArgs) Handles btnSubmit.ServerClick
        Dim httpRequest As HttpRequest = HttpContext.Current.Request
        Dim ptID As Integer = SaveDemographics()
        Session("ptID") = ptID
        Call SaveImages(ptID)

        ' Server.Transfer("CalM.aspx", True)
        Response.Redirect("CalM.aspx")
    End Sub

    Private Sub cmdCancel_Click(sender As Object, e As EventArgs) Handles cmdCancel.Click
        Session.RemoveAll()
        Response.Redirect("LandingPage.aspx")
    End Sub
End Class