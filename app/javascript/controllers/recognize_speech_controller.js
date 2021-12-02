import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['input']

  connect() { //template future targets
    console.log(this.inputTarget);
  }

  recognize(event) {
    event.preventDefault;
    this.inputTarget.value = "peanuts";
    console.log("this is before speech recognition")
    var input = this.inputTarget;
    var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
    var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
    var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
    var recognition = new SpeechRecognition()
    recognition.continuous = false;
    recognition.lang = 'en-US';
    recognition.maxAlternatives = 1;
    recognition.start();
    console.log('Ready to accept speech input');
    recognition.onresult = function(event) {
      const transcription = event.results[0][0].transcript
      console.log(transcription);
      console.log(input);
      console.log("this is during speech recognition");
      input.value = transcription;
      console.log(input.value);
    };
    recognition.onspeechend = function() {
      recognition.stop();
    }
  }
}
