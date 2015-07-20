$(document).ready(function() {

  GMaps.geolocate({
    success: function(position) {
      var map = new GMaps({
        div: '#map',
        lat: position.coords.latitude,
        lng: position.coords.longitude,
      })
      map.setCenter(position.coords.latitude, position.coords.longitude);
       map.addMarker({
        lat: position.coords.latitude,
        lng: position.coords.longitude,
        title: 'Your location',
        click: function(e) {
          alert('You clicked in this marker');
        }
       })
       $.ajax ({
        url: "http://localhost:3000/pizzas?",
        type: 'POST',
        data: {
          lat: position.coords.latitude,
          lng: position.coords.longitude
          }
       })
    },
    error: function(error) {
      alert('Geolocation failed: '+error.message);
    },
    not_supported: function() {
      alert("Your browser does not support geolocation");
    },
  });

})