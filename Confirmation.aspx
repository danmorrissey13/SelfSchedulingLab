<%@ Page Language="vb" AutoEventWireup="false"  enableEventValidation="false"  EnableViewstateMac="false" CodeBehind="Confirmation.aspx.vb" Inherits="SelfSchedulingLab.Confirmation" %>

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
        .foo{
            color: #222b64;
            position:absolute;
                top:20%;
                left:20%;
            width:50%;
             text-align:center;
             margin:20px;
             z-index:1;
        }
        .closeBtn{
            margin-top:4px;
            margin-left:4px;
            float:left;
            padding:5px;
            background-color:red;
            cursor:pointer;
            width:30px;
            height:30px;
            text-align:center;
            border-radius:5px;

        }
        #btnCloseModal{
            margin-bottom:5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="well form-horizontal">
        <div class="foo" id="modal">
            <div class="modal-content">
               <%-- <span class="closeBtn" id="closeBtn">&times;</span>--%>
            <h2><b>Your session is about to timeout.</b></h2>
                <h3> The timeslot you selected will be reclaimed if you do not click the "Confirm" button in ten seconds.</h3>
                <button id="btnCloseModal" type="button" runat="server" onclick=" closeModal();" class="btn btn-warning">OK</button>
            </div>
         </div>
<div class="container">
    <div style="width:100%;text-align:center;">
        <div style="margin:0;padding-top:20px;padding-bottom:20px;width:100%;background-color:RGB(15,33,106);">
<%--            <img src="assets/img/logo_SaratogaHosp.png" class="responsive-img"/>--%>
            <img src="assets/img/WMA_logo1.jpg"  class="responsive-img"/>
        </div>
    </div>
<fieldset>

<legend>Confirm Appointment Info</legend>


<div class="form-group">
  <label class="col-md-5 demog-label">Name:</label>  
    <asp:Label ID="lblName" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div>

<div class="form-group">
  <label class="col-md-5 demog-label">DOB:</label>  
    <asp:Label ID="lblDOB" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div>

 <div class="form-group">
  <label class="col-md-5 demog-label">Email:</label>  
    <asp:Label ID="lblEmail" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  

</div>
 <div class="form-group">
  <label class="col-md-5 demog-label">Phone:</label>  
   <asp:Label ID="lblPhone" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div>

 <div class="form-group">
  <label class="col-md-5 demog-label">Gender:</label>  
   <asp:Label ID="lblGender" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div>

 <div class="form-group">
  <label class="col-md-5 demog-label">Address:</label>  
   <asp:Label ID="lblAddr" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  

</div>
 <div class="form-group">
  <label class="col-md-5 demog-label"></label>  
   <asp:Label ID="lblAddr2" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  

</div>      

 <div class="form-group">
  <label class="col-md-5 demog-label">Ordering Physician</label>  
   <asp:Label ID="lblDr" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div>   

 <div class="form-group">
  <label class="col-md-5 demog-label">Emergency Contact</label>  
   <asp:Label ID="lblEC" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 
 <div class="form-group">
  <label class="col-md-5 demog-label">Emergency Contact Phone</label>  
   <asp:Label ID="lblEcPhone" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 
 <div class="form-group">
  <label class="col-md-5 demog-label">Next of Kin</label>  
   <asp:Label ID="lblNok" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 
 <div class="form-group">
  <label class="col-md-5 demog-label">Next of Kin Phone</label>  
   <asp:Label ID="lblNokPhone" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 
 <div class="form-group">
  <label class="col-md-5 demog-label">Have you been diagnosed with Covid-19 in the past 10 days or are you under quarantine for Covid-19?</label>  
   <asp:Label ID="lblDx" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 
 <div class="form-group">
  <label class="col-md-5 demog-label">Are you experiencing Cough, Fever, Shortness of Breath, Diarrhea, Loss of Taste or Smell?</label>  
   <asp:Label ID="lblSx" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 

 <div class="form-group">
  <label class="col-md-5 demog-label">Do you consent to treatment?</label>  
   <asp:Label ID="lblConsent" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 

 <div class="form-group">
  <label class="col-md-5 demog-label">Do you agree with the Financial Agreement?</label>  
   <asp:Label ID="lblFin" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  
</div> 

 <div class="form-group">
  <label class="col-md-5 demog-label">Selected Date:</label>  
   <asp:Label ID="lblDate" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  

</div>  
     <div class="form-group">
  <label class="col-md-5 demog-label">Selected Time:</label>  
   <asp:Label ID="lblTime" class="col-md-4 demog-text" runat="server" Text=""></asp:Label>  

</div>  
<div class="form-group">
  <label class="col-md-4 control-label"></label>

  <div class="col-md-2">
<%--      <asp:Button ID="cmdCancel" runat="server" onclick="cancelTimeSlot()" class="btn btn-warning" style="width:160px;" Text="Cancel" />--%>
      <input id="Button1" type="button" onclick="cancelTimeSlot();" class="btn btn-warning" style="width:160px;"  value="Cancel" />
  </div>
      <div class="col-md-2">
<%--      <asp:Button ID="cmdNext" runat="server" class="btn btn-success" style="width:160px;" Text="Confirm Appointment" />--%>
      <button id="btnSubmit" type="button" runat="server" onclick="checkFormBeforeSubmit();" class="btn btn-success">Confirm Appointment</button>
<%--           <button id="Button2" type="button" runat="server" onclick=" openModal();" class="btn btn-success">Open Modal</button>--%>
  </div>
</div>

</fieldset>
</div>
<input id="hidSelDate" runat="server" type="hidden" />
<input id="hidSelTime" runat="server" type="hidden" />
<input id="hidPtID" runat="server" type="hidden" />

    </form>
    <script>
        window.onload = function () {
            // Start calendar
            closeModal();
        }
        $(document).ready(function () {
            setTimeout(warnTimeout, 50000)
            setTimeout(sendToStartPage, 60000)
            //setTimeout(warnTimeout, 3000)
            //setTimeout(sendToStartPage, 7000)
        });

        function warnTimeout() {
            openModal();
        }
        $('#closeBtn').on('click', function () {
            closeModal();
        });

        function sendToStartPage() {
          //  alert('timeout');
            cancelTimeSlot();
  /*          window.location = "Demographics.aspx";*/
        }

        function openModal() {
            $("#modal").css("display", "block");
        }
        function closeModal() {
            $("#modal").css("display", "none");
        }


        function cancelTimeSlot() {
            var ptID = $("#hidPtID").val();
            // alert('ptID='+ ptID);
            var dt = $("#hidSelDate").val();
            // alert('selDate=' + dt);
            var selTime = $("#hidSelTime").val();
            // alert('selTime=' + selTime);
            $.ajax({
                type: "POST",
                url: "Confirmation.aspx/CancelTimeSlot",
                complete: function () {
                },
                data: '{strSelDate:"' + dt + '", strSelTime:"' + selTime + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessCancelTimeSlot,
                failure: function (response) {
                    console.log('CancelTimeSlot failed: ' + response.d);
                }
            });
        }
        function OnSuccessCancelTimeSlot(response) {
            console.log('CancelTimeSlot Successful');
            window.location = "Demographics.aspx";
            
        }
        function checkFormBeforeSubmit() {
          //  $("#hidSubmitFlag").val("submit");
            $("#btnSubmit").html("Please wait...");
            $("#btnSubmit").prop('disabled', true);
            $("#btnSubmit").css("background-color", "green");
            $("#form1").submit();
        }
    </script>
</body>
</html>