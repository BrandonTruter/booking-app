import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-ui"
export default class extends Controller {
  connect() {
    console.log('CONNECTED BOOKING API');
  }
}
