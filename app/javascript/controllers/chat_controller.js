import { Controller } from "stimulus";

export default class extends Controller {
  // for 'chat' data controller at application.html.rb except message target
  static targets = ['input','chats','form'];

  connect() { 
    // update message 
    console.log(this.formTarget);
    console.log(this.chatsTarget);
    console.log(this.inputTarget);
  }
};
