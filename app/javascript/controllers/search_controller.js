import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["params"]

  search(e) {
    e.preventDefault();
    e.stopImmediatePropagation();
    const value = this.paramsTarget.value;

    fetch(`/bookings/search?search=${value}`, {
      contentType: 'application/json',
      hearders: 'application/json'
    })
    .then((response) => response.text())
    .then(res => {
      document.querySelector('#bookings').innerHTML = res;
      return false;
    })
  }
}
