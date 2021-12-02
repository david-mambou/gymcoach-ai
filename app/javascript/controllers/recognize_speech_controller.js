import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['input']

  connect() { //template future targets
    console.log(this.inputTarget);
  }

  recognize(event) {
    event.preventDefault;
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
      var transcription = event.results[0][0].transcript
      console.log(transcription)
    }
    recognition.onspeechend = function() {
      recognition.stop();
    }

    recognition.onnomatch = function(speakingevent) {
      console.log("Did not understand");
    }
  }
}
