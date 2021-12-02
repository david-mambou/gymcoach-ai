import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['input']

  connect() { //template future targets
    console.log(this.inputTarget);
  }

  recognize(event) {
    event.preventDefault;
    {
      let input = this.inputTarget;
      let SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
      let SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
      let SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
      let recognition = new SpeechRecognition();
      recognition.continuous = false;
      recognition.lang = 'en-US';
      recognition.maxAlternatives = 1;
      recognition.start();
      console.log('Ready to accept speech input');
      recognition.onresult = function(event) {
        const transcription = event.results[0][0].transcript
        console.log(transcription);
        console.log(input);
        input.value = transcription;
        console.log(input.value);
      };
      recognition.onspeechend = function() {
        recognition.stop();
      }
  } }
}
