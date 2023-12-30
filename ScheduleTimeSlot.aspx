<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ScheduleTimeSlot.aspx.vb" Inherits="SelfSchedulingLab.ScheduleTimeSlot" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Time-Block Scheduling</title>
        <script src="Scripts/jquery-3.4.1.min.js"></script>

    <style>
        html,
        body {
            height: 100%;
        }

        body {
            font-size: 100%;
            line-height: 1.5;
            font-family: "Roboto Condensed", sans-serif;
            background: #28283b;
            background-image: linear-gradient(#28283b 0%,#0f0f17 100%);
            color: #444;
        }

        table {
            clear: both;
            width: 100%;
            border: 1px solid #dcdcff;
            border-radius: 3px;
            border-collapse: collapse;
            color: #444;
        }

        td {
            height: 48px;
            text-align: center;
            vertical-align: middle;
            border-right: 1px solid #dcdcff;
            border-top: 1px solid #dcdcff;
            width: 14.285714285714%;
        }

            td.not-current {
                color: #c0c0c0;
            }

            td.today {
                font-weight: 700;
                /*color: #28283b;*/
                color: red;
                font-size: 1.5em;
                cursor: pointer;
            }

                td.today:hover {
                    background: #cacaca;
                    color: red;
                }

            td.normal {
                cursor: pointer;
                color: darkgreen;
            }

         tbody td.normal:hover {
            background: #cacaca;
            color: #fff;
        }


        thead td {
            border: none;
            color: #28283b;
            text-transform: uppercase;
            font-size: 1.5em;
        }

        #btnPrev {
            float: left;
            margin-bottom: 20px;
        }

            #btnPrev:before {
                /*content: '\f104';*/
                content: '<<';
                font-family: FontAwesome;
                padding-right: 4px;
            }

        #btnNext {
            float: right;
            margin-bottom: 20px;
        }

            #btnNext:after {
                content: '>>';
                font-family: FontAwesome;
                padding-left: 4px;
            }

        #btnPrev,
        #btnNext {
            background: transparent;
            border: none;
            outline: none;
            font-size: 1em;
            color: #c0c0c0;
            cursor: pointer;
            font-family: "Roboto Condensed", sans-serif;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }

            #btnPrev:hover,
            #btnNext:hover {
                color: navy;
                /*                color: #28283b;*/ 
                font-weight: bold;
            }

        option:hover {
            background-color:lightgray;
        }

        .appt-times {
            float: right;
            height: 425px;
            position: relative;
            /*            top:50px;
            left:70%;*/
            width: 50%;
            font-size: 2em;
        }

        #times {
            font-size: 1.3em;
            padding-left: 15px;
            padding-top: 15px;
            height: 425px;
            /*            width: 50px;*/
        }

        #lblTimes {
            margin-top: 20px;
            color: white;
            width: 300px;
        }

        .flex-container {
            display: flex;
            width: 1500px;
            margin-left: 200px;
        }

        .flex-child {
            flex: 1;
            /*            border: 2px solid gray;*/
        }

            .flex-child:first-child {
                margin-right: 20px;
            }

        .cal {
            background-color: white;
            padding-top: 10px;
            /*margin-left:100px;*/
        }
        /*.times{*/
        /*                margin-right:300px;*/
        /*width:20px;
            }*/
        #lblTimes {
            margin-left: 10px;
            color: white;
        }

        #divNavBtns button {
            color: navy;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <div class="flex-container">

        <div id="divNavBtns" class="flex-child cal">
            <button id="btnPrev" type="button">Prev</button>
            <button id="btnNext" type="button">Next</button>

            <div id="divCal"></div>

        </div>

        <div class="flex-child times" style="text-align:left;">
            <label id="lblTimes" for="times" style="text-align:center;">Available Times</label><br />
            <select id="times" name="time" size="10" style="width:150px;">
                <option value="1000">10:00 AM</option>
                <option value="1030">10:30 AM</option>
                <option value="1100">11:00 AM</option>
                <option value="1130">11:30 AM</option>
                <option value="1200">12:00 PM</option>
                <option value="1230">12:30 PM</option>
                <option value="1300">1:00 PM</option>
                <option value="1330">1:30 PM</option>
                <option value="1400">2:00 PM</option>
                <option value="1430">2:30 PM</option>
                <option value="1500">3:00 PM</option>
                <option value="1530">3:30 PM</option>
                <option value="1600">4:00 PM</option>
            </select>
        </div>
        <input id="hidCurDay" runat="server" type="hidden" />
        <input id="hidCurMonth" runat="server" type="hidden" />
        <input id="hidCurYear" runat="server" type="hidden" />
            <input id="hidFacilID" runat="server" type="hidden" />
    </div>

    </form>
</body>
    <script>
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
        $("#hidCurYear").val(y);
        //alert($("#hidCurMonth").val() + ', ' + $("#hidCurYear").val());

        var d = new Date()
            // First day of the week in the selected month
            , firstDayOfMonth = new Date(y, m, 1).getDay()
            // Last day of the selected month
            , lastDateOfMonth = new Date(y, m + 1, 0).getDate()
            // Last day of the previous month
            , lastDayOfLastMonth = m == 0 ? new Date(y - 1, 11, 0).getDate() : new Date(y, m, 0).getDate();


        var html = '<table>';

        // Write selected month and year
        html += '<thead><tr>';
        html += '<td colspan="7">' + this.Months[m] + ' ' + y + '</td>';
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

            // Write the current day in the loop
            var chk = new Date();
            var chkY = chk.getFullYear();
            var chkM = chk.getMonth();
            if (chkY == this.currYear && chkM == this.currMonth && i == this.currDay) {
                html += '<td class="today">' + i + '</td>';
            } else {
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
                    html += '<td class="not-current">' + k + '</td>';
                    k++;
                }
            }

            i++;
        } while (i <= lastDateOfMonth);

        // Closes table
        html += '</table>';

        // Write HTML to the div
        document.getElementById(this.divId).innerHTML = html;

        $("td.normal").click(function () {
            $("#hidCurDay").val($(this).text())
            //alert($("#hidCurDay").val());
/*            alert($(this).text());*/

        });
        $("td.today").click(function () {
            //alert($(this).text());

        });

    };

    // On Load of the window
    window.onload = function () {

        // Start calendar
        var c = new Cal("divCal");
        c.showcurr();

        // Bind next and previous button clicks
        getId('btnNext').onclick = function () {
            c.nextMonth();
        };
        getId('btnPrev').onclick = function () {
            c.previousMonth();
        };

    }

    // Get element by id
    function getId(id) {
        return document.getElementById(id);
    }


    </script>
</html>