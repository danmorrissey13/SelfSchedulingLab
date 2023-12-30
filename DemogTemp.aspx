<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DemogTemp.aspx.vb" Inherits="SelfSchedulingLab.DemogTemp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>

    <title>Demographics</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <style>
.ast{
    color:red;
}

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

        .lnk-label{
        cursor:pointer;
        color:blue;
        text-decoration:underline;
    }

        #success_message{ display: none;}
        .responsive-img {
              width: 100%;
              height: auto;
              max-width:400px;
        }

    .btnCardPhoto{
        width:140px!important;
        background:rgb(115, 147, 179)!important;
    }
    .btnCardPhotoOK{
        width:140px!important;
        background:#228B22!important;
        color:white;
    }

 .modal{
    display:none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    height: 100%;
    width: 100%;
    overflow: auto;
    background-color:rgba(0,0,0,0.5);

}
.modal-content{
    background-color:#f4f4f4;
    margin:20% auto;
    padding:20px;
    width:70%;
    box-shadow: 0 5px 8px 0 rgba(0,0,0,0.2),0 7px 20px 0 rgba(0,0,0,0.17);
    animation-name:modalopen;
    animation-duration:1s;

}
.closeBtn{
    color:#ccc;
    float:right;
    font-size:30px;

}
.btnCardPhoto:hover, .btnCardPhoto:focus{
    color:white;
}
.closeBtn:hover,.closeBtn:focus{
    color:#000;
    text-decoration:none;
    cursor:pointer;
}
 .btnCardPhotoOK:hover,  .btnCardPhotoOK:focus{
      cursor:pointer;
       color:white;
 }

