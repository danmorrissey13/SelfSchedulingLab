<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LandingPage.aspx.vb" Inherits="SelfSchedulingLab.LandingPage" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>PatientPathPnline</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        h1{
            margin-bottom:30px;
        }
    img {
        display:block;
        margin-left:auto;
        margin-right:auto;
    }
        .responsive-img {
        margin-top:80px;
        width: 100%;
        height: auto;
        max-width: 900px;
   }
    h1 {
        text-align:center;
    }
    a {
        text-align: center;
        color: white;
        text-decoration: none;
    }
    .lead {
        text-align: center!important;
    }
    .contact {
        text-align: center;
    }
    .pps-button {
	    outline: 0; 
       background: rgb(34, 43, 100);
       border-width:1px;
	    color: #fff; 
        padding-top: 15px;
        padding-bottom: 15px;
        padding-left: 18px;
        padding-right: 18px;
        margin:5px;
/*        margin: auto;*/

        border-radius: 25px;
        text-align: center;
        border-color: rgb(109, 57, 108);
/*        border-color: rgb(0,120,209);

        border-width: 1px;
*/        border-style: solid;
        transition: background-color .5s, color .5s, border-color .5s, border-style .5s;
    }
        .pps-button:hover {
/*            font-size: 17px;*/
            color: rgb(0,120,209)!important;
            /*background: rgb(109, 57, 108);*/
            background: rgb(34, 43, 100);
            border-width:1px;
            border-style:solid;
        }
        .button-div {
            margin: auto;
            text-align: center;
        }
</style>
        <script>
            function sendToHome() {
                //alert('yo');
                window.location.href = "https://patientpathonline.com/PtPthDev/RCUC.aspx";
            }
        </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <img id="imgLogo" class="responsive-img" src="assets/img/B4E9205F-F211-4A99-A484-A77AA18DC295.png" />
            <br /><br />
              <div class="row">
                <div class="col-md-4">
                    <h1>Self Scheduling  - LAB</h1>
                <div class="button-div">
                    <asp:Button ID="cmdSSL_WMA" class="pps-button" runat="server" Text="Wilton Medical Arts" />
                </div>
                </div>
                <div class="col-md-4">
                    <h1>Self Scheduling  - Urgent Care</h1>
                    <div class="button-div">
                         <asp:Button ID="cmdSSUC_AMC" class="pps-button" runat="server" Text="Adirondack Medical Center" />
                        <asp:Button ID="cmdSSUC_MMEC" class="pps-button" runat="server" Text="Malta Med Emergent Care" />
                         <asp:Button ID="cmdSSUC_WMA" class="pps-button" runat="server" Text="Wilton Medical Arts" />
                         
                    </div>
                </div>
                <div class="col-md-4">
                    <h1>Self Check-In - Urgent Care</h1>
                <div class="button-div">
                    <asp:Button ID="cmdSCI_WMA" class="pps-button" runat="server" Text="Wilton Medical Arts" />
                </div>
                </div>
            </div>
        </div>
    </form>

</body>
</html>

