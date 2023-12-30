Public Class CalM
    Inherits System.Web.UI.Page
    Dim oSS As New clsSelfScheduling
    Private mintPtID As Integer
    Private mintFacilID As Integer
    <System.Web.Services.WebMethod()>
    Public Shared Function GetString_AvailableHoursByDate(ByVal intPtID As Integer, ByVal strDate As String, ByVal strFacilID As String) As String
        Dim oSS As New clsSelfScheduling
        'Dim strHours As String = oSS.GetString_AvailHoursByDate(intPtID, CDate(strDate))
        Dim strHours As String = oSS.GetString_AvailHoursByDate(intPtID, CDate(strDate), strFacilID)

        Return strHours
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateSelectedTime(ByVal intPtID As Integer, ByVal strPrevDate As String, ByVal strDate As String, ByVal strPrevTime As String, ByVal strSelTime As String) As String
        Dim oSS As New clsSelfScheduling
        If strSelTime <> "" Then
            Dim prevTimeM As String = oSS.ChangeToMilitaryTime(strPrevTime)
            Dim selTimeM As String = oSS.ChangeToMilitaryTime(strSelTime)
            Call oSS.Update_TimeSlot(intPtID, strPrevDate, strDate, prevTimeM, selTimeM)
        End If
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function CheckTimeSlot(ByVal intPtID As Integer, ByVal strDate As String, ByVal strSelTime As String) As String
        Dim oSS As New clsSelfScheduling
        Dim strRetVal As String

        Dim selTimeM As String = oSS.ChangeToMilitaryTime(strSelTime)
        strRetVal = oSS.CheckTimeSlot(intPtID, strDate, selTimeM)
        Return strRetVal

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckOpenTimeSlot(ByVal strDate As String, ByVal strSelTime As String) As String
        Dim oSS As New clsSelfScheduling
        Dim strRetVal As String

        Dim selTimeM As String = oSS.ChangeToMilitaryTime(strSelTime)
        strRetVal = oSS.CheckOpenTimeSlot(strDate, selTimeM)
        Return strRetVal

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ResetTimeSlot(ByVal intPtID As Integer, ByVal strDate As String, ByVal strSelTime As String) As String
        Dim oSS As New clsSelfScheduling
        If strSelTime <> "" Then
            Dim selTimeM As String = oSS.ChangeToMilitaryTime(strSelTime)
            Call oSS.Reset_TimeSlot(strDate, selTimeM)
        End If


    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Tells Demographic page that user hit back button so it can call function to NULL out time slot
        Session("calPage") = "True"
        If Not IsPostBack Then
            Dim strDate As String = Date.Now.ToShortDateString
            mintFacilID = "0" & Session("facilID")
            Session("facilID") = mintFacilID
            mintPtID = "0" + Session("ptID")
            hidPtID.Value = mintPtID

            hidSelDate.Value = strDate
            hidPrevDate.Value = strDate
            lblSelDate.Text = strDate
            LoadAvailableHours()
        Else
            Dim strSelDate As String = hidSelDate.Value
            Dim strSelTime As String = hidSelTime.Value
            Session("SelDate") = strSelDate
            Session("SelTime") = strSelTime
        End If
        Dim httpRequest As HttpRequest = HttpContext.Current.Request

    End Sub

    Private Sub LoadAvailableHours()
        Dim strMonth As String
        Dim strDay As String
        Dim strYr As String
        Dim aryDate As String()
        Dim strDate As String = Date.Now.ToShortDateString
        Dim aryRetval As String()
        Dim strTimeFirst As String
        aryDate = strDate.Split("/")
        strMonth = aryDate(0)
        strDay = aryDate(1)
        strYr = aryDate(2)
        hidSelDate.Value = strDate
        hidCurDay.Value = strDay
        hidCurMonth.Value = strMonth
        hidCurYear.Value = strYr
        Dim strHours As String = oSS.GetString_AvailHoursByDate(mintPtID, CDate(strDate), mintFacilID)
        aryRetval = strHours.Split("|")
        hidTimes.Value = aryRetval(0)
        strTimeFirst = aryRetval(2)
        hidSelTime.Value = strTimeFirst
        hidPrevTime.Value = strTimeFirst
        hidPrevDate.Value = strDate
        lblSelTime.Text = strTimeFirst
        If strTimeFirst <> "" Then
            UpdateSelectedTime(mintPtID, strDate, strDate, strTimeFirst, strTimeFirst)
            'Else
            '    cmdNext.Enabled = False
        End If


    End Sub

    Private Sub cmdNext_Click(sender As Object, e As EventArgs) Handles cmdNext.Click
        'Server.Transfer("Confirmation.aspx")
        Response.Redirect("Confirmation.aspx")

    End Sub

    Private Sub cmdCancel_Click(sender As Object, e As EventArgs) Handles cmdCancel.Click
        Session.RemoveAll()
        Server.Transfer("LandingPage.aspx", False)
    End Sub
End Class