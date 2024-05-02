import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="diary-ui"
export default class extends Controller {
  connect() {
    console.log('CONNECTED DIARY API');
    axios.get('/api/v1/diaries')
      .then(function (response) {
        document.querySelector('#name-field').innerHTML = response.data[0].name;

        const bookingStates = response.data[0].booking_statuses.map(status => `<span style="color:${status["color"]} !important;">${status["name"]}</span><br />`);
        document.querySelector('#state-field').innerHTML = `<div>${bookingStates}</div>`;

        const bookingTypes = response.data[0].booking_types.map(type => `<span style="color:${type["color"]} !important;">${type["name"]}</span><br>`);
        document.querySelector('#type-field').innerHTML = `<div>${bookingTypes}</div>`;
      })
      .catch(function (error) {
        console.log(error);
      })
      .finally(function () {
        const stateHTML = document.querySelector('#state-field').innerHTML.split(',').join('');
        document.querySelector('#state-field').innerHTML = stateHTML;

        const typeHTML = document.querySelector('#type-field').innerHTML.split(',').join('');
        document.querySelector('#type-field').innerHTML = typeHTML;
      });
  }

}
