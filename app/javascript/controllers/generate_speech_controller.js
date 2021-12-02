import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['speech'];

  connect() {
    this.speak();
  }

  speak() {
    if (this.element.dataset.spoken === "false") {
      {
        let textString = this.speechTarget.innerText;
        window.speechSynthesis.cancel();
        var variableText = "test";
        console.log(textString);
        window.speechSynthesis.speak(new SpeechSynthesisUtterance(textString));
        this.element.dataset.spoken = "true";
      }
      // window.speechSynthesis.cancel();
      // console.log(convertedTextString);
      // convertedTextString.lang = "en-US";
      // window.speechSynthesis.cancel();
      // window.speechSynthesis.speak(convertedTextString);
      // console.log("This is the end of the process")
      // window.speechSynthesis.cancel();
      // console.log(convertedTextString);
      //
    }
  }
}
