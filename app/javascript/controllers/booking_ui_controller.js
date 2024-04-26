import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-ui"
export default class extends Controller {
  static targets = ["source", "output", "link"]

  connect() {
    console.log('CONNECTED BOOKING API');
  }

  renderBookings() {
    if (!this.hasSourceTarget) { return; }

    this.render_template(this.sourceTarget.value);
  }

  render_template(data) {
    this.outputTarget.innerHTML = `
      <div data-controller="table">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>UID</th>
              <th>Entity</th>
              <th>Booking Type</th>
              <th>Name</th>
              <th>UUID</th>
              <th>Disabled</th>
            </tr>
          </thead>
          <tbody data-target="table.body">
            ${this._booking_rows(data)}
          </tbody>
        </table>
      </div>`;
  }

  _booking_rows(data) {
    return Array.from(data).forEach((row, index) => {
      `<tr data-target="table.row">
        <td data-target="table.cell">${index}</td>
        <td data-target="table.cell">${row["uid"]}</td>
        <td data-target="table.cell">${row["entity_uid"]}</td>
        <td data-target="table.cell">${row["booking_type_uid"]}</td>
        <td data-target="table.cell">${row["name"]}</td>
        <td data-target="table.cell">${row["uuid"]}</td>
        <td data-target="table.cell">${row["disabled"]}</td>
      </tr>`
    });
  }
}
