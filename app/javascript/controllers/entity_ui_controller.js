import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="entity-ui"
export default class extends Controller {
  static values = { credentials: String }

  connect() {
    console.log('CONNECTED')
  }

  authenticate() {
    console.log("AUTH CREDS", this.credentialsValue)
  }
}
