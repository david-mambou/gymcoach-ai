import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['message', 'speech-target'];


  connect() { //template for future targets
    const message = this.messageTargets[this.messageTargets.length - 1]
    message.scrollIntoView();
  }

  speak() {
    var synth = window.speechSynthesis;
    var textString = "Hello Dant from Fukouda"
    var convertedTextString = new SpeechSynthesisUtterance(textString)
    synth.speak(convertedTextString)
  }

};
