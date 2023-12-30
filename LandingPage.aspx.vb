Public Class LandingPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.RemoveAll()
    End Sub

    Private Sub cmdSSL_WMA_Click(sender As Object, e As EventArgs) Handles cmdSSL_WMA.Click
        Response.Redirect("https://patientpathonline.com/SaratogaSelfSched/Demographics.aspx")
        'WrePriPre66!
    End Sub

    Private Sub cmdSSUC_AMC_Click(sender As Object, e As EventArgs) Handles cmdSSUC_AMC.Click
        Response.Redirect("https://patientpathonline.com/UCSCH/Demographics.aspx?fid=2")
    End Sub

    Private Sub cmdSSUC_MMEC_Click(sender As Object, e As EventArgs) Handles cmdSSUC_MMEC.Click
        Response.Redirect("https://patientpathonline.com/UCSCH/Demographics.aspx?fid=1")
    End Sub

    Private Sub cmdSSUC_WMA_Click(sender As Object, e As EventArgs) Handles cmdSSUC_WMA.Click
        Response.Redirect("https://patientpathonline.com/UCSCH/Demographics.aspx?fid=3")
    End Sub

    Private Sub cmdSCI_WMA_Click(sender As Object, e As EventArgs) Handles cmdSCI_WMA.Click
        Response.Redirect("https://patientpathonline.com/SelfSched/Demographics.aspx")
    End Sub

    'Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
    '    'Server.Transfer("Demographics.aspx")
    '    Response.Redirect("Demographics.aspx")
    'End Sub

End Class