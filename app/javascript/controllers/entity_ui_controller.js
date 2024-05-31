import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="entity-ui"
export default class extends Controller {
  connect() {
    console.log('CONNECTED');
  }

  login() {
    const username = this.element.dataset.username,
          password = this.element.dataset.password;
    axios
      .post("/session", { username, password })
      .then(response => {
        console.log(response.data);
        localStorage.setItem("entity", JSON.stringify(response.data));
      })
  }
}
