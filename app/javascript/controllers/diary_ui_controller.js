import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="diary-ui"
export default class extends Controller {
  static values = {
    url: String,
    date: String,
    startAt: Date,
    duration: Number
  }

  connect() {
    console.log('CONNECTED DIARY API');
    console.log("URL of diary", this.urlValue);
    console.log("DATE in diary", this.dateValue);
    console.log("DATE for diary booking", this.startAtValue + ' | ' + this.durationValue);
  }
}
