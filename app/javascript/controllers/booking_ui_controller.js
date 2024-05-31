import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-ui"
export default class extends Controller {
  connect() {
    console.log('CONNECTED BOOKING API');
    // axios.get('/api/v1/bookings')
    //   .then(function (response) {
    //     console.log(response);
    //   })
    //   .catch(function (error) {
    //     console.log(error);
    //   })
    //   .finally(function () {
    //     // always executed
    //   })
  }

  // sendUpdate() {
  //   axios.post('http://localhost:3000/signup', {signupObj})
  //   axios.patch('http://localhost:3000/:id', {patchObj})
  //   axios.delete('http://localhost:3000/users/:id')
  // }

  showForm() {
    document.querySelectorAll(".booking-table").forEach(item => item.classList.add('hidden'))
  }

  hideForm() {
    document.querySelector('form').classList.add('hidden');
    document.querySelectorAll(".booking-table").forEach(item => item.classList.remove('hidden'))
  }

  renderDebtors() {
    axios.get('/api/v1/debtors')
      .then(function (response) {
        const dataRow = [], dataHead = `<tr><th class="p-3 text-sm font-semibold text-left text-gray-700 bg-gray-200">DEBTORS</th></tr>`;

        response.data.forEach(entry => {
          dataRow.push(`<tr><td id="${entry.uid}">${entry.surname}</td></tr>`);
        });

        document.querySelector("#debtors").innerHTML = `
          <table class="tftable mx-5 px-5 leading-loose prose-table">
            <thead>${dataHead}</thead>
            <tbody>${dataRow.join('')}</tbody>
          </table>
        `;
    })
    .catch(function (error) {
      console.log(error);
    })
  }

  renderPatients() {
    axios.get('/api/v1/patients')
      .then(function (response) {
        const dataRow = [], dataHead = `<tr><th class="p-3 text-sm font-semibold text-left text-gray-700 bg-gray-200">PATIENTS</th></tr>`;

        response.data.forEach(entry => {
          dataRow.push(`<tr><td id="${entry.uid}">${entry.surname}</td></tr>`);
        });

        document.querySelector("#patients").innerHTML = `
          <table class="tftable mx-5 px-5 leading-loose prose-table">
            <thead>${dataHead}</thead>
            <tbody>${dataRow.join('')}</tbody>
          </table>
        `;
    })
    .catch(function (error) {
      console.log(error);
    })
  }
}
