import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-ui"
export default class extends Controller {
  connect() {
    console.log('CONNECTED BOOKING API');

    // axios.get('/api/v1/bookings')
    //   .then(function (response) {
    //     console.log(response, "BOOKINGS API");
    //     // this.tableTarget.outerHTML =
    //     // document.querySelector('#bookings').innerHTML = `<table>
    //     //   <thead>
    //     //      <tr>
    //     //         <th>UID</th>
    //     //         <th>Entity</th>
    //     //         <th>Booking Type</th>
    //     //         <th>Name</th>
    //     //         <th>UUID</th>
    //     //         <th>Disabled</th>
    //     //      </tr>
    //     //    </thead>
    //     //    <tbody data-target="table.body">
    //     //       ${response.data.forEach(resp => {
    //     //         `<tr data-target="table.row">
    //     //           <td data-target="table.cell">${resp.uid}</td>
    //     //           <td data-target="table.cell">${resp.entity_uid}</td>
    //     //           <td data-target="table.cell">${resp.booking_type_uid}</td>
    //     //           <td data-target="table.cell">${resp.name}</td>
    //     //           <td data-target="table.cell">${resp.uuid}</td>
    //     //           <td data-target="table.cell">${resp.disabled}</td>
    //     //         </tr>`
    //     //       })}
    //     //     </tbody>
    //     //   </table>`
    //   })
    //   .catch(function (error) {
    //     console.log(error);
    //   })
    //   .finally(function () {
    //     // always executed
    //   })

    //   axios.get('/api/v1/debtors').then(function (response) {
    //     console.log(response, "DEBBTORS API");
    //     // document.querySelector('#debtors').innerHTML = `<table>
    //     //   <thead>
    //     //      <tr>
    //     //         <th>UID</th>
    //     //         <th>Entity</th>
    //     //         <th>Name</th>
    //     //         <th>Surname</th>
    //     //      </tr>
    //     //    </thead>
    //     //    <tbody class="table-body">
    //     //       ${response.data.forEach((resp) => {
    //     //         return `<tr class="table-row">
    //     //           <td class="table-cell">${resp.uid}</td>
    //     //           <td class="table-cell">${resp.entity_uid}</td>
    //     //           <td class="table-cell">${resp.name}</td>
    //     //           <td class="table-cell">${resp.surname}</td>
    //     //         </tr>`
    //     //       })}
    //     //     </tbody>
    //     //   </table>`
    //   })
    //   .catch(function (error) {
    //     console.log(error);
    //   })
    //   .finally(function () {
    //     // always executed
    //   });

  }
}
