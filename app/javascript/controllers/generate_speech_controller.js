import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['speech'];

  connect() {
    this.speak();
  }

  speak() {
    console.log(typeof this.element.dataset.spoken)
    if (this.element.dataset.spoken === "false") {
      {
        var textString = this.speechTarget.innerText;
        console.log(textString);
        console.log(typeof textString);
        window.speechSynthesis.cancel();
        window.speechSynthesis.speak(new SpeechSynthesisUtterance(textString));
        setTimeout(() => {
          this.element.dataset.spoken = "true";

        }, 1000);
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
