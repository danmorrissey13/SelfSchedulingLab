Public Class Complete
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            Dim strFirstName As String = Session("first_name")
            Dim strLastName As String = Session("last_name")
            Dim strEmail As String = Session("email")
            Dim strPhone As String = Session("phone")

            Dim strDate As String = Session("SelDate")
            Dim strTime As String = Session("SelTime")
            If Session("Success") = "Success" Then
                lblHeading.Text = "Appointment Successful"

                lblMsg1.Text = "Thank You " & strFirstName
                lblMsg2.Text = "Your appointment has been scheduled for " & strDate & " at " & strTime & "."
            Else
                lblHeading.Text = "Appointment not successful"

                lblMsg1.Text = "The application encountered an error. "
                lblMsg2.Text = "Please try again later."
            End If
            Session.RemoveAll()

        End If


    End Sub

    Private Sub cmdDone_Click(sender As Object, e As EventArgs) Handles cmdDone.Click
        Server.Transfer("Demographics.aspx")
    End Sub


End Class