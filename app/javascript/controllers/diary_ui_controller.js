import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="diary-ui"
export default class extends Controller {
  static values = { token: String }
  static targets = ["source", "output", "link", "form"]

  connect() {
    console.log('CONNECTED DIARY API');

    this.setupDiaryData();
  }

  setupDiaryData() {
    if (this.hasSourceTarget) {
      this.renderDiary()
    }
  }

  renderDiary(data) {
    this.outputTarget.innerHTML = this.diaryDataTable()
  }

  diaryDataTable() {
    const data = this.sourceTarget.innerHTML;

    return `
      <style type="text/css">
        .tftable {font-size:14px;color:#333333;width:100%;border-width: 1px;border-color: #87ceeb;border-collapse: collapse;}
        .tftable th {font-size:18px;background-color:#87ceeb;border-width: 1px;padding: 8px;border-style: solid;border-color: #87ceeb;text-align:left;}
        .tftable tr {background-color:#ffffff;}
        .tftable td {font-size:14px;border-width: 1px;padding: 8px;border-style: solid;border-color: #87ceeb;}
        .tftable tr:hover {background-color:#e0ffff;}
      </style>

      <table class="tftable" border="1">
        <tr>
          <th>UID</th>
          <th>Name</th>
          <th>UUID</th>
          <th>Booking Type UUID</th>
        </tr>
        <tr>
          <td>${data["uid"]}</td>
          <td>${data["name"]}</td>
          <td>${data["uuid"]}</td>
          <td>${data["booking_type_uid"]}</td>
        </tr>
      </table>`
  }
}
