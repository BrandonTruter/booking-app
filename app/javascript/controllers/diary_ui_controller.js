import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="diary-ui"
export default class extends Controller {
  connect() {

    axios.get('/api/v1/diaries')
      .then(function (response) {
        console.log('DIARY API RESPONSE', response);

        const tableRows = [],
              tableHeaders = `<tr>
                <th class="p-3 text-sm font-semibold text-left text-gray-700 bg-gray-200">UID</th>
                <th class="p-3 text-sm font-semibold text-left text-gray-700 bg-gray-200">Name</th>
                <th colspan="3" class="p-3 text-sm font-semibold text-left text-gray-700 bg-gray-200"></th>
              </tr>`;

        response.data.forEach(entry => {
          const bookingStates = entry.booking_statuses.map(bookingState => `<li style="color:${bookingState["color"]};">${bookingState["name"]}</li>`);
          const bookingTypes = entry.booking_types.map(bookingType => `<li>${bookingType["name"]}</li>`);
          tableRows.push(`<tr>
            <td>${entry.uid}</td>
            <td>${entry.name}</td>
            <td class="actions" title="Booking States"><ul>${bookingStates.join('')}</ul></td>
            <td class="actions" title="Booking Types"><ul>${bookingTypes.join('')}</ul></td>
            <td class="actions" title="Booking Links"><a href="/bookings?diary_id=${entry.uid}" class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600" title="Bookings">View</a></td>
          </tr>`);
        });

        document.querySelector('#diaries').innerHTML = `
          <table class="tftable mt-10">
            <thead>
              <tr>
                <th class="text-left">UID</th>
                <th class="text-left">NAME</th>
                <th colspan="3" class="text-center">BOOKINGS</th>
              </tr>
            </thead>
            <tbody>
              ${tableRows.join('')}
            </tbody>
          </table>`;
      })
      .catch(function (error) {
        console.log(error);
      });
  }
}
