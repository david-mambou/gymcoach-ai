import { Controller } from "stimulus";
export default class extends Controller {
  // for 'chat' data controller at application.html.rb except message target
  static targets = ['message'];

  connect() { 
    // message target is to keep page scrolled down always
    const message = this.messageTargets[this.messageTargets.length - 1]
    message.scrollIntoView();
  }
};
