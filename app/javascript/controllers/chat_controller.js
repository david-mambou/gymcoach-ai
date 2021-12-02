import { Controller } from "stimulus";

export default class extends Controller {
  // for 'chat' data controller at application.html.rb except message target
  static targets = ['input','chats','form'];

  connect() { 
    // update message 
  
  }

  update(event) {
    // event.preventDefault();

    this.formTarget.insertAdjacentHTML('beforeend', this.inputTarget.value);

  }

  createSuccess() {
    
  }
};
