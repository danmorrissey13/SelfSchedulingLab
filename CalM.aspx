<%@ Page Language="vb" AutoEventWireup="false" enableEventValidation="false" CodeBehind="CalM.aspx.vb" Inherits="SelfSchedulingLab.CalM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Date Time</title>
     <script src="Scripts/jquery-3.4.1.min.js"></script>
    <link href="Content/calM.css" rel="stylesheet" />
    <style>
        .btn-navy {
  background: #222b64;
  color: white;
}
.btn-navy:hover {
  background: #181e46;
  transition: all 0.3s ease;
  color: white;
}
.btn-navy:active {
  background: #020205;
  color: white;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
                <div style="margin:0;padding-top:20px;padding-bottom:20px;width:100%;text-align:center;">

<%--        <div style="margin:0;padding-top:20px;padding-bottom:20px;width:100%;background-color:RGB(15,33,106);">--%>
<%--            <img src="assets/img/logo_SaratogaHosp.png" style="width:400px;margin-bottom:20px;"/>--%>
            <img src="assets/img/B4E9205F-F211-4A99-A484-A77AA18DC295.png" class="responsive-img" style="margin-bottom:20px;"/>
        </div>
<%--    </div>  --%>
<div class="foo" id="modal">
            <div class="modal-content">
                <span class="closeBtn" id="closeBtn">&times;</span>
            <h2>Time Slot No Longer Available</h2>
                <h3>Time slots are being scheduled by patients continuously.</h3>
                <p> Please select another time slot.</p>
            </div>
</div>

<div>
<div style="
      margin-top: 30px;
      display: grid;
      grid-template-columns: 1fr 750px 1fr;
      column-gap: 5px;
      row-gap: 2px;
    ">
      <div class="divBlue" style="height: 40px;"></div>
      <div class="divPink" style="padding-bottom:10px;height: 40px;display: flex;justify-content:center;align-items: center;text-align:center;">          
          <asp:Label class="label" ID="Label1" runat="server" Text="Select Date"></asp:Label>
      </div>
    <div class="divBlue" style="height: 40px;"></div>


    <div class="divPink" style="height: 700px;"></div>
    <div class="divBlue" style="height: 700px;">
        <div id="cal-container" style="width:100%;">
            <div id="divNavBtns" class="flex-child cal">
                <button id="btnPrev" type="button">Prev</button>
                <button id="btnNext" type="button">Next</button>
           
                <div id="divCal" style="min-width:300px;"></div>
            </div>
        </div>

      </div>
    <div class="divPink" style="height: 500px;"></div>

    <div class="divBlue" style="height: 50px;"></div>
      <div class="divPink" style="height: 50px;display: flex;justify-content:center; align-items: center;text-align:center;">         
          <asp:Label class="label" ID="Label2" runat="server" Text="Select Time"></asp:Label>
      </div>
      <div class="divBlue" style="height: 55px;"></div>

      <div class="divPink" style="height: 55px;"></div>  
      <div class="divBlue" style="height: 55px;">
        <div style="display:flex;justify-content:center;vertical-align:middle;">
            <asp:DropDownList ID="times" class="times-m" runat="server" style="height:50px;">

            </asp:DropDownList>
        </div>

      </div>
      <div class="divPink" style="height: 50px;"></div>  

      <div class="divBlue" style="height: 40px;"></div>
      <div class="divPink" style="height: 40px;"></div>
      <div class="divBlue" style="height: 40px;"></div>


      <div class="divBlue" style="height: 110px;"></div>

      <div style="
      display: grid;
      grid-template-columns: 1fr 1fr;
      column-gap: 2px;
      row-gap: 2px;
    ">
          <div class="divPink" style="height: 55px;display: flex;justify-content:right;">             
              <asp:Label class="label" ID="Label4" runat="server" Text="Selected Date:"></asp:Label>
          </div>

          <div class="divBlue" style="height: 55px;"><asp:Label ID="lblSelDate" class="selLabel" runat="server" Text=""></asp:Label></div>

          <div class="divPink" style="height: 55px;display: flex;justify-content:right;">              
              <asp:Label class="label" ID="Label3" runat="server" Text="Selected Time:"></asp:Label>
          </div>

          <div class="divBlue" style="height: 55px;"><asp:Label ID="lblSelTime" class="selLabel" runat="server" ></asp:Label></div>

        </div>
      <div class="divBlue" style="height: 110px;"></div>


      <div class="divPink" style="height: 60px;"></div>  
      <div class="divBlue" style="height: 60px;"></div>
      <div class="divPink" style="height: 60px;"></div>

      <div class="divPink" style="height: 60px;"></div>  
      <div class="divBlue" style="height: 60px;display: flex;justify-content:center;">
          <asp:Button ID="cmdCancel" runat="server" class="btn btn-warning" Text="Cancel"  OnClientClick="return ConfirmOnCancel();"/>
          &nbsp;&nbsp;&nbsp;
          <asp:Button ID="cmdNext" runat="server" class="btn btn-navy" Text="Next >>" />
      </div>
      <div class="divPink" style="height: 60px;"></div>



    </div>
   </div>

        <input id="hidCurDay" runat="server" type="hidden" />
        <input id="hidCurMonth" runat="server" type="hidden" />
         <input id="hidPrevMonth" runat="server" type="hidden" />
        <input id="hidCurYear" runat="server" type="hidden" />
        <input id="hidTimes" runat="server" type="hidden" />
         <input id="hidSelDate" runat="server" type="hidden" />
         <input id="hidSelTime" runat="server" type="hidden" />
         <input id="hidPrevTime" runat="server" type="hidden" />
         <input id="hidPrevDate" runat="server" type="hidden" />
         <input id="hidPtID" runat="server" type="hidden" />
</form>
    <script>

        function ConfirmOnCancel() {
            if (confirm("Do you really want to cancel?") == true)
                return true;
            else
                return false;
        }

        function openModal() {
            $("#modal").css("display", "block");
        }
        function closeModal() {
            $("#modal").css("display", "none");
        }
        function testButton() {
            $("#cmdNext").attr('disabled', 'disabled');
        }

        $('#closeBtn').on('click', function () {
            closeModal();
        });


        var Cal = function (divId) {

            //Store div id
            this.divId = divId;

            // Days of week, starting on Sunday
            this.DaysOfWeek = [
                'Sun',
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat'
            ];

            // Months, stating on January
            this.Months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

            // Set the current month, year
            var d = new Date();

            this.currMonth = d.getMonth();
            //console.log("d.getMonth() is " + this.currMonth)
            this.currYear = d.getFullYear();
            this.currDay = d.getDate();

        };


        // Goes to next month
        Cal.prototype.nextMonth = function () {
            if (this.currMonth == 11) {
                this.currMonth = 0;
                this.currYear = this.currYear + 1;
            }
            else {
                this.currMonth = this.currMonth + 1;
            }
            this.showcurr();
        };

        // Goes to previous month
        Cal.prototype.previousMonth = function () {
            if (this.currMonth == 0) {
                this.currMonth = 11;
                this.currYear = this.currYear - 1;
            }
            else {
                this.currMonth = this.currMonth - 1;
            }
            this.showcurr();
        };

        // Show current month
        Cal.prototype.showcurr = function () {
            this.showMonth(this.currYear, this.currMonth);
        };

        // Show month (year, month)
        Cal.prototype.showMonth = function (y, m) {
            $("#hidCurMonth").val(m);
            //console.log("current month is "+ m)
            $("#hidCurYear").val(y);

            //alert($("#hidCurMonth").val() + ', ' + $("#hidCurYear").val());
            var nd = new Date();
            var nm = nd.getMonth();
          //alert(nm);
          //  alert(m);
            $('#btnPrev').prop('disabled', (nm == m));
            /* $('#btnNext').prop('disabled', (m >= nm + 2));*/
            $('#btnNext').prop('disabled', (m >= nm + 1));
            var d = new Date()
                //if (d.getMonth == m) { $('.btnPrev').prop('disabled', true) };
                // First day of the week in the selected month
                , firstDayOfMonth = new Date(y, m, 1).getDay()
                // Last day of the selected month
                , lastDateOfMonth = new Date(y, m + 1, 0).getDate()
                // Last day of the previous month
                , lastDayOfLastMonth = m == 0 ? new Date(y - 1, 11, 0).getDate() : new Date(y, m, 0).getDate();


            var html = '<table>';

            // Write selected month and year
            html += '<thead><tr>';
            html += '<td colspan="7" class="calHeader">' + this.Months[m] + ' ' + y + '</td>';
            html += '</tr></thead>';


            // Write the header of the days of the week
            html += '<tr class="days">';
            for (var i = 0; i < this.DaysOfWeek.length; i++) {
                html += '<td>' + this.DaysOfWeek[i] + '</td>';
            }
            html += '</tr>';

            // Write the days
            var i = 1;
            do {

                var dow = new Date(y, m, i).getDay();

                // If Sunday, start new row
                if (dow == 0) {
                    html += '<tr>';
                }
                // If not Sunday but first day of the month
                // it will write the last days from the previous month
                else if (i == 1) {
                    html += '<tr>';
                    var k = lastDayOfLastMonth - firstDayOfMonth + 1;
                    for (var j = 0; j < firstDayOfMonth; j++) {
                        html += '<td class="not-current">' + k + '</td>';
                        k++;
                    }
                }
                //XXXXXX=========================================================================XXXXXX   EDIT
                // Write the current day in the loop
                var chk = new Date();
                var chkY = chk.getFullYear();
                
                var chkM = chk.getMonth();
                var daysTillXM = daysTillXmas();
                var daysTillNY = daysTillNewYears();
                var daysInMonth = daysLeftThisMonth();
                var nextMonth = chkM + 1;
                var dy = this.currDay;
                if (chkY == this.currYear && chkM == this.currMonth && i == this.currDay) {
                   // if (dow == 0) { html += '<td class="not-current">' + i + '</td>'; } else { html += '<td class="today">' + i + '</td>'; }   
                    if (daysTillXM == 0) { html += '<td class="not-current">' + i + '</td>'; } // else { html += '<td class="today">' + i + '</td>'; }  
                    else if (daysTillNY == 0) { html += '<td class="not-current">' + i + '</td>'; }
                    //else if (daysInMonth + i > 29) { html += '<td class="not-current">' + i + '</td>'; }
                    else { html += '<td class="today">' + i + '</td>'; }  
                }
                else if (chkY == this.currYear && chkM == this.currMonth && i < this.currDay) {
                    html += '<td class="not-current">' + i + '</td>';
                }

                /* else if (chkY == this.currYear && chkM == nextMonth && ((daysInMonth + i) > 5)) {*/
                else if ((nextMonth == this.currMonth) && ((daysInMonth + i) > 29)) {
                    html += '<td class="not-current">' + i + '</td>';
                }


                else {
                    html += '<td class="normal">' + i + '</td>'; 
                }
                // If Saturday, closes the row
                if (dow == 6) {
                    html += '</tr>';
                }
                // If not Saturday, but last day of the selected month
                // it will write the next few days from the next month
                else if (i == lastDateOfMonth) {
                    var k = 1;
                    for (dow; dow < 6; dow++) {
                        /*html += '<td class="not-current">' + k + '</td>';*/
                        if (nextMonth == this.currMonth) {
                            html += '<td class="not-current">' + k + '</td>';
                        }
                        else {
                            html += '<td class="normal">' + k + '</td>';
                        }
                        
                        k++;
                    }
                }
                //XXXXXX=========================================================================XXXXXX
                i++;
            } while (i <= lastDateOfMonth);

            // Closes table
            html += '</table>';

            // Write HTML to the div
            document.getElementById(this.divId).innerHTML = html;

            $("td.normal").click(function () {

                $("#hidPrevTime").val($("#hidSelTime").val());
                $("#hidPrevDate").val($("#lblSelDate").text());
               /* $("#hidPrevMonth").val($("#hidCurMonth").val());*/
                var dyClicked = parseInt($(this).text());         
                var mnth = parseInt($("#hidCurMonth").val());
                var pmnth = parseInt($("#hidPrevMonth").val());
                
                if (dyClicked < dy) {
                    
                    mnth = chkM + 1;
                    $("#hidPrevMonth").val($("#hidCurMonth").val());
                    $("#hidCurMonth").val(mnth);
                }
                else {
                   if (mnth == nextMonth) {
                        mnth = chkM;
                        /*nextMonth = mnth + 1;*/
                    }
                   $("#hidCurMonth").val(mnth);
                }

                $("#hidCurDay").val($(this).text());
                //UpdateSelectedTime();
                $('.selDay').removeClass('selDay');
                $('td.today').removeClass('selDay');
                $(this).addClass('selDay');
                loadTimes();
                //alert($("#hidCurDay").val());
                /*            alert($(this).text());*/
            });
            $("td.today").click(function () {
                $("#hidPrevTime").val($("#hidSelTime").val());
                // $("#hidSelTime").val("0");

                $("#hidPrevDate").val($("#lblSelDate").text());
                $("#hidCurDay").val($(this).text());
                // UpdateSelectedTime();
                $('.selDay').removeClass('selDay')
                $(this).addClass('selDay');
                loadTimes();
                //alert($(this).text());
            });
        };
        // On Load of the window
        window.onload = function () {
            // Start calendar
            closeModal();
            var c = new Cal("divCal");
            c.showcurr();
            // Bind next and previous button clicks
            getId('btnNext').onclick = function () {
                c.nextMonth();
            };
            getId('btnPrev').onclick = function () {
                c.previousMonth();
            };
            $('#times').html($("#hidTimes").val());
            $("#hidTimes").val("");
            $("td.today").click();
        }

        $('input[name="apptDay"]').change(function () {
            loadTimes();
        });
        $('.today').addClass('selDay');

        window.addEventListener('click', outsideClick);

        function daysLeftThisMonth() {
            var date = new Date();
            var time = new Date(date.getTime());
            time.setMonth(date.getMonth() + 1);
            time.setDate(0);
            var days = time.getDate() > date.getDate() ? time.getDate() - date.getDate() : 0;
            return days;
            //alert(days + ' Days Remaining.');
            //$('#remainingday').html(days);
        }
        function daysTillXmas(y,m,d) {
           
            let today = new Date(y,m,d);
            let christmasYear = today.getFullYear();

            if (today.getMonth() == 11 && today.getDate() > 25) {
                christmasYear = christmasYear + 1;
            }

            let christmasDate = new Date(christmasYear, 11, 25);
            let dayMilliseconds = 1000 * 60 * 60 * 24;

            let remainingDays = Math.ceil(
                (christmasDate.getTime() - today.getTime()) /
                (dayMilliseconds)
            );
            return remainingDays;
        }

        function daysTillNewYears(y,m,d) {
            let today = new Date(y, m, d);
            let newYear = today.getFullYear();

            if (today.getMonth() == 1 && today.getDate() > 1) {
                newYear = newYear + 1;
            }

            let nyDate = new Date(newYear, 0, 0);
            let dayMilliseconds = 1000 * 60 * 60 * 24;

            let remainingDays = Math.ceil(
                (nyDate.getTime() - today.getTime()) /
                (dayMilliseconds)
            );
            return remainingDays;
        }


        function outsideClick(e) {
            if (e.target == modal) {
                modal.style.display = 'none';
            }
        }
        // Get element by id
        function getId(id) {
            return document.getElementById(id);
        }
        function loadTimes() {
            //var intMonth = 0;
            //intMonth = $("#hidCurMonth").val()
            //    intMonth = intMonth +1;
            //alert(intMonth);
            var day = $("#hidCurDay").val();
            var mnth = parseInt($("#hidCurMonth").val());
            mnth = mnth + 1
            /*            alert(mnth);*/
            var yr = $("#hidCurYear").val();
            var dt = mnth + '/' + day + '/' + yr;
            var ptID = $("#hidPtID").val();

            //   $("#hidPrevDate").val($("#lblSelDate").text());
            $("#lblSelDate").text(dt);
            $("#hidSelDate").val(dt);

            //alert(dt);

            $.ajax({
                type: "POST",
                url: "CalM.aspx/GetString_AvailHoursByDate",
                beforeSend: function () {
                    // $(".modal").show();
                },
                complete: function () {
                    // $(".modal").hide();
                },
                data: '{intPtID:"' + ptID + '", strDate:"' + dt + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessLoadTimes,
                failure: function (response) {
                    //alert("failure");
                    //alert(response.d);
                    console.log('failed: ' + response.d);
                }
            });
        }
        function OnSuccessLoadTimes(response) {
            //console.log('success:'+ response.d);
            const myArray = response.d.split("|");
            let times = myArray[0];
            $("#cmdNext").attr('disabled', (times.length == 0));
            let shortdate = myArray[1];
            $("#times").html(times);
            //  $("#hidPrevTime").val($("#hidSelTime").val());
            $("#lblSelDate").text(shortdate);
            $("#hidSelDate").val(shortdate);
            $("#lblSelDate").text(shortdate);

            var selectedTime = $("#times").find(":selected").text();
            $("#lblSelTime").text(selectedTime);
            $("#hidSelTime").val(selectedTime);
            UpdateSelectedTime();
        }

        function UpdateSelectedTime() {
            var ptID = $("#hidPtID").val();
            // alert('ptID='+ ptID);
            var dt = $("#hidSelDate").val();
            // alert('selDate=' + dt);
            var prevDate = $("#hidPrevDate").val();
            // alert('prevDate=' + prevDate);
            var prevTime = $("#hidPrevTime").val();
            //alert('prevTime=' + prevTime);
            var selTime = $("#hidSelTime").val();
            // alert('selTime=' + selTime);
            $.ajax({
                type: "POST",
                url: "Cal.aspx/UpdateSelectedTime",
                beforeSend: function () {
                    // $(".modal").show();
                },
                complete: function () {
                    // $(".modal").hide();
                },
                // data: '{intTrackID:"' + intTrackID + '", intAlbumID:"' + intAlbumID + '" }',
                data: '{intPtID:"' + ptID + '", strPrevDate:"' + prevDate + '", strDate:"' + dt + '", strPrevTime:"' + prevTime + '", strSelTime:"' + selTime + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessUpdateSelectedTime,
                failure: function (response) {
                    console.log('TimeUpdate failed: ' + response.d);
                }
            });
        }
        function OnSuccessUpdateSelectedTime(response) {
            $("#hidPrevDate").val($("#lblSelDate").text());
            console.log('TimeUpdate Successful');
        }
        $(document).ready(function () {
            $("#times").change(function () {
                getelementfromdropdown();
            });
        });
        function getelementfromdropdown() {
            // alert($("#lblSelTime").text());
            $("#hidPrevTime").val($("#lblSelTime").text());
            var value = $("#times option:selected").text();
            // alert('value=' + value);
            $("#lblSelTime").text(value);

            // alert('prevTime=' + $("#hidPrevTime").val());
            $("#hidSelTime").val(value);
            //   alert('hidSelTime=' + $("#hidSelTime").val());
            checkOpenTimeSlot();

        }

        function checkTimeSlot() {
            var ptID = $("#hidPtID").val();
            // alert('ptID='+ ptID);
            var dt = $("#hidSelDate").val();
            // alert('selDate=' + dt);
            var selTime = $("#hidSelTime").val();
            // alert('selTime=' + selTime);
            $.ajax({
                type: "POST",
                url: "Cal.aspx/CheckTimeSlot",
                beforeSend: function () {
                    // $(".modal").show();
                },
                complete: function () {
                    // $(".modal").hide();
                },

                data: '{intPtID:"' + ptID + '", strDate:"' + dt + '", strSelTime:"' + selTime + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessCheckTimeSlot,
                failure: function (response) {
                    console.log('checkTimeSlot failed: ' + response.d);
                }
            });
        }
        function OnSuccessCheckTimeSlot(response) {

            console.log('checkTimeSlot = ' + response.d);
            // alert(response.d);
            var retVal = response.d;
            if (retVal == 'True') {
                UpdateSelectedTime();
            }
            else {
                openModal();
                loadTimes();

            }


        }

        function checkOpenTimeSlot() {
            // var ptID = $("#hidPtID").val();
            // alert('ptID='+ ptID);
            var dt = $("#hidSelDate").val();
            // alert('selDate=' + dt);
            var selTime = $("#hidSelTime").val();
            // alert('selTime=' + selTime);
            $.ajax({
                type: "POST",
                url: "Cal.aspx/CheckOpenTimeSlot",
                beforeSend: function () {
                    // $(".modal").show();
                },
                complete: function () {
                    // $(".modal").hide();
                },

                data: '{strDate:"' + dt + '", strSelTime:"' + selTime + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessCheckOpenTimeSlot,
                failure: function (response) {
                    console.log('checkOpenTimeSlot failed: ' + response.d);
                }
            });
        }
        function OnSuccessCheckOpenTimeSlot(response) {

            console.log('checkOpenTimeSlot = ' + response.d);
            // alert(response.d);
            var retVal = response.d;
            if (retVal == 'True') {
                UpdateSelectedTime();
            }
            else {
                openModal();
                loadTimes();

            }


        }

    </script>


</body>
</html>