@keyframes modalopen{
    from{opacity: 0}
    to {opacity: 1}
} {
    background-color: orange;
}

  .input-error { border-color: #ea2803;}

  .dobDdlMonth{
       display:inline-block!important;
        width: 100px!important;
  }
  .dobDdlDay{
       display:inline-block!important;
        width: 90px!important;
  }
  .dobDdlYear{
       display:inline-block!important;
        width:90px!important;
  }
    </style>
</head>
<body>
    <div class="modal" id="modal">
            <div class="modal-content">
                <span class="closeBtn" id="closeBtn">&times;</span>
            <h2>Time Slot No Longer Available</h2>
                <h3>Time slots are being scheduled by patients continuously.</h3>
                <p> Please select another time slot.</p>
            </div>
</div>

    <form id="form1" runat="server" class="well form-horizontal">
<div class="container">
    <div style="width:100%;text-align:center;">
        <div style="margin:0;padding-top:20px;padding-bottom:20px;width:100%;">
            <img id="imgFacilLogo" runat="server" src="assets/img/B4E9205F-F211-4A99-A484-A77AA18DC295.png" class="responsive-img"/>
        </div>
    </div>
<fieldset>

<legend>Outpatient Lab Self Scheduling</legend>
    <asp:Label ID="lblFacilPhone" runat="server" Text=""></asp:Label>
    </fieldset>

<div class="form-group">
  <label class="col-md-4 control-label">First Name <span class="ast">*</span></label>  
  <div class="col-md-4 inputGroupContainer">
  <div class="input-group">
  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
      <asp:TextBox ID="first_name" runat="server" placeholder="First Name" class="form-control required" MaxLength="25"></asp:TextBox>
    </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" >Last Name <span class="ast">*</span></label> 
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
         <asp:TextBox ID="last_name" runat="server" placeholder="Last Name" class="form-control required" MaxLength="25"></asp:TextBox>
    </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">DOB <span class="ast">*</span></label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
            <select id="ddlMonth" name="state" class="form-control selectpicker dobDdlMonth requiredDob" runat="server">
              <option value=" " >Month</option>
				<option>Jan</option>
				<option>Feb</option>
				<option>Mar</option>
				<option>Apr</option>
				<option>May</option>
				<option>Jun</option>
				<option>Jul</option>
				<option>Aug</option>
				<option>Sep</option>
				<option>Oct</option>
				<option>Nov</option>
				<option>Dec</option>
            </select>
            <select id="ddlDay" name="state" class="form-control selectpicker dobDdlDay requiredDob" runat="server">
              <option value=" " >Day</option>
				<option>01</option>
				<option>02</option>
				<option>03</option>
				<option>04</option>
				<option>05</option>
				<option>06</option>
				<option>07</option>
				<option>08</option>
				<option>09</option>
				<option>10</option>
				<option>11</option>
				<option>12</option>
				<option>13</option>
				<option>14</option>
				<option>15</option>
				<option>16</option>
				<option>17</option>
				<option>18</option>
				<option>19</option>
				<option>20</option>
				<option>21</option>
				<option>22</option>
				<option>23</option>
				<option>24</option>
				<option>25</option>
				<option>26</option>
				<option>27</option>
				<option>28</option>
				<option>29</option>
				<option>30</option>
				<option>31</option>

            </select>
            <select id="ddlYear" name="state" class="form-control selectpicker dobDdlYear requiredDob" runat="server">
              <option value=" " >Year</option>
                <option value="2021">2023</option>
                <option value="2021">2022</option>
                <option value="2021">2021</option>
                <option value="2020">2020</option>
                <option value="2019">2019</option>
                <option value="2018">2018</option>
                <option value="2017">2017</option>
                <option value="2016">2016</option>
                <option value="2015">2015</option>
                <option value="2014">2014</option>
                <option value="2013">2013</option>
                <option value="2012">2012</option>
                <option value="2011">2011</option>
                <option value="2010">2010</option>
                <option value="2009">2009</option>
                <option value="2008">2008</option>
                <option value="2007">2007</option>
                <option value="2006">2006</option>
                <option value="2005">2005</option>
                <option value="2004">2004</option>
                <option value="2003">2003</option>
                <option value="2002">2002</option>
                <option value="2001">2001</option>
                <option value="2000">2000</option>
                <option value="1999">1999</option>
                <option value="1998">1998</option>
                <option value="1997">1997</option>
                <option value="1996">1996</option>
                <option value="1995">1995</option>
                <option value="1994">1994</option>
                <option value="1993">1993</option>
                <option value="1992">1992</option>
                <option value="1991">1991</option>
                <option value="1990">1990</option>
                <option value="1989">1989</option>
                <option value="1988">1988</option>
                <option value="1987">1987</option>
                <option value="1986">1986</option>
                <option value="1985">1985</option>
                <option value="1984">1984</option>
                <option value="1983">1983</option>
                <option value="1982">1982</option>
                <option value="1981">1981</option>
                <option value="1980">1980</option>
                <option value="1979">1979</option>
                <option value="1978">1978</option>
                <option value="1977">1977</option>
                <option value="1976">1976</option>
                <option value="1975">1975</option>
                <option value="1974">1974</option>
                <option value="1973">1973</option>
                <option value="1972">1972</option>
                <option value="1971">1971</option>
                <option value="1970">1970</option>
                <option value="1969">1969</option>
                <option value="1968">1968</option>
                <option value="1967">1967</option>
                <option value="1966">1966</option>
                <option value="1965">1965</option>
                <option value="1964">1964</option>
                <option value="1963">1963</option>
                <option value="1962">1962</option>
                <option value="1961">1961</option>
                <option value="1960">1960</option>
                <option value="1959">1959</option>
                <option value="1958">1958</option>
                <option value="1957">1957</option>
                <option value="1956">1956</option>
                <option value="1955">1955</option>
                <option value="1954">1954</option>
                <option value="1953">1953</option>
                <option value="1952">1952</option>
                <option value="1951">1951</option>
                <option value="1950">1950</option>
                <option value="1949">1949</option>
                <option value="1948">1948</option>
                <option value="1947">1947</option>
                <option value="1946">1946</option>
                <option value="1945">1945</option>
                <option value="1944">1944</option>
                <option value="1943">1943</option>
                <option value="1942">1942</option>
                <option value="1941">1941</option>
                <option value="1940">1940</option>
                <option value="1939">1939</option>
                <option value="1938">1938</option>
                <option value="1937">1937</option>
                <option value="1936">1936</option>
                <option value="1935">1935</option>
                <option value="1934">1934</option>
                <option value="1933">1933</option>
                <option value="1932">1932</option>
                <option value="1931">1931</option>
                <option value="1930">1930</option>
                <option value="1929">1929</option>
                <option value="1928">1928</option>
                <option value="1927">1927</option>
                <option value="1926">1926</option>
                <option value="1925">1925</option>
                <option value="1924">1924</option>
                <option value="1923">1923</option>
                <option value="1922">1922</option>
                <option value="1921">1921</option>
                <option value="1920">1920</option>
                <option value="1919">1919</option>
                <option value="1918">1918</option>
                <option value="1917">1917</option>
                <option value="1916">1916</option>
                <option value="1915">1915</option>
                <option value="1914">1914</option>
                <option value="1913">1913</option>
                <option value="1912">1912</option>
                <option value="1911">1911</option>
                <option value="1910">1910</option>
                <option value="1909">1909</option>
                <option value="1908">1908</option>
                <option value="1907">1907</option>
                <option value="1906">1906</option>
                <option value="1905">1905</option>
                <option value="1904">1904</option>
                <option value="1903">1903</option>
                <option value="1902">1902</option>
                <option value="1901">1901</option>
                <option value="1900">1900</option>

            </select>
    </div>
  </div>
</div>
<!-- Text input-->
       
<div class="form-group">
  <label class="col-md-4 control-label">Phone # <span class="ast">*</span></label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
         <asp:TextBox ID="txtPhone" runat="server" placeholder="Cell Phone" class="form-control"></asp:TextBox>
    </div>
  </div>
</div>



<div class="form-group">
<%--  <label id="lblEmail" class="col-md-4 control-label">E-Mail <span>*</span></label>  --%>
      <label id="lblEmail" class="col-md-4 control-label">E-Mail</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
         <asp:TextBox ID="txtEmail" runat="server" placeholder="E-Mail Address" class="form-control" MaxLength="50"></asp:TextBox>
    </div>
  </div>
</div>

<div class="form-group"> 
  <label class="col-md-4 control-label">Sex</label>
    <div class="col-md-4 selectContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
    <select id="ddlGender" name="state" class="form-control selectpicker" runat="server">
      <option value=" " >Select gender</option>
      <option>Male</option>
      <option>Female</option>
    </select>
  </div>
</div>
</div>

      
<div class="form-group">
  <label class="col-md-4 control-label">Address</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
        <asp:TextBox ID="address" runat="server" placeholder="Address" class="form-control" MaxLength="75"></asp:TextBox>
    </div>
  </div>
</div>

 
<div class="form-group">
  <label class="col-md-4 control-label">City</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
        <asp:TextBox ID="city" runat="server" placeholder="city" class="form-control" MaxLength="50"></asp:TextBox>

    </div>
  </div>
</div>

   
<div class="form-group"> 
  <label class="col-md-4 control-label">State</label>
    <div class="col-md-4 selectContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
    <select id="state" name="state" class="form-control selectpicker" runat="server">
      <option value=" " >Please select your state</option>
      <option value="AL">Alabama</option>
      <option value="AK">Alaska</option>
      <option value="AZ">Arizona</option>
      <option value="AR">Arkansas</option>
      <option value="CA">California</option>
      <option value="CO">Colorado</option>
      <option value="CT">Connecticut</option>
      <option value="DE">Delaware</option>
      <option value="DC">Dist of Columbia</option>
      <option value="FL">Florida</option>
      <option value="GA">Georgia</option>
      <option value="HI">Hawaii</option>
      <option value="ID">Idaho</option>
      <option value="IL">Illinois</option>
      <option value="IN">Indiana</option>
      <option value="IA">Iowa</option>
      <option value="KS">Kansas</option>
      <option value="KY">Kentucky</option>
      <option value="LA">Louisiana</option>
      <option value="ME">Maine</option>
      <option value="MD">Maryland</option>
      <option value="MA">Massachusetts</option>
      <option value="MI">Michigan</option>
      <option value="MN">Minnesota</option>
      <option value="MS">Mississippi</option>
      <option value="MO">Missouri</option>
      <option value="MT">Montana</option>
      <option value="NE">Nebraska</option>
      <option value="NV">Nevada</option>
      <option value="NH">New Hampshire</option>
      <option value="NJ">New Jersey</option>
      <option value="NM">New Mexico</option>
      <option value="NY">New York</option>
      <option value="NC">North Carolina</option>
      <option value="ND">North Dakota</option>
      <option value="OH">Ohio</option>
      <option value="OK">Oklahoma</option>
      <option value="OR">Oregon</option>
      <option value="PA">Pennsylvania</option>
      <option value="RI">Rhode Island</option>
      <option value="SC">South Carolina</option>
      <option value="SD">South Dakota</option>
      <option value="TN">Tennessee</option>
      <option value="TX">Texas</option>
      <option value="UT">Utah</option>
      <option value="VT">Vermont</option>
      <option value="VA">Virginia</option>
      <option value="WA">Washington</option>
      <option value="WV">West Virginia</option>
      <option value="WI">Wisconsin</option>
      <option value="WY">Wyoming</option>
    </select>
  </div>
</div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">Zip Code</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
        <asp:TextBox ID="zip" placeholder="Zip Code" class="form-control" runat="server" MaxLength="15"></asp:TextBox>
    </div>
</div>
</div>
  
<div class="form-group">
  <label class="col-md-4 control-label">Ordering Physician</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
         <asp:TextBox ID="dr" class="form-control" placeholder="Ordering Physician" runat="server" MaxLength="35"></asp:TextBox>
  </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">Emergency Contact First Name</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
         <asp:TextBox ID="txtEcFirstName" class="form-control" placeholder="First Name" runat="server" MaxLength="25"></asp:TextBox>
  </div>
  </div>
</div>
<div class="form-group">
  <label class="col-md-4 control-label">Emergency Contact Last Name</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
         <asp:TextBox ID="txtEcLastName" class="form-control" placeholder="Last Name" runat="server" MaxLength="25"></asp:TextBox>
  </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">Emergency Contact Phone #</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
         <asp:TextBox ID="txtEcPhone" runat="server" placeholder="Cell Phone" class="form-control"></asp:TextBox>
    </div>
  </div>
</div>


<div class="form-group">
  <label class="col-md-4 control-label">Next of Kin First Name</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
         <asp:TextBox ID="txtNokFirstName" class="form-control" placeholder="First Name" runat="server" MaxLength="25"></asp:TextBox>
  </div>
  </div>
</div>
<div class="form-group">
  <label class="col-md-4 control-label">Next of Kin Last Name</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
         <asp:TextBox ID="txtNokLastName" class="form-control" placeholder="Last Name" runat="server" MaxLength="25"></asp:TextBox>
  </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">Next of Kin Phone #</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
         <asp:TextBox ID="txtNokPhone" runat="server" placeholder="Cell Phone" class="form-control"></asp:TextBox>
    </div>
  </div>
</div>


 <div class="form-group">
    <label class="col-md-4 control-label">Have you been diagnosed with Covid-19 in the past 10 days or are you under quarantine for Covid-19?</label>
    <div class="col-md-4">
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbDxYes" runat="server" GroupName="Dx" text="Yes"/>
            </label>
        </div>
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbDxNo" runat="server" GroupName="Dx" Text="No" />
            </label>
        </div>
    </div>
</div>

 <div class="form-group">
    <label class="col-md-4 control-label">Are you experiencing any Cough, Fever, Shortness of Breath, Diarrhea, Loss of Taste or Smell?</label>
    <div class="col-md-4">
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbSxYes" runat="server" GroupName="Sx" text="Yes"/>
            </label>
        </div>
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbSxNo" runat="server" GroupName="Sx" Text="No" />
            </label>
        </div>
    </div>
</div>

 <div class="form-group">
  <label class="col-md-4 control-label"><label id="Label1"  runat="server"  onclick="openDoc('consent.pdf')" class="doc-link lnk-label">Do you consent to treatment?</label> <span class="ast">*</span></label>  
    <div class="col-md-4">
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbConsentYes" runat="server" GroupName="Consent" class="rbC" text="Yes"/>
            </label>
        </div>
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbConsentNo" runat="server" GroupName="Consent" class="rbC" Text="No" />
            </label>
        </div>
    </div>
</div>
 <div class="form-group">
  <label class="col-md-4 control-label"> <label id="lblConsFin"  runat="server" onclick="openDoc('fin.pdf')" class="doc-link lnk-label">Do you agree with the Financial Agreement?</label> <span class="ast">*</span></label>  
    <div class="col-md-4">
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbFinYes" runat="server" GroupName="Fin" class="rbC" text="Yes"/>
            </label>
        </div>
        <div class="radio">
            <label>
                <asp:RadioButton ID="rbFinNo" runat="server" GroupName="Fin" class="rbC" Text="No"/>
            </label>
        </div>
    </div>
</div>


<div class="form-group">
  <label class="col-md-4 control-label">Capture Order Photo</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-camera"></i></span>
        <button type="button" id="btnUploadOrder" runat="server" class="btn btn-submit btnCardPhoto btnCardPhotoFront" onclick="fileOrder.click()">Capture Front</button>
        <input type="file" id="fileOrder" runat="server"  class="custom-file-input" onchange="readURL(this);" accept="image/*" capture="camera" aria-label="Get Photo" style="display:none;"/>
        <asp:Label ID="lblFileOrder" runat="server" Text=""> &nbsp;&nbsp;No Image</asp:Label>

  </div>
  </div>
</div>


<div class="form-group">
  <label class="col-md-4 control-label">Capture Insurance Card Photo</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-camera"></i></span>
        <button type="button" id="btnUpload1F" runat="server" class="btn btn-submit btnCardPhoto" onclick="fileIns1F.click()">Capture Front</button>
        <input type="file" id="fileIns1F" runat="server" class="custom-file-input" onchange="readURL(this);" accept="image/*" capture="camera" aria-label="Get Photo" style="display:none;"/>
        <asp:Label ID="lblFileIns1F" runat="server" Text="">&nbsp;&nbsp;No Image</asp:Label>

  </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label"></label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-camera"></i></span>
        <button type="button" id="btnUpload1B" runat="server" class="btn btn-submit btnCardPhoto" onclick="fileIns1B.click()">Capture Back</button>
        <input type="file" id="fileIns1B" runat="server"  class="custom-file-input" onchange="readURL(this);" accept="image/*" capture="camera" aria-label="Get Photo" style="display:none;"/>
        <asp:Label ID="lblFileIns1B" runat="server" Text=""> &nbsp;&nbsp;No Image</asp:Label>

  </div>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label">Selfie Photo</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-camera"></i></span>
        <button type="button" id="btnUploadSelfie" runat="server" class="btn btnCardPhoto" onclick="fileSelfie.click()">Capture Selfie</button>
        <input type="file" id="fileSelfie" runat="server"  class="custom-file-input" onchange="readURL(this);" accept="image/*" capture="camera" aria-label="Get Photo" style="display:none;"/>
        <asp:Label ID="lblFileSelfie" runat="server" Text=""> &nbsp;&nbsp;No Image</asp:Label>

  </div>
  </div>
</div>

<div class="alert alert-success" role="alert" id="success_message">Success <i class="glyphicon glyphicon-thumbs-up"></i> Thanks for contacting us, we will get back to you shortly.</div>

<div class="form-group">
  <label class="col-md-4 control-label"></label>
  <div class="col-md-4">
      <asp:Button ID="cmdCancel" runat="server" class="btn btn-warning" Text="Cancel" OnClientClick="return ConfirmOnCancel();"/>
<%--       <button id="btnCancel" type="button" runat="server" class="btn btn-danger">Cancel</button>--%>

      <button id="btnSubmit" type="button" runat="server" onclick="checkFormBeforeSubmit();" class="btn btn-navy">Next >></button>

<%--      <input id="Button4" type="button" onclick="validatePhoneNumber();" value="button" />--%>
  </div>
</div>
</div>
</form>
</body>
    <script>
        $(document).ready(function () {
            DisableButton();
/*            checkValid();*/
            $('#fileOrder').change(function () {
                $('#lblFileOrder').html('Image Selected');
            });
            $('#fileIns1F').change(function () {
                $('#lblFileIns1F').html('Image Selected');
            });
            $('#fileIns1B').change(function () {
                $('#lblFileIns1B').html('Image Selected');
            });
            $('#fileSelfie').change(function () {
                $('#lblFileSelfie').html('Image Selected');
            });

            $('.required').on('focus', function () {
                $(this).removeClass('input-error');
            });

            $('.required').keyup(function () {
                checkValid();
            });
            $('.required').change(function () {
                checkValid();
            });
            $('.rbC').change(function () {
                checkValid();
            });
            //$('#txtEmail').change(function () {
            //    ValidateEmail();
            //});
            $('#txtPhone').keydown(function () {
                checkValid();
            });
            $('#ddlYear').change(function () {
                checkValid();
            });
            $('#ddlMonth').change(function () {
                checkValid();
            });
            $('#ddlDay').change(function () {
                checkValid();
            });

            var phoneInput = document.getElementById('txtPhone');
            var phoneInputEc = document.getElementById('txtEcPhone');
            var phoneInputNok = document.getElementById('txtNokPhone');
            /*    var myForm = document.getElementById("form1");*/
            // var result = document.getElementById('result');  // only for debugging purposes

            phoneInput.addEventListener('input', function (e) {
                var x = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
                e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
            });

            phoneInputEc.addEventListener('input', function (e) {
                var x2 = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
                e.target.value = !x2[2] ? x2[1] : '(' + x2[1] + ') ' + x2[2] + (x2[3] ? '-' + x2[3] : '');
            });

            phoneInputNok.addEventListener('input', function (e) {
                var x3 = e.target.value.replace(/\D/g, '').match(/(\d{0,3})(\d{0,3})(\d{0,4})/);
                e.target.value = !x3[2] ? x3[1] : '(' + x3[1] + ') ' + x3[2] + (x3[3] ? '-' + x3[3] : '');
            });

        });
/*        });*/

        function ConfirmOnCancel() {
        if (confirm("Do you really want to cancel?") == true)
                return true;
                else
                return false;
        }

       function checkFormBeforeSubmit() {
            //  $("#hidSubmitFlag").val("submit");
            $("#btnSubmit").html("Please wait...");
            $("#btnSubmit").prop('disabled', true);
            $("#btnSubmit").css("background-color", "green");
            $("#form1").submit();
        }

        function openDoc(doc) {
            var sdoc;
            var popUpObj;
            //popUpObj = window.open("Docs/" + doc, "_self,toolbar=no,scrollbars=no,location=no,menubar=no,resizable=0,width=100,height=100,left = 490,top=300");
            popUpObj = window.open("Doc/" + doc, "_blank,toolbar=no,location=no,menubar=no,resizable=0,scrollbars=yes,width=100,height=100,left = 490,top=300");
        }


        //function test() {
        //    $('#txtEmail').addClass('input-error');
        //}
        function EnableButton() {
            $('#btnSubmit').prop('disabled', false);
            alert("EnableButton called");
        }

        function DisableButton() {
<%--            $('#<%=cmdNext.ClientID %>').prop("disabled", true);--%>
            //$('#btnSubmit').prop("disabled", true);
            $('#btnSubmit').prop("disabled", true);

        }

        function validatePhoneNumber(ctl) {
            var input_str = document.getElementById(ctl).value;
            var re = /^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/;
            //var blnValid = false;
            //return re.test(input_str);
            //blnVaid = re.test(input_str);
           // alert(blnValid);
            if (input_str.match(re)) {
                $('#' + ctl).removeClass('input-error');
<%--                $('#<%=cmdNext.ClientID %>').prop("disabled", false);--%>
                $('#btnSubmit').prop("disabled", false);

               // alert('true');
                return true;
            } else {
                // 
                //document.form1.text1.focus();
                $('#' + ctl).addClass('input-error');
<%--                $('#<%=cmdNext.ClientID %>').prop("disabled", true);--%>
                $('#btnSubmit').prop("disabled", true);

                // alert("Invalid email address!");
               // alert('false');
                return false;
            }
        }

        //function ValidateEmail() {
        //    var input = document.getElementById("txtEmail");
        //    if (input == "") { return true }
        //    var validRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        //    if (input.value.match(validRegex)) {
        //        $('#txtEmail').removeClass('input-error');
        //        $('#btnSubmit').prop("disabled", false);
        //        return true;
        //    } else {
        //        $('#txtEmail').addClass('input-error');
        //        $('#btnSubmit').prop("disabled", true);
        //       return false;
        //    }
        //}

        function checkValid() {
            //var fn = $("#first_name").val();
            //var ln = $("#last_name").val();
            //var em = $("#email").val();
            //var ph = $("#phone").val();
            var not_valid = false;
     /*       var phn = validatePhoneNumber("txtPhone");*/
          //  alert('Phone valid = ' + phn);
            //var eml = ValidateEmail();
            //if (eml == false) {
            //    not_valid = true;
            //}
            //else {
            //    not_valid = false;
            //}
            var ConsTreat = $("input[type='radio'][name='Consent']:checked").val()
            var ConsFin = $("input[type='radio'][name='Fin']:checked").val()
            if (ConsTreat == '' || ConsTreat == undefined) {
                not_valid = true;
                $('rbConsentYes').addClass('input-error');
                $('rbConsentNo').addClass('input-error');
            }
            else {
                $('rbConsentYes').removeClass('input-error');
                $('rbConsentNo').removeClass('input-error');
            }

           
            if (ConsFin == '' || ConsFin == undefined) {
                not_valid = true;
                $('rbFinYes').addClass('input-error');
                $('rbFinNo').addClass('input-error');
            }
            else {
                $('rbFinYes').removeClass('input-error');
                $('rbFinNo').removeClass('input-error');
            }

            $('.required').each(function () {
                if ($(this).val() == " " || $(this).val() == "") {
                    $(this).addClass('input-error');
                    not_valid = true;
                }
                else {
                    $(this).removeClass('input-error');
                }
            });

            $('.requiredDob').each(function () {
                if ($(this).val() == " ") {
                    $(this).addClass('input-error');
                    not_valid = true;
                }
                else {
                    $(this).removeClass('input-error');
                }
            });

            //alert('ConsTreat=' + ConsTreat + ', ConsFin=' + ConsFin + ', not_valid=' + not_valid);

<%--            $('#<%=cmdNext.ClientID %>').prop("disabled", not_valid);--%>
            $('#btnSubmit').prop("disabled", not_valid);

            //alert(not_valid);
        }

        function readURL(input) {
            // alert('readURL:' + input.id);
            var inputID = input.id;
            var strImgID = '';
            switch (inputID) {
                case "fileOrder":
                    strImgID = '#img1front';
                    $("#btnUploadOrder").removeClass('btnCardPhoto');
                    $("#btnUploadOrder").addClass('btnCardPhotoOK');
                    break;
                //btnUploadOrder
                case "fileIns1F":
                    strImgID = '#img1back';
                    $("#btnUpload1F").removeClass('btnCardPhoto');
                    $("#btnUpload1F").addClass('btnCardPhotoOK');

                    break;
                case "fileIns1B":
                    strImgID = '#img2back';
                    $("#btnUpload1B").removeClass('btnCardPhoto');
                    $("#btnUpload1B").addClass('btnCardPhotoOK');
                    break;
                case "fileSelfie":
                    strImgID = '#imgSelfie';
                    $("#btnUploadSelfie").removeClass('btnCardPhoto');
                    $("#btnUploadSelfie").addClass('btnCardPhotoOK');
                    //btnUploadSelfie
                    break;
            }

        }

    </script>
</html>
