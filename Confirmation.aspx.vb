Public Class Confirmation
    Inherits System.Web.UI.Page
    <System.Web.Services.WebMethod()>
    Public Shared Function CancelTimeSlot(ByVal strSelDate As String, ByVal strSelTime As String) As String
        Dim oSS As New clsSelfScheduling
        If strSelTime <> "" Then
            Dim timeSlot As String = oSS.ChangeToMilitaryTime(strSelTime)
            Call oSS.Cancel_TimeSlot(strSelDate, timeSlot)
        End If
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            'check if session has ecpired and if so, send back to start page
            Dim intPtID As Integer = "0" & Session("PtID")
            hidPtID.Value = intPtID
            hidSelDate.Value = Session("SelDate")
            hidSelTime.Value = Session("SelTime")
            If intPtID = 0 Then
                Response.Redirect("Demographics.aspx")
            Else
                GetDemogValues()
            End If

        End If
    End Sub

    Private Sub GetDemogValues()
        Dim strFirstName As String = Session("first_name")
        Dim strDOB As String = Session("dob")
        Dim strLastName As String = Session("last_name")
        Dim strEmail As String = Session("email")
        Dim strPhone As String = Session("phone")
        Dim strGender As String = Session("gender")
        Dim strAddress As String = Session("address")
        Dim strCity As String = Session("city")
        Dim strState As String = Session("state")
        Dim strZip As String = Session("zip")
        Dim strDr As String = Session("dr")


        Dim strEcFirstName As String = Session("EcFirstName")
        Dim strEcLastName As String = Session("EcLastName")
        Dim strEc As String = strEcFirstName & " " & strEcLastName
        Dim strEcPhone As String = Session("EcPhone")
        Dim strNokFirstName As String = Session("NokFirstName")
        Dim strNokLastName As String = Session("NokLastName")
        Dim strNok = strNokFirstName & " " & strNokLastName

        Dim strNokPhone As String = Session("NokPhone")
        Dim strDx As String = Session("Dx")
        Dim strSx As String = Session("Sx")
        Dim strConsent As String = Session("Consent")
        Dim strFin As String = Session("Fin")


        Dim strDate As String = Session("SelDate")
        Dim strTime As String = Session("SelTime")


        lblName.Text = strFirstName & " " & strLastName
        lblDOB.Text = strDOB
        lblEmail.Text = strEmail
        lblPhone.Text = strPhone
        lblGender.Text = strGender
        lblAddr.Text = strAddress
        lblAddr2.Text = strCity & ", " & strState & " " & strZip
        'lblFasted.Text = strFasted
        lblDr.Text = strDr
        lblEC.Text = strEcFirstName
        lblEcPhone.Text = strEcPhone
        lblNok.Text = strNok
        lblNokPhone.Text = strNokPhone
        lblDx.Text = strDx
        lblSx.Text = strSx
        lblConsent.Text = strConsent
        lblFin.Text = strFin

        lblDate.Text = strDate
        lblTime.Text = strTime

    End Sub

    ' Private Sub cmdNext_Click(sender As Object, e As EventArgs) Handles cmdNext.Click

    'Dim oSS As New clsSelfScheduling
    ''if session has expired, send back to start page
    'Dim intPtID As Integer = "0" & Session("ptID")
    'If intPtID = 0 Then
    '    Response.Redirect("Demographics.aspx")
    'Else
    '    Dim strDate As String = Session("SelDate")
    '    Dim strTime As String = Session("SelTime")
    '    ' oSS.Demographics_Save(intPtID, strFirstName, strLastName, strPhone, strEmail, strDr, strAddress, strCity, strState, strZip)
    '    oSS.UpdatePatientAppt(intPtID, strDate, strTime)
    '    Session("Success") = "Success"
    '    Server.Transfer("Complete.aspx?status=success")
    'End If
    'End Sub

    Private Sub btnSubmit_ServerClick(sender As Object, e As EventArgs) Handles btnSubmit.ServerClick
        Dim oSS As New clsSelfScheduling
        'if session has expired, send back to start page
        Dim intPtID As Integer = "0" & Session("ptID")
        If intPtID = 0 Then
            Response.Redirect("Demographics.aspx")
        Else
            Dim strDate As String = Session("SelDate")
            Dim strTime As String = Session("SelTime")
            ' oSS.Demographics_Save(intPtID, strFirstName, strLastName, strPhone, strEmail, strDr, strAddress, strCity, strState, strZip)
            oSS.UpdatePatientAppt(intPtID, strDate, strTime)
            Session("Success") = "Success"
            Server.Transfer("Complete.aspx?status=success")
        End If

    End Sub

    'Private Sub cmdCancel_Click(sender As Object, e As EventArgs) Handles cmdCancel.Click
    '    ' Response.Redirect("Demographics.aspx")
    'End Sub

End Class