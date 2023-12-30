<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Complete.aspx.vb" Inherits="SelfSchedulingLab.Complete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>

    <title>Demographics</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
        .form-group{
            margin-bottom:2px;
        }
        .demog-label{
            text-align:right;
            vertical-align:middle;
        }
        .demog-text {
            text-align: left;
            vertical-align: middle;

        }
        legend{
            color:green;
            text-align:center;
        }
        .appt{
            color:red;
        }
        .responsive-img {
              width: 100%;
              height: auto;
              max-width:400px;
        }
    </style>
         <script type = "text/javascript" >  
         function preventBack() { window.history.forward(); }
         setTimeout("preventBack()", 0);
             window.onunload = function () { null };
         </script>    

</head>
<body>
    <form id="form1" runat="server" class="well form-horizontal">
<div class="container">
    <div style="width:100%;text-align:center;">
        <div style="margin:0;padding-top:20px;padding-bottom:20px;width:100%;background-color:RGB(15,33,106);">
<%--            <img src="assets/img/logo_SaratogaHosp.png" class="responsive-img"/>--%>
            <img src="assets/img/WMA_logo1.jpg"  class="responsive-img"/>
        </div>
    </div>
<fieldset>

<!-- Form Name -->
<legend>
    <asp:Label ID="lblHeading" runat="server" Text="" ForeColor="Green"></asp:Label>
</legend>
    <p style="margin:auto;text-align:center">
        <asp:Label ID="lblMsg1" runat="server" Text="" Font-Bold="True" Font-Size="Large"></asp:Label>
        <br />
         <asp:Label ID="lblMsg2" runat="server" Text="" Font-Bold="True" Font-Size="Large"></asp:Label>
        <br />
    </p>
<!-- Text input-->

 
<!-- Button -->
    <p>&nbsp;</p>
    <p>&nbsp;</p>
<div class="form-group">
  <label class="col-md-4 control-label"></label>
  <div class="col-md-4" style="margin:auto;text-align:center;">
<%--    <button type="submit" class="btn btn-warning" >Next >> </button>--%>
      <asp:Button ID="cmdDone" runat="server" class="btn btn-success" Text="Done" />
  </div>
</div>

</fieldset>
</div>
    </form>
</body>
</html>
