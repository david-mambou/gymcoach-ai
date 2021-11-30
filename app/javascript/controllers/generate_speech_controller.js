import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['speech'];

  connect() {
    this.speak();
  }

  speak() {
    const synth = window.speechSynthesis;
    if (this.element.dataset.spoken === "false") {
      const textString = this.speechTarget.textContent;
      const convertedTextString = new SpeechSynthesisUtterance(textString);
      convertedTextString.lang = "en-US";
      console.log(speechSynthesis.getVoices());
      const femaleVoices = ["Google UK English Female", "Google US English", "Google UK English Male", "en-AU"]
      const foundVoice = speechSynthesis.getVoices().find(({ name }) => femaleVoices.includes(name));
      convertedTextString.volume = 1;
      if (foundVoice) {
        convertedTextString.voice = foundVoice;
      }
      synth.speak(convertedTextString);
      this.element.dataset.spoken = "true";
    }
  }
}
