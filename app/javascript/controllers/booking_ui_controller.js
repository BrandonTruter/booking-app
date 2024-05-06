import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-ui"
export default class extends Controller {
  connect() {
    console.log('CONNECTED BOOKING API');

    axios.get('/api/v1/bookings')
      .then(function (response) {
        console.log(response);
      })
      .catch(function (error) {
        console.log(error);
      })
      .finally(function () {
        // always executed
      })
  }
}
