import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['exercise'];

  connect() { //template for future targets
    // console.log(this.exerciseTarget);
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
    .then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data;
    })
  }
}
