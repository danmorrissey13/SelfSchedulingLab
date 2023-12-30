Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Microsoft.VisualBasic.Strings

Public Class clsSelfScheduling
    Private mstrFacilID As String
    Protected CON_STR As String = ConfigurationManager.ConnectionStrings("PROD_Saratogaprod_Connection").ConnectionString '"ConnectionName1"]

    '
    Protected CN As SqlConnection
    Public Structure structHOO
        Public DOW As Integer
        Public DateDiff As Integer
        Public StartTimeMil_str As String
        Public StartTimeMil_int As Integer
        Public StartHour_str As String
        Public StartMin_str As String
        Public StartHour_int As Integer
        Public StartMin_int As Integer
    End Structure
    Private Function getStruct_HoursOfOperation(ByVal datDate As Date) As structHOO
        Dim Hoo As New structHOO
        Dim thisDate As Date = Now.Date
        Dim intDateDiff As Long = DateDiff(DateInterval.Day, thisDate, datDate)
        Dim intDow As Integer = Weekday(datDate)
        Dim timeNow = System.TimeZoneInfo.ConvertTime(Now, TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time"))
        Dim strTimeNow As String = Format(timeNow, "HH:mm")
        Dim strTimeNowMil As String = ChangeToMilitaryTime(strTimeNow)
        Dim intTimeNowMil As Integer = CInt(strTimeNowMil)
        Dim strL As String = Left(strTimeNowMil, 2)
        Dim strR As String = Right(strTimeNowMil, 2)
        Dim intHourCur As Integer = CInt(strL)
        Dim intMinCur As Integer = CInt(strR)
        Dim intHourStart As Integer
        'Dim startTime = Format(timeNow.AddHours(3), "HH:mm")
        '----------------------------------------------------------------------------------
        Select Case intMinCur
            Case 1 To 15
                intMinCur = 15
            Case 16 To 30
                intMinCur = 30
            Case 31 To 45
                intMinCur = 45
            Case > 45
                intMinCur = 45
        End Select
        '----------------------------------------------------------------------------------
        Select Case intDow
            Case 1
                intHourStart = 0 ' !!! Sundays should return no hours of operation
            Case 7 '!! Saturday hours are 9-2100
                Select Case intDateDiff
                    Case 0
                        intHourStart = 12 ' For current day - start time begins at noon - three hours from the start of operations
                        If intHourStart < (intHourCur + 3) Then intHourStart = intHourCur + 3 '!! Start time begins three hours from current time
                    Case 1 ' When reserving from the previous day, start time begins at the start of operations (0900) unless it's currently after 1800 the previous day
                        intHourStart = 9
                        If intHourCur > 18 Then intHourStart = 12 '!! When reserving time for a Sat from after 1800 on the prev day, start time begins three hours from start of operations
                    Case Else
                        intHourStart = 9
                End Select
            Case Else ' Weekdays - Hours of Operations are 0700-2100
                intDow = 0 ' Make all weekdays 0 DOW
                Select Case intDateDiff
                    Case 0
                        intHourStart = 10 '!! For current day - start time begins at noon - three hours from the start of operations
                        If intHourStart < (intHourCur + 3) Then intHourStart = intHourCur + 3 '!! Start time begins three hours from current time
                    Case 1
                        intHourStart = 7
                        If intHourCur >= 18 Then intHourStart = 10
                    Case Else
                        intHourStart = 7
                End Select
        End Select
        '----------------------------------------------------------------------------------
        With Hoo
            .DateDiff = intDateDiff
            .StartHour_int = intHourStart
            .StartMin_int = intMinCur
            .StartTimeMil_int = intHourStart & intMinCur
            .StartTimeMil_str = Right("00" & intHourStart, 2) & Right("00" & intMinCur, 2)
        End With
        Return Hoo
    End Function
    'Private Function getStruct_HoursOfOperation(ByVal datDate As Date) As structHOO
    '    Dim Hoo As New structHOO

    '    Dim intDOW As Integer
    '    Dim cmd As New SqlCommand
    '    Dim dr As SqlDataReader
    '    'Dim da As New SqlDataAdapter
    '    'Dim dt As New DataTable

    '    Try
    '        Call BASE_SetConSQL(True)
    '        With cmd
    '            .Connection = CN
    '            .CommandType = CommandType.StoredProcedure
    '            .CommandText = "usp_RS_GetHoursOfOperation"
    '            .Parameters.Add(New SqlParameter("@DOW", intDOW))
    '            dr = .ExecuteReader
    '        End With
    '        dr.Read()
    '        With Hoo
    '            .DOW = dr("Nbr")
    '            .Day = dr("Day")
    '            .StartTime = dr("StartTime")
    '            .EndTime = dr("EndTime")
    '        End With
    '        dr.Close()

    '        'da.SelectCommand = cmd
    '        'da.Fill(dt)
    '        'dt.TableName = "Hours"
    '        'Return dt
    '    Catch ex As Exception
    '        Throw New Exception("Error in base.NahamSaveID  Error = " & ex.Message)
    '    Finally
    '        cmd.Dispose()
    '        Call BASE_SetConSQL(False)

    '    End Try

    'End Function

    'Public Function BookAppointment(ByVal FirstName As String, ByVal LastName As String, ByVal Phone As String, ByVal Email As String,
    '                                              ByVal Dr As String, ByVal TestProc As String, ByVal strDate As String, ByVal strTime As String)
    '    Dim strColumn As String = ChangeToMilitaryTime(strTime)
    '    '  Dim intRegID As Integer = CreateNewPatientRegistration(FirstName, LastName, Phone, Email, Dr, TestProc)
    '    Dim TimeID As String = CheckTimeSlot(strDate, strColumn)
    '    If TimeID = "" Then
    '        'The time slot is still open so book it
    '        Call BookTimeSlot(intRegID, strDate, strColumn)
    '        Call UpdatePatientAppt(intRegID, strDate, strTime)
    '    End If

    'End Function
    Public Function ChangeToMilitaryTime(ByVal stime As String) As String
        'change  0545 PM to 1745  or 0915 AM to 0915
        'Removes the AM/PM and changes hour to 24 hour format
        'These are how the columns are named in the table
        If stime = "" Then Return "0000"
        Dim strTime As String() = stime.Split(":")
        Dim strHour As String = strTime(0)
        Dim strMin As String = strTime(1).Substring(0, 2)
        Dim intHour As Integer = CInt(strHour)
        Dim strAMPM As String = Right(stime, 2)
        If IsNumeric(strAMPM) Then
            strHour = stime.Replace(":", "")
            strHour = Right("0" & strHour, 4)
        Else
            If strAMPM = "PM" Then
                If intHour <> 12 Then
                    intHour += 12
                    'Else
                    '    intHour = 0
                End If
            Else
                If intHour = 12 Then intHour = 0
            End If
            strHour = Right("000" & intHour, 2) & strMin
        End If

        Return strHour
    End Function
    Protected Sub BASE_SetConSQL(ByVal Open As Boolean)
        Try
            If Open Then
                If IsNothing(CN) Then
                    CN = New SqlClient.SqlConnection(CON_STR)
                End If
                If CN.State = ConnectionState.Closed Then
                    CN.Open()
                End If
            Else
                If Not IsNothing(CN) Then
                    If CN.State = ConnectionState.Open Then CN.Close()
                End If
            End If
        Catch ex As Exception
            Throw New Exception("Base.SetCon Error: " & ex.Message)
        End Try
    End Sub

    Private Function GetTable_AvailHoursByDay(ByVal datDate As Date, ByVal intFacilID As Integer) As DataTable
        Dim strRetVal As String = ""
        Dim intDateDiff As Long = DateDiff(DateInterval.Day, Now, datDate)
        Dim intDow As Integer = Weekday(datDate)
        Dim strSproc As String

        '==========================================
        '  SELECT FACILITY - [THIS IS BEING HANDLED THROUGH A FACIL PARAM IN THIS APP INSTEAD OF THE ORIG METHOD THE UC APP BELOW]
        '==========================================
        '///   Select Case intFacilID
        '///      Case 1
        '///           strSproc = "usp_UCSCH_MMA_Sched_GetAvailHours"
        '///       Case 2
        '///           strSproc = "usp_UCSCH_AH_Sched_GetAvailHours"
        '///       Case 3
        '///           strSproc = "usp_UCSCH_WMA_Sched_GetAvailHours"
        '///   End Select

        '==========================================
        ' HOURS OF OPERATION MON-SAT ONLY Q15min
        '------------------------------------------
        '   M-F: Return 0700-2100
        '   SAT: return 0900-2100
        '------------------------------------------
        '   SAME DAY RESTRICTIONS: Can't schedule anything less than three hours in advance same day.
        '   PREV DAY RESTRICTIONS: After 1800, business hours next day start at 1000 (M-F) and noon on SAT.
        '------------------------------------------
        Select Case intDow
            Case 1, 7
            Case Else
                intDow = 0
        End Select
        '------------------------------------------
        '--  DATE CODE:
        '  Sunday-current day = 10
        '  Sunday-day before = 11
        '  Sat-current day = 60
        '  Sat-day before = 61
        '  Weekday-current day = 0
        '  Weekday-day before = 1
        '==========================================
        Dim strDateDiff As String = CStr(intDateDiff)
        Dim strDow As String = CStr(intDow)
        Dim strDateCode As String = strDateDiff & strDow
        Dim intDateCode As Integer = CInt(strDateCode)

        Dim cmd As New SqlCommand
        Dim da As New SqlDataAdapter
        Dim dt As New DataTable

        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                '.CommandText = strSproc
                .CommandText = "usp_RS_SelfSched_GetAvailHours"
                .Parameters.Add(New SqlParameter("@date", datDate))
                .Parameters.Add(New SqlParameter("@dow", intDow))
                .Parameters.Add(New SqlParameter("@facilID", intFacilID))
            End With
            da.SelectCommand = cmd
            da.Fill(dt)
            dt.TableName = "Hours"
            Return dt
        Catch ex As Exception
            Throw New Exception("Error in clsSelfScheduling.GetTable_AvailHoursByDay  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Function
    Public Function GetString_AvailHoursByDate(ByVal ptID As Integer, ByVal datDate As Date, ByVal intFacilID As Integer) As String
        Dim Hoo As New structHOO
        Hoo = getStruct_HoursOfOperation(datDate)

        Dim dt As DataTable = GetTable_AvailHoursByDay(datDate, intFacilID)
        Dim strDate As String = datDate.ToShortDateString
        Dim intPtID As String
        Dim strHours As String
        Dim datTime As DateTime
        Dim strHour As String
        Dim strHrMil As String
        Dim intHrMil As Integer


        Dim strTime As String
        Dim i As Integer

        Dim strL As String
        Dim strR As String

        Dim dr As DataRow = dt.Rows(0)
        Dim strVal As String
        Dim strTimeFirst As String

        Dim blnlPtID As Boolean '= ptID <> "0"
        Dim blnHours As Boolean
        Dim i2 As Integer = 2

        Dim blnStartMatch As Boolean
        For i = 2 To dt.Columns.Count - 2
            strHrMil = dt.Columns(i).ColumnName
            intHrMil = CInt(strHrMil)
            blnStartMatch = (Hoo.StartTimeMil_int = intHrMil)
            If blnStartMatch Then blnHours = True
            intPtID = "0" & dr(strHrMil)
            blnlPtID = (intPtID = ptID)
            strL = Left(strHrMil, 2)
            strR = Right(strHrMil, 2)

            strTime = strL & ":" & strR
            strDate = datDate.ToShortDateString & " " & strTime
            'strDate += " " & strHrMil
            datTime = CDate(strDate)
            strHour = datTime.ToShortTimeString.ToString()
            strVal = "" & dr(strHrMil)

            If blnHours Then
                If (strVal = "") Or (blnlPtID) Then
                    If i2 = 2 Then
                        strHours += "<option value=" & Chr(34) & strHrMil & Chr(34) & " selected=" & Chr(34) & "selected" & Chr(34) & ">" & strHour & "</option>"
                        strTimeFirst = strHour
                        i2 += 1
                    Else
                        strHours += "<option value=" & Chr(34) & strHrMil & Chr(34) & ">" & strHour & "</option>"
                    End If

                End If
            End If
        Next
        strHours += "|" & datDate.ToShortDateString & "|" & strTimeFirst
        Return strHours

    End Function

    Public Function GetString_AvailHoursByDate2(ByVal ptID As Integer, ByVal datDate As Date, ByVal intFacilID As Integer) As String
        Dim dt As DataTable = GetTable_AvailHoursByDay(datDate, intFacilID)
        Dim intDateDiff As Long = DateDiff(DateInterval.Day, Now, datDate)
        Dim strDate As String = datDate.ToShortDateString
        Dim intPtID As String
        Dim strHours As String
        Dim datTime As DateTime
        Dim strCol As String
        Dim strHour As String
        Dim strHrMil As String
        Dim intHrMil As Integer

        Dim pacificNow = Format(System.TimeZoneInfo.ConvertTime(Now, TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time")), "HH:mm")
        Dim intPacificNowMil = CInt(Left(pacificNow, 2))

        Dim easternNow = Format(System.TimeZoneInfo.ConvertTime(Now, TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time")), "HH:mm")
        Dim intEasternNowMil = CInt(Left(easternNow, 2))


        Dim strNowMil = Format(DateTime.Now, "HH:mm")
        Dim intNowMil = CInt(Left(strNowMil, 2))

        Dim intDayOfYear1 As Integer = datDate.DayOfYear
        Dim intDayOfYear2 As Integer = DateTime.Now.DayOfYear
        Dim blnCurDay As Boolean = (intDayOfYear1 = intDayOfYear2)

        Dim strTime As String
        Dim i As Integer
        Dim dc As DataColumn

        Dim strL As String
        Dim strR As String

        Dim dr As DataRow = dt.Rows(0)
        Dim strVal As String
        Dim strTimeFirst As String
        Dim blnExcludeHr As Boolean
        Dim blnSkip As Boolean
        Dim blnlPtID As Boolean '= ptID <> "0"
        Dim i2 As Integer = 2

        Dim intDow As Integer = Weekday(datDate)
        Dim intHrStart As Integer
        Dim intHrEnd As Integer

        For i = 2 To dt.Columns.Count - 2
            strHrMil = dt.Columns(i).ColumnName
            intPtID = "0" & dr(strHrMil)
            blnlPtID = (intPtID = ptID)
            strL = Left(strHrMil, 2)
            strR = Right(strHrMil, 2)
            intHrMil = CInt(strL)
            '
            'blnExcludeHr = (intHrMil <= intNowMil)
            If intDateDiff = 0 Then
                blnExcludeHr = (intHrMil <= intEasternNowMil + 3)
            Else
                blnExcludeHr = (intHrMil <= intEasternNowMil)
            End If

            '
            blnSkip = blnCurDay And blnExcludeHr
            strTime = strL & ":" & strR
            strDate = datDate.ToShortDateString & " " & strTime
            'strDate += " " & strHrMil
            datTime = CDate(strDate)
            strHour = datTime.ToShortTimeString.ToString()
            strVal = "" & dr(strHrMil)
            If Not blnSkip Then
                If (strVal = "") Or (blnlPtID) Then
                    If i2 = 2 Then
                        strHours += "<option value=" & Chr(34) & strHrMil & Chr(34) & " selected=" & Chr(34) & "selected" & Chr(34) & ">" & strHour & "</option>"
                        strTimeFirst = strHour
                        i2 += 1
                    Else
                        strHours += "<option value=" & Chr(34) & strHrMil & Chr(34) & ">" & strHour & "</option>"
                    End If

                End If


            End If
            'strHours += "|" & strDate
        Next
        strHours += "|" & datDate.ToShortDateString & "|" & strTimeFirst
        Return strHours

    End Function


    Private Function CreateNewPatientRegistration(byval intPtID As Integer, ByVal FirstName As String, ByVal LastName As String, ByVal Phone As String, ByVal Email As String,
                                                  ByVal Dr As String, ByVal TestProc As String) As Integer
        Dim strIPAddr As String = GetIPAddress()

        Dim cmd As New SqlCommand
        Dim dt As New DataTable
        Dim intID As Integer
        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_Patient_Save"
                .Parameters.Add(New SqlParameter("@FirstName", FirstName))
                .Parameters.Add(New SqlParameter("@LastName", LastName))
                .Parameters.Add(New SqlParameter("@Phone", Phone))
                .Parameters.Add(New SqlParameter("@Email", Email))
                .Parameters.Add(New SqlParameter("@dr", Dr))
                .Parameters.Add(New SqlParameter("@TestProc", TestProc))
                .Parameters.Add(New SqlParameter("@IPAddr", strIPAddr))
                intID = .ExecuteScalar
            End With
            Return intID
        Catch ex As Exception
            Throw New Exception("Error in base.CreateNewPatientRegistration  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Function
    Public Function Demographics_Save(ByVal intPtID As Integer, ByVal FirstName As String, ByVal LastName As String, ByVal strDOB As String, ByVal Phone As String, ByVal strGender As String, ByVal Email As String,
                                                 ByVal Dr As String, ByVal strAdddress As String, ByVal strCity As String,
                                      ByVal strState As String, ByVal strZip As String, ByVal strEcFirstName As String,
                                      ByVal strEcLastName As String, ByVal strEcPhone As String, ByVal strNokFirstName As String,
                                      ByVal strNokLastName As String, ByVal strNokPhone As String, ByVal strDx As String, ByVal strSx As String, ByVal strConsent As String, strFin As String, strFacilID As String) As Integer
        Dim strIPAddr As String = GetIPAddress()
        Dim cmd As New SqlCommand
        Dim dt As New DataTable
        Dim intID As Integer
        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_Patient_Save"
                .Parameters.Add(New SqlParameter("@ptID", intPtID))
                .Parameters.Add(New SqlParameter("@FirstName", FirstName))
                .Parameters.Add(New SqlParameter("@LastName", LastName))
                .Parameters.Add(New SqlParameter("@DOB", strDOB))
                .Parameters.Add(New SqlParameter("@Phone", Phone))
                .Parameters.Add(New SqlParameter("@Gender", strGender))
                .Parameters.Add(New SqlParameter("@Email", Email))
                .Parameters.Add(New SqlParameter("@dr", Dr))
                .Parameters.Add(New SqlParameter("@Address", strAdddress))
                .Parameters.Add(New SqlParameter("@City", strCity))
                .Parameters.Add(New SqlParameter("@State", strState))
                .Parameters.Add(New SqlParameter("@zip", strZip))
                .Parameters.Add(New SqlParameter("@EcFirstName", strEcFirstName))
                .Parameters.Add(New SqlParameter("@EcLastName", strEcLastName))
                .Parameters.Add(New SqlParameter("@EcPhone", strEcPhone))
                .Parameters.Add(New SqlParameter("@NokFirstName", strNokFirstName))
                .Parameters.Add(New SqlParameter("@NokLastName", strNokLastName))
                .Parameters.Add(New SqlParameter("@NokPhone", strNokPhone))
                .Parameters.Add(New SqlParameter("@Dx", strDx))
                .Parameters.Add(New SqlParameter("@Sx", strSx))
                .Parameters.Add(New SqlParameter("@Consent", strConsent))
                .Parameters.Add(New SqlParameter("@FinTerms", strFin))
                .Parameters.Add(New SqlParameter("@FacilID", strFacilID))
                .Parameters.Add(New SqlParameter("@IPAddr", strIPAddr))
                intID = .ExecuteScalar
            End With
            Return intID
        Catch ex As Exception
            Throw New Exception("Error in base.Demographics_Save  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Function
    Public Sub Cancel_TimeSlot(ByVal strDate As String, ByVal strSelTime As String)
        Dim cmd As New SqlCommand
        Dim dt As New DataTable
        Dim SQL As String
        SQL = "UPDATE RS_Sched SET [" & strSelTime & "] = NULL  WHERE [Date] = '" & strDate & "'"
        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_CancelTimeSlot"
                .Parameters.Add(New SqlParameter("@SQL", SQL))
                .ExecuteNonQuery()
            End With
        Catch ex As Exception
            Throw New Exception("Error in base.Update_TimeSlot  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)
        End Try
    End Sub

    Public Sub Update_TimeSlot(ByVal intPtID As Integer, ByVal strPrevDate As String, ByVal strDate As String, ByVal strPrevTime As String, ByVal strSelTime As String)

        Dim cmd As New SqlCommand
        Dim dt As New DataTable

        Dim SQL1 As String
        Dim SQL2 As String
        SQL1 = "UPDATE RS_Sched SET [" & strPrevTime & "] = NULL  WHERE [Date] = '" & strPrevDate & "'"

        SQL2 = "UPDATE RS_Sched SET [" & strSelTime & "] = " & intPtID & " WHERE [Date] = '" & strDate & "'"
        Try

            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_UpdateTimeSlot2"
                .Parameters.Add(New SqlParameter("@SQL1", SQL1))
                .Parameters.Add(New SqlParameter("@SQL2", SQL2))
                .ExecuteNonQuery()
            End With

        Catch ex As Exception
            Throw New Exception("Error in base.Update_TimeSlot  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Sub

    Public Sub Reset_TimeSlot(ByVal strDate As String, ByVal strSelTime As String)
        Dim cmd As New SqlCommand
        Dim dt As New DataTable
        Dim SQL As String
        strSelTime = ChangeToMilitaryTime(strSelTime)
        SQL = "UPDATE RS_Sched SET [" & strSelTime & "] = NULL  WHERE [Date] = '" & strDate & "'"
        Try

            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_ResetTimeSlot"
                .Parameters.Add(New SqlParameter("@SQL", SQL))
                .ExecuteNonQuery()
            End With

        Catch ex As Exception
            Throw New Exception("Error in base.Reset_TimeSlot  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Sub
    Public Sub Reset_Images(ByVal intPtID As Integer)

        Dim cmd As New SqlCommand
 
        Try

            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_ResetImages"
                .Parameters.Add(New SqlParameter("@ID", intPtID))
                .ExecuteNonQuery()
            End With

        Catch ex As Exception
            Throw New Exception("Error in base.Reset_Images  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Sub

    Public Function CheckTimeSlot(ByVal intPtID As Integer, ByVal strDate As String, ByVal strCol As String) As Boolean
        Dim cmd As New SqlCommand
        Dim da As New SqlDataAdapter
        Dim dt As New DataTable
        Dim dr As DataRow
        Dim retVal As String
        Dim ptID As Integer
        Dim blnMatch As Boolean
        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_GetTimeSlot"
                .Parameters.Add(New SqlParameter("@date", strDate))
                .Parameters.Add(New SqlParameter("@col", strCol))
            End With
            da.SelectCommand = cmd
            da.Fill(dt)
            dr = dt.Rows(0)
            ptID = CInt("0" & dr(strCol))
            blnMatch = ptID = intPtID
            Return blnMatch
        Catch ex As Exception
            Throw New Exception("Error in base.CheckTimeSlot  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Function
    Public Function CheckOpenTimeSlot(ByVal strDate As String, ByVal strCol As String) As Boolean
        Dim cmd As New SqlCommand
        Dim da As New SqlDataAdapter
        Dim dt As New DataTable
        Dim dr As DataRow
        Dim retVal As String
        Dim strPtID As String
        Dim blnMatch As Boolean
        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_GetTimeSlot"
                .Parameters.Add(New SqlParameter("@date", strDate))
                .Parameters.Add(New SqlParameter("@col", strCol))
            End With
            da.SelectCommand = cmd
            da.Fill(dt)
            dr = dt.Rows(0)
            strptID = "" & dr(strCol)
            blnMatch = strPtID = ""
            Return blnMatch
        Catch ex As Exception
            Throw New Exception("Error in base.CheckTimeSlot  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try

    End Function

    'Private Function BookTimeSlot(ByVal intRegID As Integer, ByVal strDate As String, ByVal strCol As String) As Integer
    '    Dim cmd As New SqlCommand
    '    Dim retVal As Integer
    '    Try
    '        Call BASE_SetConSQL(True)
    '        With cmd
    '            .Connection = CN
    '            .CommandType = CommandType.StoredProcedure
    '            .CommandText = "usp_RS_BookTimeSlot"
    '            .Parameters.Add(New SqlParameter("@regID", intRegID))
    '            .Parameters.Add(New SqlParameter("@date", strDate))
    '            .Parameters.Add(New SqlParameter("@col", strCol))
    '            retVal = .ExecuteNonQuery
    '        End With
    '    Catch ex As Exception
    '        Throw New Exception("Error in base.BookTimeSlot  Error = " & ex.Message)
    '    Finally
    '        cmd.Dispose()
    '        Call BASE_SetConSQL(False)
    '    End Try
    'End Function
    Public Function UpdatePatientAppt(ByVal intPtID As Integer, ByVal strDate As String, ByVal strTime As String) As Integer
        Dim cmd As New SqlCommand
        Dim retVal As Integer
        Try
            Call BASE_SetConSQL(True)
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = "usp_RS_Patient_ConfirmAppt"
                .Parameters.Add(New SqlParameter("@ID", intPtID))
                .Parameters.Add(New SqlParameter("@SchedDate", strDate))
                .Parameters.Add(New SqlParameter("@SchedTime", strTime))
                retVal = .ExecuteNonQuery
            End With
        Catch ex As Exception
            Throw New Exception("Error in base.UpdatePatientAppt  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)
        End Try
    End Function

    Public Shared Function GetIPAddress() As String
        Dim context As System.Web.HttpContext = System.Web.HttpContext.Current
        Dim sIPAddress As String = context.Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If String.IsNullOrEmpty(sIPAddress) Then
            Return context.Request.ServerVariables("REMOTE_ADDR")
        Else
            Dim ipArray As String() = sIPAddress.Split(New [Char]() {","c})
            Return ipArray(0)
        End If
    End Function

    Public Function saveImageToDB(ByVal intPtID As Integer, ByVal postedFile As HttpPostedFile, ByVal strImgType As String) As Integer
        Dim id As Integer
        'Dim sGUID As String = System.Guid.NewGuid.ToString()

        Dim strImageName As String = postedFile.FileName
        Dim lngth As Integer = postedFile.ContentLength
        Dim pic As Byte() = New Byte(lngth - 1) {}
        postedFile.InputStream.Read(pic, 0, lngth)

        'usp_MDCN_naham_ID_InsertBulk
        Dim strRetVal As String = ""

        Dim cmd As New SqlCommand
        Dim da As New SqlDataAdapter
        Dim dt As New DataTable
        Dim sprocName As String = "usp_RS_SaveImageToDB" & strImgType

        Try
            Call BASE_SetConSQL(True)


            '        Dim id As Integer = Convert.ToInt32(cmd.ExecuteScalar())
            With cmd
                .Connection = CN
                .CommandType = CommandType.StoredProcedure
                .CommandText = sprocName
                .Parameters.Add(New SqlParameter("@ptID", intPtID))
                .Parameters.Add(New SqlParameter("@ImgName", strImageName))
                .Parameters.Add(New SqlParameter("@imgBinary", pic))
                .ExecuteNonQuery()
            End With
        Catch ex As Exception
            Throw New Exception("Error in saveImageToDB( " & sprocName & ")  Error = " & ex.Message)
        Finally
            cmd.Dispose()
            Call BASE_SetConSQL(False)

        End Try
        Return id
    End Function
    Public Shared Function IsFederalHoliday(ByVal dt As DateTime) As Boolean
        Dim nthWeekDay As Integer = CInt((Math.Ceiling(CDbl(dt.Day) / 7.0R)))
        Dim dayName As DayOfWeek = dt.DayOfWeek
        Dim isThursday As Boolean = dayName = DayOfWeek.Thursday
        Dim isFriday As Boolean = dayName = DayOfWeek.Friday
        Dim isMonday As Boolean = dayName = DayOfWeek.Monday
        Dim isWeekend As Boolean = dayName = DayOfWeek.Saturday OrElse dayName = DayOfWeek.Sunday
        'New Years Day (Jan 1, or preceding Friday/following Monday if weekend)
        If (dt.Month = 12 AndAlso dt.Day = 31 AndAlso isFriday) OrElse (dt.Month = 1 AndAlso dt.Day = 1 AndAlso Not isWeekend) OrElse (dt.Month = 1 AndAlso dt.Day = 2 AndAlso isMonday) Then Return True
        '  MLK day (3rd monday in January)
        If dt.Month = 1 AndAlso isMonday AndAlso nthWeekDay = 3 Then Return True
        ' President's Day (3rd Monday in February)
        If dt.Month = 2 AndAlso isMonday AndAlso nthWeekDay = 3 Then Return True
        'Memorial Day (Last Monday in May)
        If dt.Month = 5 AndAlso isMonday AndAlso dt.AddDays(7).Month = 6 Then Return True
        'Independence Day (July 4, or preceding Friday/following Monday if weekend)
        If (dt.Month = 7 AndAlso dt.Day = 3 AndAlso isFriday) OrElse (dt.Month = 7 AndAlso dt.Day = 4 AndAlso Not isWeekend) OrElse (dt.Month = 7 AndAlso dt.Day = 5 AndAlso isMonday) Then Return True
        'Labor Day (1st Monday in September)
        If dt.Month = 9 AndAlso isMonday AndAlso nthWeekDay = 1 Then Return True
        ' Columbus Day (2nd Monday in October)
        If dt.Month = 10 AndAlso isMonday AndAlso nthWeekDay = 2 Then Return True
        'Veteran’s Day (November 11, or preceding Friday/following Monday if weekend))
        If (dt.Month = 11 AndAlso dt.Day = 10 AndAlso isFriday) OrElse (dt.Month = 11 AndAlso dt.Day = 11 AndAlso Not isWeekend) OrElse (dt.Month = 11 AndAlso dt.Day = 12 AndAlso isMonday) Then Return True
        'Thanksgiving Day (4th Thursday in November)
        If dt.Month = 11 AndAlso isThursday AndAlso nthWeekDay = 4 Then Return True
        'Christmas Day (December 25, or preceding Friday/following Monday if weekend))
        If (dt.Month = 12 AndAlso dt.Day = 24 AndAlso isFriday) OrElse (dt.Month = 12 AndAlso dt.Day = 25 AndAlso Not isWeekend) OrElse (dt.Month = 12 AndAlso dt.Day = 26 AndAlso isMonday) Then Return True
        Return False
    End Function

    Public Shared Function GetFederalHolidayCode(ByVal dt As DateTime) As Integer
        'Returns a code indicating the Type of Federal Holiday:
        '  Default of 0  = not a holiday
        '  1 = Federal holiday
        '  2 = Chistmas or Thanksgiving
        '  3 = Chrsitma or New Years Eve
        Dim nthWeekDay As Integer = CInt((Math.Ceiling(CDbl(dt.Day) / 7.0R)))
        Dim dayName As DayOfWeek = dt.DayOfWeek
        Dim isThursday As Boolean = dayName = DayOfWeek.Thursday
        Dim isFriday As Boolean = dayName = DayOfWeek.Friday
        Dim isMonday As Boolean = dayName = DayOfWeek.Monday
        Dim isWeekend As Boolean = dayName = DayOfWeek.Saturday OrElse dayName = DayOfWeek.Sunday
        'New Years Day (Jan 1, or preceding Friday/following Monday if weekend)
        If (dt.Month = 12 AndAlso dt.Day = 31 AndAlso isFriday) OrElse (dt.Month = 1 AndAlso dt.Day = 1 AndAlso Not isWeekend) OrElse (dt.Month = 1 AndAlso dt.Day = 2 AndAlso isMonday) Then Return 1

        'New Years Eve (Dec 31)
        If (dt.Month = 12 AndAlso dt.Day = 31 AndAlso Not isWeekend) Then Return 3
        'Christmas Eve (December 24)
        If (dt.Month = 12 AndAlso dt.Day = 24) Then Return 3


        '  MLK day (3rd monday in January)
        If dt.Month = 1 AndAlso isMonday AndAlso nthWeekDay = 3 Then Return 1
        ' President's Day (3rd Monday in February)
        If dt.Month = 2 AndAlso isMonday AndAlso nthWeekDay = 3 Then Return 1
        'Memorial Day (Last Monday in May)
        If dt.Month = 5 AndAlso isMonday AndAlso dt.AddDays(7).Month = 6 Then Return 1
        'Independence Day (July 4, or preceding Friday/following Monday if weekend)
        If (dt.Month = 7 AndAlso dt.Day = 3 AndAlso isFriday) OrElse (dt.Month = 7 AndAlso dt.Day = 4 AndAlso Not isWeekend) OrElse (dt.Month = 7 AndAlso dt.Day = 5 AndAlso isMonday) Then Return 1
        'Labor Day (1st Monday in September)
        If dt.Month = 9 AndAlso isMonday AndAlso nthWeekDay = 1 Then Return 1
        ' Columbus Day (2nd Monday in October)
        If dt.Month = 10 AndAlso isMonday AndAlso nthWeekDay = 2 Then Return 1
        'Veteran’s Day (November 11, or preceding Friday/following Monday if weekend))
        If (dt.Month = 11 AndAlso dt.Day = 10 AndAlso isFriday) OrElse (dt.Month = 11 AndAlso dt.Day = 11 AndAlso Not isWeekend) OrElse (dt.Month = 11 AndAlso dt.Day = 12 AndAlso isMonday) Then Return 1
        'Thanksgiving Day (4th Thursday in November)
        If dt.Month = 11 AndAlso isThursday AndAlso nthWeekDay = 4 Then Return 2
        'Christmas Day (December 25, or preceding Friday/following Monday if weekend))
        If (dt.Month = 12 AndAlso dt.Day = 24 AndAlso isFriday) OrElse (dt.Month = 12 AndAlso dt.Day = 25 AndAlso Not isWeekend) OrElse (dt.Month = 12 AndAlso dt.Day = 26 AndAlso isMonday) Then Return 2
        Return 0
    End Function
End Class
