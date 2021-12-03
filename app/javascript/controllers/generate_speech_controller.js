import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['speech'];

  connect() {
    this.synth = window.speechSynthesis;
    this.speak();
  }

  speak() {
    console.log(typeof this.element.dataset.spoken)
    if (this.element.dataset.spoken === "false") {
      this.speechProcessing(this.speechTarget.innerText);
      setTimeout(() => {
        this.element.dataset.spoken = "true";

      }, 2000);
    }
  }

  speechProcessing(text) {
    console.log(text)
    if (this.synth.speaking) {
      console.error('speechSynthesis.speaking');
      return;
    }
    if (text !== '') {
      const utterThis = new SpeechSynthesisUtterance(text);
      utterThis.onend = function (event) {
        console.log('SpeechSynthesisUtterance.onend', event);
      }
      utterThis.onerror = function (event) {
        console.error('SpeechSynthesisUtterance.onerror', event);
      }
      this.synth.speak(utterThis);
    }
  }
}
