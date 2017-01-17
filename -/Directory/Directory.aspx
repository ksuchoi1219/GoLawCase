<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Directory.aspx.cs" Inherits="Directory.Directory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <link rel='stylesheet' type='text/css' href='../../css/directoryStyle.css'/>
    <title>golawcase.com</title>
    <link rel="stylesheet" type="text/css" href="directoryCSS.css" />
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyDsQTO6_Z-q2VbejfMQzJQJCbWs6VPCL9Y"></script>
    <script type ="text/javascript" src="../../js/v3_epoly.js"></script>
    <script type="text/javascript">

        // ======= GLOBAL VARIABLES =======//
        var userZip = null;
        var userCategory = null;

        // ======= GETTING USER ZIPCODE ======== //
        function processForm() {
            var parameters = location.search.substring(1).split("&");
            var temp = parameters[0].split("=");
            userZip = unescape(temp[1]);
            return userZip;
        }

        // ======= GETTING USER CATEGORY ========//
        function getLocalStorage() {
            return localStorage.categoryOption;
        }

        // ======== ALERT MESSAGE POPUP ========//
        function alertContact() {
            alert("Contact Michael Krause \n +1-404-386-8921 \n mike@esolutiontg.com");
        }

        // ========= INITIALIZE ========//
        function initialize() {
            
            processForm();
            
            // ========== DB VARIABLES ==========//
            var uLat = [];
            var uLng = [];
            var directoryArray = [];
            var directoryName = [];
            var directoryCompany = [];
            var directoryPhone = [];
            var directoryEmail = [];
            var directoryAddr = [];
            var infoWindows = [];
            var markers = [];
            userCategory = getLocalStorage();
            // ========= GETTING LAT LNG INTO TABLE ========//
            var pTable = document.getElementById("position");
            var rowLength = pTable.rows.length;
            for (var i = 1; i < rowLength; i++) {
                var pCells = pTable.rows.item(i).cells;
                var cellLength = pCells.length;
                for (var j = 0; j < cellLength; j+=2) {
                    var cellVal = pCells.item(j).innerHTML;
                    uLat.push(cellVal);
                }
                for (var k = 1; k < cellLength; k+=2) {
                    var cellVal1 = pCells.item(k).innerHTML;
                    uLng.push(cellVal1);
                }
            }
            // ========== GETTING DIRECTORY INTO TABLE =======//
            var dTable = document.getElementById("directory_table");
            var rowLength1 = dTable.rows.length;
            for (var b = 1; b < rowLength1; b++) {
                var dCells = dTable.rows.item(b).cells;
                var cellLength1 = dCells.length;
                for (var z = 0; z < cellLength1; z++) {
                    var cellVal2 = dCells.item(z).innerHTML;
                    directoryArray.push(cellVal2);
                    if (z == 5) {
                        dCells.item(z).innerHTML = "<input type=\"button\" class=\"btn\" id=\"btn\" value=\"Website\" onclick=\"location.href = 'http://www.golawcase.com';\"/>";
                    }
                    if (z == 6) {
                        dCells.item(z).innerHTML = "<input type=\"button\" class=\"btn\" id=\"btn\" value=\"Contact\" onclick=\"alertContact()\"/>";
                    }
                } 
            }
            // ======== SORT THE DIRECTORY ========//
            for (var w = 0; w < directoryArray.length; w += 7) {
                directoryName.push(directoryArray[w]);
                directoryCompany.push(directoryArray[w + 1]);
                directoryPhone.push(directoryArray[w + 2]);
                directoryEmail.push(directoryArray[w + 3]);
                directoryAddr.push(directoryArray[w + 4]);
            }

            // ========= GOOGLE MAP VARIABLES=============//
            var ulat = 33.9812131;
            var ulng = -84.15406589999998;
            var zm = 12;
            var infoWindows = [];
            var geocoder = new google.maps.Geocoder();
            var ulat;
            var ulng;
            var umap = new google.maps.Map(document.getElementById('map_canvas'), {
                center: { lat: ulat, lng: ulng },
                zoom: zm
            });
            // ======== CURRENT LOCATION ========//
            geocoder.geocode({ 'address': userZip }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    ulat = results[0].geometry.location.lat();
                    ulng = results[0].geometry.location.lng();

                    var geoMarker = new google.maps.Marker({
                        position: { lat: ulat, lng: ulng },
                        map: umap,
                        icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
                        animation: google.maps.Animation.BOUNCE
                    });
                    var markerCenter = geoMarker.getPosition();
                    umap.setCenter(markerCenter);
                } else {
                    alert("Geocode was not successful for the following reason: " + status);
                }
            });
            // ======== MARKER INFO WINDOWS ========//
            for (var a = 0; a < uLng.length; a++) {
                var dataLatlng = new google.maps.LatLng(uLat[a], uLng[a]);
                infoWindows[a] = new google.maps.InfoWindow({
                    content: "<b> Name: </b>" + directoryName[a]
                        + "<br />" + "<b> Company Name: </b>" + directoryCompany[a]
                        + "<br />" + "<b> Phone: </b>" + directoryPhone[a]
                        + "<br />" + "<b> Email: </b>" + directoryEmail[a]
                        + "<br />" + "<b> Address: </b>" + directoryAddr[a]
                    });
                
                markers[a] = new google.maps.Marker({
                    position: dataLatlng,
                    map: umap,
                    animation: google.maps.Animation.DROP,
                })
                google.maps.event.addListener(markers[a], 'click', (function (marker, a) {

                    return function () {
                        infoWindows[a].open(umap, markers[a]);
                    }
                })(markers[a], a));

            }
            // ======== MAP BOUND =========//
            var latlngbounds = new google.maps.LatLngBounds();
            for (var o = 0; 0 < dataLatlng.length; o++) {
                latlngbounds.extend(dataLatlng[o]);
            }
            umap.fitBounds(latlngbounds);
            
        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</head>
<body onload="initialize()">
    <form id="form1" runat="server">
        <div style="width=100%;">
            <nav class="navigation-bar">
                <a class="navbar-brand" href="/"><img src="/images/logo_golawcase.png" class="top-logo" ></a>
            </nav>
        <div id="map_canvas"> </div>
        <table style="display:none;" >
            <tr>
                <td>
                        <asp:GridView ID="position" runat="server" BackColor="White" 
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="4" ForeColor="Black" GridLines="Horizontal" 
                        Width="100%" Height="164px" style="margin-left: 0px">
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <table id="directory">
            <tr>
                <td>
                        <asp:GridView ID="directory_table" runat="server" BackColor="White" 
                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="4" ForeColor="Black" GridLines="Horizontal" 
                        Width="100%" Height="164px" style="margin-left: 0px">
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        </div>
    </form>

        <script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
        </script>
        <script type="text/javascript">
            _uacct = "UA-162157-1";
            urchinTracker();
        </script>
    </body>
</html>
