var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 51.500152, lng: -0.126236},
    zoom: 12
  });

  addMarkerArray(disruptions, map);
}

function addMarkerArray(markersArray, map)
{ 
  for(var i = 0; i < markersArray.length ; i++) 
  {
    var marker    = new google.maps.Marker({
        position: markersArray[i],
        map: map
      });
  }
}