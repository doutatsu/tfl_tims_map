var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 51.500152, lng: -0.126236},
    zoom: 12
  });
}