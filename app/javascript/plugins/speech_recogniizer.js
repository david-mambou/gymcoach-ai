const recognize(event) => {
  event.preventDefault;
  {
    const inputTarget = document.querySelector(#)
    let verySpecialinput = this.inputTarget;
    let SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
    let SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
    let SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
    let recognition = new SpeechRecognition();
    recognition.continuous = false;
    recognition.lang = 'en-US';
    recognition.maxAlternatives = 1;
    recognition.start();
    console.log('Ready to accept speech input');
    recognition.onresult = function (event) {
      verySpecialinput.value = event.results[0][0].transcript;
    };
    recognition.onspeechend = function () {
      recognition.stop();
    }
  }
}
