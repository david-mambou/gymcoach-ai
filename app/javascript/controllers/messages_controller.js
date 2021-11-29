import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['message', 'speech'];


  connect() { //template for future targets
    var synth = window.speechSynthesis;
    var textString = "Hi, I will be your personal coach today. What would you like to do today?";
    var convertedTextString = new SpeechSynthesisUtterance(textString);
    const message = this.messageTargets[this.messageTargets.length - 1]
    message.scrollIntoView();
    // speech callup
    console.log(this.element.dataset.spoken)
    if (this.element.dataset.spoken === "false") {
      synth.speak(convertedTextString);
      this.element.dataset.spoken = "true";
      console.log(this.element.dataset.spoken);
    }
  }

  speak() {
    // var synth = window.speechSynthesis;
    // console.log(this.speechTargets.textContent);
    // var textString = "This is a test"
    // // var textString = this.speechTargets.textContent;
    // var convertedTextString = new SpeechSynthesisUtterance(textString);
    // synth.speak(convertedTextString)
  };

};
