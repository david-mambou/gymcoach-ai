import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['input']

  connect() { //template future targets
    // Test browser support
    window.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition || null;
    if (window.SpeechRecognition) {
      this.recognizer = new window.SpeechRecognition();
      this.initRecognition();
    }
  }

  recognize(event) {
    event.preventDefault();
    this.processRecognition();
  }

  processRecognition() {
    // Set if we need interim results
    this.recognizer.interimResults = false;
    try {
      this.recognizer.start();
      console.log('Recognition started');
    } catch (ex) {
      console.log('Recognition error: ' + ex.message);
    }
  }

  initRecognition() {
    // Recogniser doesn't stop listening even if the user pauses
    this.recognizer.continuous = true;
    // Start recognising
    this.recognizer.onresult = function (event) {
      document.querySelector(".chat-input").value = '';
      document.querySelector(".chat-input").value = event.results[0][0].transcript;

      // for (var i = event.resultIndex; i < event.results.length; i++) {
      //   if (event.results[i].isFinal) {
      //     document.querySelector(".chat-input").value = event.results[i][0].transcript;
      //   } else {
      //     document.querySelector(".chat-input").value += event.results[i][0].transcript;
      //   }
      // }
    };
    // Listen for errors
    this.recognizer.onerror = function (event) {
      console.log('Recognition error: ' + event.message);
    };

    this.recognizer.onspeechend = function () {
      this.recognizer.stop();
      console.log('Recognition stopped');
    };

    this.recognizer.onsoundend = function () {
      this.recognizer.stop();
      console.log('Recognition stopped (soundend)');
    };

  }
}
