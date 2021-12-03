import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['message', 'speech'];


  connect() { //template for future targets
    const message = this.messageTargets[this.messageTargets.length - 1]
    message.scrollIntoView();
    // speech callup
  }

  speak() {
    // var synth = window.speechSynthesis;
    // console.log(this.speechTargets.textContent);
    // var textString = "This is a test"
    // // var textString = this.speechTargets.textContent;
    // var convertedTextString = new SpeechSynthesisUtterance(textString);
    // synth.speak(convertedTextString)
    return null;
  }
};
